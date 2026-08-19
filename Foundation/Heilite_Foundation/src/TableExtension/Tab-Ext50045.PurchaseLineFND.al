tableextension 50045 PurchaseLineExtFND extends "Purchase Line"
{
    // version NAVW110.0.00.16996,NRQ102424,HEI.85

    //BC UPGRADE ATHUKS01>>
    //1. Added procedure fctUpdateHeaderDocAfterModify() in onafterinsert & Onaftermodify triggers
    //2.Commented system fields update, in BC system fields update not requried in fctUpdateHeaderDocAfterModify
    //BC UPGRADE ATHUKS01 <<
    //BC Upgrade SHARMP16 END>> ---IBM GAP STP 48 -Uncomment CalcFormula and change "Created By" field to "Created By IBM"
    //BC UPGRADE ATHUKUS01 FDDSTP_008 Added UpdateOriginalQuantity procedure to update original quantity when quantity is updated for the first time.
    //BC UPGRADE ATHUKS01 FDDSTP_GAP11 Added new field Maximo Purchase Receipt.
    fields
    {

        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order', FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
        }
        modify("Buy-from Vendor No.")
        {
            CaptionML = ENU = 'Buy-from Vendor No.', FRA = 'N° fournisseur';
        }
        modify("Document No.")
        {

            //Unsupported feature: Change TableRelation on ""Document No."(Field 3)". Please convert manually.

            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            // OptionCaptionML = ENU = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)', FRA = ' ,Compte général,Article,,Immobilisation,Frais annexes';
        }
        modify("No.")
        {

            //Unsupported feature: Change TableRelation on ""No."(Field 6)". Please convert manually.

            CaptionML = ENU = 'No.', FRA = 'N°';
            //BC Upgrade SAIA01 WHT Posting fields Update >>
            trigger OnAfterValidate()
            var
                PurchaseHeader: Record "Purchase Header";
                GLAccount: Record "G/L Account";
                Item: Record Item;
                FixedAsset: Record "Fixed Asset";
            begin
                PurchaseHeader.SetLoadFields("Document Type", "No.", "WHT Business Posting Group FND");
                GLAccount.SetLoadFields("WHT Product Posting Group FND");

                if PurchaseHeader.Get("Document Type", "Document No.") then
                    "WHT Business Posting Group FND" := PurchaseHeader."WHT Business Posting Group FND";

                if (Type = Type::"G/L Account") and (GLAccount.Get("No.")) then
                    "WHT Product Posting Group FND" := GLAccount."WHT Product Posting Group FND";

                if (Type = Type::Item) and (Item.Get("No.")) then
                    "WHT Product Posting Group FND" := Item."WHT Product Posting Group FND";

                if (Type = Type::"Fixed Asset") and (FixedAsset.Get("No.")) then
                    "WHT Product Posting Group FND" := FixedAsset."WHT Product Posting Group FND";
            end;
            //BC Upgrade SAIA01 WHT Posting fields Update <<
        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
            //BC UPGRADE SHARMP16 begin<<
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                Rec.UpdateTINBAndVATProdPostGrByLocation(); //HEI.21s
            end;
            //BC UPGRADE SHARMP16 end>>
        }
        modify("Posting Group")
        {

            //Unsupported feature: Change TableRelation on ""Posting Group"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Posting Group', FRA = 'Groupe comptabilisation';
        }
        modify("Expected Receipt Date")
        {
            CaptionML = ENU = 'Expected Receipt Date', FRA = 'Date réception prévue';
            //BC UPGRADE SHARMP16 begin<< 
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.24>>
                IF PurchSetup.GET() THEN BEGIN
                    PurchaseLine.SETRANGE("Document Type", "Document Type");
                    PurchaseLine.SETRANGE("Document No.", "Document No.");
                    PurchaseLine.SETFILTER(Type, '%1', PurchaseLine.Type::Item);
                    PurchaseLine.SETFILTER("Item Category Code", PurchSetup."Item Category FND");
                    IF NOT PurchaseLine.FINDFIRST() THEN
                        ItemCategoryBool := FALSE
                    else
                        ItemCategoryBool := TRUE;
                    IF ItemCategoryBool THEN BEGIN
                        //HEI.24<<
                        //HEI.22>>
                        IF ("SRM Order No. FND" = '') AND (("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order"))
                          AND (Type = Type::Item) AND ("Item Category Code" = PurchSetup."Item Category FND") THEN BEGIN //HEI.43
                            PurchHdrArch.RESET();
                            PurchHdrArch.SETRANGE(PurchHdrArch."Document Type", "Document Type");
                            PurchHdrArch.SETRANGE(PurchHdrArch."No.", "Document No.");
                            IF PurchHdrArch.FINDFIRST() THEN BEGIN
                                PurchHeader.RESET();
                                PurchHeader.SETRANGE(PurchHeader."No.", "Document No.");
                                IF PurchHeader.FINDFIRST() THEN BEGIN
                                    IF PurchHeader."Purch. Reason Code FND" = '' THEN
                                        ERROR(ReasonCodeErr);
                                end;
                            end;
                        end;
                        //HEI.22<<
                    end;
                    //HEI.24>>
                end;
                //end;
                //HEI.24<<


            end;
            //BC UPGRADE SHARMP16 end>> 
        }
        modify(Description)
        {

            //Unsupported feature: Change TableRelation on "Description(Field 11)". Please convert manually.

            CaptionML = ENU = 'Description', FRA = 'Désignation';

            //Unsupported feature: Change Description on "Description(Field 11)". Please convert manually.

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
            //BC UPGRADE SHARMP16 begin<<
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.21>>
                IF rec."TIN No. FND" = '' THEN
                    Rec.UpdateTINBAndVATProdPostGrByLocation();
                //HEI.21<<
                UpdateOriginalQuantity(); //BC UPGRADE ATHUKUS01 FDDSTP_008 
                //HEI.24>>
                IF PurchSetup.GET() THEN BEGIN
                    PurchaseLine.SETRANGE("Document Type", "Document Type");
                    PurchaseLine.SETRANGE("Document No.", "Document No.");
                    PurchaseLine.SETFILTER(Type, '%1', PurchaseLine.Type::Item);
                    PurchaseLine.SETFILTER("Item Category Code", PurchSetup."Item Category FND");
                    IF NOT PurchaseLine.FINDFIRST() THEN
                        ItemCategoryBool := FALSE
                    else
                        ItemCategoryBool := TRUE;
                    IF ItemCategoryBool THEN BEGIN
                        //HEI.24<<
                        //HEI.22>>
                        IF ("SRM Order No. FND" = '') AND (("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order"))
                          AND (Type = Type::Item) AND ("Item Category Code" = PurchSetup."Item Category FND") THEN BEGIN //HEI.43
                            PurchHdrArch.RESET();
                            PurchHdrArch.SETRANGE(PurchHdrArch."Document Type", "Document Type");
                            PurchHdrArch.SETRANGE(PurchHdrArch."No.", "Document No.");
                            IF PurchHdrArch.FINDFIRST() THEN BEGIN
                                PurchHeader.RESET();
                                PurchHeader.SETRANGE(PurchHeader."No.", "Document No.");
                                IF PurchHeader.FINDFIRST() THEN BEGIN
                                    IF PurchHeader."Purch. Reason Code FND" = '' THEN
                                        ERROR(ReasonCodeErr);
                                end;
                            end;
                        end;
                        //HEI.22<<
                        //HEI.24>>
                    end;
                end;
                //HEI.24<<
            end;
            //BC UPGRADE SHARMP16 end>>

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

            //Unsupported feature: Change AutoFormatExpr on ""Direct Unit Cost"(Field 22)". Please convert manually.


            //Unsupported feature: Change Description on ""Direct Unit Cost"(Field 22)". Please convert manually.
            //BC UPGRADE SHARMP16 begin<<
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.42>>
                //HEI.24>>
                //HEI.44>>
                IF PurchSetup.GET() THEN BEGIN
                    PurchaseLine.SETRANGE("Document Type", "Document Type");
                    PurchaseLine.SETRANGE("Document No.", "Document No.");
                    PurchaseLine.SETFILTER(Type, '%1', PurchaseLine.Type::Item);
                    PurchaseLine.SETFILTER("Item Category Code", PurchSetup."Item Category FND");
                    IF NOT PurchaseLine.FINDFIRST() THEN
                        ItemCategoryBool := FALSE
                    else
                        ItemCategoryBool := TRUE;
                end;
                IF ItemCategoryBool THEN BEGIN
                    IF ("SRM Order No. FND" = '') AND (("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order")) THEN BEGIN
                        PurchHdrArch.RESET();
                        PurchHdrArch.SETRANGE(PurchHdrArch."Document Type", "Document Type");
                        PurchHdrArch.SETRANGE(PurchHdrArch."No.", "Document No.");
                        IF PurchHdrArch.FINDFIRST() THEN BEGIN
                            PurchHeader.RESET();
                            PurchHeader.SETRANGE(PurchHeader."No.", "Document No.");
                            IF PurchHeader.FINDFIRST() THEN BEGIN
                                IF PurchHeader."Purch. Reason Code FND" = '' THEN
                                    ERROR(ReasonCodeErr);
                            end;
                        end;
                    end;
                end;
                //HEI.44<<
                //  end;
                // end;
                //HEI.24<<
                //HEI.42<<

            end;
            //BC UPGRADE SHARMP16 end>> 
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

            //Unsupported feature: Change AutoFormatExpr on ""Amount Including VAT"(Field 30)". Please convert manually.


            //Unsupported feature: Change Description on ""Amount Including VAT"(Field 30)". Please convert manually.

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
            //BC UPGRADE SHARMP16 begin<<
            trigger OnBeforeValidate()
            var
                myInt: Integer;
            begin
                //HEI.20>>
                SetFilter("Document Type", '<>%1|<>%2', rec."Document Type"::"Return Order", Rec."Document Type"::"Credit Memo");
                // IF (Rec."Document Type" <> Rec."Document Type"::"Return Order") AND (Rec."Document Type" <> Rec."Document Type"::"Credit Memo") THEN
                //HEI.20<<
            end;
            //BC UPGRADE SHARMP16 end>>
        }
        modify("Indirect Cost %")
        {
            CaptionML = ENU = 'Indirect Cost %', FRA = '% coût indirect';
        }
        modify("Recalculate Invoice Disc.")
        {
            CaptionML = ENU = 'Recalculate Invoice Disc.', FRA = 'Recalculer remise facture';
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

            //Unsupported feature: Change TableRelation on ""Sales Order No."(Field 71)". Please convert manually.

            CaptionML = ENU = 'Sales Order No.', FRA = 'N° commande vente';
        }
        modify("Sales Order Line No.")
        {

            //Unsupported feature: Change TableRelation on ""Sales Order Line No."(Field 72)". Please convert manually.

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
            //BC UPGRADE SHARMP16 begin<<
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                Rec.UpdateTINBAndVATProdPostGrByLocation(); //HEI.21
            end;
            //BC UPGRADE SHARMP16 end>>s
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
        modify("Reserved Quantity")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Quantity"(Field 95)". Please convert manually.

            CaptionML = ENU = 'Reserved Quantity', FRA = 'Quantité réservée';
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
        modify("Prepmt. Amount Inv. (LCY)")
        {
            CaptionML = ENU = 'Prepmt. Amount Inv. (LCY)', FRA = 'Montant acompte facturé DS';
        }
        modify("IC Partner Code")
        {
            CaptionML = ENU = 'IC Partner Code', FRA = 'Code du partenaire IC';
        }
        modify("Prepmt. VAT Amount Inv. (LCY)")
        {
            CaptionML = ENU = 'Prepmt. VAT Amount Inv. (LCY)', FRA = 'Montant TVA acompte facturé DS';
        }
        modify("Prepayment VAT Difference")
        {
            CaptionML = ENU = 'Prepayment VAT Difference', FRA = 'Différence TVA acompte';
        }
        modify("Prepmt VAT Diff. to Deduct")
        {
            CaptionML = ENU = 'Prepmt VAT Diff. to Deduct', FRA = 'Différence TVA acompte à déduire';
        }
        modify("Prepmt VAT Diff. Deducted")
        {
            CaptionML = ENU = 'Prepmt VAT Diff. Deducted', FRA = 'Différence TVA acompte déduite';
        }
        modify("Outstanding Amt. Ex. VAT (LCY)")
        {
            CaptionML = ENU = 'Outstanding Amt. Ex. VAT (LCY)', FRA = 'Montant en commande TVA DS';
        }
        modify("A. Rcd. Not Inv. Ex. VAT (LCY)")
        {
            CaptionML = ENU = 'A. Rcd. Not Inv. Ex. VAT (LCY)', FRA = 'Montant reçu non facturé TVA DS';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Job Task No.")
        {

            //Unsupported feature: Change TableRelation on ""Job Task No."(Field 1001)". Please convert manually.

            CaptionML = ENU = 'Job Task No.', FRA = 'N° tâche projet';
            //BC UPGRADE SHARMP16 begin<<
            trigger OnBeforeValidate()
            var
                myInt: Integer;
            begin
                //HEI.20>>
                SetFilter("Document Type", '<>%1|<>%2', rec."Document Type"::"Return Order", Rec."Document Type"::"Credit Memo");
                // IF (Rec."Document Type" <> Rec."Document Type"::"Return Order") AND (Rec."Document Type" <> Rec."Document Type"::"Credit Memo") THEN
                //HEI.20<<
            end;
            //BC UPGRADE SHARMP16 end>>
        }
        modify("Job Line Type")
        {
            CaptionML = ENU = 'Job Line Type', FRA = 'Type ligne projet';
            //OptionCaptionML = ENU = ' ,Budget,Billable,Both Budget and Billable', FRA = ' ,Budget,Facturable,Budget et Facturable';
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
        modify("Deferral Code")
        {
            CaptionML = ENU = 'Deferral Code', FRA = 'Code échelonnement';
        }
        modify("Returns Deferral Start Date")
        {
            CaptionML = ENU = 'Returns Deferral Start Date', FRA = 'Renvoie la date de début de l''échelonnement';
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
        modify("Reserved Qty. (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Qty. (Base)"(Field 5495)". Please convert manually.

            CaptionML = ENU = 'Reserved Qty. (Base)', FRA = 'Quantité réservée (base)';
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
            CaptionML = ENU = 'Duplicate in Depreciation Book', FRA = 'Dupliquer dans lois amort.';
        }
        modify("Use Duplication List")
        {
            CaptionML = ENU = 'Use Duplication List', FRA = 'Utiliser liste duplication';
        }
        modify("Responsibility Center")
        {

            //Unsupported feature: Change TableRelation on ""Responsibility Center"(Field 5700)". Please convert manually.

            CaptionML = ENU = 'Responsibility Center', FRA = 'Centre de gestion';
        }
        // modify("Cross-Reference No.")
        // {
        //     CaptionML = ENU = 'Cross-Reference No.', FRA = 'Référence externe';
        // }//BC UPGRADE  SHARMP16 field marked for removal.
        // modify("Unit of Measure (Cross Ref.)")
        // {

        //     //Unsupported feature: Change TableRelation on ""Unit of Measure (Cross Ref.)"(Field 5706)". Please convert manually.

        //     CaptionML = ENU = 'Unit of Measure (Cross Ref.)', FRA = 'Unité référence externe';
        // }//BC UPGRADE  SHARMP16 field marked for removal.
        // modify("Cross-Reference Type")
        // {
        //     CaptionML = ENU = 'Cross-Reference Type', FRA = 'Type référence externe';
        //     OptionCaptionML = ENU = ' ,Customer,Vendor,Bar Code', FRA = ' ,Client,Fournisseur,Code barre';
        // }//BC UPGRADE  SHARMP16 field marked for removal.
        // modify("Cross-Reference Type No.")
        // {
        //     CaptionML = ENU = 'Cross-Reference Type No.', FRA = 'N° type référence externe';
        // }//BC UPGRADE SHARMP16 field marked for removal.
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

        //     //Unsupported feature: Change TableRelation on ""Product Group Code"(Field 5712)". Please convert manually.

        //     CaptionML = ENU = 'Product Group Code', FRA = 'Code groupe produits';
        // }//BC UPGRADE SHARMP16 field marked for removal.
        modify("Special Order")
        {
            CaptionML = ENU = 'Special Order', FRA = 'Commande spéciale';
        }
        modify("Special Order Sales No.")
        {

            //Unsupported feature: Change TableRelation on ""Special Order Sales No."(Field 5714)". Please convert manually.

            CaptionML = ENU = 'Special Order Sales No.', FRA = 'N° vente cde spéciale';
        }
        modify("Special Order Sales Line No.")
        {

            //Unsupported feature: Change TableRelation on ""Special Order Sales Line No."(Field 5715)". Please convert manually.

            CaptionML = ENU = 'Special Order Sales Line No.', FRA = 'N° ligne vente cde spéciale';
        }
        modify("Whse. Outstanding Qty. (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""Whse. Outstanding Qty. (Base)"(Field 5750)". Please convert manually.

            CaptionML = ENU = 'Whse. Outstanding Qty. (Base)', FRA = 'Qté restante entrepôt (base)';
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
            CaptionML = ENU = 'Planned Receipt Date', FRA = 'Date planifiée de réception';
        }
        modify("Order Date")
        {
            CaptionML = ENU = 'Order Date', FRA = 'Date commande';
        }
        modify("Allow Item Charge Assignment")
        {

            //Unsupported feature: Change InitValue on ""Allow Item Charge Assignment"(Field 5800)". Please convert manually.

            CaptionML = ENU = 'Allow Item Charge Assignment', FRA = 'Autoriser affectation frais annexes';
        }
        modify("Qty. to Assign")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. to Assign"(Field 5801)". Please convert manually.

            CaptionML = ENU = 'Qty. to Assign', FRA = 'Qté à affecter';
        }
        modify("Qty. Assigned")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. Assigned"(Field 5802)". Please convert manually.

            CaptionML = ENU = 'Qty. Assigned', FRA = 'Qté affectée';
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

            //Unsupported feature: Change TableRelation on ""Operation No."(Field 99000751)". Please convert manually.

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

            //Unsupported feature: Change TableRelation on ""Prod. Order Line No."(Field 99000754)". Please convert manually.

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

        //Unsupported feature: CodeModification on "Type(Field 5).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        TestStatusOpen;

        TESTFIELD("Qty. Rcd. Not Invoiced",0);
        TESTFIELD("Quantity Received",0);
        TESTFIELD("Receipt No.",'');

        TESTFIELD("Return Qty. Shipped Not Invd.",0);
        TESTFIELD("Return Qty. Shipped",0);
        TESTFIELD("Return Shipment No.",'');

        TESTFIELD("Prepmt. Amt. Inv.",0);

        IF "Drop Shipment" THEN
          ERROR(
            Text001,
            FIELDCAPTION(Type),"Sales Order No.");
        IF "Special Order" THEN
          ERROR(
            Text001,
            FIELDCAPTION(Type),"Special Order Sales No.");
        IF "Prod. Order No." <> '' THEN
          ERROR(
            Text044,
            FIELDCAPTION(Type),FIELDCAPTION("Prod. Order No."),"Prod. Order No.");

        IF Type <> xRec.Type THEN BEGIN
          IF Quantity <> 0 THEN BEGIN
            ReservePurchLine.VerifyChange(Rec,xRec);
            CALCFIELDS("Reserved Qty. (Base)");
            TESTFIELD("Reserved Qty. (Base)",0);
            WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
          end;
          IF xRec.Type IN [Type::Item,Type::"Fixed Asset"] THEN BEGIN
            IF Quantity <> 0 THEN
              PurchHeader.TESTFIELD(Status,PurchHeader.Status::Open);
            DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
          end;
          IF xRec.Type = Type::"Charge (Item)" THEN
            DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
          IF xRec."Deferral Code" <> '' THEN
            DeferralUtilities.RemoveOrSetDeferralSchedule('',
              DeferralUtilities.GetPurchDeferralDocType,'','',
              xRec."Document Type",xRec."Document No.",xRec."Line No.",
              xRec.GetDeferralAmount,PurchHeader."Posting Date",'',xRec."Currency Code",TRUE);
        end;
        TempPurchLine := Rec;
        INIT;

        IF xRec."Line Amount" <> 0 THEN
          "Recalculate Invoice Disc." := TRUE;

        Type := TempPurchLine.Type;
        "System-Created Entry" := TempPurchLine."System-Created Entry";
        VALIDATE("FA Posting Type");

        IF Type = Type::Item THEN
          "Allow Item Charge Assignment" := TRUE
        else
          "Allow Item Charge Assignment" := FALSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetPurchHeader;
        TestStatusOpen;
        // <<DITW15.00.00.19 DDR 07/04/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.19 DDR
        GetPurchHeader;
        #3..13
        if "Drop Shipment" then
        #15..17
        if "Special Order" then
        #19..21
        if "Prod. Order No." <> '' then
        #23..26
        if Type <> xRec.Type then begin
          if Quantity <> 0 then begin
        #29..32
          end;
          if xRec.Type in [Type::Item,Type::"Fixed Asset"] then begin
            if Quantity <> 0 then
              PurchHeader.TESTFIELD(Status,PurchHeader.Status::Open);
            DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
          end;
          if xRec.Type = Type::"Charge (Item)" then
            DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
          // <<DITW15.00.00.36 DDR 18/11/2009 - DITW15.00.00.37 DDR 28/04/2010
          if (xRec.Type <> xRec.Type::"Charge (Item)") and xRec."Is Item Charge"  and
            (xRec."Item Charge Calculate per" <> xRec."Item Charge Calculate per"::Item)
          then
            DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
          // >>DITW15.00.00.37 DDR

          // <<DITW15.00.00.01 DDR 15/01/2008 - DITW15.00.00.19 DDR 22/04/2008 - DITW15.00.00.23 DDR 01/08/2008
          // <<DITW15.00.00.37 DDR 03/06/2010
          if (xRec.Type = xRec.Type::Item) and (CurrFieldNo <> 0) and
            (PurchHeader.Status <> PurchHeader.Status::Released)
          then
            DeleteAllChargePurchLines(xRec,true);
          // >>DITW15.00.00.37 DDR
          if xRec."Deferral Code" <> '' then
        #42..44
              xRec.GetDeferralAmount,PurchHeader."Posting Date",'',xRec."Currency Code",true);
        end;
        #47..49
        if xRec."Line Amount" <> 0 then
          "Recalculate Invoice Disc." := true;
        #52..56
        if Type = Type::Item then
          "Allow Item Charge Assignment" := true
        else
          "Allow Item Charge Assignment" := false;

        // <<DITW15.00.00.28 DDR 24/11/2008
        UpdateAADInfo();
        // >>DITW15.00.00.28 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""No."(Field 6).OnValidate". Please convert manually.

        //trigger "(Field 6)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "No." := FindNoFromTypedValue("No.");

        TestStatusOpen;
        TESTFIELD("Qty. Rcd. Not Invoiced",0);
        TESTFIELD("Quantity Received",0);
        TESTFIELD("Receipt No.",'');

        TESTFIELD("Prepmt. Amt. Inv.",0);

        TestReturnFieldsZero;

        IF "Drop Shipment" THEN
          ERROR(
            Text001,
            FIELDCAPTION("No."),"Sales Order No.");

        IF "Special Order" THEN
          ERROR(
            Text001,
            FIELDCAPTION("No."),"Special Order Sales No.");

        IF "Prod. Order No." <> '' THEN
          ERROR(
            Text044,
            FIELDCAPTION(Type),FIELDCAPTION("Prod. Order No."),"Prod. Order No.");

        IF "No." <> xRec."No." THEN BEGIN
          IF (Quantity <> 0) AND ItemExists(xRec."No.") THEN BEGIN
            ReservePurchLine.VerifyChange(Rec,xRec);
            CALCFIELDS("Reserved Qty. (Base)");
            TESTFIELD("Reserved Qty. (Base)",0);
            IF Type = Type::Item THEN
              WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
          end;
          IF Type = Type::Item THEN
            DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
          IF Type = Type::"Charge (Item)" THEN
            DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
        end;
        TempPurchLine := Rec;
        INIT;
        IF xRec."Line Amount" <> 0 THEN
          "Recalculate Invoice Disc." := TRUE;
        Type := TempPurchLine.Type;
        "No." := TempPurchLine."No.";
        IF "No." = '' THEN
          EXIT;
        IF Type <> Type::" " THEN BEGIN
          Quantity := TempPurchLine.Quantity;
          "Outstanding Qty. (Base)" := TempPurchLine."Outstanding Qty. (Base)";
        end;

        "System-Created Entry" := TempPurchLine."System-Created Entry";
        GetPurchHeader;
        PurchHeader.TESTFIELD("Buy-from Vendor No.");

        "Buy-from Vendor No." := PurchHeader."Buy-from Vendor No.";
        "Currency Code" := PurchHeader."Currency Code";
        "Expected Receipt Date" := PurchHeader."Expected Receipt Date";
        "Shortcut Dimension 1 Code" := PurchHeader."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := PurchHeader."Shortcut Dimension 2 Code";
        IF NOT IsServiceItem THEN
          "Location Code" := PurchHeader."Location Code";
        "Transaction Type" := PurchHeader."Transaction Type";
        "Transport Method" := PurchHeader."Transport Method";
        "Pay-to Vendor No." := PurchHeader."Pay-to Vendor No.";
        "Gen. Bus. Posting Group" := PurchHeader."Gen. Bus. Posting Group";
        "VAT Bus. Posting Group" := PurchHeader."VAT Bus. Posting Group";
        "Entry Point" := PurchHeader."Entry Point";
        Area := PurchHeader.Area;
        "Transaction Specification" := PurchHeader."Transaction Specification";
        "Tax Area Code" := PurchHeader."Tax Area Code";
        "Tax Liable" := PurchHeader."Tax Liable";
        IF NOT "System-Created Entry" AND ("Document Type" = "Document Type"::Order) AND (Type <> Type::" ") THEN
          "Prepayment %" := PurchHeader."Prepayment %";
        "Prepayment Tax Area Code" := PurchHeader."Tax Area Code";
        "Prepayment Tax Liable" := PurchHeader."Tax Liable";
        "Responsibility Center" := PurchHeader."Responsibility Center";

        "Requested Receipt Date" := PurchHeader."Requested Receipt Date";
        "Promised Receipt Date" := PurchHeader."Promised Receipt Date";
        "Inbound Whse. Handling Time" := PurchHeader."Inbound Whse. Handling Time";
        "Order Date" := PurchHeader."Order Date";
        UpdateLeadTimeFields;
        UpdateDates;

        CASE Type OF
          Type::" ":
            BEGIN
              StandardText.GET("No.");
              Description := StandardText.Description;
              "Allow Item Charge Assignment" := FALSE;
            end;
          Type::"G/L Account":
            BEGIN
              GLAcc.GET("No.");
              GLAcc.CheckGLAcc;
              IF NOT "System-Created Entry" THEN
                GLAcc.TESTFIELD("Direct Posting",TRUE);
              Description := GLAcc.Name;
              "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
              "VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
              "Tax Group Code" := GLAcc."Tax Group Code";
              "Allow Invoice Disc." := FALSE;
              "Allow Item Charge Assignment" := FALSE;
              InitDeferralCode;
            end;
          Type::Item:
            BEGIN
              GetItem;
              GetGLSetup;
              Item.TESTFIELD(Blocked,FALSE);
              Item.TESTFIELD("Gen. Prod. Posting Group");
              IF Item.Type = Item.Type::Inventory THEN BEGIN
                Item.TESTFIELD("Inventory Posting Group");
                "Posting Group" := Item."Inventory Posting Group";
              end;
              Description := Item.Description;
              "Description 2" := Item."Description 2";
              "Unit Price (LCY)" := Item."Unit Price";
              "Units per Parcel" := Item."Units per Parcel";
              "Indirect Cost %" := Item."Indirect Cost %";
              "Overhead Rate" := Item."Overhead Rate";
              "Allow Invoice Disc." := Item."Allow Invoice Disc.";
              "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
              "VAT Prod. Posting Group" := Item."VAT Prod. Posting Group";
              "Tax Group Code" := Item."Tax Group Code";
              Nonstock := Item."Created From Nonstock Item";
              "Item Category Code" := Item."Item Category Code";
              "Product Group Code" := Item."Product Group Code";
              "Allow Item Charge Assignment" := TRUE;
              PrepmtMgt.SetPurchPrepaymentPct(Rec,PurchHeader."Posting Date");

              IF Item."Price Includes VAT" THEN BEGIN
                IF NOT VATPostingSetup.GET(
                     Item."VAT Bus. Posting Gr. (Price)",Item."VAT Prod. Posting Group")
                THEN
                  VATPostingSetup.INIT;
                CASE VATPostingSetup."VAT Calculation Type" OF
                  VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                    VATPostingSetup."VAT %" := 0;
                  VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                    ERROR(
                      Text002,
                      VATPostingSetup.FIELDCAPTION("VAT Calculation Type"),
                      VATPostingSetup."VAT Calculation Type");
                end;
                "Unit Price (LCY)" :=
                  ROUND("Unit Price (LCY)" / (1 + VATPostingSetup."VAT %" / 100),
                    GLSetup."Unit-Amount Rounding Precision");
              end;

              IF PurchHeader."Language Code" <> '' THEN
                GetItemTranslation;

              "Unit of Measure Code" := Item."Purch. Unit of Measure";
              InitDeferralCode;
            end;
          Type::"3":
            ERROR(Text003);
          Type::"Fixed Asset":
            BEGIN
              FixedAsset.GET("No.");
              FixedAsset.TESTFIELD(Inactive,FALSE);
              FixedAsset.TESTFIELD(Blocked,FALSE);
              GetFAPostingGroup;
              Description := FixedAsset.Description;
              "Description 2" := FixedAsset."Description 2";
              "Allow Invoice Disc." := FALSE;
              "Allow Item Charge Assignment" := FALSE;
            end;
          Type::"Charge (Item)":
            BEGIN
              ItemCharge.GET("No.");
              Description := ItemCharge.Description;
              "Gen. Prod. Posting Group" := ItemCharge."Gen. Prod. Posting Group";
              "VAT Prod. Posting Group" := ItemCharge."VAT Prod. Posting Group";
              "Tax Group Code" := ItemCharge."Tax Group Code";
              "Allow Invoice Disc." := FALSE;
              "Allow Item Charge Assignment" := FALSE;
              "Indirect Cost %" := 0;
              "Overhead Rate" := 0;
            end;
        end;

        IF NOT (Type IN [Type::" ",Type::"Fixed Asset"]) THEN
          VALIDATE("VAT Prod. Posting Group");

        UpdatePrepmtSetupFields;

        IF Type <> Type::" " THEN BEGIN
          Quantity := xRec.Quantity;
          VALIDATE("Unit of Measure Code");
          IF Quantity <> 0 THEN BEGIN
            InitOutstanding;
            IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
              InitQtyToShip
            else
              InitQtyToReceive;
          end;
          UpdateWithWarehouseReceive;
          UpdateDirectUnitCost(FIELDNO("No."));
          IF xRec."Job No." <> '' THEN
            VALIDATE("Job No.",xRec."Job No.");
          "Job Line Type" := xRec."Job Line Type";
          IF xRec."Job Task No." <> '' THEN BEGIN
            VALIDATE("Job Task No.",xRec."Job Task No.");
            IF "No." = xRec."No." THEN
              VALIDATE("Job Planning Line No.",xRec."Job Planning Line No.");
          end;
        end;

        IF NOT ISTEMPORARY THEN
          CreateDim(
            DimMgt.TypeToTableID3(Type),"No.",
            DATABASE::Job,"Job No.",
            DATABASE::"Responsibility Center","Responsibility Center",
            DATABASE::"Work Center","Work Center No.");

        PurchHeader.GET("Document Type","Document No.");
        UpdateItemReference;

        GetDefaultBin;

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(TRUE);
          UpdateJobPrices;
        end
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.04>>
        if GUIALLOWED then
        //HEI.04<<
        #1..3
        // <<DITW15.00.00.01 DDR 08/02/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.01 DDR
        // <<DITW15.00.00.39 DDR 07/10/2011 #1396
        CheckItemExclusivityAvail(FIELDNO("No."));
        // >>DITW15.00.00.39 DDR #1396

        #4..11
        if "Drop Shipment" then
        #13..16
        if "Special Order" then
        #18..21
        if "Prod. Order No." <> '' then
        #23..26
        // <<DITW15.00.00.01 DDR 02/01/2008 - DITW15.00.00.36 DDR 15/12/2009
        if (xRec."No." <> "No.") and (CurrFieldNo <> 0) then begin
          if Type = Type::"Charge (Item)" then
            TESTFIELD("Is Item Charge",false);
        end;
        // >>DITW15.00.00.36 DDR

        if "No." <> xRec."No." then begin
          if (Quantity <> 0) and ItemExists(xRec."No.") then begin
        #29..31
            if Type = Type::Item then
              WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
          end;
          if Type = Type::Item then
            DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
          if Type = Type::"Charge (Item)" then
            DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
          // <<DITW15.00.00.36 DDR 18/11/2009 - DITW15.00.00.37 DDR 28/04/2010
          if (Type <> Type::"Charge (Item)") and "Is Item Charge"  and
            ("Item Charge Calculate per" <> "Item Charge Calculate per"::Item)
          then
            DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
          // >>DITW15.00.00.37 DDR
        end;

        // <<DITW15.00.00.35 DDR 01/07/2009
        CLEAR(SaveTempPurchChargeLine);
        SaveTempPurchChargeLine.DELETEALL;
        // >>DITW15.00.00.35 DDR

        // <<DITW15.00.00.19 DDR 22/04/2008 - DITW15.00.00.36  DDR 23/11/2009
        TransferTaxCharges.ClearBuffer();
        TransferDepositCharges.ClearBuffer();
        TransferDiscountCharges.ClearBuffer();
        TransferPromotionCharges.ClearBuffer();
        // >>DITW15.00.00.36 DDR

        TempPurchLine := Rec;
        INIT;
        if xRec."Line Amount" <> 0 then
          "Recalculate Invoice Disc." := true;
        Type := TempPurchLine.Type;
        "Manual Insert" := TempPurchLine."Manual Insert";//HEI.14
        "No." := TempPurchLine."No.";
        // <<DITW15.00.00.35 DDR 23/07/2009
        "Is Item Charge" := TempPurchLine."Is Item Charge";
        "Item Charge Type" := TempPurchLine."Item Charge Type";
        "Free Item" := TempPurchLine."Free Item";
        // >>DITW15.00.00.35 DDR
        // <<DITW17.00.02 TEC1 12/09/2013 DIT-770 #132 - DITW17.10.05 DDR 12/02/2015 DIT-770 #1118
        "Free Reason Code" := TempPurchLine."Free Reason Code";
        // >>DITW17.00.02 TEC1 DIT-770 #132 - DITW17.10.05 DDR DIT-770 #1118
        // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
        "Allow VAT Calculation (Free)" := TempPurchLine."Allow VAT Calculation (Free)";
        // >>DITW16.00.00.40 DDR DIT-715 #172
        // <<DITW15.00.00.37 DDR 04/06/2010
        Collapse := TempPurchLine.Collapse;
        // >>DITW15.00.00.37 DDR
        // <<DITW15.00.00.37 DDR 05/05/2010
        "Prod. Order No." := TempPurchLine."Prod. Order No.";
        // >>DITW15.00.00.37 DDR

        //<< DITW18.00.07 VSC 04/03/2016 DIT-770 #1702
        "Original Quantity" := TempPurchLine."Original Quantity";
        //>> DITW18.00.07 VSC DIT-770 #1702

        // <<DITW15.00.00.23 DDR 30/07/2008
        if (xRec."No." <> '') and ("No." = '') and
           (Type <> Type::" ") and (xRec.Type = Type) and
           (CurrFieldNo <> 0)
        then
          TESTFIELD("No.");
        // >>DITW15.00.00.23 DDR
        "Astro Unique ID" := TempPurchLine."Astro Unique ID";  //HEI.62

        if "No." = '' then
          exit;
        if Type <> Type::" " then begin
          Quantity := TempPurchLine.Quantity;
          "Outstanding Qty. (Base)" := TempPurchLine."Outstanding Qty. (Base)";
        end;
        #52..57
        //<<DITW17.00.02 SR 12/09/2013 DIT-770 #153
        "Linked Customer No." := PurchHeader."Linked Customer No.";
        //>>DITW17.00.02 SR 12/09/2013 DIT-770 #153
        #58..61
        if not IsServiceItem then begin
          // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
          "Physical Location Group Code" := PurchHeader."Physical Location Group Code";
          // >>DITW18.00.06 DDR DIT-770 #1191
          "Location Code" := PurchHeader."Location Code";
        end;
        #64..68
        "WHT Business Posting Group" := PurchHeader."WHT Business Posting Group";//WHT
        #69..73
        if not "System-Created Entry" and ("Document Type" = "Document Type"::Order) and (Type <> Type::" ") then
          // <<DITW15.00.00.39 DDR 10/05/2011 #718
          if not ("Is Item Charge" and (Quantity < 0)) then
          // >>DITW15.00.00.39 DDR #718
            "Prepayment %" := PurchHeader."Prepayment %";
        #76..83
        // <<DITW15.00.00.25 DDR 17/10/2008
        "Shipping Agent Code" := PurchHeader."Shipping Agent Code";
        "Shipping Agent Service Code" := PurchHeader."Shipping Agent Service Code";
        Distance := PurchHeader.Distance;
        "Shipping Charge Per" := PurchHeader."Shipping Charge Per";
        // >>DITW15.00.00.25 DDR
        // <<DITW15.00.00.35 DDR 24/06/2009
        if Type = Type::Item then
          "Free Item Posting Type" := PurchHeader."Free Item Posting Type";
        // >>DITW15.00.00.35 DDR
        // <<DITW17.10.05 MSF 17/07/2014 DIT-770 #698
        "Vendor DTax Group Code" := PurchHeader."Vendor DTax Group Code";
        // >>DITW17.10.05 MSF 17/07/2014 DIT-770 #698

        //<< DITW18.00.07 VSC 25/05/2016 DIT-770 #1984 -> #652
        Route := PurchHeader.Route;
        "Receipt Status" := PurchHeader."Receipt Status";
        "Shipment Status" :=  PurchHeader."Shipment status";
        //>> DITW18.00.07 VSC DIT-770 #1984 -> #652

        // <<DITW16.00.00.41 AHU 27/07/2012 DIT-715 #392 - 06/08/2012 DIT-715 #327
        SetFilterSubContractPostType2();
        // >>DITW16.00.00.41 AHU DIT-715 #392 #327


        UpdateLeadTimeFields;
        UpdateDates;
        //<<MANXL7.00.001 WSA 11/07/2014 #87
        if rMANXLSetup.READPERMISSION then
        //>>MANXL7.00.001 WSA 11/07/2014 #87
          //<<MANXL7.00.001 DAT 26/02/2014 #8
          if "Document Type" = "Document Type"::"Blanket Order" then begin
            "Valid Until":=  PurchHeader."Valid Until";
            "Document Date":= PurchHeader."Document Date";
          end;
          //>>MANXL7.00.001 DAT 26/02/2014 #8

        // << DITW19.00.08 SFI 18/08/2016 BL#10868
        GetGLSetup();
        // >> DITW19.00.08 SFI BL#10868

        case Type of
          Type::" ":
            begin
              StandardText.GET("No.");
              Description := StandardText.Description;
              "Allow Item Charge Assignment" := false;
              // << DITW19.00.08 SFI 18/08/2016 BL#10868
              "Allow Invoice Disc." := false;
              // >> DITW19.00.08 SFI BL#10868
            end;
          Type::"G/L Account":
            begin
              GLAcc.GET("No.");
              GLAcc.CheckGLAcc;
              if not "System-Created Entry" then
                GLAcc.TESTFIELD("Direct Posting",true);
        #100..102
              "WHT Product Posting Group" := GLAcc."WHT Product Posting Group";//WHT
              "Tax Group Code" := GLAcc."Tax Group Code";
              "Allow Invoice Disc." := false;
              // << DITW19.00.08 SFI 18/08/2016 BL#10868
              if GLSetup."Allow Invoice Disc. G/L Acc." then
                "Allow Invoice Disc." := GLAcc."Allow Invoice Disc.";
              // >> DITW19.00.08 SFI BL#10868
              "Allow Item Charge Assignment" := false;
              // <<DITW15.00.00.39 DDR 09/05/2011 #1328
              if "Is Item Charge" then
                Collapse := GLAcc.Collapse;
              // >>DITW15.00.00.39 DDR #1328
              // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
              if (GLAcc."DIT Sub-Contract Posting Type" <> GLAcc."DIT Sub-Contract Posting Type"::" ") and
                (GLAcc."DIT Sub-Contract Posting Type" <> GLAcc."DIT Sub-Contract Posting Type"::All) and
                ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ")
              then
                TESTFIELD("DIT Sub-Contract Type",GLAcc."DIT Sub-Contract Posting Type");

              if GLAcc."DIT Sub-Contract Posting Type" <> GLAcc."DIT Sub-Contract Posting Type"::All then
                "DIT Sub-Contract Type" := GLAcc."DIT Sub-Contract Posting Type";
              // >>DITW16.00.00.41 AHU DIT-715 #327
              InitDeferralCode;
              //<<FINXL7.00.001 RBE 25/03/2013
              if recFinXLSetup.READPERMISSION then
                "Auto. Acc. Group" := GLAcc."Auto. Acc. Group";
              //>>FINXL7.00.001 RBE 25/03/2013
            end;
          Type::Item:
            begin
              GetItem;
              GetGLSetup;
              Item.TESTFIELD(Blocked,false);
              // << DITW110.00.11 SFI 31/08/2017 BL#30569
              Item.BlockedSKU("Location Code","Variant Code",true);
              // >> DITW110.00.11 SFI BL#30569
              Item.TESTFIELD("Gen. Prod. Posting Group");
              if Item.Type = Item.Type::Inventory then begin
                Item.TESTFIELD("Inventory Posting Group");
                "Posting Group" := Item."Inventory Posting Group";
              end;
              ///DITW110.00.10 MSF 14/07/2017 NRQ#16224

              Description := Item.Description;
              "Description 2" := Item."Description 2";
              //<< DITW18.00.07 AKH 29/04/2016 DIT-770 #1346
              "Item Delivery Type" := Item."Item Delivery Type";
              //>> DITW18.00.07 AKH DIT-770 #1346
        #120..126
              "WHT Product Posting Group" := Item."WHT Product Posting Group";//WHT
              "Tax Group Code" := Item."Tax Group Code";
              Nonstock := Item."Created From Nonstock Item";
              // <<DITW15.00.00.28 DDR 28/11/2008
              //"Item Category Code" := Item."Item Category Code";
              VALIDATE("Item Category Code",Item."Item Category Code");
              // >>DITW15.00.00.28 DDR
              "Product Group Code" := Item."Product Group Code";
              // <<DITW18.00.06 DDR 27/02/2015 DIT-770 #1191
              //<<DITW18.00.06 MSF 08/09/2015 DIT-770 #1534
              if Item."Location Code" <> '' then begin
              //>>DITW18.00.06 DDR 08/09/2015 DIT-770 #1534
                ItemLocationCode := UserSetupMgt.GetLocation(1,Item."Location Code","Responsibility Center");
                if ItemLocationCode <> '' then
                  "Location Code" := ItemLocationCode;
              //<<DITW18.00.06 MSF 08/09/2015 DIT-770 #1534
              end;
              //>>DITW18.00.06 MSF 08/09/2015 DIT-770 #1534
              // >>DITW18.00.06 DDR DIT-770 #1191
              // <<DITW16.00.00.40 DDR 16/04/2012 DIT-715 #247
              // <<DITW16.00.00.40 DDR 16/04/2012 02/05/2012 DIT-715 #247 - DITW18.00.06 DDR 27/02/2015 DIT-770 #1191
              if (("Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"]) xor (Quantity < 0)) and
                (ItemLocationCode <> '')
              then
                "Location Code" := ItemLocationCode;
              // >>DITW16.00.00.40 DDR DIT-715 #247 - DITW18.00.06 DDR DIT-770 #1191
              // <<DITW15.00.00.35 DLE 06/09/2009 - 06/10/2009
              GetLocation("Location Code");
              // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1191
              if not UserSetupMgt.CheckLocation(1,"Location Code","Responsibility Center") then
                //<< DITW19.00.08 AKH 27/10/2016 BL#11231
                ERROR(
                  Text2014414,
                  Location.TABLECAPTION,"Location Code");
                //>> DITW19.00.08 AKH BL#11231

              if "Location Code" <> xRec."Location Code" then
                VALIDATE("Location Code");
              // >>DITW18.00.06 DDR DIT-770 #1191

              // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1191
              if Location.Code <> '' then
              // >>DITW18.00.06 DDR DIT-770 #1191
                "Physical Location Group Code" := Location."Physical Location Group Code";
              // <<DITW15.00.00.37 DDR 20/01/2010
              "Location Group Code" := Location."Location Group Code";
              // >>DITW15.00.00.37 DDR
              // >>DITW15.00.00.35 DLE 06/09/2009
              Nonstock := Item."Created From Nonstock Item";
              "Profit %" := Item."Profit %";
              "Allow Item Charge Assignment" := true;
              PrepmtMgt.SetPurchPrepaymentPct(Rec,PurchHeader."Posting Date");
              // <<DITW15.00.00.01 DDR 27/12/2007
              "Item DTax Group Code" := Item."Item DTax Group Code";
              // >>DITW15.00.00.01 DDR
              // <<DITW17.10.05 MSF 17/07/2014 DIT-770 #698
              "Vendor DTax Group Code" := GetVendorTaxGroupCode("Vendor DTax Group Code","Item DTax Group Code");
              if ("Vendor DTax Group Code" <> '') and ("Vendor DTax Group Code" <> PurchHeader."Vendor DTax Group Code") then
                TestVenorTaxRegHeader();
              // >>DITW17.10.05 MSF 17/07/2014 DIT-770 #698

              // <<DITW15.00.00.01 DDR 04/01/2007
              "Item DDeposit Group Code" := Item."Item DDeposit Group Code";
              // >>DITW15.00.00.01 DDR
              // <<DITW15.00.00.01 DDR 24/01/2008 - DITW19.00.08 DDR 17/08/2016 BL#10443
              "Unit Volume HL" := Item."Unit Volume HL" * UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
              // >>DITW15.00.00.01 DDR - DITW19.00.08 DDR BL#10443
              // <<DITW15.00.00.28 DDR 24/11/2008
              "Tariff No." := Item."Tariff No.";
              // >>DITW15.00.00.28 DDR
              //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
              if GetSKU then begin
                "Indirect Cost %" := SKU."Indirect Cost %";
                 "Overhead Rate" := SKU."Overhead Rate";
              end;
              //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185

              if Item."Price Includes VAT" then begin
                if not VATPostingSetup.GET(
                     Item."VAT Bus. Posting Gr. (Price)",Item."VAT Prod. Posting Group")
                then
                  VATPostingSetup.INIT;
                case VATPostingSetup."VAT Calculation Type" of
        #140..146
                end;
        #148..150
              end;

              // <<DITW15.00.00.35 DDR 24/06/2009
              //<< DITW110.00.12A ISL 21/06/2018 NRQ#67425
              //"Free Item" := Item."Free Item";
              "Free Item":=Item."Free Item (Purchase)";
              //>> DITW110.00.12A ISL NRQ#67425
              // <<DITW17.10.05 DDR 12/02/2015 DIT-770 #1118
              if "Free Item" then
              //<< DITW17.00.02 TEC1 12/09/2013 DIT-770 #132 - DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
                //<< DITW110.00.12A ISL 21/06/2018 NRQ#67425
                //"Free Reason Code" := Item."Free Reason Code"
                "Free Reason Code":=Item."Free Reason Code (Purchase)"
                //>> DITW110.00.12A ISL NRQ#67425
              else
                "Free Reason Code" := '';
              //>> DITW17.00.02 TEC1 DIT-770 #132 - DITW18.00.07A DDR DIT-770 #2074
              // >>DITW17.10.05 DDR DIT-770 #1118
              // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
              "Allow VAT Calculation (Free)" := Item."Allow VAT Calculation (Free)";
              // >>DITW16.00.00.40 DDR DIT-715 #172
              "Gen. Prod. Posting Free Group" := Item."Gen. Prod. Posting Free Group";
              if Item."Free Item Posting Type" <> Item."Free Item Posting Type"::" " then
                "Free Item Posting Type" := Item."Free Item Posting Type"
              else
                "Free Item Posting Type" := PurchHeader."Free Item Posting Type";
              // >>DITW15.00.00.35 DDR

              if PurchHeader."Language Code" <> '' then
        #154..157

              //? <<FINXL10.00 DDR 02/01/2017 NRQ#0
              ////<<FINXL7.00.001 RBE 20/03/2013
              //IF recFinXLSetup.READPERMISSION THEN
              //  "Tariff No." := Item."Tariff No.";
              ////>>FINXL7.00.001 RBE 20/03/2013
              //? >>INXL10.00 DDR 02/01/2017 NRQ#0

              //<<MANXL7.00.001 WSA 11/07/2014 #87
              if rMANXLSetup.READPERMISSION then
              //>>MANXL7.00.001 WSA 11/07/2014 #87
                //<<MANXL7.00.001 DAT 26/02/2014 #13
                if "Document Type" in ["Document Type"::Order] then begin
                  "Revision No." := Item.fctGetLastActiveRevision("No.");
                end;
                //>>MANXL7.00.001 DAT 26/02/2014 #13

              //? <<FINXL10.00 DDR 02/01/2017 NRQ#0
              ////<<FINXL8.00.001 BSA 04/06/2015 #51
              //IF recFinXLSetup.READPERMISSION THEN
              //  IF Item."Location Code" <> '' THEN
              //    "Location Code" := Item."Location Code";
              ////>>FINXL8.00.001 BSA 04/06/2015 #51
              //? >>FINXL10.00 DDR 02/01/2017 NRQ#0

              // <<DITW15.00.00.38 DDR 02/09/2010 #1217
              ItemUnitOfMeasure.GET("No.","Unit of Measure Code");
              // <<DITW110.00.09 DDR 13/04/2017 NRQ#13107
              VALIDATE("Packaging Type Code",ItemUnitOfMeasure."Packaging Type Code");
              // >>DITW110.00.09 DDR NRQ#13107
              // >>DITW15.00.00.38 DDR
              // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
              if ItemUnitOfMeasure."Packaging Type Code" <> '' then
                ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
              "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
              // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
              // <<DITW15.00.00.28 DDR 24/11/2008
              UpdateAADInfo();
              // >>DITW15.00.00.28 DDR
              // <<DITW15.00.00.38 DDR 01/09/2010 #1217
              "Product Tax Code" := Item."Product Tax Code";
              // >>DITW15.00.00.38 DDR
              // <<DITW15.00.00.39 DDR 23/09/2011 #1258
              if ("Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"]) and
                (Item."Service Item Group" <> '')
              then begin
                ServItemGroup.GET(Item."Service Item Group");
                if ServItemGroup."Default Return Reason Code" <> '' then
                  VALIDATE("Return Reason Code",ServItemGroup."Default Return Reason Code");
              end;
              // >>DITW15.00.00.39 DDR  #1258
              // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868 - DITW17.10.05 DDR 12/02/2015 DIT-770 #1118
              VALIDATE("Free Item");
              // >>DITW17.10.05 DDR DIT-770 #868 - DITW17.10.05 DDR DIT-770 #1118
              // <<DITW19.00.08 DDR 17/08/2016 17/10/2016 BL#10443
              "Strength Spec. Code" := Item."Strength Spec. Code";
              "Vol-Strength Spec. Code" := Item."Vol-Strength Spec. Code";
              // >>DITW19.00.08 DDR BL#10443
              // << DITW110.00.11 SFI 30/08/2017 BL#14417
              GetDepositValue;
              // >> DITW110.00.11 SFI BL#14417
            end;
        #159..161
            begin
              FixedAsset.GET("No.");
              FixedAsset.TESTFIELD(Inactive,false);
              FixedAsset.TESTFIELD(Blocked,false);
              GetFAPostingGroup;
              "WHT Product Posting Group" := FixedAsset."WHT Product Posting Group";//WHT
              Description := FixedAsset.Description;
              "Description 2" := FixedAsset."Description 2";
              "Allow Invoice Disc." := false;
              // << DITW19.00.08 SFI 18/08/2016 BL#10868
              if GLSetup."Allow Invoice Disc. FA" then
                "Allow Invoice Disc." := FixedAsset."Allow Invoice Disc.";
              // >> DITW19.00.08 SFI BL#10868
              "Allow Item Charge Assignment" := false;
              // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
              //<<DITW17.10.05 MSF 16/07/2014 DIT-770 #690
              if FixedAsset."Financial Contract No."<>'' then
              //>>DITW17.10.05 MSF 16/07/2014 DIT-770 #690
                VALIDATE("Contract Type","Contract Type"::Financial)
              //<<DITW17.10.05 MSF 16/07/2014 DIT-770 #690
              //<< DITW18.00.07 VSC 11/01/2016 DIT-770 #1751
              else begin
                "Contract Type":="Contract Type"::" ";
              end;
              //>> DITW18.00.07 VSC DIT-770 #1751
              //>>DITW17.10.05 MSF 16/07/2014 DIT-770 #690
              FixedAsset.CALCFIELDS("DIT Sub-Contract Type");
              "DIT Sub-Contract Type" := FixedAsset."DIT Sub-Contract Type";
              //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
              if FixedAsset."Financial Contract No." <> "Financial Contract No." then
                VALIDATE("Financial Contract No.",FixedAsset."Financial Contract No.");
              //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
              // >>DITW16.00.00.41 AHU DIT-715 #327
            end;
          Type::"Charge (Item)":
            begin
              ItemCharge.GET("No.");
              // <<DITW16.00.00.43 DDR 27/08/2013 DIT-715 #742
              if (CurrFieldNo <> 0) and (ItemCharge."Item Charge Type" <> "Item Charge Type"::" ") and
                 (ItemCharge."Item Charge Type" <> ItemCharge."Item Charge Type"::ShippingCost) then //>>HEI.31 FDD-HT658 IBM.GUNERE01 01.10.2019
                ItemCharge.FIELDERROR("Item Charge Type");
              // >>DITW16.00.00.43 DDR DIT-715 #742
        #175..178
              "WHT Product Posting Group" := ItemCharge."WHT Product Posting Group";//WHT
              "Allow Invoice Disc." := false;
              // << DITW19.00.08 SFI 18/08/2016 BL#10868
              if GLSetup."Allow Invoice Disc. Item Chrg." then
                "Allow Invoice Disc." := ItemCharge."Allow Invoice Disc.";
              // >> DITW19.00.08 SFI BL#10868
              "Allow Item Charge Assignment" := false;
              "Indirect Cost %" := 0;
              "Overhead Rate" := 0;
              // <<DITW15.00.00.01 DDR 02/01/2008
              "Item Charge Type" := ItemCharge."Item Charge Type";
              // >>DITW15.00.00.01 DDR
              // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
              "Gen. Prod. Posting Free Group" := ItemCharge."Gen. Prod. Posting Free Group";
              // >>DITW16.00.00.40 DDR DIT-715 #172
            end;
        end;

        if not (Type in [Type::" ",Type::"Fixed Asset"]) then begin
          VALIDATE("VAT Prod. Posting Group");
          //WHT>>
          VALIDATE("WHT Product Posting Group");
        end;
          //WHT<<
        #188..190
        if Type <> Type::" " then begin
          Quantity := xRec.Quantity;
          VALIDATE("Unit of Measure Code");
          if Quantity <> 0 then begin
            InitOutstanding;
            if "Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"] then
              InitQtyToShip
            else
              InitQtyToReceive;
            //<< DITW18.00.07 AKH 29/04/2016 DIT-770 #1346
            if "Document Type" = "Document Type"::Order then
              CalcDeliveryTimeQtyBase();
            //>> DITW18.00.07 AKH DIT-770 #1346
          end;
          UpdateWithWarehouseReceive;
          UpdateDirectUnitCost(FIELDNO("No."));

          // <<DITW15.00.00.39 DDR 23/09/2011 #1258
          if "Return Reason Code" <> '' then
            VALIDATE("Return Reason Code");
          // >>DITW15.00.00.39 DDR  #1258

          // <<DITW15.00.00.35 DDR 25/06/2009
          if ("Free Item") and (Type = Type::Item) then
            VALIDATE("Free Item");
          // >>DITW15.00.00.35 DDR

          if xRec."Job No." <> '' then
            VALIDATE("Job No.",xRec."Job No.");
          "Job Line Type" := xRec."Job Line Type";
          if xRec."Job Task No." <> '' then begin
            VALIDATE("Job Task No.",xRec."Job Task No.");
            if "No." = xRec."No." then
              VALIDATE("Job Planning Line No.",xRec."Job Planning Line No.");
          end;
        end;

          // <<DITW15.00.00.38 DDR 27/01/2011 #1259
          // <<DITW18.00.06 DDR 16/09/2015 18/09/2015 05/11/2015 DIT-770 #1592
          // <<DITW110.00.08 DDR 02/01/2017 NRQ#0
          //IF NOT ISTEMPORARY THEN
          if not ISTEMPORARY and (CurrFieldNo = FIELDNO("No.")) or ((CurrFieldNo = 0) and ("Line No." <> 0)) then
          // >>DITW110.00.08 DDR NRQ#0
          // >>DITW18.00.06 DDR DIT-770 #1592
            CreateDim(
              DimMgt.TypeToTableID3(Type),"No.",
              DATABASE::Job,"Job No.",
              DATABASE::"Responsibility Center","Responsibility Center",
              DATABASE::"Work Center","Work Center No.",
              // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
              //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
              DimMgt.TypeToTableID2034932(2,"Contract Type"),GetContractNo(),
              //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
              // >>DITW16.00.00.41 AHU DIT-715 #327
              // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
              DimMgt.TypeToTableID3(Type::Item),"Tax Item No.",
              // >>DITW16.00.00.43 DDR DIT-715 #768
              //<<DITW110.00.10 MSF 21/05/2017 NRQ#13382
              DATABASE::Customer,"Linked Customer No.");
              //>>DITW110.00.10 MSF 21/05/2017 NRQ#13382

          // >>DITW15.00.00.38 DDR #1259

        //<<DITW18.00.06 MVN 14/10/2015 DIT-770 #1650
        //PurchHeader.GET("Document Type","Document No.");
        GetPurchHeader();
        //>>DITW18.00.06 MVN 14/10/2015 DIT-770 #1650
        #221..224
        if JobTaskIsSet then begin
          CreateTempJobJnlLine(true);

          //HEI.20>>
          if (Rec."Document Type" <> Rec."Document Type"::"Return Order") and (Rec."Document Type" <> Rec."Document Type"::"Credit Memo")  then
          //HEI.20<<
          UpdateJobPrices;
        end;

        // <<DITW15.00.00.24 DDR 20/08/2008 - DITW15.00.00.35 DDR 01/07/2009
        if (CurrFieldNo = FIELDNO("No.")) and
           (Type = Type::Item)  and
           (not BatchInsertCheckSuspended)
        then begin
          COMMIT;
          // <<DITW15.00.00.35 DDR 29/06/2009
          if "Line No." <> 0 then begin
            if TransferExtText.PurchCheckIfAnyExtText(Rec,false) then
              TransferExtText.InsertPurchExtText(Rec);
            COMMIT;
          end;
          // >>DITW15.00.00.35 DDR

          // <<DITW15.00.00.36 DDR 17/11/2009 - DITW15.00.00.37 DDR 04/05/2010
          if (Type = Type::Item) and ("Quantity Invoiced" = 0) and
            ("Quantity Received" = 0) and ("Return Qty. Shipped" = 0) and
            ("Appl.-to Item Entry" = 0) and
            ("Receipt No." = '') and ("Return Shipment No." = '')
          then begin
            if (Quantity <> 0) or (xRec.Quantity <> Quantity) then begin
              // <<DITW15.00.00.38 DDR 27/01/2011 #1259
              lTempCurrfieldno := CurrFieldNo;
              // >>DITW15.00.00.38 DDR #1259
              CurrFieldNo := FIELDNO("Location Code");
              InsertCharges3(FIELDNO("Location Code"));
              // <<DITW15.00.00.38 DDR 27/01/2011 #1259
              CurrFieldNo := lTempCurrfieldno;
              // >>DITW15.00.00.38 DDR #1259
              // <<DITW17.10.05 DDR 15/12/2014 DIT-770 #1110
              UpdateAmounts;
              // >>DITW17.10.05 DDR DIT-770 #1110
            end else
              DeleteAllChargePurchLines(Rec,true);
          end;
          // >>DITW15.00.00.37 DDR
        end;
        // >>DITW15.00.00.35 DDR
        //HEI.66>>
        "Due Date" := PurchHeader."Due Date";
        if (PurchHeader."Payment Terms Code" <> '') and (Rec."Expected Receipt Date" <> 0D) then begin
           PaymentTerms.GET(PurchHeader."Payment Terms Code");
        "Estimated Pmt. Due Date" := CALCDATE(PaymentTerms."Due Date Calculation",Rec."Expected Receipt Date");
        end;
        //HEI.66<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Field 7).OnValidate". Please convert manually.

        //trigger (Variable: lTempBatchInsertCheckSuspended)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;

        IF "Location Code" <> '' THEN
          IF IsServiceItem THEN
            Item.TESTFIELD(Type,Item.Type::Inventory);
        IF xRec."Location Code" <> "Location Code" THEN BEGIN
          IF "Prepmt. Amt. Inv." <> 0 THEN
            IF NOT CONFIRM(Text046,FALSE,FIELDCAPTION("Direct Unit Cost"),FIELDCAPTION("Location Code"),PRODUCTNAME.FULL) THEN BEGIN
              "Location Code" := xRec."Location Code";
              EXIT;
            end;
          TESTFIELD("Qty. Rcd. Not Invoiced",0);
          TESTFIELD("Receipt No.",'');

          TESTFIELD("Return Qty. Shipped Not Invd.",0);
          TESTFIELD("Return Shipment No.",'');
        end;

        IF "Drop Shipment" THEN
          ERROR(
            Text001,
            FIELDCAPTION("Location Code"),"Sales Order No.");
        IF "Special Order" THEN
          ERROR(
            Text001,
            FIELDCAPTION("Location Code"),"Special Order Sales No.");

        IF "Location Code" <> xRec."Location Code" THEN
          InitItemAppl;

        IF (xRec."Location Code" <> "Location Code") AND (Quantity <> 0) THEN BEGIN
          ReservePurchLine.VerifyChange(Rec,xRec);
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
          UpdateWithWarehouseReceive;
        end;
        "Bin Code" := '';

        IF Type = Type::Item THEN
          UpdateDirectUnitCost(FIELDNO("Location Code"));

        IF "Location Code" = '' THEN BEGIN
          IF InvtSetup.GET THEN
            "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
        end else
          IF Location.GET("Location Code") THEN
            "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";

        UpdateLeadTimeFields;
        UpdateDates;

        GetDefaultBin;
        CheckWMS;

        IF "Document Type" = "Document Type"::"Return Order" THEN
          ValidateReturnReasonCode(FIELDNO("Location Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        UpdateTINBAndVATProdPostGrByLocation; //HEI.21
        // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1191
        // <<DITW18.00.06 DDR 05/11/2015 DIT-770 #1592
        if (("Responsibility Center" = xRec."Responsibility Center") or ("No." <> xRec."No.")) and
          ("Location Code" <> xRec."Location Code")
        then begin
        // >>DITW18.00.06 DDR DIT-770 #1592
          GetLocation("Location Code");
          // <<DITW18.00.06 DDR 16/09/2015 DIT-770 #1592
          "Responsibility Center" := UserSetupMgt.GetFirstRespCenter(1,Location."Physical Location Group Code","Location Code");
          // >>DITW18.00.06 DDR DIT-770 #1592
        end;
        // >>DITW18.00.06 DDR DIT-770 #1191

        // <<DITW18.00.06 DDR 19/02/2015 26/02/2015 DIT-770 #1191
        if (("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> '')) or
          ("Responsibility Center" <> xRec."Responsibility Center")
        then
          if not UserSetupMgt.CheckLocation(1,"Location Code","Responsibility Center") then
            //<< DITW19.00.08 AKH 27/10/2016 BL#11231
            ERROR(
              Text2014414,
              Location.TABLECAPTION,"Location Code");
            //>> DITW19.00.08 AKH BL#11231
        // >>DITW18.00.06 DDR DIT-770 #1191

        if "Location Code" <> '' then
          if IsServiceItem then
            Item.TESTFIELD(Type,Item.Type::Inventory);
        if xRec."Location Code" <> "Location Code" then begin
          //>>HEI.50
          //IF "Prepmt. Amt. Inv." <> 0 THEN
          if (("Prepmt. Amt. Inv." <> 0) and (GUIALLOWED)) then
          //<<HEI.50
            if not CONFIRM(Text046,false,FIELDCAPTION("Direct Unit Cost"),FIELDCAPTION("Location Code"),PRODUCTNAME.FULL) then begin
              "Location Code" := xRec."Location Code";
              exit;
            end;
        #12..16
        end;

        if "Drop Shipment" then
        #20..22
        if "Special Order" then
        #24..27
        if "Location Code" <> xRec."Location Code" then
          InitItemAppl;

        // <<DITW18.00.06 DDR 19/02/2015 DIT-770 #1191
        if "Location Code" <> '' then begin
          Location.GET("Location Code");
          if Location."Physical Location Group Code" <> "Physical Location Group Code" then
            "Physical Location Group Code" := Location."Physical Location Group Code";
        end;
        // >>DITW18.00.06 DDR DIT-770 #1191
        if xRec."Physical Location Group Code" = "Physical Location Group Code" then
          VALIDATE("Physical Location Group Code");
        // >>DITW18.00.06 DDR DIT-770 #1191

        if (xRec."Location Code" <> "Location Code") and (Quantity <> 0) then begin
          // <<DITW15.00.00.37 DDR 04/05/2010 (moved)
          //ReservePurchLine.VerifyChange(Rec,xRec);
          // >>DITW15.00.00.37 DDR 04/05/2010 (moved)
          // <<DITW16.00.00.40 DDR 16/04/2012 DIT-715 #247 - DITW18.00.06 DDR 27/02/2015 DIT-770 #1191 (moved)
          //WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
          // >>DITW16.00.00.40 DDR 16/04/2012 DIT-715 #247 - DITW18.00.06 DDR 27/02/2015 DIT-770 #1191 (moved)
          UpdateWithWarehouseReceive;
        end;
        "Bin Code" := '';

        if Type = Type::Item then begin
          // <<DITW15.00.00.37 DDR 04/05/2010
          lTempBatchInsertCheckSuspended := BatchInsertCheckSuspended;
          BatchInsertCheckSuspended := true;
          // >>DITW15.00.00.37 DDR
          UpdateDirectUnitCost(FIELDNO("Location Code"));
          // <<DITW15.00.00.37 DDR 04/05/2010
          BatchInsertCheckSuspended := lTempBatchInsertCheckSuspended;
          // >>DITW15.00.00.37 DDR

          // <<DITW15.00.00.01 DDR 28/01/2008
          UpdateWithWarehouseReceive;
          // >>DITW15.00.00.01 DDR
        end;

        if "Location Code" = '' then begin
          if InvtSetup.GET then
            "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
        end else
          if Location.GET("Location Code") then
        #46..51

        // <<DITW15.00.00.35 DLE 06/09/2009 - 06/10/2009
        // <<DITW15.00.00.37 DDR 20/01/2010
        // <<DITW18.00.06 DDR 02/03/2015 DIT-770 #1191
          GetLocation("Location Code");
          if Location.Code <> '' then begin
            "Location Group Code" := Location."Location Group Code";
          end else begin
            "Location Group Code" := '';
          end;
        if Type = Type::Item then begin
            //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
            if GetSKU then begin
              "Indirect Cost %" := SKU."Indirect Cost %";
              "Overhead Rate" := SKU."Overhead Rate";
        end;
            //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
        end;
        // >>DITW18.00.06 DDR DIT-770 #1191

        // << DITW110.00.11 SFI 30/08/2017 BL#14417
        if Type = Type::Item then
          GetDepositValue;
        // >> DITW110.00.11 SFI BL#14417

        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        if (Type = Type::Item) then begin
          GetItem();
          Item.BlockedSKU("Location Code","Variant Code",true);
        end;
        // >> DITW110.00.11 SFI BL#30569
        // <<DITW15.00.00.37 DDR 04/05/2010
        if (Type = Type::Item) and ((Quantity <> 0) or (xRec.Quantity <> Quantity)) then
          InsertCharges3(FIELDNO("Location Code"));

        // <<DITW18.00.06 DDR 16/09/2015 05/11/2015 DIT-770 #1592
        if ("Responsibility Center" <> xRec."Responsibility Center") and
          ("Location Code" <> xRec."Location Code") and
          (CurrFieldNo = FIELDNO("Location Code"))
        then
          VALIDATE("Responsibility Center");
        // >>DITW18.00.06 DDR DIT-770 #1592

        // <<DITW15.00.00.38 DDR 30/08/2010 #1217
        UpdateAADInfo();
        // >>DITW15.00.00.38 DDR

        if (xRec."Location Code" <> "Location Code") and (Quantity <> 0) then begin
          ReservePurchLine.VerifyChange(Rec,xRec);
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        end;
        // >>DITW15.00.00.37 DDR

        CheckWMS;

        if "Document Type" = "Document Type"::"Return Order" then
          ValidateReturnReasonCode(FIELDNO("Location Code"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Expected Receipt Date"(Field 10).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT TrackingBlocked THEN
          CheckDateConflict.PurchLineCheck(Rec,CurrFieldNo <> 0);

        CheckReservationDateConflict(FIELDNO("Expected Receipt Date"));

        IF "Expected Receipt Date" <> 0D THEN
          VALIDATE(
            "Planned Receipt Date",
            CalendarMgmt.CalcDateBOC2(InternalLeadTimeDays("Expected Receipt Date"),"Expected Receipt Date",
              CalChange."Source Type"::Location,"Location Code",'',
              CalChange."Source Type"::Location,"Location Code",'',FALSE))
        else
          VALIDATE("Planned Receipt Date","Expected Receipt Date");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not TrackingBlocked then
        #2..5
        if "Expected Receipt Date" <> 0D then
        #7..10
              CalChange."Source Type"::Location,"Location Code",'',false))
        else
          VALIDATE("Planned Receipt Date","Expected Receipt Date");

        // <<DITW15.00.00.01 DDR 18/12/2007 - 14/01/2008
        // <<DITW15.00.00.19 DDR 07/04/2008 - DITW15.00.00.37 DDR 09/06/2010
        if (Type = Type::Item) and (CurrFieldNo <> 0) and
          (xRec."Expected Receipt Date" <> "Expected Receipt Date")
        then
          UpdateCharges(FIELDNO("Expected Receipt Date"),true);
        // >>DITW15.00.00.37 DDR

        //HEI.24>>
        if PurchSetup.GET then begin
          PurchaseLine.SETRANGE("Document Type","Document Type");
          PurchaseLine.SETRANGE("Document No.","Document No.");
          PurchaseLine.SETFILTER(Type,'%1',PurchaseLine.Type::Item);
          PurchaseLine.SETFILTER("Item Category Code",PurchSetup."Item Category");
          if not PurchaseLine.FINDFIRST then
            ItemCategoryBool := false
          else
            ItemCategoryBool := true;
          if ItemCategoryBool then begin
        //HEI.24<<
         //HEI.22>>
            if ("SRM Order No." = '') and (("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::"Return Order"))
              and (Type = Type::Item) and ("Item Category Code" = PurchSetup."Item Category") then begin //HEI.43
                PurchHdrArch.RESET;
                PurchHdrArch.SETRANGE(PurchHdrArch."Document Type","Document Type");
                PurchHdrArch.SETRANGE(PurchHdrArch."No.","Document No.");
                if PurchHdrArch.FINDFIRST then begin
                  PurchHeader.RESET;
                  PurchHeader.SETRANGE(PurchHeader."No.","Document No.");
                  if PurchHeader.FINDFIRST then begin
                    if PurchHeader."Purch. Reason Code" = '' then
                       ERROR(ReasonCodeErr);
                    end;
                end;
            end;
        //HEI.22<<
          end;
        //HEI.24>>
          end;
        //end;
        //HEI.24<<

        {
        //HEI.22>>
        IF ("SRM Order No." = '') AND (("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order")) THEN BEGIN
            PurchHdrArch.RESET;
            PurchHdrArch.SETRANGE(PurchHdrArch."Document Type","Document Type");
            PurchHdrArch.SETRANGE(PurchHdrArch."No.","Document No.");
            IF PurchHdrArch.FINDFIRST THEN BEGIN
              PurchHeader.RESET;
              PurchHeader.SETRANGE(PurchHeader."No.","Document No.");
              IF PurchHeader.FINDFIRST THEN BEGIN
                IF PurchHeader."Purch. Reason Code" = '' THEN
                   ERROR(ReasonCodeErr);
                end;
            end;
        end;
        //HEI.22<<
        }
        */
        //end;


        //Unsupported feature: CodeModification on "Description(Field 11).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type = Type::" " THEN
          EXIT;

        IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
          Item.SETFILTER(Description,'''@' + CONVERTSTR(Description,'''','?') + '''');
          IF NOT Item.FINDFIRST THEN
            EXIT;
          IF Item."No." = "No." THEN
            EXIT;
          IF IsReceivedFromOcr THEN
            EXIT;
          IF CONFIRM(AnotherItemWithSameDescrQst,FALSE,Item."No.",Item.Description) THEN
            VALIDATE("No.",Item."No.");
        end else
          IF "No." = '' THEN
            IF TypeHelper.FindRecordByDescription(ReturnValue,Type,Description) = 1 THEN BEGIN
              CurrFieldNo := FIELDNO("No.");
              VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN("No.")));
            end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Type = Type::" " then
          exit;

        if (Type = Type::Item) and ("No." <> '') then begin
          Item.SETFILTER(Description,'''@' + CONVERTSTR(Description,'''','?') + '''');
          if not Item.FINDFIRST then
            exit;
          if Item."No." = "No." then
            exit;
          if IsReceivedFromOcr then
            exit;
          //>>HEI.50
          if GUIALLOWED then begin
          //<<HEI.50
            if CONFIRM(AnotherItemWithSameDescrQst,false,Item."No.",Item.Description) then
              VALIDATE("No.",Item."No.");
          //>>HEI.50
          end else begin
            VALIDATE("No.",Item."No.");
          end;
          //<<HEI.50
        end else
          if "No." = '' then
            if TypeHelper.FindRecordByDescription(ReturnValue,Type,Description) = 1 then begin
              CurrFieldNo := FIELDNO("No.");
              VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN("No.")));
            end;
        */
        //end;


        //Unsupported feature: CodeInsertion on "Quantity(Field 15).OnValidate". Please convert manually.

        //trigger (Variable: lrBlankedOrderLine)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on "Quantity(Field 15).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;

        IF "Drop Shipment" AND ("Document Type" <> "Document Type"::Invoice) THEN
          ERROR(
            Text001,
            FIELDCAPTION(Quantity),"Sales Order No.");
        "Quantity (Base)" := CalcBaseQty(Quantity);
        IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN BEGIN
          IF (Quantity * "Return Qty. Shipped" < 0) OR
             ((ABS(Quantity) < ABS("Return Qty. Shipped")) AND ("Return Shipment No." = ''))
          THEN
            FIELDERROR(Quantity,STRSUBSTNO(Text004,FIELDCAPTION("Return Qty. Shipped")));
          IF ("Quantity (Base)" * "Return Qty. Shipped (Base)" < 0) OR
             ((ABS("Quantity (Base)") < ABS("Return Qty. Shipped (Base)")) AND ("Return Shipment No." = ''))
          THEN
            FIELDERROR("Quantity (Base)",STRSUBSTNO(Text004,FIELDCAPTION("Return Qty. Shipped (Base)")));
        end else BEGIN
          IF (Quantity * "Quantity Received" < 0) OR
             ((ABS(Quantity) < ABS("Quantity Received")) AND ("Receipt No." = ''))
          THEN
            FIELDERROR(Quantity,STRSUBSTNO(Text004,FIELDCAPTION("Quantity Received")));
          IF ("Quantity (Base)" * "Qty. Received (Base)" < 0) OR
             ((ABS("Quantity (Base)") < ABS("Qty. Received (Base)")) AND ("Receipt No." = ''))
          THEN
            FIELDERROR("Quantity (Base)",STRSUBSTNO(Text004,FIELDCAPTION("Qty. Received (Base)")));
        end;

        IF (Type = Type::"Charge (Item)") AND (CurrFieldNo <> 0) THEN BEGIN
          IF (Quantity = 0) AND ("Qty. to Assign" <> 0) THEN
            FIELDERROR("Qty. to Assign",STRSUBSTNO(Text011,FIELDCAPTION(Quantity),Quantity));
          IF (Quantity * "Qty. Assigned" < 0) OR (ABS(Quantity) < ABS("Qty. Assigned")) THEN
            FIELDERROR(Quantity,STRSUBSTNO(Text004,FIELDCAPTION("Qty. Assigned")));
        end;

        IF "Receipt No." <> '' THEN
          CheckReceiptRelation
        else
          IF "Return Shipment No." <> '' THEN
            CheckRetShptRelation;

        IF (xRec.Quantity <> Quantity) OR (xRec."Quantity (Base)" <> "Quantity (Base)") OR
           ("No." = xRec."No.")
        THEN BEGIN
          InitOutstanding;
          IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
            InitQtyToShip
          else
            InitQtyToReceive;
        end;
        IF (Quantity * xRec.Quantity < 0) OR (Quantity = 0) THEN
          InitItemAppl;

        IF Type = Type::Item THEN
          UpdateDirectUnitCost(FIELDNO(Quantity))
        else
          VALIDATE("Line Discount %");

        UpdateWithWarehouseReceive;
        IF (xRec.Quantity <> Quantity) OR (xRec."Quantity (Base)" <> "Quantity (Base)") THEN BEGIN
          ReservePurchLine.VerifyQuantity(Rec,xRec);
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
          CheckApplToItemLedgEntry;
        end;

        IF (xRec.Quantity <> Quantity) AND (Quantity = 0) AND
           ((Amount <> 0) OR ("Amount Including VAT" <> 0) OR ("VAT Base Amount" <> 0))
        THEN BEGIN
          Amount := 0;
          "Amount Including VAT" := 0;
          "VAT Base Amount" := 0;
        end;

        UpdatePrePaymentAmounts;

        IF "Job Planning Line No." <> 0 THEN
          VALIDATE("Job Planning Line No.");

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(TRUE);
          UpdateJobPrices;
        end;

        CheckWMS;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        //HEI.21>>
        if "TIN No." = '' then
          UpdateTINBAndVATProdPostGrByLocation;
        //HEI.21<<

        //<< DITW18.00.07 VSC 17/06/2016 DIT-770 #1703
        UpdateOriginalQuantity;
        //>> DITW18.00.07 VSC DIT-770 #1703

        // <<DITW15.00.00.19 DDR 07/04/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.19 DDR

        //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
        if not DropSpecialCheckSuspended then
        //>> DITW18.00.07 AKH DIT-770 #1425
          if "Drop Shipment" and ("Document Type" <> "Document Type"::Invoice) then
            ERROR(
              Text001,
              FIELDCAPTION(Quantity),"Sales Order No.");
        "Quantity (Base)" := CalcBaseQty(Quantity);
        if "Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"] then begin
          if (Quantity * "Return Qty. Shipped" < 0) or
             ((ABS(Quantity) < ABS("Return Qty. Shipped")) and ("Return Shipment No." = ''))
          then
            FIELDERROR(Quantity,STRSUBSTNO(Text004,FIELDCAPTION("Return Qty. Shipped")));
          if ("Quantity (Base)" * "Return Qty. Shipped (Base)" < 0) or
             ((ABS("Quantity (Base)") < ABS("Return Qty. Shipped (Base)")) and ("Return Shipment No." = ''))
          then
            FIELDERROR("Quantity (Base)",STRSUBSTNO(Text004,FIELDCAPTION("Return Qty. Shipped (Base)")));
        end else begin
          if (Quantity * "Quantity Received" < 0) or
             ((ABS(Quantity) < ABS("Quantity Received")) and ("Receipt No." = ''))
          then
            FIELDERROR(Quantity,STRSUBSTNO(Text004,FIELDCAPTION("Quantity Received")));
          if ("Quantity (Base)" * "Qty. Received (Base)" < 0) or
             ((ABS("Quantity (Base)") < ABS("Qty. Received (Base)")) and ("Receipt No." = ''))
          then
            FIELDERROR("Quantity (Base)",STRSUBSTNO(Text004,FIELDCAPTION("Qty. Received (Base)")));
        end;

        // <<DITW15.00.00.01 DDR 24/01/2008 - DITW15.00.00.24 DDR 06/10/2008
        if (Quantity <> 1) and (CurrFieldNo <> 0) then
          case "Extra Charge Type" of
            "Extra Charge Type"::"Fixed Amount":
              TESTFIELD(Quantity, 1);
            "Extra Charge Type"::VolumeHL:
              begin
                if "Attached to Line No." <> 0 then begin
                  PurchLine2.GET("Document Type","Document No.","Attached to Line No.");
                  PurchLine2.TESTFIELD("Unit Volume HL");
                  TESTFIELD(Quantity, PurchLine2."Unit Volume HL");
                end;
              end;
          end;
        // >>DITW15.00.00.24 DDR

        // <<DITW15.00.00.19 DDR 19/05/2008 - DITW15.00.00.26 DDR 31/10/2008 - DITW114.00.15 DDR 24/04/2020 29/04/2020 NRQ#102424
        //HEI.64>>
        // IF (CurrFieldNo = FIELDNO(Quantity)) AND
        //   (xRec.Quantity <> Quantity) AND (Quantity <> 0) AND
        //   ((Type <> Type::Item) OR ("Qty. Rcd. Not Invoiced" = 0)) AND
        //   NOT ("Item Charge Type" IN ["Item Charge Type"::" ","Item Charge Type"::Promotion]) AND NOT "Free Item" AND
        //   NOT (("Item Charge Calculate per" IN ["Item Charge Calculate per"::Period]))
        // THEN
        //  TESTFIELD(Quantity, xRec.Quantity);
        //HEI.64<<
        // >>DITW15.00.00.26 DDR - DITW114.00.15 DDR NRQ#102424

        // <<DITW15.00.00.39 DDR 10/05/2011 #718
        if "Is Item Charge" and (Quantity < 0) then
          VALIDATE("Prepayment %",0);
        // >>DITW15.00.00.39 DDR #718

        // <<DITW15.00.00.39 DDR 12/04/2011 #1303
        if (Type = Type::Item) and (Quantity = 0) and (xRec.Quantity <> Quantity) and
          ("Quantity Invoiced" = 0) and ("Quantity Received" = 0) and ("Return Qty. Shipped" = 0) and
          ("Appl.-to Item Entry" = 0) and
          ("Receipt No." = '') and ("Return Shipment No." = '') and
          // <<DITW17.10.03 DDR 26/06/2014 DIT-770 #570 - DITW110.00.12A MSF 17/07/2018 NRQ#78507
          ("Line No." <> 0)
          // >>DITW17.10.03 DDR DIT-770 #570 - DITW110.00.12A MSF NRQ#78507
          ///DITW110.00.12A MSF 17/07/2018 NRQ#78507
        then begin
          CLEAR(SaveTempPurchChargeLine);
          SaveTempPurchChargeLine.DELETEALL;
          TransferTaxCharges.ClearBuffer();
          TransferDepositCharges.ClearBuffer();
          TransferDiscountCharges.ClearBuffer();
          TransferPromotionCharges.ClearBuffer();
          DeleteAllChargePurchLines(Rec,true);
          // <<DITW16.00.00.43 DDR 23/08/2013 DIT-715 #691
          if "Item Charge Value" <> "Direct Unit Cost" then
            VALIDATE("Direct Unit Cost","Item Charge Value");
          // >>DITW16.00.00.43 DDR DIT-715 #691
        end;
        // >>DITW15.00.00.39 DDR #1303

        // <<DITW15.00.00.01 DDR 04/02/2008 - DITW15.00.00.19 DDR 22/04/2008
        if (Type = Type::"Charge (Item)") and (CurrFieldNo <> 0) and ("Line No." <> 0) then begin
          if (Quantity = 0) and ("Qty. to Assign" <> 0) then
            FIELDERROR("Qty. to Assign",STRSUBSTNO(Text011,FIELDCAPTION(Quantity),Quantity));
          if (Quantity * "Qty. Assigned" < 0) or (ABS(Quantity) < ABS("Qty. Assigned")) then
            FIELDERROR(Quantity,STRSUBSTNO(Text004,FIELDCAPTION("Qty. Assigned")));
        end;

        // <<DITW17.00.02 DDR 28/11/2013 DIT-715 #273
        if not BatchInsertCheckSuspended then
        // >>DITW17.00.02 DDR DIT-715 #273
          if "Receipt No." <> '' then
            CheckReceiptRelation
          else
            if "Return Shipment No." <> '' then
              CheckRetShptRelation;

        if (xRec.Quantity <> Quantity) or (xRec."Quantity (Base)" <> "Quantity (Base)") or
           ("No." = xRec."No.")
        then begin
          InitOutstanding;
          if "Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"] then
            InitQtyToShip
          else
            InitQtyToReceive;
          //<< DITW18.00.07 AKH 29/04/2016 DIT-770 #1346
          if "Document Type" = "Document Type"::Order then
            CalcDeliveryTimeQtyBase();
          //>> DITW18.00.07 AKH DIT-770 #1346
          // <<DITW110.00.09 DDR 13/04/2017 NRQ#13107
          VALIDATE("Packaging Type Code");
          // >>DITW110.00.09 DDR NRQ#13107
        end;
        if (Quantity * xRec.Quantity < 0) or (Quantity = 0) then
          InitItemAppl;

        // <<DITW16.00.00.40 DDR 16/04/2012 02/05/2012 DIT-715 #247
        if (Type = Type::Item) and (Quantity <> 0) and (xRec.Quantity <> Quantity) and
          ((Quantity < 0) or ((xRec.Quantity * Quantity) <= -1)) and
          ("Quantity Invoiced" = 0) and ("Quantity Received" = 0) and ("Return Qty. Shipped" = 0) and
          ("Appl.-to Item Entry" = 0) and  ("Receipt No." = '') and ("Return Shipment No." = '')
        then begin
          GetItem();
          GetPurchHeader();
          GetLocation(PurchHeader."Location Code");
          if (("Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"]) xor (Quantity < 0)) then
            GetLocation(Item."Reverse Location Code")
          else
            GetLocation(Item."Location Code");
          if ("Location Code" <> Location.Code) and (Location.Code <> '') and
          // <<DITW17.10.03 DDR 26/06/2014 DIT-770 #570
          (CurrFieldNo <> 0) and ("Line No." <> 0)
          // >>DITW17.10.03 DDR DIT-770 #570
          //<< DITW19.00.08 AKH 23/09/2016 BL#10763
          and not (IsRetReasonWithLocation("Return Reason Code")) and (CurrFieldNo = FIELDNO(Quantity))
          //>> DITW19.00.08 AKH BL#10763
          then begin
            CLEAR(SaveTempPurchChargeLine);
            SaveTempPurchChargeLine.DELETEALL;
            TransferTaxCharges.ClearBuffer();
            TransferDepositCharges.ClearBuffer();
            TransferDiscountCharges.ClearBuffer();
            TransferPromotionCharges.ClearBuffer();
            DeleteAllChargePurchLines(Rec,true);
            "Physical Location Group Code" := Location."Physical Location Group Code";
            VALIDATE("Location Code",Location.Code);
          end;
        end;
        // >>DITW16.00.00.40 DDR DIT-715 #247

        // <<DITW15.00.00.21 DDR 24/06/2008 - DITW16.00.00.40 DDR 16/04/2012 DIT-715 #247
        GetLocation("Location Code");
        if Location."Directed Put-away and Pick" then
          CheckBinCubageWeight(xRec.Cubage,xRec.Weight);
        // >>DITW15.00.00.21 DDR

        if Type = Type::Item then begin
          // <<DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
          if "Free Item" and
            (CurrFieldNo <> FIELDNO("Free Item")) and
            (CurrFieldNo <> FIELDNO("Free Item Posting Type")) and
            (CurrFieldNo <> FIELDNO("Free Reason Code"))
          then
            VALIDATE("Free Item Posting Type");
          // >>DITW18.00.07A DDR DIT-770 #2074
          /// DITW16.00.00.43 DDR 05/11/2013 DIT-715 #811 - DITW110.00.11 DDR 10/08/2017 NRQ#24875

          // <<DITW114.00.15 DDR 24/04/2020 NRQ#102424
          if (not "Drop Shipment") and (Type = Type::Item) and ("Item Charge Type" = "Item Charge Type"::" ") then
            UpdateWithWarehouseReceive;
          // >>DITW114.00.15 DDR NRQ#102424

          UpdateDirectUnitCost(FIELDNO(Quantity));
        end else
          VALIDATE("Line Discount %");

        //<<DITW110.00.12A MSF 17/07/2018 NRQ#78507
        if (Type = Type::Item) and (Quantity <> 0) and (xRec.Quantity <> Quantity) and ("Line No." <> 0) and
          ("Attached to Line No." = 0) and not BatchInsertCheckSuspended and (CurrFieldNo = 0) and
          (("Quantity Invoiced" <> 0) or ("Quantity Received" <> 0) or ("Return Qty. Shipped" <> 0)) and
          ("Appl.-to Item Entry" = 0) and ("Appl.-to Item Entry" = 0)
        then
          UpdateCharges2(FIELDNO(Quantity),false);
        //>>DITW110.00.12A MSF 17/07/2018 NRQ#78507

          // <<DITW110.00.12 DDR 05/03/2018 NRQ#13043
          if (Type = Type::Item) and (Quantity <> xRec.Quantity) and (Quantity <> 0) and
            not BatchInsertCheckSuspended and "Disc.Promo. Order Calculated"
          then begin
            if xRec.Quantity = 0 then begin
              "Disc.Promo. Order Calculated" := false;
              if "Order No." = '' then
                "Order Line No." := 0;
            end;
            UpdateCharges(FIELDNO(Quantity),not (("Item Charge Type" = "Item Charge Type"::Promotion) and ("Attached to Line No." <> 0)));
          end;
          // >>DITW110.00.12 DDR NRQ#13043

          // <<DITW15.00.00.37 DDR 30/04/2010 - DITW16.00.00.40 DDR 16/04/2012 DIT-715 #247
          if not (BatchInsertCheckSuspended and "Is Item Charge") then
          // >>DITW15.00.00.37 DDR - DITW16.00.00.40 DDR DIT-715 #247
          //<<FINXL7.00.001 WSA 04/07/2014
        if not blnChangedFromWarehouseRcpt then
          //>>FINXL7.00.001 WSA 04/07/2014
          UpdateWithWarehouseReceive;
        if (xRec.Quantity <> Quantity) or (xRec."Quantity (Base)" <> "Quantity (Base)") then begin
          // <<DITW15.00.00.35 DDR 17/07/2009
          if not "Is Item Charge" then
          // >>DITW15.00.00.35 DDR
            ReservePurchLine.VerifyQuantity(Rec,xRec);
          // <<DITW15.00.00.35 DDR 17/07/2009
          if not "Is Item Charge" then
          // >>DITW15.00.00.35 DDR
            //<<FINXL7.00.001 RBE 20/03/2013
            if not blnChangedFromWarehouseRcpt then
            //>>FINXL7.00.001 RBE 20/03/2013
              WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
          CheckApplToItemLedgEntry;
        end;

        // <<DITW15.00.00.29 DDR 12/12/2008 - DITW15.00.00.37 DDR 03/05/2010 - 04/05/2010
        // only purchase
        if (Type = Type::Item) or "Is Item Charge" then
          UpdateWithWarehouseReceive;
        // >>DITW15.00.00.37 DDR

        if (xRec.Quantity <> Quantity) and (Quantity = 0) and
           ((Amount <> 0) or ("Amount Including VAT" <> 0) or ("VAT Base Amount" <> 0))
        then begin
        #68..70
        end;

        // <<DITW15.00.00.39 DDR 23/09/2011 #1258
        if "Return Reason Code" <> '' then
          VALIDATE("Return Reason Code");
        // >>DITW15.00.00.39 DDR  #1258

        //FIXME DIT-770 #1971 <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
        if (Type = Type::Item) and "Is Item Charge" then begin
          CalcCubageWeight();
          //<<DITW17.00.02 SR 08/01/2014 DIT-770 #189
          //<<DITW17.00.02 SR 08/01/2014 DIT-770 #189
          CalcHLCubage;
          CalcEqVUOMQuantity;
          //>>DITW17.00.02 SR 08/01/2014 DIT-770 #189
          //>>DITW17.00.02 SR 08/01/2014 DIT-770 #189
          // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
          //? fixme UpdateRoutePlanRqstLines(FIELDNO(Quantity));
          // >>DITW18.00.07 DDR DIT-770 #1488
         end;
        // >>DITW16.00.00.40 DDR DIT-715 #172
        //? FIXME DIT-770 #1971 <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
        // <<DITW15.00.00.36 DDR 21/12/2009
        if (Type = Type::Item) and
          "Free Item" and
          // <<DITW110.00.11 DDR 06/10/2017 NRQ#37925
          ("Attached to Line No." <> 0)  and
          // >>DITW110.00.11 DDR NRQ#37925
          // <<DITW114.00.15 DDR 29/04/2020 NRQ#102424
          ((CurrFieldNo = 0) or ((CurrFieldNo <> 0) and (("Quantity Received"+"Return Qty. Shipped") <> 0)))
          // >>DITW114.00.15 DDR NRQ#102424
        then
          // <<DITW114.00.15 DDR 29/04/2020 NRQ#102424
          UpdateCharges(FIELDNO(Quantity),(CurrFieldNo <> 0));
          // >>DITW114.00.15 DDR NRQ#102424
        // >>DITW15.00.00.36 DDR
        #72..74
        //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #144
        GetPurchHeader;
        if Quantity < xRec.Quantity then
          if "Approved Line Amount" <> 0 then
            "Approved Line Amount" := ("Approved Line Amount"*Quantity)/xRec.Quantity;
            "Approved Line Amount" := ROUND("Approved Line Amount",Currency."Amount Rounding Precision");
        if (Quantity > xRec.Quantity) and
           (xRec.Quantity <> 0)
        then
         //-- DITW17.00.05 YHE 06/11/2014 DIT-770 #961 // IF "Blanket Order No." <> '' THEN
            if "Approved Line Amount" <> 0 then
              "Approved Line Amount" := ("Approved Line Amount"*Quantity)/xRec.Quantity;
              "Approved Line Amount" := ROUND("Approved Line Amount",Currency."Amount Rounding Precision");
        //>>DITW17.00.02 TEC1 DIT-770 #144

        //<< DITW17.00.05 YHE 06/11/2014 DIT-770 #961
        if lrBlankedOrderLine.GET(lrBlankedOrderLine."Document Type"::"Blanket Order","Blanket Order No.","Blanket Order Line No.") then begin
          if lrBlankedOrderLine.Quantity <> 0 then begin
            "Approved Line Amount" := (lrBlankedOrderLine."Approved Line Amount" / lrBlankedOrderLine.Quantity) * Quantity;
            "Approved Line Amount" := ROUND("Approved Line Amount",Currency."Amount Rounding Precision");
          end;
        end;
        if lrPurchRcptLine.GET("Receipt No.","Receipt Line No.") then
          if lrPurchaseOrderLine.GET(lrPurchaseOrderLine."Document Type"::Order,lrPurchRcptLine."Order No.",lrPurchRcptLine."Order Line No.")
          then
            if lrPurchaseOrderLine.Quantity <> 0 then begin
              "Approved Line Amount" := (lrPurchaseOrderLine."Approved Line Amount" / lrPurchaseOrderLine.Quantity) * Quantity;
              "Approved Line Amount" := ROUND("Approved Line Amount",Currency."Amount Rounding Precision");
            end;
        //>> DITW17.00.05 YHE 06/11/2014 DIT-770 #961

        if "Job Planning Line No." <> 0 then
          VALIDATE("Job Planning Line No.");

        if JobTaskIsSet then begin
          CreateTempJobJnlLine(true);
          UpdateJobPrices;
        end;

        CheckWMS;

        //HEI.24>>
        if PurchSetup.GET then begin
          PurchaseLine.SETRANGE("Document Type","Document Type");
          PurchaseLine.SETRANGE("Document No.","Document No.");
          PurchaseLine.SETFILTER(Type,'%1',PurchaseLine.Type::Item);
          PurchaseLine.SETFILTER("Item Category Code",PurchSetup."Item Category");
          if not PurchaseLine.FINDFIRST then
            ItemCategoryBool := false
          else
            ItemCategoryBool := true;
          if ItemCategoryBool then begin
        //HEI.24<<
        //HEI.22>>
        if ("SRM Order No." = '') and (("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::"Return Order"))
          and (Type = Type::Item) and ("Item Category Code" = PurchSetup."Item Category") then begin //HEI.43
            PurchHdrArch.RESET;
            PurchHdrArch.SETRANGE(PurchHdrArch."Document Type","Document Type");
            PurchHdrArch.SETRANGE(PurchHdrArch."No.","Document No.");
            if PurchHdrArch.FINDFIRST then begin
              PurchHeader.RESET;
              PurchHeader.SETRANGE(PurchHeader."No.","Document No.");
              if PurchHeader.FINDFIRST then begin
                if PurchHeader."Purch. Reason Code" = '' then
                   ERROR(ReasonCodeErr);
                end;
            end;
        end;
        //HEI.22<<
        //HEI.24>>
          end;
        end;
        //HEI.24<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Outstanding Quantity"(Field 16)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.21 DDR 24/06/2008
        CalcCubageWeight();
        // >>DITW15.00.00.21 DDR
        //<< DITW18.00.07 VSC 12/05/2016 DIT-770 #1971 -> DIT-770 #189
        CalcHLCubage;
        CalcEqVUOMQuantity;
        //>> DITW18.00.07 VSC DIT-770 #1971 -> DIT-770 #189
        //<< DITW18.00.07 VSC 12/05/2016 DIT-770 #1971 -> DIT-770 #1488
        //IF (xRec."Outstanding Quantity" <> "Outstanding Quantity") AND (CurrFieldNo <> 0) THEN
          //fixme UpdateRoutePlanRqstLines(FIELDNO("Outstanding Quantity"));
        //>> DITW18.00.07 VSC DIT-770 #1971 -> DIT-770 #1488
        //<< DITW18.00.07 AKH 10/05/2016 DIT-770 #1346
        if "Document Type" = "Document Type"::Order then
          CalcDeliveryTimeQtyBase();
        //>> DITW18.00.07 AKH DIT-770 #1346
        */
        //end;


        //Unsupported feature: CodeModification on ""Qty. to Invoice"(Field 17).OnValidate". Please convert manually.

        //trigger  to Invoice"(Field 17)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Qty. to Invoice" = MaxQtyToInvoice THEN
          InitQtyToInvoice
        else
          "Qty. to Invoice (Base)" := CalcBaseQty("Qty. to Invoice");
        IF ("Qty. to Invoice" * Quantity < 0) OR (ABS("Qty. to Invoice") > ABS(MaxQtyToInvoice)) THEN
          ERROR(
            Text006,
            MaxQtyToInvoice);
        IF ("Qty. to Invoice (Base)" * "Quantity (Base)" < 0) OR (ABS("Qty. to Invoice (Base)") > ABS(MaxQtyToInvoiceBase)) THEN
          ERROR(
            Text007,
            MaxQtyToInvoiceBase);
        "VAT Difference" := 0;
        CalcInvDiscToInvoice;
        CalcPrepaymentToDeduct;

        IF "Job Planning Line No." <> 0 THEN
          VALIDATE("Job Planning Line No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Qty. to Invoice" = MaxQtyToInvoice then
          InitQtyToInvoice
        else
          "Qty. to Invoice (Base)" := CalcBaseQty("Qty. to Invoice");
        if ("Qty. to Invoice" * Quantity < 0) or (ABS("Qty. to Invoice") > ABS(MaxQtyToInvoice)) then
        #6..8
        if ("Qty. to Invoice (Base)" * "Quantity (Base)" < 0) or (ABS("Qty. to Invoice (Base)") > ABS(MaxQtyToInvoiceBase)) then
        #10..16
        if "Job Planning Line No." <> 0 then
          VALIDATE("Job Planning Line No.");

        // <<DITW15.00.00.01 DDR 04/01/2008 - 15/01/2008
        // <<DITW15.00.00.19 DDR 07/04/2008 - DITW15.00.00.23 DDR 08/08/2008
        // <<DITW15.00.00.37 DDR 22/01/2010
        // <<DITW15.00.00.39 DDR 29/06/2011 #1308
        // <<DITW16.00.00.40 DDR 23/05/2012 DIT-715 #345
        if (Type = Type::Item) and ("Qty. to Invoice" <> xRec."Qty. to Invoice") and
          (CurrFieldNo <> FIELDNO(Quantity)) and
          not BatchInsertCheckSuspended
        then
          // <<DITW110.00.11 DDR 06/10/2017 NRQ#37925 - DITW114.00.15 DDR 29/04/2020 NRQ#102424
          UpdateCharges(FIELDNO("Qty. to Invoice"),not ISTEMPORARY);
          // >>DITW110.00.11 DDR NRQ#37925 - DITW114.00.15 DDR NRQ#102424
          // >>DITW110.00.11 DDR NRQ#37925
        // >>DITW15.00.00.37 DDR - DITW15.00.00.39 DDR #1308 - DITW16.00.00.40 DDR DIT-715 #345

        // <<DITW15.00.00.01 DDR 10/01/2008 - 31/01/2008
        // <<DITW15.00.00.19 DDR 22/04/2008 - DITW15.00.00.35 DDR 15/10/2009 - DITW15.00.00.36 DDR 18/11/2009 - 21/12/2009
        // <<DITW15.00.00.37 DDR 28/04/2010
        if ((Type <> Type::Item) and ("Is Item Charge")) or
          ("Item Charge Calculate per" <> "Item Charge Calculate per"::Item)
        then begin
          if CurrFieldNo <> 0 then begin
            UpdateItemChargeAssgnt();
            if CurrFieldNo <> FIELDNO(Quantity) then
              SaveItemChargeAssgnt();
          end else
            if not BatchInsertCheckSuspended then
              AutoSuggestItemChargeAssgnt(GetItemChargeAssgntType());
        end;
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Qty. to Receive"(Field 18).OnValidate". Please convert manually.

        //trigger  to Receive"(Field 18)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetLocation("Location Code");
        IF (CurrFieldNo <> 0) AND
           (Type = Type::Item) AND
           (NOT "Drop Shipment")
        THEN BEGIN
          IF Location."Require Receive" AND
             ("Qty. to Receive" <> 0)
          THEN
            CheckWarehouse;
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        end;

        IF "Qty. to Receive" = Quantity - "Quantity Received" THEN
          InitQtyToReceive
        else BEGIN
          "Qty. to Receive (Base)" := CalcBaseQty("Qty. to Receive");
          InitQtyToInvoice;
        end;
        IF ((("Qty. to Receive" < 0) XOR (Quantity < 0)) AND (Quantity <> 0) AND ("Qty. to Receive" <> 0)) OR
           (ABS("Qty. to Receive") > ABS("Outstanding Quantity")) OR
           (((Quantity < 0 ) XOR ("Outstanding Quantity" < 0)) AND (Quantity <> 0) AND ("Outstanding Quantity" <> 0))
        THEN
          ERROR(
            Text008,
            "Outstanding Quantity");
        IF ((("Qty. to Receive (Base)" < 0) XOR ("Quantity (Base)" < 0)) AND ("Quantity (Base)" <> 0) AND ("Qty. to Receive (Base)" <> 0)) OR
           (ABS("Qty. to Receive (Base)") > ABS("Outstanding Qty. (Base)")) OR
           ((("Quantity (Base)" < 0) XOR ("Outstanding Qty. (Base)" < 0)) AND ("Quantity (Base)" <> 0) AND ("Outstanding Qty. (Base)" <> 0))
        THEN
          ERROR(
            Text009,
            "Outstanding Qty. (Base)");

        IF (CurrFieldNo <> 0) AND (Type = Type::Item) AND ("Qty. to Receive" < 0) THEN
          CheckApplToItemLedgEntry;

        IF "Job Planning Line No." <> 0 THEN
          VALIDATE("Job Planning Line No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 22/01/2016 DIT-770 #1702
        ValidateMancoSurplusTolerance;
        //>> DITW18.00.07 VSC DIT-770 #1702

        //<<FINXL7.00.001 RBE 20/03/2013
        if recFinXLSetup.READPERMISSION then
          fctValidateQtyToReceive;
        //>>FINXL7.00.001 RBE 20/03/2013

        GetLocation("Location Code");
        if (CurrFieldNo <> 0) and
           (Type = Type::Item) and
           (not "Drop Shipment")
        then begin
          if Location."Require Receive" and
             ("Qty. to Receive" <> 0)
          then
            CheckWarehouse;
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        end;

        if "Qty. to Receive" = Quantity - "Quantity Received" then
          InitQtyToReceive
        else begin
          "Qty. to Receive (Base)" := CalcBaseQty("Qty. to Receive");
          InitQtyToInvoice;
        end;
        if ((("Qty. to Receive" < 0) xor (Quantity < 0)) and (Quantity <> 0) and ("Qty. to Receive" <> 0)) or
           (ABS("Qty. to Receive") > ABS("Outstanding Quantity")) or
           (((Quantity < 0 ) xor ("Outstanding Quantity" < 0)) and (Quantity <> 0) and ("Outstanding Quantity" <> 0))
        then
        #23..25
        if ((("Qty. to Receive (Base)" < 0) xor ("Quantity (Base)" < 0)) and ("Quantity (Base)" <> 0) and ("Qty. to Receive (Base)" <> 0)) or
           (ABS("Qty. to Receive (Base)") > ABS("Outstanding Qty. (Base)")) or
           ((("Quantity (Base)" < 0) xor ("Outstanding Qty. (Base)" < 0)) and ("Quantity (Base)" <> 0) and ("Outstanding Qty. (Base)" <> 0))
        then
        #30..33
        if (CurrFieldNo <> 0) and (Type = Type::Item) and ("Qty. to Receive" < 0) then
          CheckApplToItemLedgEntry;

        if "Job Planning Line No." <> 0 then
          VALIDATE("Job Planning Line No.");

        // <<DITW15.00.00.01 DDR 04/01/2008 - 15/01/2008
        // <<DITW15.00.00.19 DDR 07/04/2008 - DITW15.00.00.23 DDR 08/08/2008
        // <<DITW15.00.00.37 DDR 22/01/2010 - 11/03/2010 - 18/06/2010
        // <<DITW15.00.00.38 DDR 13/10/2010 #1231
        // <<DITW15.00.00.39 DDR 29/06/2011 #1308
        // <<DITW16.00.00.40 DDR 23/05/2012 DIT-715 #275-DITW111.00.13A MSF 22/04/2019 NRQ#108355
        if (Type = Type::Item) and
        //>>DITW111.00.13A MSF 22/04/2019 NRQ#108355
          (CurrFieldNo <> FIELDNO(Quantity)) and
          not BatchInsertCheckSuspended
        then
          // <<DITW110.00.11 DDR 06/10/2017 NRQ#37925 - DITW114.00.15 DDR 29/04/2020 NRQ#102424
          UpdateCharges(FIELDNO("Qty. to Receive"),not ISTEMPORARY);
          // >>DITW110.00.11 DDR NRQ#37925 - DITW114.00.15 DDR NRQ#102424
        // >>DITW15.00.00.38 DDR #1231 - DITW15.00.00.39 DDR #1308 - DITW16.00.00.40 DDR DIT-715 #275
        */
        //end;


        //Unsupported feature: CodeModification on ""Direct Unit Cost"(Field 22).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Line Discount %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.42>>
        //HEI.24>>
        //HEI.44>>
         if PurchSetup.GET then begin
          PurchaseLine.SETRANGE("Document Type","Document Type");
          PurchaseLine.SETRANGE("Document No.","Document No.");
          PurchaseLine.SETFILTER(Type,'%1',PurchaseLine.Type::Item);
          PurchaseLine.SETFILTER("Item Category Code",PurchSetup."Item Category");
          if not PurchaseLine.FINDFIRST then
            ItemCategoryBool := false
          else
            ItemCategoryBool := true;
         end;
        if ItemCategoryBool then begin
         if ("SRM Order No." = '') and (("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::"Return Order")) then begin
            PurchHdrArch.RESET;
            PurchHdrArch.SETRANGE(PurchHdrArch."Document Type","Document Type");
           PurchHdrArch.SETRANGE(PurchHdrArch."No.","Document No.");
            if PurchHdrArch.FINDFIRST then begin
              PurchHeader.RESET;
              PurchHeader.SETRANGE(PurchHeader."No.","Document No.");
              if PurchHeader.FINDFIRST then begin
                if PurchHeader."Purch. Reason Code" = '' then
                  ERROR(ReasonCodeErr);
              end;
            end;
         end;
        end;
         //HEI.44<<
        //  end;
        // end;
        //HEI.24<<
        //HEI.42<<

        // <<DITW15.00.00.19 DDR 07/04/2008
        TestStatusOpen();
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.19 DDR
        // <<DITW15.00.00.01 DDR 18/12/2007 - 15/01/2008 - 25/01/2008 - DITW15.00.00.34 DDR 12/06/2009
        // 13-12-05, VS B: Alleen handmatige wijzigingen overnemen. Anders van toeslag
        if ("Extra Charge Type" <> "Extra Charge Type"::Amount) and
           ("Extra Charge Type" <> "Extra Charge Type"::"Fixed Amount") and
           ("Extra Charge Type" <> "Extra Charge Type"::VolumeHL) and
           ("Extra Charge Type" <> "Extra Charge Type"::"Price Item") and
           (CurrFieldNo = FIELDNO("Direct Unit Cost")) and
           "Is Item Charge"
        then
          FIELDERROR("Extra Charge Type");
        // >>DITW15.00.00.34 DDR

        // <<DITW15.00.00.01 DDR 01/02/2008 - 21/03/2008
        // <<DITW15.00.00.01 DDR 08/02/2008
        GetPurchHeader();
        if CurrFieldNo = FIELDNO("Direct Unit Cost") then begin
          // <<DITW15.00.00.35 DDR 25/06/2009 - 09/10/2009 - DITW16.00.00.40 DDR 25/01/2012 DIT-715 #172
          if "Free Item" and ("Free Item Posting Type" = "Free Item Posting Type"::Price) then
            ERROR(Text023,FIELDCAPTION("Direct Unit Cost"),FIELDCAPTION("Free Item"));
          // >>DITW16.00.00.40 DDR DIT-715 #172

          if not "Is Item Charge" then
            "Item Charge Value" := "Direct Unit Cost"
          else
            // <<DITW15.00.00.30 DDR 16/01/2009
            UpdateItemChargeValue();
            // >>DITW15.00.00.30 DDR

          // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
          if (Type = Type::Item) and ("Direct Unit Cost" <> xRec."Direct Unit Cost") and not BatchInsertCheckSuspended then
          // >>DITW110.00.11 DDR NRQ#24875
            CheckNoItemChargeInclPrice(FIELDCAPTION("Direct Unit Cost"));
        end;
        // >>DITW15.00.00.19 DDR
        // <<DITW19.00.08 DDR 05/08/2016 BL#9865
        // <<DITW17.10.05 DDR 30/07/2014 DIT-770 #826
        if (Type = Type::Item) and ("Direct Unit Cost" <> xRec."Direct Unit Cost") then
          UpdateCharges(FIELDNO("Direct Unit Cost"),false);
        // >>DITW17.10.05 DDR DIT-770 #826

        VALIDATE("Line Discount %");
        // >>DITW19.00.08 DDR BL#9865

        // <<DITW16.00.00.43 DDR 23/08/2013 DIT-715 #691
        // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
        if (Type = Type::"Charge (Item)") and
          //>> HEI.41
          //("Item Charge Type" <> "Item Charge Type"::" ") AND
          (("Item Charge Type" = "Item Charge Type"::Deposit) or
            ("Item Charge Type" = "Item Charge Type"::Tax) or
            ("Item Charge Type" = "Item Charge Type"::Discount)) and
          //<< HEI.41
          ("Direct Unit Cost" <> xRec."Direct Unit Cost") and
          (CurrFieldNo = FIELDNO("Direct Unit Cost"))
        then
          CalcBackDirectCostItem();
        // >>DITW110.00.11 DDR NRQ#24875
        // >>DITW16.00.00.43 DDR DIT-715 #691

        // <<DITW15.00.00.25 DDR 30/10/2008 - DITW15.00.00.36 DDR 18/11/2009 - DITW15.00.00.37 DDR 08/02/2010 - 28/04/2010
        if ("Line No." <> 0) and
          (((Type <> Type::Item) and ("Is Item Charge")) or ("Item Charge Calculate per" <> "Item Charge Calculate per"::Item))
        then
          UpdateItemChargeAssgnt;
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit Cost (LCY)"(Field 23).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        TESTFIELD("No.");
        TESTFIELD(Quantity);

        IF "Prod. Order No." <> '' THEN
          ERROR(
            Text99000000,
            FIELDCAPTION("Unit Cost (LCY)"));

        IF CurrFieldNo = FIELDNO("Unit Cost (LCY)") THEN
          IF Type = Type::Item THEN BEGIN
            GetItem;
            IF Item."Costing Method" = Item."Costing Method"::Standard THEN
              ERROR(
                Text010,
                FIELDCAPTION("Unit Cost (LCY)"),Item.FIELDCAPTION("Costing Method"),Item."Costing Method");
          end;

        UnitCostCurrency := "Unit Cost (LCY)";
        GetPurchHeader;
        IF PurchHeader."Currency Code" <> '' THEN BEGIN
          PurchHeader.TESTFIELD("Currency Factor");
          GetGLSetup;
          UnitCostCurrency :=
            ROUND(
              CurrExchRate.ExchangeAmtLCYToFCY(
                GetDate,"Currency Code",
                "Unit Cost (LCY)",PurchHeader."Currency Factor"),
              GLSetup."Unit-Amount Rounding Precision");
        end;

        IF ("Direct Unit Cost" <> 0) AND
           ("Direct Unit Cost" <> ("Line Discount Amount" / Quantity))
        THEN
          "Indirect Cost %" :=
            ROUND(
              (UnitCostCurrency - "Direct Unit Cost" + "Line Discount Amount" / Quantity) /
              ("Direct Unit Cost" - "Line Discount Amount" / Quantity) * 100,0.00001)
        else
          "Indirect Cost %" := 0;

        UpdateSalesCost;

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(FALSE);
          TempJobJnlLine.VALIDATE("Unit Cost (LCY)","Unit Cost (LCY)");
          UpdateJobPrices;
        end
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        if "Prod. Order No." <> '' then
        #6..9
        if CurrFieldNo = FIELDNO("Unit Cost (LCY)") then
          if Type = Type::Item then begin
            GetItem;
            if Item."Costing Method" = Item."Costing Method"::Standard then
        #14..16
          end;
        #18..20
        if PurchHeader."Currency Code" <> '' then begin
        #22..29
        end;

        if ("Direct Unit Cost" <> 0) and
           ("Direct Unit Cost" <> ("Line Discount Amount" / Quantity))
        then
        #35..38
        else
          "Indirect Cost %" := 0;


        // <<DITW15.00.00.19 DDR 23/05/2008
        VALIDATE("Line Discount %");
        // >>DITW15.00.00.19 DDR
        #41..43
        if JobTaskIsSet then begin
          CreateTempJobJnlLine(false);
          TempJobJnlLine.VALIDATE("Unit Cost (LCY)","Unit Cost (LCY)");
          UpdateJobPrices;
        end
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Line Discount %"(Field 27).OnValidate". Please convert manually.

        //trigger (Variable: lCurrDirectUnitCost)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Discount %"(Field 27).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        GetPurchHeader;
        "Line Discount Amount" :=
          ROUND(
            ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") *
            "Line Discount %" / 100,
            Currency."Amount Rounding Precision");
        "Inv. Discount Amount" := 0;
        "Inv. Disc. Amount to Invoice" := 0;
        UpdateAmounts;
        UpdateUnitCost;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        // <<DITW15.00.00.19 DDR 07/04/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.19 DDR

        GetPurchHeader;
        // <<DITW15.00.00.30 DDR 16/01/2009
        UpdateItemChargeValue();
        // >>DITW15.00.00.30 DDR
        // <<DITW15.00.00.19 DDR 07/04/2008
        // <<DITW17.00.02 DDR 10/07/2013 DIT-770 #114
        if (Type = Type::Item) and (not "Is Item Charge") and (not "Free Item") then
        // >>DITW17.00.02 DDR DIT-770 #113
          lCurrDirectUnitCost := "Item Charge Value"
        else
          lCurrDirectUnitCost := "Direct Unit Cost";
        // >>DITW15.00.00.19 DDR

        if (CurrFieldNo = FIELDNO("Line Discount %")) then begin
          // <<DITW15.00.00.35 DDR 25/06/2009 - 09/10/2009
          if "Free Item" then
            ERROR(Text023,FIELDCAPTION("Line Discount %"),FIELDCAPTION("Free Item"));
          // >>DITW15.00.00.35 DDR
          "Direct Unit Cost" := lCurrDirectUnitCost;
        end;

        // <<DITW15.00.00.19 DDR 07/04/2008
        //"Line Discount Amount" :=
        //  ROUND(
        //    ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") *
        //    "Line Discount %" / 100,
        //    Currency."Amount Rounding Precision");
        "Line Discount Amount" :=
          ROUND(
            ROUND(Quantity * lCurrDirectUnitCost,Currency."Amount Rounding Precision") *
              "Line Discount %" / 100,
              Currency."Amount Rounding Precision");
        // >>DITW15.00.00.19 DDR

        "Inv. Discount Amount" := 0;
        "Inv. Disc. Amount to Invoice" := 0;

        // <<DITW17.10.05 DDR 30/07/2014 DIT-770 #826
        if (Type = Type::Item) and (Quantity <> 0) and (CurrFieldNo <> 0) and
          (CurrFieldNo <> FIELDNO(Quantity)) and ("Line No." <> 0) and
          ((xRec."Line Amount" = 0) or (xRec."Line Discount %" = 100) or (xRec."Direct Unit Cost" = 0)) and
          (not BatchInsertCheckSuspended) and (not ForceDeleteItemCharges)
        then
          InsertCharges3(CurrFieldNo);
        // >>DITW17.10.05 DDR DIT-770 #826

        UpdateAmounts;
        UpdateUnitCost;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Line Discount Amount"(Field 28).OnValidate". Please convert manually.

        //trigger (Variable: lCurrDirectUnitCost)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Discount Amount"(Field 28).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        "Line Discount Amount" := ROUND("Line Discount Amount",Currency."Amount Rounding Precision");
        TestStatusOpen;
        TESTFIELD(Quantity);
        IF xRec."Line Discount Amount" <> "Line Discount Amount" THEN
          IF ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") <> 0 THEN
            "Line Discount %" :=
              ROUND(
                "Line Discount Amount" /
                ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") * 100,
                0.00001)
          else
            "Line Discount %" := 0;
        "Inv. Discount Amount" := 0;
        "Inv. Disc. Amount to Invoice" := 0;
        UpdateAmounts;
        UpdateUnitCost;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        // <<DITW15.00.00.19 DDR 07/04/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.19 DDR
        TESTFIELD(Quantity);

        // <<DITW15.00.00.30 DDR 16/01/2009
        UpdateItemChargeValue();
        // >>DITW15.00.00.30 DDR

        // <<DITW15.00.00.19 DDR 07/04/2008
        if (Type = Type::Item) and (not "Is Item Charge") then
          lCurrDirectUnitCost := "Item Charge Value"
        else
          lCurrDirectUnitCost := "Direct Unit Cost";

        if (CurrFieldNo = FIELDNO("Line Discount Amount")) or
           (CurrFieldNo = FIELDNO("Line Amount"))
        then begin
          // <<DITW15.00.00.35 DDR 25/06/2009 - 13/10/2009
          if "Free Item" then
            ERROR(Text023,FIELDCAPTION("Line Discount Amount"),FIELDCAPTION("Free Item"));
          // >>DITW15.00.00.35 DDR
          "Direct Unit Cost" := lCurrDirectUnitCost;
        end;
        // >>DITW15.00.00.35 DDR


        // <<DITW15.00.00.19 DDR 07/04/2008
        //IF xRec."Line Discount Amount" <> "Line Discount Amount" THEN
        //  IF ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") <> 0 THEN
        //    "Line Discount %" :=
        //      ROUND(
        //        "Line Discount Amount" /
        //        ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") * 100,
        //        0.00001)
        //  else
        //    "Line Discount %" := 0;
        if xRec."Line Discount Amount" <> "Line Discount Amount" then
          if ROUND(Quantity * lCurrDirectUnitCost,Currency."Amount Rounding Precision") <> 0 then
        #7..9
                ROUND(Quantity * lCurrDirectUnitCost,Currency."Amount Rounding Precision") * 100,
                0.00001)
          else
            "Line Discount %" := 0;
          // >>DITW15.00.00.35 DDR

        "Inv. Discount Amount" := 0;
        "Inv. Disc. Amount to Invoice" := 0;

        // <<DITW17.10.05 DDR 30/07/2014 DIT-770 #826
        if (Type = Type::Item) and (Quantity <> 0) and (CurrFieldNo <> 0) and
          (CurrFieldNo <> FIELDNO(Quantity)) and ("Line No." <> 0) and
          ((xRec."Line Amount" = 0) or (xRec."Line Discount %" = 100) or (xRec."Direct Unit Cost" = 0)) and
          (not BatchInsertCheckSuspended) and (not ForceDeleteItemCharges)
        then
          InsertCharges3(CurrFieldNo);
        // >>DITW17.10.05 DDR DIT-770 #826

        UpdateAmounts;
        UpdateUnitCost;
        */
        //end;


        //Unsupported feature: CodeModification on "Amount(Field 29).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        Amount := ROUND(Amount,Currency."Amount Rounding Precision");
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            BEGIN
              "VAT Base Amount" :=
                ROUND(Amount * (1 - PurchHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
              "Amount Including VAT" :=
                ROUND(Amount + "VAT Base Amount" * "VAT %" / 100,Currency."Amount Rounding Precision");
            end;
          "VAT Calculation Type"::"Full VAT":
            IF Amount <> 0 THEN
              FIELDERROR(Amount,
                STRSUBSTNO(
                  Text011,FIELDCAPTION("VAT Calculation Type"),
                  "VAT Calculation Type"));
          "VAT Calculation Type"::"Sales Tax":
            BEGIN
              PurchHeader.TESTFIELD("VAT Base Discount %",0);
              "VAT Base Amount" := Amount;
              IF "Use Tax" THEN
                "Amount Including VAT" := "VAT Base Amount"
              else BEGIN
                "Amount Including VAT" :=
                  Amount +
                  ROUND(
                    SalesTaxCalculate.CalculateTax(
                      "Tax Area Code","Tax Group Code","Tax Liable",PurchHeader."Posting Date",
                      "VAT Base Amount","Quantity (Base)",PurchHeader."Currency Factor"),
                    Currency."Amount Rounding Precision");
                IF "VAT Base Amount" <> 0 THEN
                  "VAT %" :=
                    ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
                else
                  "VAT %" := 0;
              end;
            end;
        end;

        InitOutstandingAmount;
        UpdateUnitCost;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetPurchHeader;
        Amount := ROUND(Amount,Currency."Amount Rounding Precision");
        case "VAT Calculation Type" of
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            begin
        #7..10
            end;
          "VAT Calculation Type"::"Full VAT":
            if Amount <> 0 then
        #14..18
            begin
              PurchHeader.TESTFIELD("VAT Base Discount %",0);
              "VAT Base Amount" := Amount;
              if "Use Tax" then
                "Amount Including VAT" := "VAT Base Amount"
              else begin
        #25..31
                if "VAT Base Amount" <> 0 then
                  "VAT %" :=
                    ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
                else
                  "VAT %" := 0;
              end;
            end;
        end;
        #40..42
        // <<DITW15.00.00.19 DDR 22/04/2008 - DITW15.00.00.23 DDR 08/08/2008
        if (not BatchInsertCheckSuspended) and
           (Type = Type::"Charge (Item)") and
           ("Line No." <> 0) and
           (CurrFieldNo <> 0)
        then begin
          UpdateItemChargeAssgnt;
          SaveItemChargeAssgnt;
        end;
        // >>DITW15.00.00.23 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Amount Including VAT"(Field 30).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        "Amount Including VAT" := ROUND("Amount Including VAT",Currency."Amount Rounding Precision");
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            BEGIN
              Amount :=
                ROUND(
                  "Amount Including VAT" /
                  (1 + (1 - PurchHeader."VAT Base Discount %" / 100) * "VAT %" / 100),
                  Currency."Amount Rounding Precision");
              "VAT Base Amount" :=
                ROUND(Amount * (1 - PurchHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
            end;
          "VAT Calculation Type"::"Full VAT":
            BEGIN
              Amount := 0;
              "VAT Base Amount" := 0;
            end;
          "VAT Calculation Type"::"Sales Tax":
            BEGIN
              PurchHeader.TESTFIELD("VAT Base Discount %",0);
              IF "Use Tax" THEN BEGIN
                Amount := "Amount Including VAT";
                "VAT Base Amount" := Amount;
              end else BEGIN
                Amount :=
                  ROUND(
                    SalesTaxCalculate.ReverseCalculateTax(
                      "Tax Area Code","Tax Group Code","Tax Liable",PurchHeader."Posting Date",
                      "Amount Including VAT","Quantity (Base)",PurchHeader."Currency Factor"),
                    Currency."Amount Rounding Precision");
                "VAT Base Amount" := Amount;
                IF "VAT Base Amount" <> 0 THEN
                  "VAT %" :=
                    ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
                else
                  "VAT %" := 0;
              end;
            end;
        end;

        InitOutstandingAmount;
        UpdateUnitCost;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetPurchHeader;
        "Amount Including VAT" := ROUND("Amount Including VAT",Currency."Amount Rounding Precision");
        case "VAT Calculation Type" of
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            begin
        #7..13
            end;
          "VAT Calculation Type"::"Full VAT":
            begin
              Amount := 0;
              "VAT Base Amount" := 0;
            end;
          "VAT Calculation Type"::"Sales Tax":
            begin
              PurchHeader.TESTFIELD("VAT Base Discount %",0);
              if "Use Tax" then begin
                Amount := "Amount Including VAT";
                "VAT Base Amount" := Amount;
              end else begin
        #27..33
                if "VAT Base Amount" <> 0 then
                  "VAT %" :=
                    ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
                else
                  "VAT %" := 0;
              end;
            end;
        end;
        #42..44
        */
        //end;


        //Unsupported feature: CodeModification on ""Allow Invoice Disc."(Field 32).OnValidate". Please convert manually.

        //trigger "(Field 32)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF ("Allow Invoice Disc." <> xRec."Allow Invoice Disc.") AND
           (NOT "Allow Invoice Disc.")
        THEN BEGIN
          "Inv. Discount Amount" := 0;
          "Inv. Disc. Amount to Invoice" := 0;
          UpdateAmounts;
          UpdateUnitCost;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        if ("Allow Invoice Disc." <> xRec."Allow Invoice Disc.") and
           (not "Allow Invoice Disc.")
        then begin
        #5..8
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Appl.-to Item Entry"(Field 38).OnLookup". Please convert manually.

        //trigger -to Item Entry"(Field 38)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SelectItemEntry;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.39 DDR 29/08/2011 #1396
        //SelectItemEntry;
        SelectItemEntry(FIELDNO("Appl.-to Item Entry"));
        // >>DITW15.00.00.39 DDR #1396
        */
        //end;


        //Unsupported feature: CodeModification on ""Appl.-to Item Entry"(Field 38).OnValidate". Please convert manually.

        //trigger -to Item Entry"(Field 38)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Appl.-to Item Entry" <> 0 THEN
          "Location Code" := CheckApplToItemLedgEntry;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Appl.-to Item Entry" <> 0 then
          "Location Code" := CheckApplToItemLedgEntry;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job No."(Field 45).OnValidate". Please convert manually.

        //trigger "(Field 45)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Drop Shipment",FALSE);
        TESTFIELD("Special Order",FALSE);
        TESTFIELD("Receipt No.",'');
        IF "Document Type" = "Document Type"::Order THEN
          TESTFIELD("Quantity Received",0);

        IF ReservEntryExist THEN
          TESTFIELD("Job No.",'');

        IF "Job No." <> xRec."Job No." THEN BEGIN
          VALIDATE("Job Task No.",'');
          VALIDATE("Job Planning Line No.",0);
        end;

        IF "Job No." = '' THEN BEGIN
          CreateDim(
            DATABASE::Job,"Job No.",
            DimMgt.TypeToTableID3(Type),"No.",
            DATABASE::"Responsibility Center","Responsibility Center",
            DATABASE::"Work Center","Work Center No.");
          EXIT;
        end;

        IF NOT (Type IN [Type::Item,Type::"G/L Account"]) THEN
          FIELDERROR("Job No.",STRSUBSTNO(Text012,FIELDCAPTION(Type),Type));
        Job.GET("Job No.");
        Job.TestBlocked;
        "Job Currency Code" := Job."Currency Code";

        CreateDim(
          DATABASE::Job,"Job No.",
          DimMgt.TypeToTableID3(Type),"No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Work Center","Work Center No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Drop Shipment",false);
        TESTFIELD("Special Order",false);

        //HEI.20>>
        if (Rec."Document Type" <> Rec."Document Type"::"Return Order") and (Rec."Document Type" <> Rec."Document Type"::"Credit Memo")  then
        //HEI.20<<
        TESTFIELD("Receipt No.",'');

        if "Document Type" = "Document Type"::Order then
          TESTFIELD("Quantity Received",0);

        if ReservEntryExist then
          TESTFIELD("Job No.",'');

        if "Job No." <> xRec."Job No." then begin
          VALIDATE("Job Task No.",'');
          VALIDATE("Job Planning Line No.",0);
        end;

        if "Job No." = '' then begin
        #16..19
            DATABASE::"Work Center","Work Center No.",
            // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
            //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
            DimMgt.TypeToTableID2034932(2,"Contract Type"),GetContractNo(),
            //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
            // >>DITW16.00.00.41 AHU DIT-715 #327
            // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
            DimMgt.TypeToTableID3(Type::Item),"Tax Item No.",
            // >>DITW16.00.00.43 DDR DIT-715 #768
            //<<DITW110.00.10 MSF 21/05/2017 NRQ#13382
            DATABASE::Customer,"Linked Customer No.");
            //>>DITW110.00.10 MSF 21/05/2017 NRQ#13382
          exit;
        end;

        if not (Type in [Type::Item,Type::"G/L Account"]) then
        #25..33
          DATABASE::"Work Center","Work Center No.",
          // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(2,"Contract Type"),GetContractNo(),
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
          // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
          DimMgt.TypeToTableID3(Type::Item),"Tax Item No.",
          // >>DITW16.00.00.43 DDR DIT-715 #768
          //<<DITW110.00.10 MSF 21/05/2017 NRQ#13382
          DATABASE::Customer,"Linked Customer No.");
          //>>DITW110.00.10 MSF 21/05/2017 NRQ#13382
        */
        //end;


        //Unsupported feature: CodeModification on ""Indirect Cost %"(Field 54).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("No.");
        TestStatusOpen;

        IF Type = Type::"Charge (Item)" THEN
          TESTFIELD("Indirect Cost %",0);

        IF (Type = Type::Item) AND ("Prod. Order No." = '') THEN BEGIN
          GetItem;
          IF Item."Costing Method" = Item."Costing Method"::Standard THEN
            ERROR(
              Text010,
              FIELDCAPTION("Indirect Cost %"),Item.FIELDCAPTION("Costing Method"),Item."Costing Method");
        end;

        UpdateUnitCost;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        if Type = Type::"Charge (Item)" then
          TESTFIELD("Indirect Cost %",0);

        if (Type = Type::Item) and ("Prod. Order No." = '') then begin
          GetItem;
          if Item."Costing Method" = Item."Costing Method"::Standard then
        #10..12
        end;

        UpdateUnitCost;
        */
        //end;


        //Unsupported feature: CodeModification on ""Outstanding Amount"(Field 57).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        Currency2.InitRoundingPrecision;
        IF PurchHeader."Currency Code" <> '' THEN
          "Outstanding Amount (LCY)" :=
            ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
                GetDate,"Currency Code",
                "Outstanding Amount",PurchHeader."Currency Factor"),
              Currency2."Amount Rounding Precision")
        else
          "Outstanding Amount (LCY)" :=
            ROUND("Outstanding Amount",Currency2."Amount Rounding Precision");

        "Outstanding Amt. Ex. VAT (LCY)" :=
          ROUND("Outstanding Amount (LCY)" / (1 + "VAT %" / 100),Currency2."Amount Rounding Precision");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetPurchHeader;
        Currency2.InitRoundingPrecision;
        if PurchHeader."Currency Code" <> '' then
        #4..9
        else
        #11..15
        */
        //end;


        //Unsupported feature: CodeModification on ""Amt. Rcd. Not Invoiced"(Field 59).OnValidate". Please convert manually.

        //trigger  Rcd();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        Currency2.InitRoundingPrecision;
        IF PurchHeader."Currency Code" <> '' THEN
          "Amt. Rcd. Not Invoiced (LCY)" :=
            ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
                GetDate,"Currency Code",
                "Amt. Rcd. Not Invoiced",PurchHeader."Currency Factor"),
              Currency2."Amount Rounding Precision")
        else
          "Amt. Rcd. Not Invoiced (LCY)" :=
            ROUND("Amt. Rcd. Not Invoiced",Currency2."Amount Rounding Precision");

        "A. Rcd. Not Inv. Ex. VAT (LCY)" :=
          ROUND("Amt. Rcd. Not Invoiced (LCY)" / (1 + "VAT %" / 100),Currency2."Amount Rounding Precision");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetPurchHeader;
        Currency2.InitRoundingPrecision;
        if PurchHeader."Currency Code" <> '' then
        #4..9
        else
        #11..15
        */
        //end;


        //Unsupported feature: CodeModification on ""Inv. Discount Amount"(Field 69).OnValidate". Please convert manually.

        //trigger  Discount Amount"(Field 69)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdateAmounts;
        UpdateUnitCost;
        CalcInvDiscToInvoice;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        // <<DITW15.00.00.19 DDR 22/04/2008 - DITW15.00.00.35 DDR 29/06/2009
        if (Type = Type::Item) and
           ExistItemChargeInclPrice()
        then begin
          // <<DITW15.00.00.30 DDR 16/01/2009
          UpdateItemChargeValue();
          // >>DITW15.00.00.35 DDR
          "Direct Unit Cost" := "Item Charge Value";
          UpdateAmounts;
        end;
        // >>DITW15.00.00.19 DDR
        // <<DITW15.00.00.19 DDR 22/04/2008 - DITW15.00.00.36 DDR 18/11/2009
        // <<DITW15.00.00.37 DDR 28/04/2010
        if ("Line No." <> 0) and
          (((Type <> Type::Item) and ("Is Item Charge")) or ("Item Charge Calculate per" <> "Item Charge Calculate per"::Item))
        then begin
          UpdateItemChargeAssgnt;
          SaveItemChargeAssgnt;
        end;
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Vendor Item No."(Field 70).OnValidate". Please convert manually.

        //trigger "(Field 70)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF PurchHeader."Send IC Document" AND
           ("IC Partner Ref. Type" = "IC Partner Ref. Type"::"Vendor Item No.")
        THEN
          "IC Partner Reference" := "Vendor Item No.";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if PurchHeader."Send IC Document" and
           ("IC Partner Ref. Type" = "IC Partner Ref. Type"::"Vendor Item No.")
        then
          "IC Partner Reference" := "Vendor Item No.";
        */
        //end;


        //Unsupported feature: CodeModification on ""Sales Order No."(Field 71).OnValidate". Please convert manually.

        //trigger "(Field 71)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (xRec."Sales Order No." <> "Sales Order No.") AND (Quantity <> 0) THEN BEGIN
          ReservePurchLine.VerifyChange(Rec,xRec);
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (xRec."Sales Order No." <> "Sales Order No.") and (Quantity <> 0) then begin
          ReservePurchLine.VerifyChange(Rec,xRec);
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Sales Order Line No."(Field 72).OnValidate". Please convert manually.

        //trigger "(Field 72)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (xRec."Sales Order Line No." <> "Sales Order Line No.") AND (Quantity <> 0) THEN BEGIN
          ReservePurchLine.VerifyChange(Rec,xRec);
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (xRec."Sales Order Line No." <> "Sales Order Line No.") and (Quantity <> 0) then begin
          ReservePurchLine.VerifyChange(Rec,xRec);
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Drop Shipment"(Field 73).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (xRec."Drop Shipment" <> "Drop Shipment") AND (Quantity <> 0) THEN BEGIN
          ReservePurchLine.VerifyChange(Rec,xRec);
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        end;
        IF "Drop Shipment" THEN BEGIN
          "Bin Code" := '';
          EVALUATE("Inbound Whse. Handling Time",'<0D>');
          VALIDATE("Inbound Whse. Handling Time");
          InitOutstanding;
          InitQtyToReceive;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (xRec."Drop Shipment" <> "Drop Shipment") and (Quantity <> 0) then begin
          ReservePurchLine.VerifyChange(Rec,xRec);
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        end;
        if "Drop Shipment" then begin
        #6..10
          //<< DITW18.00.07 AKH 10/05/2016 DIT-770 #1346
          if "Document Type" = "Document Type"::Order then
            CalcDeliveryTimeQtyBase();
          //>> DITW18.00.07 AKH DIT-770 #1346
        end;

        // <<DITW15.00.00.01 15/01/2008
        // <<DITW15.00.00.19 DDR 22/04/2008
        if Type = Type::Item then
          UpdateCharges(FIELDNO("Drop Shipment"),true);
        // >>DITW15.00.00.19 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Bus. Posting Group"(Field 74).OnValidate". Please convert manually.

        //trigger  Bus();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
          IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
            VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
          if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") then
            VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Gen. Prod. Posting Group"(Field 75).OnValidate". Please convert manually.

        //trigger (Variable: VATProdPostingGroup)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Prod. Posting Group"(Field 75).OnValidate". Please convert manually.

        //trigger  Prod();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" THEN
          IF GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") THEN
            VALIDATE("VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
          if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") then begin
            //<<DITW110.00.12A MSF 05/07/2018 NRQ#64943
            VATProdPostingGroup := GetVatProdPostingGroup();
            if VATProdPostingGroup <> '' then
              VALIDATE("VAT Prod. Posting Group",VATProdPostingGroup)
            else
            //>>DITW110.00.12A MSF 05/07/2018 NRQ#64943
              VALIDATE("VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");
          //<<DITW110.00.12A MSF 05/07/2018 NRQ#64943
          end;
          //>>DITW110.00.12A MSF 05/07/2018 NRQ#64943
        // <<DITW18.00.07 DDR 28/02/2016 DIT-770 #1836
        UpdateCharges(FIELDNO("Gen. Prod. Posting Group"),true);
        // >>DITW18.00.07 DDR DIT-770 #1836
        */
        //end;


        //Unsupported feature: CodeModification on ""VAT Prod. Posting Group"(Field 90).OnValidate". Please convert manually.

        //trigger  Posting Group"(Field 90)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
        "VAT Difference" := 0;
        "VAT %" := VATPostingSetup."VAT %";
        "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
        "VAT Identifier" := VATPostingSetup."VAT Identifier";
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Reverse Charge VAT",
          "VAT Calculation Type"::"Sales Tax":
            "VAT %" := 0;
          "VAT Calculation Type"::"Full VAT":
            BEGIN
              TESTFIELD(Type,Type::"G/L Account");
              VATPostingSetup.TESTFIELD("Purchase VAT Account");
              TESTFIELD("No.",VATPostingSetup."Purchase VAT Account");
            end;
        end;
        IF PurchHeader."Prices Including VAT" AND (Type = Type::Item) THEN
          "Direct Unit Cost" :=
            ROUND(
              "Direct Unit Cost" * (100 + "VAT %") / (100 + xRec."VAT %"),
              Currency."Unit-Amount Rounding Precision");
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        UpdateTINBAndVATProdPostGrByLocation; //HEI.21
        // <<DITW15.00.00.01 DDR 25/01/2008
        //VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
        // <<DITW18.00.07 DDR 20/02/2016 DIT-770 #1836
        CLEAR(VATPostingSetup);
        // >>DITW18.00.07 DDR DIT-770 #1836
        if not VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group") then
          // <<DITW18.00.07 DDR 20/02/2016 DIT-770 #1836
          if not (HideValidationDialog or BatchInsertCheckSuspended) then
          // >>DITW18.00.07 DDR DIT-770 #1836
            ERROR(Text2014410,VATPostingSetup.TABLECAPTION,"VAT Bus. Posting Group","VAT Prod. Posting Group",Type,"No.");
        // >>DITW15.00.00.01 DDR

        #3..6
        case "VAT Calculation Type" of
        #8..11
            begin
        #13..15
            end;
        end;
        if PurchHeader."Prices Including VAT" and (Type = Type::Item) then
        #19..22

        // <<DITW18.00.07 DDR 28/02/2016 DIT-770 #1836
        UpdateCharges(FIELDNO("VAT Prod. Posting Group"),true);
        // >>DITW18.00.07 DDR DIT-770 #1836
        UpdateAmounts;
        */
        //end;


        //Unsupported feature: CodeModification on ""Blanket Order No."(Field 97).OnValidate". Please convert manually.

        //trigger "(Field 97)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Quantity Received",0);
        IF "Blanket Order No." = '' THEN
          "Blanket Order Line No." := 0
        else
          VALIDATE("Blanket Order Line No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Quantity Received",0);
        if "Blanket Order No." = '' then
          "Blanket Order Line No." := 0
        else
          VALIDATE("Blanket Order Line No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Blanket Order Line No."(Field 98).OnValidate". Please convert manually.

        //trigger "(Field 98)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Quantity Received",0);
        IF "Blanket Order Line No." <> 0 THEN BEGIN
          PurchLine2.GET("Document Type"::"Blanket Order","Blanket Order No.","Blanket Order Line No.");
          PurchLine2.TESTFIELD(Type,Type);
          PurchLine2.TESTFIELD("No.","No.");
          PurchLine2.TESTFIELD("Pay-to Vendor No.","Pay-to Vendor No.");
          PurchLine2.TESTFIELD("Buy-from Vendor No.","Buy-from Vendor No.");
          VALIDATE("Variant Code",PurchLine2."Variant Code");
          VALIDATE("Location Code",PurchLine2."Location Code");
          VALIDATE("Unit of Measure Code",PurchLine2."Unit of Measure Code");
          VALIDATE("Direct Unit Cost",PurchLine2."Direct Unit Cost");
          VALIDATE("Line Discount %",PurchLine2."Line Discount %");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Quantity Received",0);
        if "Blanket Order Line No." <> 0 then begin
          PurchLine2.GET("Document Type"::"Blanket Order","Blanket Order No.","Blanket Order Line No.");
          //HEI.26>>
          //PurchLine2.TESTFIELD(Type,Type);
          //PurchLine2.TESTFIELD("No.","No.");
          //HEI.26<<
          PurchLine2.TESTFIELD("Pay-to Vendor No.","Pay-to Vendor No.");
          PurchLine2.TESTFIELD("Buy-from Vendor No.","Buy-from Vendor No.");
          //HEI.26>>
          //VALIDATE("Variant Code",PurchLine2."Variant Code");

          //VALIDATE("Location Code",PurchLine2."Location Code");
          //HEI.26<<
          //VALIDATE("Unit of Measure Code",PurchLine2."Unit of Measure Code");
          //HEI.26>>
          //VALIDATE("Direct Unit Cost",PurchLine2."Direct Unit Cost");
          //VALIDATE("Line Discount %",PurchLine2."Line Discount %");
          //HEI.26<<
        end;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Line Amount"(Field 103).OnValidate". Please convert manually.

        //trigger (Variable: lCurrDirectUnitCost)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Amount"(Field 103).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Type);
        TESTFIELD(Quantity);
        TESTFIELD("Direct Unit Cost");

        GetPurchHeader;
        "Line Amount" := ROUND("Line Amount",Currency."Amount Rounding Precision");
        VALIDATE(
          "Line Discount Amount",ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") - "Line Amount");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        // <<DITW15.00.00.19 DDR 07/04/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.19 DDR

        GetPurchHeader;
        // <<DITW15.00.00.30 DDR 16/01/2009
        UpdateItemChargeValue();
        // >>DITW15.00.00.30 DDR

        // <<DITW15.00.00.35 DDR 25/06/2009 - 13/10/2009
        if CurrFieldNo = FIELDNO("Line Amount") then begin
          if "Free Item" then
            ERROR(Text023,FIELDCAPTION("Line Amount"),FIELDCAPTION("Free Item"));
        end;
        // >>DITW15.00.00.35 DDR

        // <<DITW15.00.00.19 DDR 07/04/2008
        if (Type = Type::Item) and (not "Is Item Charge") then
          lCurrDirectUnitCost := "Item Charge Value"
        else
          lCurrDirectUnitCost := "Direct Unit Cost";
        // >>DITW15.00.00.19 DDR

        // <<DITW15.00.00.19 DDR 07/04/2008
        //"Line Amount" := ROUND("Line Amount",Currency."Amount Rounding Precision");
        //VALIDATE(
        //  "Line Discount Amount",ROUND(Quantity * "Direct Unit Cost",Currency."Amount Rounding Precision") - "Line Amount");
        "Line Amount" := ROUND("Line Amount",Currency."Amount Rounding Precision");
        VALIDATE(
          "Line Discount Amount",ROUND(Quantity * lCurrDirectUnitCost,Currency."Amount Rounding Precision") - "Line Amount");
        // >>DITW15.00.00.19
        */
        //end;


        //Unsupported feature: CodeModification on ""IC Partner Ref. Type"(Field 107).OnValidate". Please convert manually.

        //trigger  Type"(Field 107)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "IC Partner Code" <> '' THEN
          "IC Partner Ref. Type" := "IC Partner Ref. Type"::"G/L Account";
        IF "IC Partner Ref. Type" <> xRec."IC Partner Ref. Type" THEN
          "IC Partner Reference" := '';
        IF "IC Partner Ref. Type" = "IC Partner Ref. Type"::"Common Item No." THEN BEGIN
          IF Item."No." <> "No." THEN
            Item.GET("No.");
          Item.TESTFIELD("Common Item No.");
          "IC Partner Reference" := Item."Common Item No.";
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "IC Partner Code" <> '' then
          "IC Partner Ref. Type" := "IC Partner Ref. Type"::"G/L Account";
        if "IC Partner Ref. Type" <> xRec."IC Partner Ref. Type" then
          "IC Partner Reference" := '';
        if "IC Partner Ref. Type" = "IC Partner Ref. Type"::"Common Item No." then begin
          if Item."No." <> "No." then
        #7..9
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""IC Partner Reference"(Field 108).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." <> '' THEN
          CASE "IC Partner Ref. Type" OF
            "IC Partner Ref. Type"::"G/L Account":
              BEGIN
                IF ICGLAccount.GET("IC Partner Reference") THEN;
                IF PAGE.RUNMODAL(PAGE::"IC G/L Account List",ICGLAccount) = ACTION::LookupOK THEN
                  VALIDATE("IC Partner Reference",ICGLAccount."No.");
              end;
            "IC Partner Ref. Type"::Item:
              BEGIN
                IF Item.GET("IC Partner Reference") THEN;
                IF PAGE.RUNMODAL(PAGE::"Item List",Item) = ACTION::LookupOK THEN
                  VALIDATE("IC Partner Reference",Item."No.");
              end;
            "IC Partner Ref. Type"::"Cross Reference":
              BEGIN
                GetPurchHeader;
                ItemCrossReference.RESET;
                ItemCrossReference.SETCURRENTKEY("Cross-Reference Type","Cross-Reference Type No.");
                ItemCrossReference.SETFILTER(
                  "Cross-Reference Type",'%1|%2',
                  ItemCrossReference."Cross-Reference Type"::Vendor,
                  ItemCrossReference."Cross-Reference Type"::" ");
                ItemCrossReference.SETFILTER("Cross-Reference Type No.",'%1|%2',PurchHeader."Buy-from Vendor No.",'');
                IF PAGE.RUNMODAL(PAGE::"Cross Reference List",ItemCrossReference) = ACTION::LookupOK THEN
                  VALIDATE("IC Partner Reference",ItemCrossReference."Cross-Reference No.");
              end;
            "IC Partner Ref. Type"::"Vendor Item No.":
              BEGIN
                GetPurchHeader;
                ItemVendorCatalog.SETCURRENTKEY("Vendor No.");
                ItemVendorCatalog.SETRANGE("Vendor No.",PurchHeader."Buy-from Vendor No.");
                IF PAGE.RUNMODAL(PAGE::"Vendor Item Catalog",ItemVendorCatalog) = ACTION::LookupOK THEN
                  VALIDATE("IC Partner Reference",ItemVendorCatalog."Vendor Item No.");
              end;
          end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "No." <> '' then
          case "IC Partner Ref. Type" of
            "IC Partner Ref. Type"::"G/L Account":
              begin
                if ICGLAccount.GET("IC Partner Reference") then;
                if PAGE.RUNMODAL(PAGE::"IC G/L Account List",ICGLAccount) = ACTION::LookupOK then
                  VALIDATE("IC Partner Reference",ICGLAccount."No.");
              end;
            "IC Partner Ref. Type"::Item:
              begin
                if Item.GET("IC Partner Reference") then;
                if PAGE.RUNMODAL(PAGE::"Item List",Item) = ACTION::LookupOK then
                  VALIDATE("IC Partner Reference",Item."No.");
              end;
            "IC Partner Ref. Type"::"Cross Reference":
              begin
        #17..24
                if PAGE.RUNMODAL(PAGE::"Cross Reference List",ItemCrossReference) = ACTION::LookupOK then
                  VALIDATE("IC Partner Reference",ItemCrossReference."Cross-Reference No.");
              end;
            "IC Partner Ref. Type"::"Vendor Item No.":
              begin
        #30..32
                if PAGE.RUNMODAL(PAGE::"Vendor Item Catalog",ItemVendorCatalog) = ACTION::LookupOK then
                  VALIDATE("IC Partner Reference",ItemVendorCatalog."Vendor Item No.");
              end;
          end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Prepayment %"(Field 109).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        UpdatePrepmtSetupFields;

        IF Type <> Type::" " THEN
          UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        // <<DITW15.00.00.23 DDR 11/08/2008
        UpdateCharges(FIELDNO("Prepayment %"),false);
        // >>DITW15.00.00.23 DDR

        if Type <> Type::" " then
          UpdateAmounts;
        */
        //end;


        //Unsupported feature: CodeModification on ""Prepmt. Line Amount"(Field 110).OnValidate". Please convert manually.

        //trigger  Line Amount"(Field 110)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        PrePaymentLineAmountEntered := TRUE;
        TESTFIELD("Line Amount");
        IF "Prepmt. Line Amount" < "Prepmt. Amt. Inv." THEN
          FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text038,"Prepmt. Amt. Inv."));
        IF "Prepmt. Line Amount" > "Line Amount" THEN
          FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text039,"Line Amount"));
        VALIDATE("Prepayment %",ROUND("Prepmt. Line Amount" * 100 / "Line Amount",0.00001));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        PrePaymentLineAmountEntered := true;
        TESTFIELD("Line Amount");
        if "Prepmt. Line Amount" < "Prepmt. Amt. Inv." then
          FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text038,"Prepmt. Amt. Inv."));
        if "Prepmt. Line Amount" > "Line Amount" then
          FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text039,"Line Amount"));
        VALIDATE("Prepayment %",ROUND("Prepmt. Line Amount" * 100 / "Line Amount",0.00001));
        */
        //end;


        //Unsupported feature: CodeModification on ""Prepmt Amt to Deduct"(Field 121).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Prepmt Amt to Deduct" > "Prepmt. Amt. Inv." - "Prepmt Amt Deducted" THEN
          FIELDERROR(
            "Prepmt Amt to Deduct",
            STRSUBSTNO(Text039,"Prepmt. Amt. Inv." - "Prepmt Amt Deducted"));

        IF "Prepmt Amt to Deduct" > "Qty. to Invoice" * "Direct Unit Cost" THEN
          FIELDERROR(
            "Prepmt Amt to Deduct",
            STRSUBSTNO(Text039,"Qty. to Invoice" * "Direct Unit Cost"));
        IF ("Prepmt. Amt. Inv." - "Prepmt Amt to Deduct" - "Prepmt Amt Deducted") >
           (Quantity - "Qty. to Invoice" - "Quantity Invoiced") * "Direct Unit Cost"
        THEN
          FIELDERROR(
            "Prepmt Amt to Deduct",
            STRSUBSTNO(Text038,
              "Prepmt. Amt. Inv." - "Prepmt Amt Deducted" -
              (Quantity - "Qty. to Invoice" - "Quantity Invoiced") * "Direct Unit Cost"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Prepmt Amt to Deduct" > "Prepmt. Amt. Inv." - "Prepmt Amt Deducted" then
        #2..5
        if "Prepmt Amt to Deduct" > "Qty. to Invoice" * "Direct Unit Cost" then
        #7..9
        if ("Prepmt. Amt. Inv." - "Prepmt Amt to Deduct" - "Prepmt Amt Deducted") >
           (Quantity - "Qty. to Invoice" - "Quantity Invoiced") * "Direct Unit Cost"
        then
        #13..17
        */
        //end;


        //Unsupported feature: CodeModification on ""IC Partner Code"(Field 130).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "IC Partner Code" <> '' THEN BEGIN
          TESTFIELD(Type,Type::"G/L Account");
          GetPurchHeader;
          PurchHeader.TESTFIELD("Buy-from IC Partner Code",'');
          PurchHeader.TESTFIELD("Pay-to IC Partner Code",'');
          VALIDATE("IC Partner Ref. Type","IC Partner Ref. Type"::"G/L Account");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "IC Partner Code" <> '' then begin
        #2..6
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Task No."(Field 1001).OnValidate". Please convert manually.

        //trigger "(Field 1001)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Receipt No.",'');

        IF "Job Task No." <> xRec."Job Task No." THEN BEGIN
          VALIDATE("Job Planning Line No.",0);
          IF "Document Type" = "Document Type"::Order THEN
            TESTFIELD("Quantity Received",0);
        end;

        IF "Job Task No." = '' THEN BEGIN
          CLEAR(TempJobJnlLine);
          "Job Line Type" := "Job Line Type"::" ";
          UpdateJobPrices;
          CreateDim(
            DimMgt.TypeToTableID3(Type),"No.",
            DATABASE::Job,"Job No.",
            DATABASE::"Responsibility Center","Responsibility Center",
            DATABASE::"Work Center","Work Center No.");
          EXIT;
        end;

        JobSetCurrencyFactor;
        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(TRUE);
          UpdateJobPrices;
        end;
        UpdateDimensionsFromJobTask;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.20>>
        if (Rec."Document Type" <> Rec."Document Type"::"Return Order") and (Rec."Document Type" <> Rec."Document Type"::"Credit Memo") then
        //HEI.20<<
        TESTFIELD("Receipt No.",'');

        if "Job Task No." <> xRec."Job Task No." then begin
          VALIDATE("Job Planning Line No.",0);
          if "Document Type" = "Document Type"::Order then
            TESTFIELD("Quantity Received",0);
        end;

        if "Job Task No." = '' then begin
          CLEAR(TempJobJnlLine);
          "Job Line Type" := "Job Line Type"::" ";

        //HEI.20>>
        if (Rec."Document Type" <> Rec."Document Type"::"Return Order") and (Rec."Document Type" <> Rec."Document Type"::"Credit Memo") then
        //HEI.20<<
        #12..16
            DATABASE::"Work Center","Work Center No.",
            // <<DITW110.00.08 DDR 02/01/2017 NRQ#0
            DimMgt.TypeToTableID2034932(2,"Contract Type"),GetContractNo(),
            DimMgt.TypeToTableID3(Type::Item),"Tax Item No.",
            // >>DITW110.00.08 DDR NRQ#0
            //<<DITW110.00.10 MSF 21/05/2017 NRQ#13382
            DATABASE::Customer,"Linked Customer No.");
            //>>DITW110.00.10 MSF 21/05/2017 NRQ#13382
          exit;
        end;

        JobSetCurrencyFactor;
        if JobTaskIsSet then begin
          CreateTempJobJnlLine(true);
          UpdateJobPrices;
        end;
        UpdateDimensionsFromJobTask;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Line Type"(Field 1002).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Receipt No.",'');
        IF "Document Type" = "Document Type"::Order THEN
          TESTFIELD("Quantity Received",0);

        IF "Job Planning Line No." <> 0 THEN
          ERROR(Text048,FIELDCAPTION("Job Line Type"),FIELDCAPTION("Job Planning Line No."));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        //HEI.20>>
        if (Rec."Document Type" <> Rec."Document Type"::"Return Order") and (Rec."Document Type" <> Rec."Document Type"::"Credit Memo") then
        //HEI.20<<
        TESTFIELD("Receipt No.",'');
        if "Document Type" = "Document Type"::Order then
          TESTFIELD("Quantity Received",0);

        if "Job Planning Line No." <> 0 then
          ERROR(Text048,FIELDCAPTION("Job Line Type"),FIELDCAPTION("Job Planning Line No."));
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Unit Price"(Field 1003).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Receipt No.",'');
        IF "Document Type" = "Document Type"::Order THEN
          TESTFIELD("Quantity Received",0);

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(FALSE);
          TempJobJnlLine.VALIDATE("Unit Price","Job Unit Price");
          UpdateJobPrices;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.20>>
        if (Rec."Document Type" <> Rec."Document Type"::"Return Order") and (Rec."Document Type" <> Rec."Document Type"::"Credit Memo") then
        //HEI.20<<
        TESTFIELD("Receipt No.",'');
        if "Document Type" = "Document Type"::Order then
          TESTFIELD("Quantity Received",0);

        if JobTaskIsSet then begin
          CreateTempJobJnlLine(false);
          TempJobJnlLine.VALIDATE("Unit Price","Job Unit Price");
          UpdateJobPrices;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Line Amount"(Field 1005).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Receipt No.",'');
        IF "Document Type" = "Document Type"::Order THEN
          TESTFIELD("Quantity Received",0);

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(FALSE);
          TempJobJnlLine.VALIDATE("Line Amount","Job Line Amount");
          UpdateJobPrices;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.20>>
        if (Rec."Document Type" <> Rec."Document Type"::"Return Order") and (Rec."Document Type" <> Rec."Document Type"::"Credit Memo") then
        //HEI.20<<
        TESTFIELD("Receipt No.",'');

        if "Document Type" = "Document Type"::Order then
          TESTFIELD("Quantity Received",0);

        if JobTaskIsSet then begin
          CreateTempJobJnlLine(false);
          TempJobJnlLine.VALIDATE("Line Amount","Job Line Amount");
          UpdateJobPrices;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Line Discount Amount"(Field 1006).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Receipt No.",'');
        IF "Document Type" = "Document Type"::Order THEN
          TESTFIELD("Quantity Received",0);

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(FALSE);
          TempJobJnlLine.VALIDATE("Line Discount Amount","Job Line Discount Amount");
          UpdateJobPrices;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.20>>
        if (Rec."Document Type" <> Rec."Document Type"::"Return Order") and (Rec."Document Type" <> Rec."Document Type"::"Credit Memo") then
        //HEI.20<<
        TESTFIELD("Receipt No.",'');
        if "Document Type" = "Document Type"::Order then
          TESTFIELD("Quantity Received",0);

        if JobTaskIsSet then begin
          CreateTempJobJnlLine(false);
          TempJobJnlLine.VALIDATE("Line Discount Amount","Job Line Discount Amount");
          UpdateJobPrices;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Line Discount %"(Field 1007).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Receipt No.",'');
        IF "Document Type" = "Document Type"::Order THEN
          TESTFIELD("Quantity Received",0);

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(FALSE);
          TempJobJnlLine.VALIDATE("Line Discount %","Job Line Discount %");
          UpdateJobPrices;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.20>>
        if (Rec."Document Type" <> Rec."Document Type"::"Return Order") and (Rec."Document Type" <> Rec."Document Type"::"Credit Memo") then
        //HEI.20<<
        TESTFIELD("Receipt No.",'');
        if "Document Type" = "Document Type"::Order then
          TESTFIELD("Quantity Received",0);

        if JobTaskIsSet then begin
          CreateTempJobJnlLine(false);
          TempJobJnlLine.VALIDATE("Line Discount %","Job Line Discount %");
          UpdateJobPrices;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Unit Price (LCY)"(Field 1008).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Receipt No.",'');
        IF "Document Type" = "Document Type"::Order THEN
          TESTFIELD("Quantity Received",0);

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(FALSE);
          TempJobJnlLine.VALIDATE("Unit Price (LCY)","Job Unit Price (LCY)");
          UpdateJobPrices;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.20>>
        if (Rec."Document Type" <> Rec."Document Type"::"Return Order") and (Rec."Document Type" <> Rec."Document Type"::"Credit Memo") then
        //HEI.20<<
        TESTFIELD("Receipt No.",'');
        if "Document Type" = "Document Type"::Order then
          TESTFIELD("Quantity Received",0);

        if JobTaskIsSet then begin
          CreateTempJobJnlLine(false);
          TempJobJnlLine.VALIDATE("Unit Price (LCY)","Job Unit Price (LCY)");
          UpdateJobPrices;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Line Amount (LCY)"(Field 1010).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Receipt No.",'');
        IF "Document Type" = "Document Type"::Order THEN
          TESTFIELD("Quantity Received",0);

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(FALSE);
          TempJobJnlLine.VALIDATE("Line Amount (LCY)","Job Line Amount (LCY)");
          UpdateJobPrices;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.20>>
        if (Rec."Document Type" <> Rec."Document Type"::"Return Order") and (Rec."Document Type" <> Rec."Document Type"::"Credit Memo") then
        //HEI.20<<
        TESTFIELD("Receipt No.",'');

        if "Document Type" = "Document Type"::Order then
          TESTFIELD("Quantity Received",0);

        if JobTaskIsSet then begin
          CreateTempJobJnlLine(false);
          TempJobJnlLine.VALIDATE("Line Amount (LCY)","Job Line Amount (LCY)");
          UpdateJobPrices;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Line Disc. Amount (LCY)"(Field 1011).OnValidate". Please convert manually.

        //trigger  Amount (LCY)"(Field 1011)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Receipt No.",'');
        IF "Document Type" = "Document Type"::Order THEN
          TESTFIELD("Quantity Received",0);

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(FALSE);
          TempJobJnlLine.VALIDATE("Line Discount Amount (LCY)","Job Line Disc. Amount (LCY)");
          UpdateJobPrices;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.20>>
        if (Rec."Document Type" <> Rec."Document Type"::"Return Order") and (Rec."Document Type" <> Rec."Document Type"::"Credit Memo") then
        //HEI.20<<
        TESTFIELD("Receipt No.",'');

        if "Document Type" = "Document Type"::Order then
          TESTFIELD("Quantity Received",0);

        if JobTaskIsSet then begin
          CreateTempJobJnlLine(false);
          TempJobJnlLine.VALIDATE("Line Discount Amount (LCY)","Job Line Disc. Amount (LCY)");
          UpdateJobPrices;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Planning Line No."(Field 1019).OnLookup". Please convert manually.

        //trigger "(Field 1019)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        JobPlanningLine.SETRANGE("Job No.","Job No.");
        JobPlanningLine.SETRANGE("Job Task No.","Job Task No.");
        CASE Type OF
          Type::"G/L Account":
            JobPlanningLine.SETRANGE(Type,JobPlanningLine.Type::"G/L Account");
          Type::Item:
            JobPlanningLine.SETRANGE(Type,JobPlanningLine.Type::Item);
        end;
        JobPlanningLine.SETRANGE("No.","No.");
        JobPlanningLine.SETRANGE("Usage Link",TRUE);
        JobPlanningLine.SETRANGE("System-Created Entry",FALSE);

        IF PAGE.RUNMODAL(0,JobPlanningLine) = ACTION::LookupOK THEN
          VALIDATE("Job Planning Line No.",JobPlanningLine."Line No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        JobPlanningLine.SETRANGE("Job No.","Job No.");
        JobPlanningLine.SETRANGE("Job Task No.","Job Task No.");
        case Type of
        #4..7
        end;
        JobPlanningLine.SETRANGE("No.","No.");
        JobPlanningLine.SETRANGE("Usage Link",true);
        JobPlanningLine.SETRANGE("System-Created Entry",false);

        if PAGE.RUNMODAL(0,JobPlanningLine) = ACTION::LookupOK then
          VALIDATE("Job Planning Line No.",JobPlanningLine."Line No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Planning Line No."(Field 1019).OnValidate". Please convert manually.

        //trigger "(Field 1019)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Job Planning Line No." <> 0 THEN BEGIN
          JobPlanningLine.GET("Job No.","Job Task No.","Job Planning Line No.");
          JobPlanningLine.TESTFIELD("Job No.","Job No.");
          JobPlanningLine.TESTFIELD("Job Task No.","Job Task No.");
          CASE Type OF
            Type::"G/L Account":
              JobPlanningLine.TESTFIELD(Type,JobPlanningLine.Type::"G/L Account");
            Type::Item:
              JobPlanningLine.TESTFIELD(Type,JobPlanningLine.Type::Item);
          end;
          JobPlanningLine.TESTFIELD("No.","No.");
          JobPlanningLine.TESTFIELD("Usage Link",TRUE);
          JobPlanningLine.TESTFIELD("System-Created Entry",FALSE);
          "Job Line Type" := JobPlanningLine."Line Type" + 1;
          VALIDATE("Job Remaining Qty.",JobPlanningLine."Remaining Qty." - "Qty. to Invoice");
        end else
          VALIDATE("Job Remaining Qty.",0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Job Planning Line No." <> 0 then begin
        #2..4
          case Type of
        #6..9
          end;
          JobPlanningLine.TESTFIELD("No.","No.");
          JobPlanningLine.TESTFIELD("Usage Link",true);
          JobPlanningLine.TESTFIELD("System-Created Entry",false);
          "Job Line Type" := JobPlanningLine."Line Type" + 1;
          VALIDATE("Job Remaining Qty.",JobPlanningLine."Remaining Qty." - "Qty. to Invoice");
        end else
          VALIDATE("Job Remaining Qty.",0);
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Remaining Qty."(Field 1030).OnValidate". Please convert manually.

        //trigger "(Field 1030)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Job Remaining Qty." <> 0) AND ("Job Planning Line No." = 0) THEN
          ERROR(Text047,FIELDCAPTION("Job Remaining Qty."),FIELDCAPTION("Job Planning Line No."));

        IF "Job Planning Line No." <> 0 THEN BEGIN
          JobPlanningLine.GET("Job No.","Job Task No.","Job Planning Line No.");
          IF JobPlanningLine.Quantity >= 0 THEN BEGIN
            IF "Job Remaining Qty." < 0 THEN
              "Job Remaining Qty." := 0;
          end else BEGIN
            IF "Job Remaining Qty." > 0 THEN
              "Job Remaining Qty." := 0;
          end;
        end;
        "Job Remaining Qty. (Base)" := CalcBaseQty("Job Remaining Qty.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Job Remaining Qty." <> 0) and ("Job Planning Line No." = 0) then
          ERROR(Text047,FIELDCAPTION("Job Remaining Qty."),FIELDCAPTION("Job Planning Line No."));

        if "Job Planning Line No." <> 0 then begin
          JobPlanningLine.GET("Job No.","Job Task No.","Job Planning Line No.");
          if JobPlanningLine.Quantity >= 0 then begin
            if "Job Remaining Qty." < 0 then
              "Job Remaining Qty." := 0;
          end else begin
            if "Job Remaining Qty." > 0 then
              "Job Remaining Qty." := 0;
          end;
        end;
        "Job Remaining Qty. (Base)" := CalcBaseQty("Job Remaining Qty.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Deferral Code"(Field 1700).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        DeferralPostDate := PurchHeader."Posting Date";

        #4..6
          GetDeferralAmount,DeferralPostDate,
          Description,PurchHeader."Currency Code");

        IF "Document Type" = "Document Type"::"Return Order" THEN
          "Returns Deferral Start Date" :=
            DeferralUtilities.GetDeferralStartDate(DeferralUtilities.GetPurchDeferralDocType,
              "Document Type","Document No.","Line No.","Deferral Code",PurchHeader."Posting Date");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..9
        if "Document Type" = "Document Type"::"Return Order" then
        #11..13
        */
        //end;


        //Unsupported feature: CodeModification on ""Returns Deferral Start Date"(Field 1702).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        IF DeferralHeader.GET(DeferralUtilities.GetPurchDeferralDocType,'','',"Document Type","Document No.","Line No.") THEN
          DeferralUtilities.CreateDeferralSchedule("Deferral Code",DeferralUtilities.GetPurchDeferralDocType,'','',
            "Document Type","Document No.","Line No.",GetDeferralAmount,
            DeferralHeader."Calc. Method","Returns Deferral Start Date",
            DeferralHeader."No. of Periods",TRUE,
            DeferralHeader."Schedule Description",FALSE,
            PurchHeader."Currency Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetPurchHeader;
        if DeferralHeader.GET(DeferralUtilities.GetPurchDeferralDocType,'','',"Document Type","Document No.","Line No.") then
        #3..5
            DeferralHeader."No. of Periods",true,
            DeferralHeader."Schedule Description",false,
            PurchHeader."Currency Code");
        */
        //end;


        //Unsupported feature: CodeModification on ""Prod. Order No."(Field 5401).OnValidate". Please convert manually.

        //trigger  Order No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Drop Shipment" THEN
          ERROR(
            Text001,
            FIELDCAPTION("Prod. Order No."),"Sales Order No.");

        AddOnIntegrMgt.ValidateProdOrderOnPurchLine(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Drop Shipment" then
        #2..6
        */
        //end;


        //Unsupported feature: CodeModification on ""Variant Code"(Field 5402).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Variant Code" <> '' THEN
          TESTFIELD(Type,Type::Item);
        TestStatusOpen;

        IF xRec."Variant Code" <> "Variant Code" THEN BEGIN
          TESTFIELD("Qty. Rcd. Not Invoiced",0);
          TESTFIELD("Receipt No.",'');

          TESTFIELD("Return Qty. Shipped Not Invd.",0);
          TESTFIELD("Return Shipment No.",'');
        end;

        IF "Drop Shipment" THEN
          ERROR(
            Text001,
            FIELDCAPTION("Variant Code"),"Sales Order No.");

        IF Type = Type::Item THEN
          UpdateDirectUnitCost(FIELDNO("Variant Code"));

        IF (xRec."Variant Code" <> "Variant Code") AND (Quantity <> 0) THEN BEGIN
          ReservePurchLine.VerifyChange(Rec,xRec);
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
          InitItemAppl;
        end;

        UpdateLeadTimeFields;
        UpdateDates;
        GetDefaultBin;
        UpdateItemReference;

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(TRUE);
          UpdateJobPrices;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Variant Code" <> '' then
        #2..4
        if xRec."Variant Code" <> "Variant Code" then begin
        #6..10
        end;

        if "Drop Shipment" then
        #14..17
        if Type = Type::Item then begin
          UpdateDirectUnitCost(FIELDNO("Variant Code"));
         //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
          if GetSKU then begin
            "Indirect Cost %" := SKU."Indirect Cost %";
            "Overhead Rate" := SKU."Overhead Rate";
          end;
          //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
        end;
        if (xRec."Variant Code" <> "Variant Code") and (Quantity <> 0) then begin
        #22..24
        end;

        // << DITW110.00.11 SFI 30/08/2017 BL#14417
        if Type = Type::Item then
          GetDepositValue;
        // >> DITW110.00.11 SFI BL#14417

        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        if (Type = Type::Item) then begin
          GetItem();
          Item.BlockedSKU("Location Code","Variant Code",true);
        end;
        // >> DITW110.00.11 SFI BL#30569
        #27..31
        if JobTaskIsSet then begin
          CreateTempJobJnlLine(true);
          UpdateJobPrices;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 5403).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT IsInbound AND ("Quantity (Base)" <> 0) THEN
          BinCode := WMSManagement.BinContentLookUp("Location Code","No.","Variant Code",'',"Bin Code")
        else
          BinCode := WMSManagement.BinLookUp("Location Code","No.","Variant Code",'');

        IF BinCode <> '' THEN
          VALIDATE("Bin Code",BinCode);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not IsInbound and ("Quantity (Base)" <> 0) then
          BinCode := WMSManagement.BinContentLookUp("Location Code","No.","Variant Code",'',"Bin Code")
        else
          BinCode := WMSManagement.BinLookUp("Location Code","No.","Variant Code",'');

        if BinCode <> '' then
          VALIDATE("Bin Code",BinCode);
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 5403).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bin Code" <> '' THEN BEGIN
          IF NOT IsInbound AND ("Quantity (Base)" <> 0) THEN
            WMSManagement.FindBinContent("Location Code","Bin Code","No.","Variant Code",'')
          else
            WMSManagement.FindBin("Location Code","Bin Code",'');
        end;

        IF "Drop Shipment" THEN
          ERROR(
            Text001,
            FIELDCAPTION("Bin Code"),"Sales Order No.");

        TESTFIELD(Type,Type::Item);
        TESTFIELD("Location Code");

        IF "Bin Code" <> '' THEN BEGIN
          GetLocation("Location Code");
          Location.TESTFIELD("Bin Mandatory");
          CheckWarehouse;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bin Code" <> '' then begin
          if not IsInbound and ("Quantity (Base)" <> 0) then
            WMSManagement.FindBinContent("Location Code","Bin Code","No.","Variant Code",'')
          else
            WMSManagement.FindBin("Location Code","Bin Code",'');
        end;

        if "Drop Shipment" then
        #9..15
        if "Bin Code" <> '' then begin
        #17..19
          // <<DITW15.00.00.21 DDR 24/06/2008
          if Location."Directed Put-away and Pick" then
            CheckBinCubageWeight(0,0);
          // >>DITW15.00.00.21 DDR
        end;
        // <<DITW15.00.00.01 DDR 18/12/2007 - 14/01/2008
        // <<DITW15.00.00.19 DDR 07/04/2008 - DITW15.00.00.35 DDR 29/06/2009 - DITW15.00.00.36 DDR 17/11/2009
        if (Type = Type::Item) and ((Quantity <> 0) or (xRec.Quantity <> Quantity)) then
          InsertCharges3(FIELDNO("Bin Code"));
        // >>DITW15.00.00.35 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit of Measure Code"(Field 5407).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        TESTFIELD("Quantity Received",0);
        TESTFIELD("Qty. Received (Base)",0);
        TESTFIELD("Qty. Rcd. Not Invoiced",0);
        TESTFIELD("Return Qty. Shipped",0);
        TESTFIELD("Return Qty. Shipped (Base)",0);
        IF "Unit of Measure Code" <> xRec."Unit of Measure Code" THEN BEGIN
          TESTFIELD("Receipt No.",'');
          TESTFIELD("Return Shipment No.",'');
        end;
        IF "Drop Shipment" THEN
          ERROR(
            Text001,
            FIELDCAPTION("Unit of Measure Code"),"Sales Order No.");
        IF (xRec."Unit of Measure" <> "Unit of Measure") AND (Quantity <> 0) THEN
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        UpdateDirectUnitCost(FIELDNO("Unit of Measure Code"));
        IF "Unit of Measure Code" = '' THEN
          "Unit of Measure" := ''
        else BEGIN
          UnitOfMeasure.GET("Unit of Measure Code");
          "Unit of Measure" := UnitOfMeasure.Description;
          GetPurchHeader;
          IF PurchHeader."Language Code" <> '' THEN BEGIN
            UnitOfMeasureTranslation.SETRANGE(Code,"Unit of Measure Code");
            UnitOfMeasureTranslation.SETRANGE("Language Code",PurchHeader."Language Code");
            IF UnitOfMeasureTranslation.FINDFIRST THEN
              "Unit of Measure" := UnitOfMeasureTranslation.Description;
          end;
        end;
        UpdateItemReference;
        IF "Prod. Order No." = '' THEN BEGIN
          IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
            GetItem;
            "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
            "Gross Weight" := Item."Gross Weight" * "Qty. per Unit of Measure";
            "Net Weight" := Item."Net Weight" * "Qty. per Unit of Measure";
            "Unit Volume" := Item."Unit Volume" * "Qty. per Unit of Measure";
            "Units per Parcel" := ROUND(Item."Units per Parcel" / "Qty. per Unit of Measure",0.00001);
            IF "Qty. per Unit of Measure" > xRec."Qty. per Unit of Measure" THEN
              InitItemAppl;
            UpdateUOMQtyPerStockQty;
          end else
            "Qty. per Unit of Measure" := 1;
        end else
          "Qty. per Unit of Measure" := 0;

        VALIDATE(Quantity);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
        if "Unit of Measure Code" <> xRec."Unit of Measure Code" then begin
          TESTFIELD("Receipt No.",'');
          TESTFIELD("Return Shipment No.",'');
        end;
        // <<DITW16.00.00.43 DDR 22/01/2014 DIT-715 #882
        if "Unit of Measure Code" <> '' then  // FCE01-+
        if "Is Item Charge" and not HideValidationDialog then
          ERROR(Text2013662,FIELDCAPTION("Unit of Measure Code"),FIELDCAPTION("Item Charge Type"));
        // >>DITW16.00.00.43 DDR DIT-715 #882

        if "Drop Shipment" then
        #12..14
        if (xRec."Unit of Measure" <> "Unit of Measure") and (Quantity <> 0) then
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        UpdateDirectUnitCost(FIELDNO("Unit of Measure Code"));
        if "Unit of Measure Code" = '' then begin
          "Unit of Measure" := '';
          // <<DITW15.00.00.38 DDR 02/09/2010 #1217
          // <<DITW16.00.00.43 DDR 20/12/2013 DIT-715 #864
          VALIDATE("Packaging Type Code",'');
          // >>DITW16.00.00.43 DDR DIT-715 #864
          // >>DITW15.00.00.38 DDR
          // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
          "Pack Qty. per Unit of Measure" := 0;
          // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
        end
        else begin
          UnitOfMeasure.GET("Unit of Measure Code");
          "Unit of Measure" := UnitOfMeasure.Description;
          // <<DITW15.00.00.38 DDR 02/09/2010 #1217
          "Packaging Type Code" := UnitOfMeasure."Packaging Type Code";
          // >>DITW15.00.00.38 DDR
          // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
          "Pack Qty. per Unit of Measure" := 0;
          // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
          GetPurchHeader;
          if PurchHeader."Language Code" <> '' then begin
            UnitOfMeasureTranslation.SETRANGE(Code,"Unit of Measure Code");
            UnitOfMeasureTranslation.SETRANGE("Language Code",PurchHeader."Language Code");
            if UnitOfMeasureTranslation.FINDFIRST then
              "Unit of Measure" := UnitOfMeasureTranslation.Description;
          end;
        end;
        UpdateItemReference;
        if "Prod. Order No." = '' then begin
          if (Type = Type::Item) and ("No." <> '') then begin
        #34..39
            // <<DITW15.00.00.01 DDR 24/01/2008
            "Unit Volume HL" := Item."Unit Volume HL" * "Qty. per Unit of Measure";
            // >>DITW15.00.00.01 DDR
            // <<DITW15.00.00.28 DDR 24/11/2008
            "Tariff No." := Item."Tariff No.";
            // >>DITW15.00.00.28 DDR
            // <<DITW114.00.15 DDR 08/05/2020 NRQ#145254
            GetDepositValue();
            // >>DITW114.00.15 DDR NRQ#145254
            // <<DITW15.00.00.38 DDR 02/09/2010 #1217
            ItemUnitOfMeasure.GET("No.","Unit of Measure Code");
            // <<DITW16.00.00.43 DDR 20/12/2013 DIT-715 #864
            VALIDATE("Packaging Type Code",ItemUnitOfMeasure."Packaging Type Code");
            // >>DITW16.00.00.43 DDR DIT-715 #864
            // >>DITW15.00.00.38 DDR
            // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
            if ItemUnitOfMeasure."Packaging Type Code" <> '' then
              ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
            "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
            // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
            if "Qty. per Unit of Measure" > xRec."Qty. per Unit of Measure" then
              InitItemAppl;
            UpdateUOMQtyPerStockQty;
          end else
            // <<DITW15.00.00.38 DDR 17/12/2010 #703
            if "Tax Item No." <> '' then begin
              Item.GET("Tax Item No.");
              // <<DITW16.00.00.43 DDR 20/12/2013 DIT-715 #864
              ItemUnitOfMeasure.GET(Item."No.","Unit of Measure Code");
              "Qty. per Unit of Measure" := 1;
              // >>DITW16.00.00.43 DDR DIT-715 #864
              "Gross Weight" := Item."Gross Weight" * "Qty. per Unit of Measure";
              "Net Weight" := Item."Net Weight" * "Qty. per Unit of Measure";
              "Unit Volume" := Item."Unit Volume" * "Qty. per Unit of Measure";
              "Units per Parcel" := ROUND(Item."Units per Parcel" / "Qty. per Unit of Measure",0.00001);
              "Unit Volume HL" := Item."Unit Volume HL" * "Qty. per Unit of Measure";
              "Tariff No." := Item."Tariff No.";
              // <<DITW16.00.00.43 DDR 01/10/2013 DIT-715 #519
              ItemUnitOfMeasure.GET(Item."No.","Unit of Measure Code");
              // >>DITW16.00.00.43 DDR DIT-715 #519
              // <<DITW16.00.00.43 DDR 20/12/2013 DIT-715 #864
              VALIDATE("Packaging Type Code",ItemUnitOfMeasure."Packaging Type Code");
              // >>DITW16.00.00.43 DDR DIT-715 #864
              // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
              if ItemUnitOfMeasure."Packaging Type Code" <> '' then
                ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
              "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
              // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
            end else
            // >>DITW15.00.00.38 DDR #703
              "Qty. per Unit of Measure" := 1;
        end else
        #46..48
        */
        //end;


        //Unsupported feature: CodeModification on ""FA Posting Type"(Field 5601).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type = Type::"Fixed Asset" THEN BEGIN
          TESTFIELD("Job No.",'');
          IF "FA Posting Type" = "FA Posting Type"::" " THEN
            "FA Posting Type" := "FA Posting Type"::"Acquisition Cost";
          GetFAPostingGroup
        end else BEGIN
          "Depreciation Book Code" := '';
          "FA Posting Date" := 0D;
          "Salvage Value" := 0;
          "Depr. until FA Posting Date" := FALSE;
          "Depr. Acquisition Cost" := FALSE;
          "Maintenance Code" := '';
          "Insurance No." := '';
          "Budgeted FA No." := '';
          "Duplicate in Depreciation Book" := '';
          "Use Duplication List" := FALSE;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Type = Type::"Fixed Asset" then begin
          TESTFIELD("Job No.",'');
          if "FA Posting Type" = "FA Posting Type"::" " then
            "FA Posting Type" := "FA Posting Type"::"Acquisition Cost";
          GetFAPostingGroup
        end else begin
        #7..9
          "Depr. until FA Posting Date" := false;
          "Depr. Acquisition Cost" := false;
        #12..15
          "Use Duplication List" := false;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Budgeted FA No."(Field 5611).OnValidate". Please convert manually.

        //trigger "(Field 5611)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Budgeted FA No." <> '' THEN BEGIN
          FixedAsset.GET("Budgeted FA No.");
          FixedAsset.TESTFIELD("Budgeted Asset",TRUE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Budgeted FA No." <> '' then begin
          FixedAsset.GET("Budgeted FA No.");
          FixedAsset.TESTFIELD("Budgeted Asset",true);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Duplicate in Depreciation Book"(Field 5612).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Use Duplication List" := FALSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        "Use Duplication List" := false;
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
          DimMgt.TypeToTableID3(Type),"No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Work Center","Work Center No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        if xRec."Responsibility Center" <> "Responsibility Center" then begin
          if not UserSetupMgt.CheckRespCenter(1,"Responsibility Center") then
            ERROR(
              Text2014413,
              RespCenter.TABLECAPTION,UserSetupMgt.GetPurchasesFilter);
        end;

        // "Location Code" := UserSetupMgt.GetLocation(1,'',"Responsibility Center");
        if (CurrFieldNo <> FIELDNO("Location Code")) and
          (CurrFieldNo <> FIELDNO("Physical Location Group Code")) and
          (xRec."Physical Location Group Code" = "Physical Location Group Code") and
          (xRec."Location Code" = "Location Code")
        then begin
            // <<DITW18.00.06 DDR 05/11/2015 DIT-770 #1592
            PhysLocGrCode := UserSetupMgt.GetphysicalLocation(1,'',"Responsibility Center");
            if PhysLocGrCode <> "Physical Location Group Code" then begin
              "Location Code" := '';
              SETFILTER("Location Table Filter",
                UserSetupMgt.GetRespLocationFilter(1,"Responsibility Center",PhysLocGrCode,"Location Code"));
            end;
            VALIDATE("Physical Location Group Code",PhysLocGrCode);
            // >>DITW18.00.06 DDR DIT-770 #1592
            LocationCode := UserSetupMgt.GetLocation(1,'',"Responsibility Center");
            // <<DITW18.00.06 DDR 27/02/2015 DIT-770 #1191
            if (LocationCode <> '') or ("Physical Location Group Code" <> xRec."Physical Location Group Code") then
            // >>DITW18.00.06 DDR DIT-770 #1191
              VALIDATE("Location Code", LocationCode);
        end;
        // >>DITW18.00.06 DDR DIT-770 #1191

        // <<DITW18.00.06 DDR 27/02/2015 DIT-770 #1190 - DITW18.00.06 DDR 05/11/2015 DIT-770 #1592
        if "Responsibility Center" <> xRec."Responsibility Center" then
          UpdateCharges2(FIELDNO("Responsibility Center"),(CurrFieldNo = FIELDNO("Responsibility Center")));
        // >>DITW18.00.06 DDR DIT-770 #1190 - DITW18.00.06 DDR DIT-770 #1592

        #1..4
          DATABASE::"Work Center","Work Center No.",
          // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
          // <<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(2,"Contract Type"),GetContractNo(),
          // >>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
          // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
          DimMgt.TypeToTableID3(Type::Item),"Tax Item No.",
          // >>DITW16.00.00.43 DDR DIT-715 #768
          //<<DITW110.00.10 MSF 21/05/2017 NRQ#13382
          DATABASE::Customer,"Linked Customer No.");
          //>>DITW110.00.10 MSF 21/05/2017 NRQ#13382
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Responsibility Center"(Field 5700)". Please convert manually.



        //Unsupported feature: CodeModification on ""Cross-Reference No."(Field 5705).OnValidate". Please convert manually.

        //trigger "(Field 5705)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        "Buy-from Vendor No." := PurchHeader."Buy-from Vendor No.";

        ReturnedCrossRef.INIT;
        IF "Cross-Reference No." <> '' THEN BEGIN
          DistIntegration.ICRLookupPurchaseItem(Rec,ReturnedCrossRef);
          VALIDATE("No.",ReturnedCrossRef."Item No.");
          SetVendorItemNo;
          IF ReturnedCrossRef."Variant Code" <> '' THEN
            VALIDATE("Variant Code",ReturnedCrossRef."Variant Code");
          IF ReturnedCrossRef."Unit of Measure" <> '' THEN
            VALIDATE("Unit of Measure Code",ReturnedCrossRef."Unit of Measure");
          UpdateDirectUnitCost(FIELDNO("Cross-Reference No."));
        end;

        "Unit of Measure (Cross Ref.)" := ReturnedCrossRef."Unit of Measure";
        "Cross-Reference Type" := ReturnedCrossRef."Cross-Reference Type";
        "Cross-Reference Type No." := ReturnedCrossRef."Cross-Reference Type No.";
        "Cross-Reference No." := ReturnedCrossRef."Cross-Reference No.";

        IF ReturnedCrossRef.Description <> '' THEN
          Description := ReturnedCrossRef.Description;

        UpdateICPartner;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        if "Cross-Reference No." <> '' then begin
          DistIntegration.ICRLookupPurchaseItem(Rec,ReturnedCrossRef);
          /// DITW15.00.00.38 DDR 27/01/2011 #1259 - DITW110.00.08 DDR 02/01/2017 NRQ#0
          VALIDATE("No.",ReturnedCrossRef."Item No.");
          SetVendorItemNo;
          if ReturnedCrossRef."Variant Code" <> '' then
            VALIDATE("Variant Code",ReturnedCrossRef."Variant Code");
          if ReturnedCrossRef."Unit of Measure" <> '' then
            VALIDATE("Unit of Measure Code",ReturnedCrossRef."Unit of Measure");
          UpdateDirectUnitCost(FIELDNO("Cross-Reference No."));
        end else
          // <<DITW15.00.00.38 DDR 27/01/2011 #1259
          VALIDATE("No.");
          // >>DITW15.00.00.38 DDR #1259
        #15..20
        if ReturnedCrossRef.Description <> '' then
        #22..24

        // <<DITW15.00.00.38 DDR 27/01/2011 #1259
        if (CurrFieldNo = FIELDNO("Cross-Reference No.")) and
           (Type = Type::Item)  and
           (not BatchInsertCheckSuspended)
        then begin
          COMMIT;
          if "Line No." <> 0 then begin
            if TransferExtText.PurchCheckIfAnyExtText(Rec,false) then
              TransferExtText.InsertPurchExtText(Rec);
            COMMIT;
          end;

          if (Type = Type::Item) and ("Quantity Invoiced" = 0) and
            ("Quantity Received" = 0) and ("Return Qty. Shipped" = 0) and
            ("Appl.-to Item Entry" = 0) and
            ("Receipt No." = '') and ("Return Shipment No." = '') and
            // <<DITW17.10.03 DDR 26/06/2014 DIT-770 #570
            (CurrFieldNo <> 0) and ("Line No." <> 0)
            // >>DITW17.10.03 DDR DIT-770 #570
          then begin
            if (Quantity <> 0) or (xRec.Quantity <> Quantity) then begin
              lTempCurrfieldNo := CurrFieldNo;
              CurrFieldNo := FIELDNO("Location Code");
              InsertCharges3(FIELDNO("Location Code"));
              CurrFieldNo := lTempCurrfieldNo;
            end else
              DeleteAllChargePurchLines(Rec,true);
          end;
        end;

        CreateDim(
          DimMgt.TypeToTableID3(Type),"No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Work Center","Work Center No.",
          // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(2,"Contract Type"),GetContractNo(),
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
          // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
          DimMgt.TypeToTableID3(Type::Item),"Tax Item No.",
          // >>DITW16.00.00.43 DDR DIT-715 #768
          //<<DITW110.00.10 MSF 21/05/2017 NRQ#13382
          DATABASE::Customer,"Linked Customer No.");
         //>>DITW110.00.10 MSF 21/05/2017 NRQ#13382
        // >>DITW15.00.00.38 DDR #1259
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Item Category Code"(Field 5709)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.28 DDR 24/11/2008
        if "Item Category Code" <> '' then begin
          ItemCategory.GET("Item Category Code" );
          if "AAD No. Series" <> '' then begin
            // <<DITW15.00.00.32 DDR 09/04/2009
            if "Tariff No." = '' then begin
              GetItem();
              Item.TESTFIELD("Tariff No.");
            end;
            // >>DITW15.00.00.32 DDR
          end;
        end;
        // >>DITW15.00.00.28 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Purchasing Code"(Field 5711).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF PurchasingCode.GET("Purchasing Code") THEN BEGIN
          "Drop Shipment" := PurchasingCode."Drop Shipment";
          "Special Order" := PurchasingCode."Special Order";
        end else
          "Drop Shipment" := FALSE;
        VALIDATE("Drop Shipment","Drop Shipment");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if PurchasingCode.GET("Purchasing Code") then begin
          "Drop Shipment" := PurchasingCode."Drop Shipment";
          "Special Order" := PurchasingCode."Special Order";
        end else
          "Drop Shipment" := false;
        VALIDATE("Drop Shipment","Drop Shipment");

        // <<DITW15.00.00.01 15/01/2008
        // <<DITW15.00.00.19 DDR 22/04/2008
        UpdateCharges(FIELDNO("Purchasing Code"),true);
        // >>DITW15.00.00.01 DDR
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Purchasing Code"(Field 5711)". Please convert manually.



        //Unsupported feature: CodeModification on ""Special Order"(Field 5713).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (xRec."Special Order" <> "Special Order") AND (Quantity <> 0) THEN
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (xRec."Special Order" <> "Special Order") and (Quantity <> 0) then
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);

        // <<DITW15.00.00.01 15/01/2008
        // <<DITW15.00.00.19 DDR 22/04/2008
        if Type = Type::Item then
          UpdateCharges(FIELDNO("Special Order"),true);
        // >>DITW15.00.00.01 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Special Order Sales No."(Field 5714).OnValidate". Please convert manually.

        //trigger "(Field 5714)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (xRec."Special Order Sales No." <> "Special Order Sales No.") AND (Quantity <> 0) THEN
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (xRec."Special Order Sales No." <> "Special Order Sales No.") and (Quantity <> 0) then
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        */
        //end;


        //Unsupported feature: CodeModification on ""Special Order Sales Line No."(Field 5715).OnValidate". Please convert manually.

        //trigger "(Field 5715)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (xRec."Special Order Sales Line No." <> "Special Order Sales Line No.") AND (Quantity <> 0) THEN
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (xRec."Special Order Sales Line No." <> "Special Order Sales Line No.") and (Quantity <> 0) then
          WhseValidateSourceLine.PurchaseLineVerifyChange(Rec,xRec);
        */
        //end;


        //Unsupported feature: CodeModification on ""Requested Receipt Date"(Field 5790).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF (CurrFieldNo <> 0) AND
           ("Promised Receipt Date" <> 0D)
        THEN
          ERROR(
            Text023,
            FIELDCAPTION("Requested Receipt Date"),
            FIELDCAPTION("Promised Receipt Date"));

        IF "Requested Receipt Date" <> 0D THEN
          VALIDATE("Order Date",
            CalendarMgmt.CalcDateBOC2(AdjustDateFormula("Lead Time Calculation"),"Requested Receipt Date",
              CalChange."Source Type"::Vendor,"Buy-from Vendor No.",'',
              CalChange."Source Type"::Location,"Location Code",'',TRUE))
        else
          IF "Requested Receipt Date" <> xRec."Requested Receipt Date" THEN
            GetUpdateBasicDates;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        if (CurrFieldNo <> 0) and
           ("Promised Receipt Date" <> 0D)
        then
        #5..9
        if "Requested Receipt Date" <> 0D then
        #11..13
              CalChange."Source Type"::Location,"Location Code",'',true))
        else
          if "Requested Receipt Date" <> xRec."Requested Receipt Date" then
            GetUpdateBasicDates;
        {
        //HEI.24>>
        IF PurchSetup.GET THEN BEGIN
          PurchaseLine.SETRANGE("Document No.","No.");
          PurchaseLine.SETFILTER(Type,'%1',PurchaseLine.Type::Item);
          PurchaseLine.SETFILTER("Item Category Code",'*%1',PurchSetup."Item Category");
          IF NOT PurchaseLine.FINDFIRST THEN
            ItemCategoryBool := FALSE
          else
            ItemCategoryBool := TRUE;
          IF ItemCategoryBool THEN BEGIN
        //HEI.24<<
            //HEI.22>>
        IF ("SRM Order No." = '') AND (("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order")) THEN BEGIN
            PurchHdrArch.RESET;
            PurchHdrArch.SETRANGE(PurchHdrArch."Document Type","Document Type");
            PurchHdrArch.SETRANGE(PurchHdrArch."No.","Document No.");
            IF PurchHdrArch.FINDFIRST THEN BEGIN
              PurchHeader.RESET;
              PurchHeader.SETRANGE(PurchHeader."No.","Document No.");
              IF PurchHeader.FINDFIRST THEN BEGIN
                IF PurchHeader."Purch. Reason Code" = '' THEN
                   ERROR(ReasonCodeErr);
                end;
            end;
        end;
        //HEI.22<<
        //HEI.24>>
          end;
        end;
        //HEI.24<<
        }
        */
        //end;


        //Unsupported feature: CodeModification on ""Promised Receipt Date"(Field 5791).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrFieldNo <> 0 THEN
          IF "Promised Receipt Date" <> 0D THEN
            VALIDATE("Planned Receipt Date","Promised Receipt Date")
          else
            VALIDATE("Requested Receipt Date")
        else
          VALIDATE("Planned Receipt Date","Promised Receipt Date");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CurrFieldNo <> 0 then
          if "Promised Receipt Date" <> 0D then
            VALIDATE("Planned Receipt Date","Promised Receipt Date")
          else
            VALIDATE("Requested Receipt Date")
        else
          VALIDATE("Planned Receipt Date","Promised Receipt Date");
        */
        //end;


        //Unsupported feature: CodeModification on ""Lead Time Calculation"(Field 5792).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        LeadTimeMgt.CheckLeadTimeIsNotNegative("Lead Time Calculation");

        IF "Requested Receipt Date" <> 0D THEN BEGIN
          VALIDATE("Planned Receipt Date");
        end else
          GetUpdateBasicDates;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        if "Requested Receipt Date" <> 0D then begin
          VALIDATE("Planned Receipt Date");
        end else
          GetUpdateBasicDates;
        */
        //end;


        //Unsupported feature: CodeModification on ""Inbound Whse. Handling Time"(Field 5793).OnValidate". Please convert manually.

        //trigger  Handling Time"(Field 5793)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF ("Promised Receipt Date" <> 0D) OR
           ("Requested Receipt Date" <> 0D)
        THEN
          VALIDATE("Planned Receipt Date")
        else
          VALIDATE("Expected Receipt Date");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        if ("Promised Receipt Date" <> 0D) or
           ("Requested Receipt Date" <> 0D)
        then
          VALIDATE("Planned Receipt Date")
        else
          VALIDATE("Expected Receipt Date");
        */
        //end;


        //Unsupported feature: CodeModification on ""Planned Receipt Date"(Field 5794).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF "Promised Receipt Date" <> 0D THEN BEGIN
          IF "Planned Receipt Date" <> 0D THEN
            "Expected Receipt Date" :=
              CalendarMgmt.CalcDateBOC(InternalLeadTimeDays("Planned Receipt Date"),"Planned Receipt Date",
                CalChange."Source Type"::Location,"Location Code",'',
                CalChange."Source Type"::Location,"Location Code",'',FALSE)
          else
            "Expected Receipt Date" := "Planned Receipt Date";
        end else
          IF "Planned Receipt Date" <> 0D THEN BEGIN
            "Order Date" :=
              CalendarMgmt.CalcDateBOC2(AdjustDateFormula("Lead Time Calculation"),"Planned Receipt Date",
                CalChange."Source Type"::Vendor,"Buy-from Vendor No.",'',
                CalChange."Source Type"::Location,"Location Code",'',TRUE);
            "Expected Receipt Date" :=
              CalendarMgmt.CalcDateBOC(InternalLeadTimeDays("Planned Receipt Date"),"Planned Receipt Date",
                CalChange."Source Type"::Location,"Location Code",'',
                CalChange."Source Type"::Location,"Location Code",'',FALSE)
          end else
            GetUpdateBasicDates;

        IF NOT TrackingBlocked THEN
          CheckDateConflict.PurchLineCheck(Rec,CurrFieldNo <> 0);
        CheckReservationDateConflict(FIELDNO("Planned Receipt Date"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        if "Promised Receipt Date" <> 0D then begin
          if "Planned Receipt Date" <> 0D then
        #4..6
                CalChange."Source Type"::Location,"Location Code",'',false)
          else
            "Expected Receipt Date" := "Planned Receipt Date";
        end else
          if "Planned Receipt Date" <> 0D then begin
        #12..14
                CalChange."Source Type"::Location,"Location Code",'',true);
        #16..18
                CalChange."Source Type"::Location,"Location Code",'',false)
          end else
            GetUpdateBasicDates;

        if not TrackingBlocked then
          CheckDateConflict.PurchLineCheck(Rec,CurrFieldNo <> 0);
        CheckReservationDateConflict(FIELDNO("Planned Receipt Date"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Order Date"(Field 5795).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF (CurrFieldNo <> 0) AND
           ("Document Type" = "Document Type"::Order) AND
           ("Order Date" < WORKDATE) AND
           ("Order Date" <> 0D)
        THEN
          MESSAGE(
            Text018,
            FIELDCAPTION("Order Date"),"Order Date",WORKDATE);

        IF "Order Date" <> 0D THEN
          "Planned Receipt Date" :=
            CalendarMgmt.CalcDateBOC(AdjustDateFormula("Lead Time Calculation"),"Order Date",
              CalChange."Source Type"::Vendor,"Buy-from Vendor No.",'',
              CalChange."Source Type"::Location,"Location Code",'',TRUE);

        IF "Planned Receipt Date" <> 0D THEN
          "Expected Receipt Date" :=
            CalendarMgmt.CalcDateBOC(InternalLeadTimeDays("Planned Receipt Date"),"Planned Receipt Date",
              CalChange."Source Type"::Location,"Location Code",'',
              CalChange."Source Type"::Location,"Location Code",'',FALSE)
        else
          "Expected Receipt Date" := "Planned Receipt Date";

        IF NOT TrackingBlocked THEN
          CheckDateConflict.PurchLineCheck(Rec,CurrFieldNo <> 0);
        CheckReservationDateConflict(FIELDNO("Order Date"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        if (CurrFieldNo <> 0) and
           ("Document Type" = "Document Type"::Order) and
           ("Order Date" < WORKDATE) and
           ("Order Date" <> 0D)
        then
          //>>HEI.50
          if GUIALLOWED then
          //<<HEI.50
            MESSAGE(
              Text018,
              FIELDCAPTION("Order Date"),"Order Date",WORKDATE);

        if "Order Date" <> 0D then
        #12..14
              CalChange."Source Type"::Location,"Location Code",'',true);

        if "Planned Receipt Date" <> 0D then
        #18..20
              CalChange."Source Type"::Location,"Location Code",'',false)
        else
          "Expected Receipt Date" := "Planned Receipt Date";

        if not TrackingBlocked then
          CheckDateConflict.PurchLineCheck(Rec,CurrFieldNo <> 0);
        CheckReservationDateConflict(FIELDNO("Order Date"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Return Qty. to Ship"(Field 5803).OnValidate". Please convert manually.

        //trigger  to Ship"(Field 5803)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (CurrFieldNo <> 0) AND
           (Type = Type::Item) AND
           ("Return Qty. to Ship" <> 0) AND
           (NOT "Drop Shipment")
        THEN
          CheckWarehouse;

        IF "Return Qty. to Ship" = Quantity - "Return Qty. Shipped" THEN
          InitQtyToShip
        else BEGIN
          "Return Qty. to Ship (Base)" := CalcBaseQty("Return Qty. to Ship");
          InitQtyToInvoice;
        end;
        IF ("Return Qty. to Ship" * Quantity < 0) OR
           (ABS("Return Qty. to Ship") > ABS("Outstanding Quantity")) OR
           (Quantity * "Outstanding Quantity" < 0)
        THEN
          ERROR(
            Text020,
            "Outstanding Quantity");
        IF ("Return Qty. to Ship (Base)" * "Quantity (Base)" < 0) OR
           (ABS("Return Qty. to Ship (Base)") > ABS("Outstanding Qty. (Base)")) OR
           ("Quantity (Base)" * "Outstanding Qty. (Base)" < 0)
        THEN
          ERROR(
            Text021,
            "Outstanding Qty. (Base)");

        IF (CurrFieldNo <> 0) AND (Type = Type::Item) AND ("Return Qty. to Ship" > 0) THEN
          CheckApplToItemLedgEntry;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (CurrFieldNo <> 0) and
           (Type = Type::Item) and
           ("Return Qty. to Ship" <> 0) and
           (not "Drop Shipment")
        then
          CheckWarehouse;

        //<< DITW18.00.07 VSC 22/01/2016 DIT-770 #1702
        ValidateMancoSurplusTolerance;
        //>> DITW18.00.07 VSC DIT-770 #1702

        if "Return Qty. to Ship" = Quantity - "Return Qty. Shipped" then
          InitQtyToShip
        else begin
          "Return Qty. to Ship (Base)" := CalcBaseQty("Return Qty. to Ship");
          InitQtyToInvoice;
        end;
        if ("Return Qty. to Ship" * Quantity < 0) or
           (ABS("Return Qty. to Ship") > ABS("Outstanding Quantity")) or
           (Quantity * "Outstanding Quantity" < 0)
        then
        #18..20
        if ("Return Qty. to Ship (Base)" * "Quantity (Base)" < 0) or
           (ABS("Return Qty. to Ship (Base)") > ABS("Outstanding Qty. (Base)")) or
           ("Quantity (Base)" * "Outstanding Qty. (Base)" < 0)
        then
        #25..28
        if (CurrFieldNo <> 0) and (Type = Type::Item) and ("Return Qty. to Ship" > 0) then
          CheckApplToItemLedgEntry;

        // <<DITW15.00.00.01 DDR 04/01/2008 - 15/01/2008
        // <<DITW15.00.00.19 DDR 22/04/2008  - DITW15.00.00.31 DDR 19/02/2009 - DITW15.00.00.35 DDR 29/06/2009
        // <<DITW15.00.00.37 DDR 22/01/2010
        // <<DITW16.00.00.40 DDR 23/05/2012 DIT-715 #275-DITW111.00.13A MSF 22/04/2019 NRQ#108355
        if (Type = Type::Item) and
        //>>DITW111.00.13A MSF 22/04/2019 NRQ#108355
        // <<DITW16.00.00.40 DDR 23/05/2012 DIT-715 #275
        //IF (Type = Type::Item) AND ("Return Qty. to Ship" <> xRec."Return Qty. to Ship") AND
          // <<DITW110.00.11 DDR 06/10/2017 NRQ#37925
          (CurrFieldNo <> FIELDNO(Quantity)) and
          // >>DITW110.00.11 DDR NRQ#37925
          not BatchInsertCheckSuspended
        then
          // <<DITW110.00.11 DDR 06/10/2017 NRQ#37925 - DITW114.00.15 DDR 29/04/2020 NRQ#102424
          UpdateCharges(FIELDNO("Return Qty. to Ship"),not ISTEMPORARY);
          // >>DITW110.00.11 DDR NRQ#37925 - DITW114.00.15 DDR NRQ#102424
        // >>DITW15.00.00.37 DDR - DITW16.00.00.40 DDR DIT-715 #275
        */
        //end;


        //Unsupported feature: CodeModification on ""Return Shpd. Not Invd."(Field 5807).OnValidate". Please convert manually.

        //trigger  Not Invd();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        Currency2.InitRoundingPrecision;
        IF PurchHeader."Currency Code" <> '' THEN
          "Return Shpd. Not Invd. (LCY)" :=
            ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
                GetDate,"Currency Code",
                "Return Shpd. Not Invd.",PurchHeader."Currency Factor"),
              Currency2."Amount Rounding Precision")
        else
          "Return Shpd. Not Invd. (LCY)" :=
            ROUND("Return Shpd. Not Invd.",Currency2."Amount Rounding Precision");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetPurchHeader;
        Currency2.InitRoundingPrecision;
        if PurchHeader."Currency Code" <> '' then
        #4..9
        else
          "Return Shpd. Not Invd. (LCY)" :=
            ROUND("Return Shpd. Not Invd.",Currency2."Amount Rounding Precision");
        */
        //end;


        //Unsupported feature: CodeModification on ""Return Reason Code"(Field 6608).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateReturnReasonCode(FIELDNO("Return Reason Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        /// DITW110.00.08 DDR 02/01/2017 NRQ#0
        ValidateReturnReasonCode(FIELDNO("Return Reason Code"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Operation No."(Field 99000751).OnValidate". Please convert manually.

        //trigger "(Field 99000751)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Operation No." = '' THEN
          EXIT;

        TESTFIELD(Type,Type::Item);
        TESTFIELD("Prod. Order No.");
        #6..18
        "Expected Receipt Date" := ProdOrderRtngLine."Ending Date";
        VALIDATE("Work Center No.",ProdOrderRtngLine."No.");
        VALIDATE("Direct Unit Cost",ProdOrderRtngLine."Direct Unit Cost");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Operation No." = '' then
          exit;
        #3..21
        */
        //end;


        //Unsupported feature: CodeModification on ""Work Center No."(Field 99000752).OnValidate". Please convert manually.

        //trigger "(Field 99000752)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type = Type::"Charge (Item)" THEN
          TESTFIELD("Work Center No.",'');
        IF "Work Center No." = '' THEN
          EXIT;

        WorkCenter.GET("Work Center No.");
        "Gen. Prod. Posting Group" := WorkCenter."Gen. Prod. Posting Group";
        "VAT Prod. Posting Group" := '';
        IF GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") THEN
          "VAT Prod. Posting Group" := GenProdPostingGrp."Def. VAT Prod. Posting Group";
        VALIDATE("VAT Prod. Posting Group");

        #13..16
          DATABASE::"Work Center","Work Center No.",
          DimMgt.TypeToTableID3(Type),"No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Responsibility Center","Responsibility Center");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Type = Type::"Charge (Item)" then
          TESTFIELD("Work Center No.",'');
        if "Work Center No." = '' then
          exit;
        #5..8
        if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") then
        #10..19
          DATABASE::"Responsibility Center","Responsibility Center",
          // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(2,"Contract Type"),GetContractNo(),
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
          // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
          DimMgt.TypeToTableID3(Type::Item),"Tax Item No.",
          // >>DITW16.00.00.43 DDR DIT-715 #768
          //<<DITW110.00.10 MSF 21/05/2017 NRQ#13382
          DATABASE::Customer,"Linked Customer No.");
          //>>DITW110.00.10 MSF 21/05/2017 NRQ#13382
        */
        //end;


        //Unsupported feature: CodeModification on ""Planning Flexibility"(Field 99000757).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Planning Flexibility" <> xRec."Planning Flexibility" THEN
          ReservePurchLine.UpdatePlanningFlexibility(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Planning Flexibility" <> xRec."Planning Flexibility" then
          ReservePurchLine.UpdatePlanningFlexibility(Rec);
        */
        //end;
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
            Editable = true;

            trigger OnValidate();
            var
                PurchLine: Record "Purchase Line";
                WHRcptHdr: Record "Warehouse Receipt Header";
                WHRequest: Record "Warehouse Request";
            begin
                //HEI.79>>
                if "Delivery Finalized FND" = false then begin
                    if "Outstanding Quantity" = 0 then
                        ERROR(Text50005, "Line No.", "Document No.")
                    else begin
                        if WHRequest.GET(WHRequest.Type::Inbound, "Location Code", DATABASE::"Purchase Line", WHRequest."Source Subtype"::"1", "Document No.") then begin
                            if WHRequest."Completely Handled" then begin
                                WHRequest."Completely Handled" := false;
                                WHRequest.MODIFY();
                            end;
                        end;
                    end;
                end else begin
                    PurchLine.RESET();
                    PurchLine.SETRANGE(PurchLine."Document Type", "Document Type");
                    PurchLine.SETRANGE(PurchLine."Document No.", "Document No.");
                    //HEI.82>>
                    // PurchLine.SETRANGE(PurchLine.Type,PurchLine.Type::Item);
                    //HEI.82<<
                    PurchLine.SETFILTER(PurchLine."Line No.", '<>%1', "Line No.");
                    PurchLine.SETRANGE(PurchLine."Delivery Finalized FND", false);
                    if not PurchLine.FINDFIRST() then begin
                        if WHRequest.GET(WHRequest.Type::Inbound, "Location Code", DATABASE::"Purchase Line", WHRequest."Source Subtype"::"1", "Document No.") then begin
                            if not WHRequest."Completely Handled" then begin
                                WHRequest."Completely Handled" := true;
                                WHRequest.MODIFY();
                            end;
                        end;
                    end;
                end;

                //HEI.79<<
                //HEI.80>>
                //BC UPgrade SHARMP16 Drink-IT fields used to build the logic begin <<
                // if WHRequest.GET(WHRequest.Type::Inbound, "Location Code", DATABASE::"Purchase Line", WHRequest."Source Subtype"::"1", "Document No.") then begin
                //     if ((Type = Type::Item) and (WHRequest."Warehouse Rcpt/Shpt No." <> '')) then begin
                //         //IF WHRcptHdr.GET(WHRequest."Warehouse Rcpt/Shpt No.") THEN BEGIN //HEI.81
                //         if not WHRcptHdr.GET(WHRequest."Warehouse Rcpt/Shpt No.") then begin //HEI.81
                //             WHRequest."Warehouse Rcpt/Shpt No." := '';
                //             WHRequest.MODIFY;
                //         end;
                //     end;
                // end;
                //BC UPgrade SHARMP16 Drink-IT fields used to build the logic end >>
                //HEI.80<<
                //<<HEI.33
                if "Delivery Finalized FND" = true then
                    "Completely Received" := true
                else if "Delivery Finalized FND" = false then
                    "Completely Received" := false;
                //>>HEI.33
            end;
        }
        field(50009; "Tolerance Received Over % FND"; Decimal)
        {
            Caption = 'Tolerance Received Over %';
            DecimalPlaces = 2 : 5;
            Description = 'HEI.01';
            Editable = true;
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
        field(50017; "WHT Business Posting Group FND"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            Description = 'HEI.03';
            TableRelation = "WHT Business Posting Group FND".Code;
        }
        field(50018; "WHT Product Posting Group FND"; Code[10])
        {
            Caption = 'WHT Product Posting Group';
            Description = 'HEI.03';
            TableRelation = "WHT Product Posting Group FND".Code;
        }
        field(50019; "WHT Absorb Base FND"; Decimal)
        {
            Caption = 'WHT Absorb Base';
            Description = 'HEI.03';
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
        field(50022; "Invoiced Amount FND"; Decimal)
        {
            Caption = 'Invoiced Amount';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50023; "Qty. to Return FND"; Decimal)
        {
            AccessByPermission = TableData "Return Shipment Header" = R;
            CaptionML = ENU = 'Qty. to Return',
                        ESP = 'Cantidad a devolver',
                        FRA = 'Qté à retourner';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.09';

            trigger OnValidate();
            begin
                //HEI.09>>
                if ((("Qty. to Return FND" < 0) xor (Quantity < 0)) and (Quantity <> 0) and ("Qty. to Return FND" <> 0)) or
                   (ABS("Qty. to Return FND") > ABS("Quantity Received")) or
                   (((Quantity < 0) xor ("Quantity Received" < 0)) and (Quantity <> 0) and ("Quantity Received" <> 0))
                then
                    ERROR(
                      CannotReturnUnitsErr,
                      "Quantity Received");
                if ((("Qty. to Return (Base) FND" < 0) xor ("Quantity (Base)" < 0)) and ("Quantity (Base)" <> 0) and ("Qty. to Return (Base) FND" <> 0)) or
                   (ABS("Qty. to Return (Base) FND") > ABS("Qty. Received (Base)")) or
                   ((("Quantity (Base)" < 0) xor ("Qty. Received (Base)" < 0)) and ("Quantity (Base)" <> 0) and ("Qty. Received (Base)" <> 0))
                then
                    ERROR(
                      CannotReturnBaseUnitsErr,
                      "Qty. Received (Base)");
                //HEI.09<<
            end;
        }
        field(50024; "Qty. to Return (Base) FND"; Decimal)
        {
            CaptionML = ENU = 'Qty. to Return (Base)',
                        ESP = 'Cdad. a devolver (base)',
                        FRA = 'Qté à retourner (base)';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.09';

            trigger OnValidate();
            begin
                //HEI.09>>
                TESTFIELD("Qty. per Unit of Measure", 1);
                VALIDATE("Qty. to Return FND", "Qty. to Return (Base) FND");
                //HEI.09<<
            end;
        }
        field(50030; "Maximo Requisition No. FND"; Code[20])
        {
            Caption = 'Maximo Requisition No.';
            Description = 'HEI.05';
            Editable = false;
        }
        field(50031; "Maximo Requis. Line No. FND"; Integer)
        {
            Caption = 'Maximo Requisition Line No.';
            Description = 'HEI.05';
            Editable = false;
        }
        field(50032; "Machine Reference Number FND"; Text[50])
        {
            Caption = 'Machine Reference Number';
            Description = 'HEI.13';
            Editable = false;
            FieldClass = Normal;
        }
        field(50035; "SC Source Type FND"; Integer)
        {
            Caption = 'SC Source Type';
        }
        field(50036; "SC Source No. FND"; Code[10])
        {
            Caption = 'SC Source No.';
        }
        field(50037; "SC Line No. FND"; Integer)
        {
            Caption = 'SC Line No.';
        }
        field(50038; "Remaining Amount FND"; Decimal)
        {
            Caption = 'Remaining Amount';
            Description = 'HEI.06';
            Editable = false;
        }
        field(50039; "Initial Amount FND"; Decimal)
        {
            Caption = 'Initial Amount';
            Description = 'HEI.06';
            Editable = false;
        }
        field(50040; "Zone Code FND"; Code[20])
        {
            Caption = 'Zone Code';
            Description = 'HEI.05';
        }
        field(50041; "Manual Insert FND"; Boolean)
        {
            Caption = 'Manual Insert';
            Description = 'HEI.14';
        }
        field(50042; "TIN No. FND"; Text[20])
        {
            Caption = 'TIN No.';
            Description = 'HEI.19';
            Editable = false;
            TableRelation = "TIN by Location FND"."TIN No.";
            ValidateTableRelation = false;
        }
        field(50043; "H.S.Code FND"; Code[10])
        {
            Description = 'HEI.36 FDD-HT1079.V03';
            Caption = 'H.S. Code';
        }
        field(50045; "Requesters ID FND"; Code[50])
        {
            // CalcFormula = Lookup("Purchase Header"."Requester ID" where("Document Type" = FIELD("Document Type"),//BC UPGRADE SHARMP16 Drink-it field used for Calcformula 
            //                                                              "No." = FIELD("Document No.")));
            Description = 'HEI.46';
            Caption = 'Requesters ID';
            // FieldClass = FlowField;//BCUpgrade sharmp16--PurchProcesstestchange
        }
        field(50046; "Additional Description FND"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.45';
            Caption = 'Additional Description';
        }
        field(50047; "Import Identifier FND"; Boolean)
        {
            CalcFormula = Lookup("Purchase Header Additional FND"."Import Identifier" where("No." = FIELD("Document No."),
                                                                                         "Document Type" = FIELD("Document Type")));
            Description = 'HEI.47';
            Caption = 'Import Identifier';
            FieldClass = FlowField;
        }
        field(50048; "Exp Physical Del Date(Imp) FND"; Date)
        {
            Caption = 'Expected Physical Delivery Date(Imp)';
            Description = 'HEI.48';

            trigger OnValidate();
            begin
                //HEI.48>>
                TestStatusOpen();
                //HEI.48<<
            end;
        }
        field(50049; "TO Reference FND"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.48';
            Caption = 'TO Reference';
        }
        field(50051; "CAD Amount FND"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'CAD Amount',
                        FRA = 'CAD Montant';
            DataClassification = ToBeClassified;
            Description = 'HEI.51';
            Editable = false;
        }
        field(50052; "CAD Attached to Line No. FND"; Integer)
        {
            Caption = 'CAD Attached to Line No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.51';
            Editable = false;
        }
        field(50054; "Astro Unique ID FND"; Code[20])
        {
            Caption = 'Astro Unique ID';
            DataClassification = ToBeClassified;
            Description = 'HEI.58';
            Editable = false;
        }
        field(50055; "Header Document Date FND"; Date)
        {
            CalcFormula = Lookup("Purchase Header"."Document Date" where("Document Type" = FIELD("Document Type"),
                                                                          "No." = FIELD("Document No.")));
            Description = 'HEI.59';
            Caption = 'Header Document Date';
            FieldClass = FlowField;
        }
        field(50056; "Header Created By FND"; Code[50])
        {
            CalcFormula = Lookup("Purchase Header"."Created By IBM FND" where("Document Type" = FIELD("Document Type"),
                                                                       "No." = FIELD("Document No.")));//BC Upgrade SHARMP16 END>> ---IBM GAP STP 48
            Description = 'HEI.59';
            Caption = 'Header Created By';
            FieldClass = FlowField;
        }
        field(50057; "SPL Code FND"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.61';
            Caption = 'SPL Code';
            TableRelation = "Vendor SPL Relation FND"."SPL Code" where("Vendor No." = FIELD("Buy-from Vendor No."),
                                                                    Blocked = CONST(false));

            trigger OnValidate();
            var
                VendorSPL: Record "Vendor SPL Relation FND";
            begin
                //HEI.61 >>
                "SPL Name FND" := '';
                if VendorSPL.GET("Buy-from Vendor No.", "SPL Code FND") then
                    "SPL Name FND" := VendorSPL.Name;
                //HEI.61 <<
            end;
        }
        field(50058; "SPL Name FND"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.61';
            Caption = 'SPL Name';
            Editable = false;
        }
        field(50059; "Consumption SPL Code FND"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.61';
            Caption = 'Consumption SPL Code';
            TableRelation = "Vendor SPL Relation FND"."SPL Code" where("Vendor No." = FIELD("Buy-from Vendor No."),
                                                                    Blocked = CONST(false));
        }
        field(50060; "Due Date FND"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.66';
            Caption = 'Due Date';
            Editable = false;
        }
        field(50061; "Estimated Pmt. Due Date FND"; Date)
        {
            Caption = 'Estimated Payment Due Date';
            DataClassification = ToBeClassified;
            Description = 'HAI.66';
            Editable = false;
        }
        field(50062; "H&S Levy Tax % FND"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.67';
            Caption = 'H&S Levy Tax %';
            Editable = false;
            TableRelation = "H&S Tax Posting Group FND";
        }
        field(50063; "H&S Levy Tax Amount FND"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.67';
            Caption = 'H&S Levy Tax Amount';
            Editable = false;
        }
        field(50064; "Total Amount Excl VAT/H&S FND"; Decimal)
        {
            Caption = 'Total Amount Excl VAT/H&S';
            DataClassification = ToBeClassified;
            Description = 'HEI.67';
            Editable = false;
        }
        field(50065; "HS Posting Group FND"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.70';
            Caption = 'H&S Posting Group';
            TableRelation = "H&S Tax Posting Group FND";
        }
        field(50075; "Zycus Order No. FND"; Code[20])
        {
            Caption = 'Zycus Order No.';
            Description = 'HEI.68,HEI.74';
            Editable = false;
        }
        field(50076; "Zycus Order Line No. FND"; Integer)
        {
            Caption = 'Zycus Order Line No.';
            Description = 'HEI.68,HEI.74';
            Editable = false;
        }
        field(50077; "Zycus PR Reference No. FND"; Code[20])
        {
            Caption = 'Zycus PR Reference No.';
            Description = 'HEI.74';
            Editable = false;
        }
        field(50078; "Zycus PO Type Code FND"; Code[3])
        {
            Caption = 'Zycus PO Type Code';
            Description = 'HEI.69,HEI.74';
            Editable = false;
        }
        field(50079; "Zycus PO Line Type Code FND"; Code[1])
        {
            Caption = 'Zycus PO Line Type Code';
            Description = 'HEI.69,HEI.74';
            Editable = false;
        }
        field(50080; "Zycus PO Line Validated FND"; Boolean)
        {
            Caption = 'Zycus PO Line Validated';
            Description = 'HEI.74';
            Editable = false;
        }
        field(50081; "Tolerance Exceeded FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.71';
            Caption = 'Tolerance Exceeded';
        }
        field(50082; "Vendor Shipment No. FND"; Code[35])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.78';
            Caption = 'Vendor Shipment No.';
        }
        field(50085; "Zycus Movement Type FND"; Integer)
        {
            Caption = 'Zycus Movement Type';
            Description = 'HEI.77';
            Editable = false;
        }
        //BC UPGRADE ATHUKUS01 FDDSTP_007>>
        field(50086; "Original Quantity FND"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Original Quantity';
        }
        //BC UPGRADE ATHUKUS01 FDDSTP_007<<
        //BC UPGRADE ATHUKS01 FDDSTP_GAP11<<
        field(50087; "Whse. Receipt No. (Open) FND"; Code[20])
        {
            CalcFormula = Lookup("Warehouse Receipt Line"."No." WHERE("Source Type" = CONST(39),
                                                                       "Source Subtype" = FIELD("Document Type"),
                                                                       "Source No." = FIELD("Document No."),
                                                                       "Source Line No." = FIELD("Line No.")));
            CaptionML = ENU = 'Whse. Receipt No. (Open)',
                        FRA = 'N° réception magasin (Ouvert)';
            Description = 'DITW15.00.00.39 #1399';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Warehouse Receipt Header";
        }
        // BC Upgrade BHARDA11 >> -- This field has been created because when we enter values in the “Qty. to Receive” field on the Purchase Order, its behavior is not working correctly. Therefore, this field is introduced to handle and control that behavior properly.
        field(50088; "Qty. to Reveive Heilite FND"; Decimal)
        {
            Description = 'This field is used for store data of Qty. to Receive till OnBeforeInitQtyToReceive executed';
            DataClassification = ToBeClassified;
            Caption = 'Quantity to Receive Heilite';
        }
        field(50090; "CAD Line FND"; Boolean)
        {
            Caption = 'CAD Line';
            DataClassification = ToBeClassified;
            Editable = false;
        }//BC Upgrade SHARMP16 //BC Upgrade SHARMP16 CAD

        // BC Upgrade BHARDA11 << -- This field has been created because when we enter values in the “Qty. to Receive” field on the Purchase Order, its behavior is not working correctly. Therefore, this field is introduced to handle and control that behavior properly.

        //BC UPGRADE ATHUKS01 FDDSTP_GAP11>>

        //BC UPGRADE SHARMP16 Drink-IT fileds begin<<
        // field(2013610;"Item DDeposit Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Deposit Group Code',
        //                 FRA='Code groupe consigne article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Deposit Group".Code WHERE ("Source Type"=CONST(Item));

        //     trigger OnValidate();
        //     begin
        //         TestStatusOpen;
        //     end;
        // }

        // field(2013611;"Empty Goods Item No.";Code[20])
        // {
        //     CaptionML = ENU='Empty Goods Item No.',
        //                 FRA='N° article vidange';
        //     Description = 'DITW15.00.00.01-.35';
        //     TableRelation = Item WHERE ("Empty Good"=CONST(true));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009
        //         TestStatusOpen;
        //         // >>DITW15.00.00.35 DDR
        //     end;
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
        // field(2013622;"Empty Good";Boolean)
        // {
        //     CalcFormula = Lookup("Inventory Posting Group"."As Empty Good" WHERE (Code=FIELD("Posting Group")));
        //     Caption = 'Empty Good';
        //     Description = 'NRQ#16224';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013636;"Split Deposit on Invoice";Boolean)
        // {
        //     CaptionML = ENU='Split Deposit on Invoice (Entries)',
        //                 FRA='Diviser consigne sur facture (écritures)';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.42 DDR 07/12/2012 DIT-715 #370
        //         if "Split Deposit on Invoice" then begin
        //           if Type <> Type::"Charge (Item)" then
        //             FIELDERROR(Type);
        //           TESTFIELD("Item Charge Type","Item Charge Type"::Deposit);
        //           GetPurchHeader();
        //           PurchHeader.TESTFIELD("Deposit Vendor Posting Group");
        //         end;
        //         // >>DITW16.00.00.42 DDR DIT-715 #370
        //     end;
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
        //     Description = 'VC8-DITW15.00.00.01-.34, DIT-770 #1678';
        //     OptionCaptionML = ENU=' ,Amount,Price %,Amount %,Fixed Amount,Volume /Unit,Weight,Cubage,Distance,Purchase Price,Unit of measure',
        //                       FRA=' ,Montant,Prix %,Montant %,Montant Fixe,Volume /Unité,Poids,Cubage,Distance,Prix vente,Unité de mesure';
        //     OptionMembers = " ",Amount,"Price %","Amount %","Fixed Amount",VolumeHL,Weight,Cubage,Distance,"Price Item","Unit of measure";
        // }
        // field(2013661;"Item Charge Value";Decimal)
        // {
        //     AutoFormatExpression = GetAutoformatRoundingType("Currency Code");
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
        //     CaptionML = ENU='Vendor Tax Group Code',
        //                 FRA='Code groupe taxe fournisseur';
        //     Description = 'DITW17.10.03 DIT-770 698';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Vendor));

        //     trigger OnValidate();
        //     begin
        //         //<<DITW17.10.05 MSF 17/07/2014 DIT-770 #698
        //         TestStatusOpen;
        //         TestVenorTaxRegHeader();
        //         //TestStatusModifyEmcs(FIELDCAPTION("Customer DTax Group Code"));

        //         // <<DITW17.10.05 MSF 30/07/2014 DIT-770 #692
        //         if (xRec."Vendor DTax Group Code" <> "Vendor DTax Group Code") and
        //           ("Line No." <> 0) and (Quantity <> 0) and
        //           (not BatchInsertCheckSuspended)
        //         then begin
        //           TESTFIELD(Type,Type::Item);
        //           CLEAR(CommonItemChrgMgt);
        //           CLEAR(TransferTaxCharges);
        //           GetPurchHeader();
        //           ForceDeleteItemCharges := false;
        //           CLEAR(SaveTempPurchChargeLine);
        //           SaveTempPurchChargeLine.DELETEALL;
        //           PurchLine2.COPY(Rec);
        //           SaveTempPurchChargeLine.SETRANGE("Item Charge Type",SaveTempPurchChargeLine."Item Charge Type"::Tax);
        //           CommonItemChrgMgt.DeletePurchLines(PurchLine2,
        //             SaveTempPurchChargeLine,true,"Item Charge Calculate per"::Item);
        //           TransferTaxCharges.SuspendStatusCheck(true);
        //           TransferTaxCharges.CalcDirectUnitPurchLine(PurchHeader,Rec,0,true,0);
        //           if TransferTaxCharges.PurchCheckIfAny(PurchHeader,Rec,false,FIELDNO(Quantity)) then begin
        //             TransferTaxCharges.TempInsertPurch(Rec,SaveTempPurchChargeLine);
        //             GetItem();
        //             if Item."Gift Box Item" then begin
        //               if BomItemCharges.PurchCheckIfAny(PurchHeader,Rec,true,FIELDNO(Quantity)) then
        //                 BomItemCharges.TempInsertPurch(Rec,SaveTempPurchChargeLine);
        //             end;
        //             if TransferTaxCharges.MakeUpdate() or BomItemCharges.MakeUpdate() then begin
        //               CommonItemChrgMgt.InsertChrgPurchLines(
        //                 PurchHeader,Rec,SaveTempPurchChargeLine,SaveTempItemChrgAssgnPurch,true,true,true);
        //               UpdateAmounts();
        //             end;
        //           end;
        //         end;
        //         // >>DITW17.10.05 DDR DIT-770 #692
        //         UpdateAADInfo();
        //         //>>DITW17.10.05 MSF 17/07/2014 DIT-770 #698
        //     end;
        // }
        // field(2013667;"Item DTax Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Tax Group Code',
        //                 FRA='Code groupe taxe article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Item));

        //     trigger OnValidate();
        //     begin
        //         TestStatusOpen;
        //         // <<DITW15.00.00.38 DDR 20/08/2010 #1217
        //         UpdateAADInfo();
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2013695;"Item Charge Type";Option)
        // {
        //     CaptionML = ENU='Item Charge Type',
        //                 FRA='Type frais annexes';
        //     Description = 'DITW15.00.00.01-.35';
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

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 20/08/2010 #1217
        //         UpdateAADInfo();
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2013708;"Due Tax";Boolean)
        // {
        //     CaptionML = ENU='Due Tax',
        //                 FRA='Taxe due';
        //     Description = 'DITW15.00.00.01';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009
        //         TestStatusOpen;
        //         // >>DITW15.00.00.35 DDR
        //         // <<DITW17.10.05 MSF 11/12/2014 DIT-770 #701
        //         TestTaxDueMandatory ();
        //         // >>DITW17.10.05 MSF 11/12/2014 DIT-770 #701
        //         // <<DITW15.00.00.38 DDR 20/08/2010 #1217
        //         TestDutySuspendMandatory();
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2013715;"Tax Formula";Code[80])
        // {
        //     CaptionML = ENU='Tax Formula',
        //                 FRA='Formule taxe';
        //     Description = 'DITW15.00.00.30';
        // }
        // field(2013716;"Strength Spec. Code";Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0,FIELDNO("Strength Spec. Code"));
        //     CaptionML = ENU='Strength Spec. Code',
        //                 FRA='Code contrainte spécification taxe';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" WHERE (Type=CONST(Specification));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        //         TestStatusOpen;
        //         TESTFIELD(Type,Type::Item);
        //     end;
        // }
        // field(2013717;"Strength Spec. Value";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CalcFormula = Average("Reservation Entry"."Strength Spec. Value" WHERE ("Source Type"=CONST(39),
        //                                                                             "Source Subtype"=FIELD("Document Type"),
        //                                                                             "Source ID"=FIELD("Document No."),
        //                                                                             "Source Batch Name"=CONST(''),
        //                                                                             "Source Prod. Order Line"=CONST(0),
        //                                                                             "Source Ref. No."=FIELD("Line No.")));
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

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        //         TestStatusOpen;
        //     end;
        // }
        // field(2013719;"Vol-Strength Spec. Value";Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Vol-Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CalcFormula = Sum("Reservation Entry"."Vol-Strength Spec. Value" WHERE ("Source Type"=CONST(39),
        //                                                                             "Source Subtype"=FIELD("Document Type"),
        //                                                                             "Source ID"=FIELD("Document No."),
        //                                                                             "Source Batch Name"=CONST(''),
        //                                                                             "Source Prod. Order Line"=CONST(0),
        //                                                                             "Source Ref. No."=FIELD("Line No.")));
        //     CaptionClass = GetTaxSpecCaption(1,FIELDNO("Vol-Strength Spec. Value"));
        //     CaptionML = ENU='Vol-Strength Spec. Value',
        //                 FRA='Valeur spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013722;"Duty Suspended";Boolean)
        // {
        //     CaptionML = ENU='Duty Suspended',
        //                 FRA='Taxe en suspension';
        //     Description = 'DITW15.00.00.33';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 20/08/2010 #1217
        //         TestDutySuspendMandatory();
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2013726;"Company Tax Registration No.";Text[20])
        // {
        //     CaptionML = ENU='Company Tax Registration No.',
        //                 FRA='N° identif. accise société';
        //     Description = 'DITW15.00.00.28';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009
        //         TestStatusOpen;
        //         // >>DITW15.00.00.35 DDR
        //         // <<DITW15.00.00.38 DDR 20/08/2010 #1217
        //         TestTaxRegMandatory();
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2013727;"AAD No. Series";Code[10])
        // {
        //     CaptionML = ENU='AAD No. Series',
        //                 FRA='Souches de n° DAA';
        //     Description = 'DITW15.00.00.28';
        //     TableRelation = "No. Series";

        //     trigger OnLookup();
        //     var
        //         lrPurchLine : Record "Purchase Line";
        //         lDefaultAADCode : Code[10];
        //     begin
        //         // <<DITW15.00.00.28 DDR 24/11/2008
        //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //         if Type = Type::"Charge (Item)" then
        //           TESTFIELD("Tax Item No.")
        //         else
        //           TESTFIELD(Type,Type::Item);
        //         // >>DITW15.00.00.38 DDR #703

        //         // <<DITW15.00.00.33 DDR 14/05/2009 - DITW15.00.00.38 DDR 20/08/2010 #1217
        //         TestAADNoSeriesMandatory();
        //         // >>DITW15.00.00.38 DDR

        //         with lrPurchLine do begin
        //           lrPurchLine := Rec;
        //           lDefaultAADCode := GetAADNoSeries();
        //           if NoSeriesMgt.LookupSeries(lDefaultAADCode,"AAD No. Series") then
        //             VALIDATE("AAD No. Series");
        //           Rec := lrPurchLine;
        //         end;
        //     end;

        //     trigger OnValidate();
        //     var
        //         lDefaultAADCode : Code[10];
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009
        //         TestStatusOpen;
        //         // >>DITW15.00.00.35 DDR
        //         // <<DITW15.00.00.28 DDR 24/11/2008
        //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //         if Type = Type::"Charge (Item)" then
        //           TESTFIELD("Tax Item No.")
        //         else
        //           TESTFIELD(Type,Type::Item);
        //         // >>DITW15.00.00.38 DDR #703

        //         if "AAD No. Series" <> '' then begin
        //           lDefaultAADCode := GetAADNoSeries();
        //           if lDefaultAADCode <> '' then
        //             NoSeriesMgt.TestSeries(lDefaultAADCode,"AAD No. Series");
        //           // <<DITW15.00.00.32 DDR 09/04/2009 - DITW15.00.00.38 DDR 20/08/2010 #1217
        //           TestAADNoSeriesMandatory();
        //           // >>DITW15.00.00.38 DDR
        //         end;
        //         TESTFIELD("AAD No.",'');
        //     end;
        // }
        // field(2013728;"AAD No.";Code[20])
        // {
        //     CaptionML = ENU='AAD No.',
        //                 FRA='N° DAA';
        //     Description = 'DITW15.00.00.28';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW15.00.00.35 DDR 24/06/2009 - DITW15.00.00.37 DDR 07/01/2010
        //         if "Outstanding Quantity" = 0 then
        //           FIELDERROR("Outstanding Quantity");
        //         // >>DITW15.00.00.37 DDR

        //         // <<DITW15.00.00.39 DDR 11/07/2011 #1369
        //         if CurrFieldNo = FIELDNO("AAD No.") then
        //           TESTFIELD("Applies-to AAD Trck. Entry No.",0);
        //         // >>DITW15.00.00.39 DDR #1369

        //         // <<DITW15.00.00.28 DDR 24/11/2008
        //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //         if Type = Type::"Charge (Item)" then
        //           TESTFIELD("Tax Item No.")
        //         else
        //           TESTFIELD(Type,Type::Item);
        //         // >>DITW15.00.00.38 DDR #703

        //         if "AAD No." <> xRec."AAD No." then begin
        //           NoSeriesMgt.TestManual("AAD No. Series");
        //           "AAD No. Series" := '';
        //         end;

        //         if "AAD No." <> '' then begin
        //           AADDocMgt.CheckAADNo("AAD No.");
        //           // <<DITW15.00.00.32 DDR 09/04/2009
        //           TESTFIELD("Tariff No.");
        //           // >>DITW15.00.00.32 DDR
        //         end;
        //     end;
        // }
        // field(2013729;"Tariff No.";Code[10])
        // {
        //     CaptionML = ENU='Tariff No.',
        //                 FRA='Nomenclature produits';
        //     Description = 'DITW15.00.00.28';
        //     TableRelation = "Tariff Number";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009
        //         TestStatusOpen;
        //         // >>DITW15.00.00.35 DDR
        //         // <<DITW15.00.00.32 DDR 09/04/2009
        //         if "Tariff No." = '' then
        //           TESTFIELD("AAD No. Series",'');
        //         // >>DITW15.00.00.32 DDR
        //     end;
        // }
        // field(2013731;"Applies-to AAD Trck. Entry No.";Integer)
        // {
        //     CaptionML = ENU='Applies-to Correction AAD Trck. Entry No.',
        //                 FRA='N° Ecriture correction suivi DAA lettrage';
        //     Description = 'DITW15.00.00.39 #1369';
        //     TableRelation = "AAD Tracking Entry"."Entry No." WHERE ("Entry Type"=CONST(Outbound),
        //                                                             "Source Type"=CONST(Vendor),
        //                                                             "Source No."=FIELD("Buy-from Vendor No."));

        //     trigger OnLookup();
        //     var
        //         AADTrackingEntry : Record "AAD Tracking Entry";
        //     begin
        //         // <<DITW16.00.00.39 DDR 05/08/2011 DIT-715 #148
        //         AADTrackingEntry.SETRANGE("Entry Type",AADTrackingEntry."Entry Type"::Outbound);
        //         AADTrackingEntry.SETRANGE("Source Type",AADTrackingEntry."Source Type"::Vendor);
        //         AADTrackingEntry.SETRANGE("Source No.","Buy-from Vendor No.");
        //         AADTrackingEntry."Entry No." := "Applies-to AAD Trck. Entry No.";
        //         if PAGE.RUNMODAL(0,AADTrackingEntry) = ACTION::LookupOK then
        //           VALIDATE("Applies-to AAD Trck. Entry No.",AADTrackingEntry."Entry No.");
        //     end;

        //     trigger OnValidate();
        //     var
        //         AADTrackingEntry : Record "AAD Tracking Entry";
        //     begin
        //         // <<DITW15.00.00.39 DDR 04/08/2011 #1369
        //         if Type = Type::" " then
        //           FIELDERROR(Type);
        //         if "Applies-to AAD Trck. Entry No." <> 0 then begin
        //           TESTFIELD("LRN No.",'');
        //           AADTrackingEntry.GET("Applies-to AAD Trck. Entry No.");
        //           "AAD No. Series" := '';
        //           "AAD No." := AADTrackingEntry."AAD No.";
        //           "LRN No. Series" := '';
        //           "ARC No." := AADTrackingEntry."ARC No.";
        //           "ARC No. Mandatory" := false;
        //         end else begin
        //           "AAD No." := '';
        //           "ARC No." := '';
        //           if Type = Type::Item then
        //             UpdateAADInfo();
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

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.01 DDR 24/01/2008 - DITW15.00.00.19 DDR 22/04/2008
        //         UpdateCharges(FIELDNO("Unit Volume HL"),true);
        //         // >>DITW15.00.00.19 DDR
        //     end;
        // }
        // field(2013773;"Vendor DDisc. Group Code";Code[10])
        // {
        //     CaptionML = ENU='Vendor Discount Group',
        //                 FRA='Groupe remise fournisseur';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Discount Group".Code WHERE ("Source Type"=CONST(Vendor));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009
        //         TestStatusOpen;
        //     end;
        // }
        // field(2013774;"Item DDisc. Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Discount Group',
        //                 FRA='Groupe remise article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Discount Group".Code WHERE ("Source Type"=CONST(Item));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009
        //         TestStatusOpen;
        //     end;
        // }
        // field(2013775;"Vendor DPromo. Group Code";Code[10])
        // {
        //     CaptionML = ENU='Vendor Promotion Group',
        //                 FRA='Groupe promotion fournisseur';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Promotion Group".Code WHERE ("Source Type"=CONST(Vendor));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009
        //         TestStatusOpen;
        //     end;
        // }
        // field(2013776;"Item DPromo. Group Code";Code[10])
        // {
        //     CaptionML = ENU='Item Promotion Group',
        //                 FRA='Groupe promotion article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Promotion Group".Code WHERE ("Source Type"=CONST(Item));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009
        //         TestStatusOpen;
        //     end;
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
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013779;"Using Qty. (Base)";Boolean)
        // {
        //     CaptionML = ENU='Using Qty. (Base)',
        //                 FRA='Utilisation quantité (Base)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013780;"Free Quantity";Decimal)
        // {
        //     CaptionML = ENU='Free Quantity',
        //                 FRA='Quantité gratuite';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.01';
        //     MinValue = 0;
        // }
        // field(2013781;"Multiple Quantity";Decimal)
        // {
        //     CaptionML = ENU='Multiple Quantity',
        //                 FRA='Quantité multiple';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.01';
        //     MinValue = 0;
        // }
        // field(2013782;"Maximum Free Quantity";Decimal)
        // {
        //     CaptionML = ENU='Maximum Free Quantity',
        //                 FRA='Quantité maximum gratuite';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.01';
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
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     CaptionML = ENU='DDiscount Base Amount',
        //                 FRA='Montant base remise';
        //     Description = 'DITW17.00.02 DIT-770 #274';
        // }
        // field(2013785;"Periodic Disc.-Promo Entry No.";Integer)
        // {
        //     CaptionML = ENU='Periodic Disc.-Promo Entry No.',
        //                 FRA='N° écriture Remise-Promotion périodique';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Sales Discount.-Promo. Entry"."Entry No.";
        // }
        // field(2013788;"DDiscount Include Tax";Boolean)
        // {
        //     CaptionML = ENU='DDiscount Include Tax',
        //                 FRA='Remise inculent taxe';
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

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 - 20/01/2012 DIT-715 #172 - 25/01/2012 DIT-715 #172
        //         TestStatusOpen;
        //         // <<DITW16.00.00.43 DDR 05/11/2013 DIT-715 #811
        //         if xRec."Allow VAT Calculation (Free)" <> "Allow VAT Calculation (Free)" then begin
        //         // >>DITW16.00.00.43 DDR DIT-715 #812
        //           TESTFIELD("Quantity Received",0);
        //           TESTFIELD("Qty. Received (Base)",0);
        //           TESTFIELD("Return Qty. Shipped",0);
        //           TESTFIELD("Return Qty. Shipped (Base)",0);
        //         end;
        //         if "Allow VAT Calculation (Free)" and "Free Item" then begin
        //           if Type = Type::Item then
        //             TESTFIELD("Free Item Posting Type")
        //           else
        //             TESTFIELD("Free Calculation Type","Free Calculation Type"::"Discount 100%");
        //             // <<DITW111.00.13 DDR 11/12/2018 NRQ#35372
        //             GetPurchHeader;
        //             "VAT Base Amount" := ROUND(Quantity * "Item Charge Value",Currency."Amount Rounding Precision");
        //             // >>DITW111.00.13 DDR NRQ#35372
        //         end else begin
        //           Amount := 0;
        //           "Amount Including VAT" := 0;
        //           "VAT Base Amount" := 0;
        //         end;
        //         if (Type = Type::Item) and "Is Item Charge" then
        //           UpdateCharges(FIELDNO("Allow VAT Calculation (Free)"),false);
        //         InitOutstandingAmount;
        //         UpdateAmounts();
        //     end;
        // }
        // field(2013824;"Gen. Prod. Posting Free Group";Code[10])
        // {
        //     CaptionML = ENU='Gen. Prod. Posting Group Free Item',
        //                 FRA='Groupe article gratuit compta. produit';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Gen. Product Posting Group";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009
        //         TestStatusOpen;
        //         // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
        //         case Type of
        //           Type::Item:
        //             begin
        //               TESTFIELD("Free Item Posting Type");
        //               if "Free Item" then
        //                 VALIDATE("Free Item");
        //             end;
        //         end;
        //         // >>DITW16.00.00.40 DDR DIT-715 #172
        //     end;
        // }
        // field(2013825;"Free Item Posting Type";Option)
        // {
        //     CaptionML = ENU='Calculate Price on Free',
        //                 FRA='Calculer Prix sur gratuit';
        //     Description = 'DITW15.00.00.35';
        //     OptionCaptionML = ENU=' ,Price 0,Discount 100%',
        //                       FRA=' ,Prix 0,Remise 100%';
        //     OptionMembers = " ",Price,Amount;

        //     trigger OnValidate();
        //     var
        //         lTempBatchInsertCheckSuspended : Boolean;
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009 - 14/10/2009
        //         TestStatusOpen;
        //         // <<DITW15.00.00.37 DDR 20/01/2010
        //         // <<DITW16.00.00.43 DDR 18/10/2013 DIT-715 #811
        //         if (xRec."Free Item" <> "Free Item") or
        //           (xRec."Free Item Posting Type" <> "Free Item Posting Type")
        //         then begin
        //         // >>DITW16.00.00.43 DDR DIT-715 #811
        //           TESTFIELD("Quantity Received",0);
        //           TESTFIELD("Qty. Received (Base)",0);
        //           TESTFIELD("Return Qty. Shipped",0);
        //           TESTFIELD("Return Qty. Shipped (Base)",0);
        //         end;
        //         // >>DITW15.00.00.37 DDR
        //         TESTFIELD(Type,Type::Item);

        //         lTempBatchInsertCheckSuspended := BatchInsertCheckSuspended;
        //         BatchInsertCheckSuspended := true;

        //         case "Free Item Posting Type" of
        //           "Free Item Posting Type"::" ":
        //             begin
        //               // <<DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
        //               if CurrFieldNo = FIELDNO("Free Item Posting Type") then begin
        //                 BatchInsertCheckSuspended := lTempBatchInsertCheckSuspended;
        //                 // <<DITW114.00.15 DDR 08/07/2020 NRQ#151016
        //                 if (CurrFieldNo <> FIELDNO("Free Item Posting Type")) then
        //                 // >>DITW114.00.15 DDR NRQ#151016
        //                   VALIDATE("Free Item",false);
        //                 UpdateDirectUnitCost(FIELDNO("Free Item Posting Type"));
        //               end;
        //               VALIDATE("Line Discount %",0);
        //             end;
        //           "Free Item Posting Type"::Price:
        //             begin
        //               // <<DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
        //               if "Free Item" then begin
        //                 if CurrFieldNo = FIELDNO("Free Item Posting Type") then begin
        //                   VALIDATE("Free Item");
        //                   // <<DITW19.00.08 DDR 11/08/2016 BL#9886
        //                   VALIDATE("Line Discount %",0);
        //                   VALIDATE("Direct Unit Cost",0);
        //                   // >>DITW19.00.08 DDR BL#9886
        //                   UpdateDirectUnitCost(FIELDNO("Free Item Posting Type"));
        //                 end;
        //                 VALIDATE("Line Discount %",0);
        //                 VALIDATE("Direct Unit Cost",0);
        //               // <<DITW19.00.08 DDR 11/08/2016 BL#9886
        //               end else
        //                 UpdateDirectUnitCost(FIELDNO("Free Item Posting Type"));
        //               // >>DITW19.00.08 DDR BL#9886
        //             end;
        //           "Free Item Posting Type"::Amount:
        //             begin
        //               // <<DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
        //               if "Free Item" then begin
        //                 if CurrFieldNo = FIELDNO("Free Item Posting Type") then begin
        //                   VALIDATE("Free Item");
        //                   "Line Discount %" := 0;
        //                   "Direct Unit Cost" := "Item Charge Value";
        //                   UpdateDirectUnitCost(FIELDNO("Free Item Posting Type"));
        //                 end;
        //                 VALIDATE("Line Discount %",100);
        //               // <<DITW19.00.08 DDR 11/08/2016 BL#9886
        //               end else
        //                 VALIDATE("Line Discount %",0);
        //               // >>DITW19.00.08 DDR BL#9886
        //             end;
        //         end;

        //         BatchInsertCheckSuspended := lTempBatchInsertCheckSuspended;
        //         if  xRec."Free Item Posting Type" <> "Free Item Posting Type" then
        //           UpdateAmounts();
        //     end;
        // }
        // field(2013826;"Free Item";Boolean)
        // {
        //     CaptionML = ENU='Free Item',
        //                 FRA='Article gratuit';
        //     Description = 'DITW15.00.00.35';

        //     trigger OnValidate();
        //     var
        //         lTempBatchInsertCheckSuspended : Boolean;
        //         lTempCurrfieldno : Integer;
        //         "_NRQ195518.1_LOCALS" : Integer;
        //         lrecFreeReasonCode : Record "Free Reason Code";
        //         lrecItem : Record Item;
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009 - 21/08/2009 - 14/10/2009
        //         TestStatusOpen;
        //         // <<DITW15.00.00.37 DDR 20/01/2010
        //         // <<DITW16.00.00.43 DDR 18/10/2013 DIT-715 #811
        //         if (xRec."Free Item" <> "Free Item") or
        //           (xRec."Free Item Posting Type" <> "Free Item Posting Type")
        //         then begin
        //         // >>DITW16.00.00.43 DDR DIT-715 #811
        //           TESTFIELD("Quantity Received",0);
        //           TESTFIELD("Qty. Received (Base)",0);
        //           TESTFIELD("Return Qty. Shipped",0);
        //           TESTFIELD("Return Qty. Shipped (Base)",0);
        //         end;
        //         // >>DITW15.00.00.37 DDR
        //         // <<DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
        //         TESTFIELD(Type,Type::Item);
        //         // >>DITW18.00.07A DDR DIT-770 #2074
        //         GetPurchHeader();

        //         lTempBatchInsertCheckSuspended := BatchInsertCheckSuspended;
        //         BatchInsertCheckSuspended := true;

        //         if "Free Item" then begin
        //           // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868 - DITW17.10.05 DDR 12/02/2015 DIT-770 #1118
        //             GetItem();
        //           // >>DITW17.10.05 DDR DIT-770 #868
        //           if "Free Item Posting Type" = "Free Item Posting Type"::" " then begin
        //             if Item."Free Item Posting Type" <> Item."Free Item Posting Type"::" " then
        //               "Free Item Posting Type" := Item."Free Item Posting Type"
        //             else
        //               "Free Item Posting Type" := PurchHeader."Free Item Posting Type";
        //           end;
        //           // <<DITW17.00.01 DDR 08/03/2013 DIT-770 #001
        //           TESTFIELD("Free Item Posting Type");
        //           PurchHeader.TESTFIELD("Gen. Bus. Posting Free Group");
        //           TESTFIELD("Gen. Prod. Posting Free Group");

        //           // >>DITW17.00.01 DDR DIT-770 #001
        //           // <<DITW17.10.03 DDR 04/07/2014 DIT-770 #699 - DITW17.10.05 DDR 12/02/2015 DIT-770 #1118
        //           //<< DITW110.00.12A ISL 21/06/2018 NRQ#67425
        //           //IF (Item."Free Reason Code" <> "Free Reason Code") AND ("Free Reason Code" = '') THEN
        //             //"Free Reason Code" := Item."Free Reason Code";
        //           if (Item."Free Reason Code (Purchase)"<>"Free Reason Code") and ("Free Reason Code" = '') then
        //             "Free Reason Code" := Item."Free Reason Code (Purchase)";
        //           //>> DITW110.00.12A ISL NRQ#67425
        //           // >>DITW17.10.03 DDR DIT-770 #699 - DITW17.10.05 DDR DIT-770 #1118
        //           "Gen. Bus. Posting Group" := PurchHeader."Gen. Bus. Posting Free Group";
        //           // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
        //           VALIDATE("Gen. Prod. Posting Group","Gen. Prod. Posting Free Group");
        //           // >>DITW16.00.00.40 DDR DIT-715 #172
        //           VALIDATE("VAT Prod. Posting Group");
        //           // <<DITW17.10.05 DDR 12/02/2015 DIT-770 #1118
        //           if (CurrFieldNo <> FIELDNO("Free Item Posting Type")) and
        //             // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868
        //             (CurrFieldNo <> FIELDNO("Free Reason Code")) and
        //             (CurrFieldNo <> FIELDNO("No."))
        //             // >>DITW17.10.05 DDR DIT-770 #868
        //           then begin
        //             // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868
        //             lTempCurrfieldno := CurrFieldNo;
        //             VALIDATE("Free Reason Code");
        //             // >>DITW17.10.05 DDR DIT-770 #868
        //             // >>DITW17.10.05 DDR DIT-770 #1118
        //             // <<DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
        //             if (CurrFieldNo = FIELDNO("Free Item")) or
        //               (CurrFieldNo = 0)
        //             then
        //               BatchInsertCheckSuspended := lTempBatchInsertCheckSuspended;
        //             // <<DITW114.00.15 DDR 08/07/2020 NRQ#151016
        //             if (CurrFieldNo <> FIELDNO("Free Item Posting Type")) and
        //               (xRec."Free Item Posting Type" = "Free Item Posting Type")
        //             then
        //             // >>DITW114.00.15 DDR NRQ#151016
        //               VALIDATE("Free Item Posting Type");
        //             // >>DITW18.00.07A DDR DIT-770 #2074
        //             UpdateDirectUnitCost(FIELDNO("Free Item"));
        //             // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868 - DITW17.10.05 DDR 12/02/2015 DIT-770 #1118
        //             CurrFieldNo := lTempCurrfieldno;
        //             // >>DITW17.10.05 DDR DIT-770 #868 - DITW17.10.05 DDR DIT-770 #1118
        //             UpdateAmounts();
        //             // <<DITW16.00.00.40 DDR 27/04/2012 DIT-715 #243 - DITW17.10.05 DDR 12/02/2015 DIT-770 #1118
        //             BatchInsertCheckSuspended := lTempBatchInsertCheckSuspended;
        //             // >>DITW16.00.00.40 DDR DIT-715 #243 - DITW17.10.05 DDR DIT-770 #1118
        //             // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
        //             if "Allow VAT Calculation (Free)" and (CurrFieldNo <> 0) and
        //               (CurrFieldNo <> FIELDNO("Allow VAT Calculation (Free)"))
        //             then
        //               VALIDATE("Allow VAT Calculation (Free)");
        //             // >>DITW16.00.00.40 DDR DIT-715 #172
        //           // <<DITW111.00.13A DDR 12/06/2019 NRQ#112600
        //           end else
        //             if (CurrFieldNo <> FIELDNO("Free Item Posting Type")) then
        //               VALIDATE("Free Item Posting Type");
        //           // >>DITW111.00.13A DDR NRQ#112600
        //         end else begin
        //           // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
        //           if (CurrFieldNo <> 0) and "Is Item Charge" and xRec."Free Item" and not HideValidationDialog then
        //             ERROR(
        //               STRSUBSTNO(Text010,
        //                 FIELDCAPTION("Free Item"),
        //                 FIELDCAPTION("Item Charge Type"),"Item Charge Type"));
        //           PurchHeader.TESTFIELD("Gen. Bus. Posting Group");
        //           "Gen. Bus. Posting Group" := PurchHeader."Gen. Bus. Posting Group";
        //           GetItem;
        //           Item.TESTFIELD(Blocked,false);
        //           // << DITW110.00.11 SFI 31/08/2017 BL#30569
        //           Item.BlockedSKU("Location Code","Variant Code",true);
        //           // >> DITW110.00.11 SFI BL#30569
        //           Item.TESTFIELD("Inventory Posting Group");
        //           Item.TESTFIELD("Gen. Prod. Posting Group");
        //           "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
        //           "VAT Prod. Posting Group" := Item."VAT Prod. Posting Group";
        //           // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
        //           "VAT Base Amount" := 0;
        //           // >>DITW16.00.00.40 DDR DIT-715 #172
        //           // <<DITW17.10.05 DDR 12/02/2015 DIT-770 #1118
        //           if (CurrFieldNo <> FIELDNO("No.")) and (CurrFieldNo <> FIELDNO("Free Reason Code")) then begin
        //           // >>DITW17.10.05 DDR DIT-770 #1118
        //             //<<DITW17.10.05 MSF 06/08/2014 DIT-770 #864 - DITW17.10.05 DDR 12/02/2015 DIT-770 #1118
        //             "Free Reason Code" := '';
        //             // <<DITW110.00.12 DDR 08/03/2018 NRQ#63284
        //             "Vendor DTax Group Code" := GetVendorTaxGroupCode("Vendor DTax Group Code","Item DTax Group Code");
        //             // >>DITW110.00.12 DDR NRQ#63284
        //             //>>DITW17.10.05 MSF 06/08/2014 DIT-770 #864 - DITW17.10.05 DDR DIT-770 #1118
        //             VALIDATE("VAT Prod. Posting Group");
        //             BatchInsertCheckSuspended := lTempBatchInsertCheckSuspended;
        //             if (CurrFieldNo = FIELDNO("Free Item")) or
        //               (CurrFieldNo = FIELDNO("Free Item Posting Type")) or
        //               // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868 - DITW17.10.05 DDR 12/02/2015 DIT-770 #1118
        //               (CurrFieldNo = FIELDNO("Free Reason Code")) or
        //               // >>DITW17.10.05 DDR DIT-770 #868 - DITW17.10.05 DDR DIT-770 #1118
        //               // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
        //               (CurrFieldNo = FIELDNO("Allow VAT Calculation (Free)"))
        //               // >>DITW16.00.00.40 DDR DIT-715 #172
        //             then begin
        //               VALIDATE("Unit of Measure Code");
        //               if Quantity <> 0 then begin
        //                 InitOutstanding;
        //                 if "Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"] then
        //                   InitQtyToShip
        //                 else
        //                   InitQtyToReceive;
        //                 UpdateWithWarehouseReceive();
        //                 //<< DITW18.00.07 AKH 10/05/2016 DIT-770 #1346
        //                 if "Document Type" = "Document Type"::Order then
        //                   CalcDeliveryTimeQtyBase();
        //                 //>> DITW18.00.07 AKH DIT-770 #1346
        //                 // <<DITW114.00.15 DDR 08/07/2020 NRQ#151016
        //                 if (CurrFieldNo <> FIELDNO("Free Item Posting Type")) and
        //                   (xRec."Free Item Posting Type" = "Free Item Posting Type")
        //                 then
        //                 // >>DITW114.00.15 DDR NRQ#151016
        //                   VALIDATE("Free Item Posting Type");
        //                 UpdateAmounts();
        //                 // >>DITW19.00.08 DDR BL#9886
        //               end;
        //               // <<DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
        //               BatchInsertCheckSuspended := lTempBatchInsertCheckSuspended;
        //               // >>DITW18.00.07A DDR DIT-770 #2074
        //               // <<DITW114.00.15 DDR 08/07/2020 NRQ#151016
        //               if (CurrFieldNo <> FIELDNO("Free Item Posting Type")) and
        //                 (xRec."Free Item Posting Type" = "Free Item Posting Type")
        //               then
        //               // >>DITW114.00.15 DDR NRQ#151016
        //               // <<DITW19.00.08 DDR 11/08/2016 BL#9886
        //               VALIDATE("Free Item Posting Type");
        //               // >>DITW19.00.08 DDR BL#9886
        //               UpdateDirectUnitCost(FIELDNO("Free Item"));
        //             end;
        //           end;
        //         end;
        //         BatchInsertCheckSuspended := lTempBatchInsertCheckSuspended;
        //     end;
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
        // field(2013829;"Free Reason Code";Code[10])
        // {
        //     CaptionML = ENU='Free Reason Code',
        //                 FRA='Code motif gratuit';
        //     Description = 'DITW17.00.02 DIT-770 #132';
        //     TableRelation = "Free Reason Code";

        //     trigger OnValidate();
        //     var
        //         lTempBatchInsertCheckSuspended : Boolean;
        //     begin
        //         //<< DITW17.00.02 TEC1 12/09/2013 DIT-770 #132
        //         // <<DITW17.10.05 DDR 12/02/2015 DIT-770 #1118
        //         // <<DITW17.10.03 DDR 04/07/2014 DIT-770 #699
        //         if xRec."Free Reason Code" <> "Free Reason Code" then begin
        //           PurchSetup.GET;
        //           // Not yet
        //           //IF PurchSetup."Enforce Free Reason on Free" THEN BEGIN
        //           //  IF "Free Item" <> ("Free Reason Code" <> '') THEN BEGIN
        //           //    "Free Item" := ("Free Reason Code" <> '');
        //           //  end;
        //           //end else
        //           // <<DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
        //           if CurrFieldNo <> FIELDNO("Free Item") then begin
        //           // >>DITW18.00.07A DDR DIT-770 #2074
        //             // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868
        //             "Free Item" := ("Free Reason Code" <> '');
        //             // >>DITW17.10.05 DDR DIT-770 #868
        //           end;
        //           if "Free Reason Code" <>'' then begin
        //             // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868
        //             rFreeReasonCode.GET("Free Reason Code");
        //             // >>DITW17.10.05 DDR DIT-770 #868
        //               //<<DITW17.10.05 MSF 31/07/2014 DIT-770 #692
        //               if rFreeReasonCode."Vendor DTax Group Code"<>'' then
        //                 VALIDATE("Vendor DTax Group Code",rFreeReasonCode."Vendor DTax Group Code")
        //               else
        //                 // <<DITW110.00.12 DDR 08/03/2018 NRQ#63284
        //                 VALIDATE("Vendor DTax Group Code",GetVendorTaxGroupCode("Vendor DTax Group Code","Item DTax Group Code"))
        //                 // >>DITW110.00.12 DDR NRQ#63284
        //               //>>DITW17.10.05 MSF 31/07/2014 DIT-770 #692
        //           end else
        //             //<<DITW17.10.05 MSF 01/08/2014 DIT-770 #692
        //             // <<DITW17.10.05 DDR 12/02/2015 DIT-770 #1118 - DITW110.00.12 DDR 08/03/2018 NRQ#63284
        //             "Vendor DTax Group Code" := GetVendorTaxGroupCode("Vendor DTax Group Code","Item DTax Group Code");
        //             // >>DITW17.10.05 DDR DIT-770 #1118 - DITW110.00.12 DDR NRQ#63284
        //             //>>DITW17.10.05 MSF 31/07/2014 DIT-770 #692
        //           //>>DITW17.10.05 MSF 31/07/2014 DIT-770 #692
        //           // >>DITW17.10.05 DDR DIT-770 #1118

        //           // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868 - DITW17.10.05 DDR 12/02/2015 DIT-770 #1118
        //           if (CurrFieldNo <> FIELDNO("Free Item")) and
        //             (CurrFieldNo <> FIELDNO("No."))
        //           then begin
        //             if CurrFieldNo = FIELDNO("Free Reason Code") then begin
        //               VALIDATE("Free Item");
        //               // <<DITW114.00.15 DDR 08/07/2020 NRQ#151016
        //               if (CurrFieldNo <> FIELDNO("Free Item Posting Type")) and
        //                 (xRec."Free Item Posting Type" = "Free Item Posting Type")
        //               then
        //               // >>DITW114.00.15 DDR NRQ#151016
        //                 // <<DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
        //                 VALIDATE("Free Item Posting Type");
        //                 // >>DITW18.00.07A DDR DIT-770 #2074
        //             end;
        //             UpdateDirectUnitCost(FIELDNO("Free Reason Code"));
        //             UpdateAmounts();
        //             // >>DITW17.10.05 DDR DIT-770 #868 - DITW17.10.05 DDR DIT-770 #1118
        //           end;
        //           //>>DITW17.10.05 MSF 06/08/2014 DIT-770 #864
        //         end;
        //         //>>DITW17.10.05 MSF 18/07/2014 DIT-770 #692
        //     end;
        // }
        // field(2014060;Route;Code[20])
        // {
        //     CaptionML = ENU='Route',
        //                 FRA='Route';
        //     Description = 'DIT-770 #1968';
        //     Editable = false;
        //     TableRelation = Route;
        // }
        // field(2014062;"Shipment Status";Option)
        // {
        //     CaptionML = ENU='Shipment Status',
        //                 FRA='Statut expédition';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        //     Editable = false;
        //     OptionCaptionML = ENU='Open,Picklist Printed,Assigned,Picked,Shipped,Return completed,Invoice',
        //                       FRA='Ouvert,Prélèvement imprimé,Affecté,Prélevé,Expédié,Retour terminée,Facturée';
        //     OptionMembers = Open,"Picklist Printed",Assigned,Picked,Shipped,"Return completed",Invoice;
        // }
        // field(2014063;"Truck Zone";Option)
        // {
        //     CaptionML = ENU='Truck Zone',
        //                 FRA='Zone de camion';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        //     Editable = false;
        //     OptionCaptionML = ENU=' ,Right,Left',
        //                       FRA=' ,Droite,Gauche';
        //     OptionMembers = " ",Right,Left;
        // }
        // field(2014064;"Shipping Charge Per";Option)
        // {
        //     CaptionML = ENU='Shipping Charge Per',
        //                 FRA='Frais transport par';
        //     Description = 'DITW15.00.00.25';
        //     OptionCaptionML = ENU='Shipment,Weight,Volume',
        //                       FRA='Expédition,Poids,Volume';
        //     OptionMembers = Shipment,Weight,Volume;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.24 DDR 14/08/2008
        //         TestStatusOpen;
        //         // >>DITW15.00.00.24 DDR
        //     end;
        // }
        // field(2014065;"Original Quantity";Decimal)
        // {
        //     CaptionML = ENU='Original Quantity',
        //                 FRA='Quantité initiale';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW18.00.07 DIT-770 #1702';
        //     MaxValue = 100;
        //     MinValue = 0;
        // }
        // field(2014066;"Receipt Status";Option)
        // {
        //     CaptionML = ENU='Receipt Status',
        //                 FRA='Satut Recéption';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        //     OptionCaptionML = ENU='Open,Order Printed,Order Sent,Order Confirmed,To Receive,Receipt Completed,Invoice',
        //                       FRA='Ouvert,Commande Imprimée,Commande Envoyée,Commande Confirmée,A réceptionner,Réception Complete,Facturée';
        //     OptionMembers = Open,"Order Printed","Order Sent","Order Confirmed","To Receive","Receipt Completed",Invoice;
        // }
        // field(2014067;"Backorder Type";Option)
        // {
        //     CalcFormula = Lookup(Item."Backorder Type" WHERE ("No."=FIELD("No.")));
        //     Caption = 'Backorder Type';
        //     Description = 'DITW110.00.10 BL#15657';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     OptionCaption = '" ,Backorder,No Backorder"';
        //     OptionMembers = " ",Backorder,"No Backorder";

        //     trigger OnValidate();
        //     var
        //         ItemBackOrderNotification : Notification;
        //     begin
        //     end;
        // }
        // field(2014075;"Shipping Agent Code";Code[10])
        // {
        //     CaptionML = ENU='Shipping Agent Code',
        //                 FRA='Code transporteur';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Shipping Agent";

        //     trigger OnLookup();
        //     begin
        //         // <<DITW15.00.00.25 DDR 17/10/2008
        //         TestStatusOpen;
        //         if "Drop Shipment" then
        //           UpdateDates;
        //     end;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.25 DDR 17/10/2008
        //         TestStatusOpen;
        //         if "Shipping Agent Code" <> xRec."Shipping Agent Code" then
        //           VALIDATE("Shipping Agent Service Code",'');
        //     end;
        // }
        // field(2014076;"Shipping Agent Service Code";Code[10])
        // {
        //     CaptionML = ENU='Shipping Agent Service Code',
        //                 FRA='Code prestation transporteur';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Shipping Agent Services".Code WHERE ("Shipping Agent Code"=FIELD("Shipping Agent Code"));
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
        // field(2014081;"HL Cubage";Decimal)
        // {
        //     CaptionClass = GetUomCaptionClassHL(FIELDNO("HL Cubage"));
        //     CaptionML = ENU='Outstanding Volume',
        //                 FRA='Volume Restant';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW18.00.07 DIT-770 #1971';
        // }
        // field(2014082;"Eq. UOM Quantity";Decimal)
        // {
        //     CaptionClass = GetUomCaptionClassEqUom(FIELDNO("Eq. UOM Quantity"));
        //     CaptionML = ENU='Outstanding Eq. UOM Quantity',
        //                 FRA='Quantité Restante UOM';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW18.00.07 DIT-770 #1971';
        // }
        // field(2014083;"Cubage (Base)";Decimal)
        // {
        //     CaptionML = ENU='Volume (Cubage)',
        //                 FRA='Volume (cubage)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DIT-770 #1488';
        // }
        // field(2014084;"Weight (Base)";Decimal)
        // {
        //     CaptionML = ENU='Weight',
        //                 FRA='Poids';
        //     DecimalPlaces = 0:5;
        //     Description = 'DIT-770 #1488';
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

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.24 DDR 14/08/2008
        //         TestStatusOpen;
        //         // >>DITW15.00.00.24 DDR
        //     end;
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
        //     TableRelation = "Physical Location Group" WHERE (Code=FIELD("Phys. Location Table Filter"));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 06/10/2009
        //         TestStatusOpen();
        //         InvtSetup.GET;

        //         if xRec."Physical Location Group Code" <> "Physical Location Group Code" then begin
        //           TESTFIELD("Qty. Rcd. Not Invoiced",0);
        //           TESTFIELD("Receipt No.",'');
        //           TESTFIELD("Return Qty. Shipped Not Invd.",0);
        //           TESTFIELD("Return Shipment No.",'');
        //         end;

        //         // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1191
        //         if ("Responsibility Center" = xRec."Responsibility Center") and
        //           ("Physical Location Group Code" <> xRec."Physical Location Group Code") and
        //           ("Physical Location Group Code" <> '')
        //         then
        //           // <<DITW18.00.06 DDR 05/11/2015 DIT-770 #1592
        //           "Responsibility Center" := UserSetupMgt.GetFirstRespCenter(1,"Physical Location Group Code",'');
        //           // >>DITW18.00.06 DDR DIT-770 #1592
        //         // >>DITW18.00.06 DDR DIT-770 #1191

        //         // <<DITW18.00.06 DDR 19/02/2015 DIT-770 #1191
        //         if xRec."Physical Location Group Code" <> "Physical Location Group Code" then
        //           if not UserSetupMgt.CheckPhysLocation(1,"Physical Location Group Code","Responsibility Center") then
        //             //<< DITW19.00.08 AKH 27/10/2016 BL#11231
        //             ERROR(
        //               Text2014414,
        //               PhysLocationGr.TABLECAPTION,"Physical Location Group Code");
        //             //>> DITW19.00.08 AKH BL#11231
        //         // >>DITW18.00.06 DDR DIT-770 #1191

        //         // <<DITW18.00.06 DDR 23/02/2015 27/02/2015 DIT-770 #1191
        //         if ((xRec."Physical Location Group Code" <> "Physical Location Group Code") or (CurrFieldNo = 0)) and
        //           ("Location Code" <> '')
        //         then begin
        //           GetLocation("Location Code");
        //           if (Location."Physical Location Group Code" <> "Physical Location Group Code") then begin
        //             if ((CurrFieldNo <> FIELDNO("Location Code")) and (xRec."Responsibility Center" = "Responsibility Center")) or
        //               (CurrFieldNo = FIELDNO("Physical Location Group Code"))
        //             then
        //               VALIDATE("Location Code",'')
        //             else
        //               "Location Code" := '';
        //           end;
        //         end;
        //         // >>DITW18.00.06 DDR DIT-770 #1191

        //         // <<DITW18.00.06 DDR 05/11/2015 DIT-770 #1592
        //         if ("Responsibility Center" <> xRec."Responsibility Center") and (CurrFieldNo <> FIELDNO("Responsibility Center")) then
        //           VALIDATE("Responsibility Center");
        //         // >>DITW18.00.06 DDR DIT-770 #1592

        //         // <<DITW18.00.06 DDR 27/02/2015 DIT-770 #1191
        //         // <<DITW18.00.06 DDR 05/11/2015 DIT-770 #1592
        //         if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
        //           UpdateCharges2(FIELDNO("Physical Location Group Code"),(CurrFieldNo = FIELDNO("Physical Location Group Code")));
        //         // >>DITW18.00.06 DDR DIT-770 #1592
        //         // >>DITW18.00.06 DDR DIT-770 #1191
        //     end;
        // }
        // field(2014095;"Shpg. Cst. Source Type";Integer)
        // {
        //     CaptionML = ENU='Shipping Cost Source Type',
        //                 FRA='Type d''origine frais de Livraison';
        //     Description = 'DIT-770 #1066';
        //     Editable = false;
        // }
        // field(2014096;"Shpg. Cst. Source No.";Code[20])
        // {
        //     CaptionML = ENU='Shipping Cost Source No.',
        //                 FRA='N° d''origine frais de livraison';
        //     Description = 'DIT-770 #1066';
        //     Editable = false;
        // }
        // field(2014097;"Shpg. Cst. Line No.";Integer)
        // {
        //     AccessByPermission = TableData "Shipping Agent Services"=R;
        //     CaptionML = ENU='Shipping Cost Line No.',
        //                 FRA='N° Line Frais de livraison';
        //     Description = 'DIT-770 #1066,HEI.15';
        // }
        // field(2014098;"Order Printed (date/time)";DateTime)
        // {
        //     CaptionML = ENU='Order Printed (date/time)',
        //                 FRA='Commande Imprimée (Date/Heure)';
        //     Description = 'DIT-770 #1968';
        // }
        // field(2014103;"Whse. Receipt No. (Open)";Code[20])
        // {
        //     CalcFormula = Lookup("Warehouse Receipt Line"."No." WHERE ("Source Type"=CONST(39),
        //                                                                "Source Subtype"=FIELD("Document Type"),
        //                                                                "Source No."=FIELD("Document No."),
        //                                                                "Source Line No."=FIELD("Line No.")));
        //     CaptionML = ENU='Whse. Receipt No. (Open)',
        //                 FRA='N° réception magasin (Ouvert)';
        //     Description = 'DITW15.00.00.39 #1399';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     TableRelation = "Warehouse Receipt Header";
        // }
        // field(2014113;"Tax Item No.";Code[20])
        // {
        //     CaptionML = ENU='Tax Tracking Item No.',
        //                 FRA='N° article traçable Taxe';
        //     Description = 'DITW15.00.00.38 #703';
        //     TableRelation = Item;

        //     trigger OnValidate();
        //     var
        //         lrFromItemPurchLine : Record "Purchase Line";
        //         TempPurchLine : Record "Purchase Line";
        //     begin
        //         // <<DITW16.00.00.43 DDR 20/12/2013 DIT-715 #864
        //         TestStatusOpen;
        //         // >>DITW16.00.00.43 DDR DIT-715 #864
        //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //         CLEAR(Item);
        //         CLEAR(TempPurchLine);
        //         if "Tax Item No." <> '' then begin
        //           Item.GET("Tax Item No.");
        //           GetPurchHeader();
        //           TempPurchLine.SetPurchHeader(PurchHeader);
        //           TempPurchLine.SetHideValidationDialog(true);
        //           TempPurchLine.SetSkipUpdateShippingHeader(true);
        //           TempPurchLine.SetBatchInsertCheck(true);
        //           TempPurchLine."Document Type" := "Document Type";
        //           TempPurchLine."Document No." := "Document No.";
        //           TempPurchLine.VALIDATE(Type,Type::Item);
        //           TempPurchLine.VALIDATE("No.","Tax Item No.");
        //           // <<DITW16.00.00.43 DDR 18/12/2013 DIT-715 #766
        //           TempPurchLine."Physical Location Group Code" := '';
        //           // >>DITW16.00.00.43 DDR DIT-715 #766
        //           TempPurchLine.VALIDATE("Location Code","Location Code");
        //           TempPurchLine.VALIDATE(Quantity,Quantity);
        //           // <<DITW16.00.00.43 DDR 01/10/2013 DIT-715 #519
        //           TempPurchLine.VALIDATE("Unit of Measure Code","Unit of Measure Code");
        //           // >>DITW16.00.00.43 DDR DIT-715 #519
        //           TempPurchLine.UpdateAADInfo();
        //           TempPurchLine.CalcCubageWeight();
        //           //<< DITW18.00.07 VSC 12/05/2016 DIT-770 #1971 -> DIT-770 #189
        //           TempPurchLine.CalcHLCubage;
        //           TempPurchLine.CalcEqVUOMQuantity;
        //           //>> DITW18.00.07 VSC DIT-770 #1971 -> DIT-770 #189
        //         end;
        //         "Gross Weight" := TempPurchLine."Gross Weight";
        //         "Net Weight" := TempPurchLine."Net Weight";
        //         "Unit Volume" := TempPurchLine."Unit Volume";
        //         "Units per Parcel" := TempPurchLine."Units per Parcel";
        //         "Unit Volume HL" := TempPurchLine."Unit Volume HL";
        //         Cubage := TempPurchLine.Cubage;
        //         Weight := TempPurchLine.Weight;
        //         //<< DITW18.00.07 VSC 12/05/2016 DIT-770 #1971 -> DIT-770 #1488
        //         "Cubage (Base)" := TempPurchLine."Cubage (Base)";
        //         "Weight (Base)" := TempPurchLine."Weight (Base)";
        //         //<< DITW18.00.07 VSC DIT-770 #1971 -> DIT-770 #1488
        //         Distance := TempPurchLine.Distance;
        //         // <<DITW16.00.00.43 DDR 25/09/2013 DIT-715 #519
        //         "Item Category Code" := TempPurchLine."Item Category Code";
        //         "Product Group Code" := TempPurchLine."Product Group Code";
        //         "Unit Volume HL" := TempPurchLine."Unit Volume HL";
        //         // >>DITW16.00.00.43 DDR DIT-715 #519
        //         // <<DITW16.00.00.43 DDR 22/01/2014 DIT-715 #882
        //         "Item Charge Qty. per Uom" := TempPurchLine."Item Charge Qty. per Uom";
        //         // >>DITW16.00.00.43 DDR DIT-715 #882
        //         //<< DITW18.00.07 VSC 12/05/2016 DIT-770 #1971 -> DIT-770 #1449
        //         "HL Cubage" := TempPurchLine."HL Cubage";
        //         //>> DITW18.00.07 VSC DIT-770 #1971 -> DIT-770 #1489
        //         //<< DITW18.00.07 VSC 12/05/2016 DIT-770 #1971 -> DIT-770 #1488
        //         "Eq. UOM Quantity" := TempPurchLine."Eq. UOM Quantity";
        //         //>> DITW18.00.07 VSC DIT-770 #1971 -> DIT-770 #1488

        //         if ("Line No." <> 0) and (CurrFieldNo <> 0) and ("Attached to Line No." <> 0) then begin
        //           // <<DITW110.00.08 DDR 02/01/2017 NRQ#0
        //           lrFromItemPurchLine.GET("Document Type","Document No.","Attached to Line No.");
        //           // >>DITW110.00.08 DDR NRQ#0
        //           "Gross Weight" := "Gross Weight" * lrFromItemPurchLine."Qty. per Unit of Measure";
        //           "Net Weight" := "Net Weight" * lrFromItemPurchLine."Qty. per Unit of Measure";
        //           "Unit Volume" := "Unit Volume" * lrFromItemPurchLine."Qty. per Unit of Measure";
        //           "Units per Parcel" := ROUND("Units per Parcel" / lrFromItemPurchLine."Qty. per Unit of Measure",0.00001);
        //           "Unit Volume HL" := "Unit Volume HL" * lrFromItemPurchLine."Qty. per Unit of Measure";
        //           Cubage := Cubage * lrFromItemPurchLine."Qty. per Unit of Measure";
        //           Weight := Weight * lrFromItemPurchLine."Qty. per Unit of Measure";
        //           //<< DITW18.00.07 VSC 12/05/2016 DIT-770 #1971 -> DIT-770 #1449
        //           "HL Cubage" := "HL Cubage" * lrFromItemPurchLine."Qty. per Unit of Measure";
        //           //>> DITW18.00.07 VSC DIT-770 #1971 -> DIT-770 #1449
        //         end;

        //         "Tariff No." := TempPurchLine."Tariff No.";

        //         // <<DITW16.00.00.43 DDR 23/10/2013 DIT-715 #768
        //         if "Item Charge Type" = "Item Charge Type"::Tax then begin
        //         // >>DITW16.00.00.43 DDR DIT-715 #768
        //           "Item DTax Group Code" := TempPurchLine."Item DTax Group Code";
        //           "AAD No. Series" := TempPurchLine."AAD No. Series";
        //           "Company Tax Registration No." := TempPurchLine."Company Tax Registration No.";
        //           "LRN No. Series" := TempPurchLine."LRN No. Series";
        //           "Product Tax Code" := TempPurchLine."Product Tax Code";
        //           "ARC No. Mandatory" := TempPurchLine."ARC No. Mandatory";
        //           "Company Tax Warehouse Ref." := TempPurchLine."Company Tax Warehouse Ref.";
        //           "Packaging Type Code" := TempPurchLine."Packaging Type Code";
        //           // >>DITW15.00.00.38 DDR #703
        //           // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
        //           "Pack Qty. per Unit of Measure" := TempPurchLine."Pack Qty. per Unit of Measure";
        //           // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
        //           // <<DITW18.00.06 DDR 26/10/2015 DIT-770 #1412
        //           "No. of Packages" := TempPurchLine."No. of Packages";
        //           // >>DITW18.00.06 DDR DIT-770 #1412
        //         end;
        //         // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768

        //         CreateDim(
        //           DimMgt.TypeToTableID3(Type::Item),"Tax Item No.",
        //           DimMgt.TypeToTableID3(Type),"No.",
        //           DATABASE::Job,"Job No.",
        //           DATABASE::"Responsibility Center","Responsibility Center",
        //           DATABASE::"Work Center","Work Center No.",
        //           //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //           DimMgt.TypeToTableID2034932(1,"Contract Type"),GetContractNo(),
        //           //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //           //<<DITW110.00.10 MSF 21/05/2017 NRQ#13382
        //           DATABASE::Customer,"Linked Customer No.");
        //           //>>DITW110.00.10 MSF 21/05/2017 NRQ#13382
        //         // >>DITW16.00.00.43 DDR DIT-715 #768
        //     end;
        // }
        // field(2014260;"LRN No. Series";Code[10])
        // {
        //     CaptionML = ENU='LRN No. Series',
        //                 FRA='Souches de n° LRN';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "No. Series";

        //     trigger OnLookup();
        //     var
        //         lrpurchline : Record "Purchase Line";
        //         lDefaultAADCode : Code[10];
        //     begin
        //         // <<DITW15.00.00.38 DDR 10/08/2010 #1217
        //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //         if Type = Type::"Charge (Item)" then
        //           TESTFIELD("Tax Item No.")
        //         else
        //           TESTFIELD(Type,Type::Item);
        //         // >>DITW15.00.00.38 DDR #703
        //         TestLRNNoSeriesMandatory();

        //         with lrpurchline do begin
        //           lrpurchline := Rec;
        //           EmcsSetup.GET;
        //           lDefaultAADCode := EmcsSetup."LRN Nos.";
        //           if NoSeriesMgt.LookupSeries(lDefaultAADCode,"LRN No. Series") then
        //             VALIDATE("LRN No. Series");
        //           Rec := lrpurchline;
        //         end;
        //     end;

        //     trigger OnValidate();
        //     var
        //         lDefaultAADCode : Code[10];
        //     begin
        //         // <<DITW15.00.00.38 DDR 10/08/2010 #1217
        //         TestStatusOpen;
        //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //         if Type = Type::"Charge (Item)" then
        //           TESTFIELD("Tax Item No.")
        //         else
        //           TESTFIELD(Type,Type::Item);
        //         // >>DITW15.00.00.38 DDR #703
        //         if "LRN No. Series" <> '' then begin
        //           EmcsSetup.GET;
        //           lDefaultAADCode := EmcsSetup."LRN Nos.";
        //           if lDefaultAADCode <> '' then
        //             NoSeriesMgt.TestSeries(lDefaultAADCode,"LRN No. Series");
        //           TestLRNNoSeriesMandatory();
        //         end;
        //         TESTFIELD("LRN No.",'');
        //     end;
        // }
        // field(2014261;"LRN No.";Code[20])
        // {
        //     CaptionML = ENU='LRN No.',
        //                 FRA='N° LRN';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 10/08/2010 #1217
        //         // <<DITW110.00.09 DDR 13/04/2017 NRQ#13107
        //         if "Document Type" = "Document Type"::"Return Order" then begin
        //           TESTFIELD("ARC No. Mandatory",true);
        //           TESTFIELD("ARC No.",'');
        //         end else
        //         // >>DITW110.00.09 DDR NRQ#13107
        //           if "Outstanding Quantity" = 0 then
        //             FIELDERROR("Outstanding Quantity");

        //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
        //         if Type = Type::"Charge (Item)" then
        //           TESTFIELD("Tax Item No.")
        //         else
        //           TESTFIELD(Type,Type::Item);
        //         // >>DITW15.00.00.38 DDR #703
        //         // <<DITW110.00.09 DDR 13/04/2017 NRQ#13107
        //         if (CurrFieldNo = FIELDNO("LRN No.")) and ("LRN No." <> xRec."LRN No.") and ("LRN No." <> '') then begin
        //         // >>DITW110.00.09 DDR NRQ#13107
        //           NoSeriesMgt.TestManual("LRN No. Series");
        //           "LRN No. Series" := '';
        //         end;
        //         // <<DITW15.00.00.39 DDR 11/07/2011 #1369
        //         TESTFIELD("Applies-to AAD Trck. Entry No.",0);
        //         // >>DITW15.00.00.39 DDR #1369
        //     end;
        // }
        // field(2014262;"ARC No.";Code[30])
        // {
        //     CaptionML = ENU='ARC No.',
        //                 FRA='N° ARC';
        //     Description = 'DITW15.00.00.38 #1217';

        //     trigger OnLookup();
        //     var
        //         NewText : Text[1024];
        //     begin
        //         // <<DITW15.00.00.38 DDR 30/09/2010 #1217
        //         NewText := "ARC No.";
        //         if EDILookupExtTrackingARC(NewText) then
        //           VALIDATE("ARC No.",NewText);
        //         // >>DITW15.00.00.38 DDR
        //     end;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 20/08/2010 #1217
        //         if "ARC No." <> '' then
        //           TESTFIELD("ARC No. Mandatory")
        //         else
        //           if "ARC No. Mandatory" then begin
        //             PurchLine2.RESET;
        //             PurchLine2 := Rec;
        //             PurchLine2.SETRECFILTER;
        //             // <<DITW15.00.00.39 DDR 15/04/2011 #1296
        //             if GUIALLOWED and not HideValidationDialog and (CurrFieldNo <> 0) then
        //             // >>DITW15.00.00.39 DDR #1296
        //               MESSAGE(Text2014260,FIELDCAPTION("ARC No."),TABLECAPTION,PurchLine2.GETFILTERS);
        //           end;
        //         // <<DITW15.00.00.38 DDR 30/09/2010 #1217
        //         if xRec."ARC No." <> "ARC No." then begin
        //           EDIUpdateInboxDocNo(xRec."ARC No.","ARC No.");
        //           if not TestOpenEDIInboxDocNo(xRec."ARC No.") then
        //             TESTFIELD("ARC No.",xRec."ARC No.");
        //         end;
        //         // >>DITW15.00.00.38 DDR
        //           // <<DITW15.00.00.39 DDR 11/07/2011 #1369
        //         if CurrFieldNo = FIELDNO("ARC No.") then
        //             TESTFIELD("Applies-to AAD Trck. Entry No.",0);
        //           // >>DITW15.00.00.39 DDR #1369
        //     end;
        // }
        // field(2014263;"SAD No.";Code[30])
        // {
        //     CaptionML = ENU='SAD No.',
        //                 FRA='N° SAD';
        //     Description = 'DITW15.00.00.38 #1217';
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

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 13/09/2010 #1217
        //         TestStatusOpen;
        //         TestTaxWhseRefMandatory();
        //     end;
        // }
        // field(2014310;"Service Contract Line No.";Integer)
        // {
        //     CaptionML = ENU='Contract Line No.',
        //                 FRA='N° ligne contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392';
        // }
        // field(2014312;"DIT Sub-Contr.Pst. Type Filter";Option)
        // {
        //     CaptionML = ENU='Financial Contract Posting Type Filter',
        //                 FRA='Filtre Type Imputation contrat DIT';
        //     Description = 'DITW16.00.00.41 DIT-715 #327';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance,,,,,All',
        //                       FRA=' ,Location,Prêt,Mise à disposition,Maintenance,Divers,Maintenance Usine,,,,,Tous';
        //     OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance,,,,,All;
        // }
        // field(2014313;"Financial Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Financial Contract No.',
        //                 FRA='N° contrat financier';
        //     Description = 'DITW18.00.06 DIT-770 #1368';
        //     TableRelation = IF ("DIT Sub-Contract Type"=CONST(" ")) "Financial Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract))
        //                     else IF ("DIT Sub-Contract Type"=FILTER(<>" ")) "Financial Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                                                                       "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));

        //     trigger OnValidate();
        //     var
        //         FA2 : Record "Fixed Asset";
        //     begin
        //         // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        //         TestStatusOpen;
        //         if "Financial Contract No." <> '' then begin
        //           //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           "Contract Type" := "Contract Type"::Financial;
        //           TESTFIELD("Service Contract No.",'');
        //           //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           if (CurrFieldNo = FIELDNO("Financial Contract No.")) and
        //             (xRec."Financial Contract No." <> "Financial Contract No.")
        //           then begin
        //             "Service Contract Line No." := 0;
        //             "Contract Group Code" := '';
        //           end;
        //           if Type = Type::"Fixed Asset" then begin
        //             TESTFIELD("No.");
        //             FA2.GET("No.");
        //           end;
        //           if FA2."Financial Contract No." <> '' then
        //             TESTFIELD("Financial Contract No.",FA2."Financial Contract No.");

        //           ContractDIT.GET(ContractDIT."Contract Type"::Contract,"Financial Contract No.");
        //           if ("DIT Sub-Contract Type" <> 0) or
        //             ((xRec."DIT Sub-Contract Type" <> 0) and ("DIT Sub-Contract Type" = 0) and
        //             (xRec."Financial Contract No." = "Financial Contract No."))
        //           then
        //             TESTFIELD("DIT Sub-Contract Type",ContractDIT."DIT Sub-Contract Type")
        //           else
        //             "DIT Sub-Contract Type" := ContractDIT."DIT Sub-Contract Type";
        //           if ("Contract Group Code" <> '') or
        //             ((xRec."Contract Group Code" <> '') and ("Contract Group Code" = '') and
        //             (xRec."Financial Contract No." = "Financial Contract No."))
        //           then
        //             TESTFIELD("Contract Group Code",ContractDIT."Contract Group Code")
        //           else
        //             "Contract Group Code" := ContractDIT."Contract Group Code";
        //         end else begin
        //           //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           CLEAR("Contract Type");
        //           //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           CLEAR("Service Contract Line No.");
        //           CLEAR("Contract Group Code");
        //         end;

        //         CreateDim(
        //           DimMgt.TypeToTableID2034932(2,"Contract Type"),"Financial Contract No.",
        //           DimMgt.TypeToTableID3(Type),"No.",
        //           DATABASE::Job,"Job No.",
        //           DATABASE::"Responsibility Center","Responsibility Center",
        //           DATABASE::"Work Center","Work Center No.",
        //           // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //           DimMgt.TypeToTableID3(Type::Item),"Tax Item No.",
        //           // >>DITW16.00.00.43 DDR DIT-715 #768
        //           //<<DITW110.00.10 MSF 21/05/2017 NRQ#13382
        //           DATABASE::Customer,"Linked Customer No.");
        //           //>>DITW110.00.10 MSF 21/05/2017 NRQ#13382

        //         SetFilterSubContractPostType();
        //     end;
        // }
        // field(2014410;Collapse;Boolean)
        // {
        //     CaptionML = ENU='Collapse',
        //                 FRA='Réduire';
        //     Description = 'DITW15.00.00.01';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.01 DDR 23/01/2008
        //         if Collapse and
        //           ("Attached to Line No." = 0)
        //         then
        //           TESTFIELD(Collapse, false);
        //         // >>DITW15.00.00.01 DDR
        //     end;
        // }
        // field(2014412;"Order No.";Code[20])
        // {
        //     CaptionML = ENU='Order No.',
        //                 FRA='N° commande';
        //     Description = 'DITW18.00.07 DIT-770 #1844';
        // }
        // field(2014413;"Order Line No.";Integer)
        // {
        //     CaptionML = ENU='Order Line No.',
        //                 FRA='N° ligne commande';
        //     Description = 'DITW18.00.07 DIT-770 #1844';
        // }
        // field(2014415;"Item Charge Qty. per Uom";Decimal)
        // {
        //     CaptionML = ENU='Item Charge Qty. per Unit of Measure',
        //                 FRA='Qté frais annexe par unité de mesure';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW16.00.00.43 DIT-715 #882';
        //     Editable = false;
        //     InitValue = 1;
        // }
        // field(2014418;"Lot Reserved Qty. (Base)";Decimal)
        // {
        //     CalcFormula = -Sum("Reservation Entry"."Quantity (Base)" WHERE ("Source Type"=CONST(39),
        //                                                                     "Source ID"=FIELD("Document No."),
        //                                                                     "Source Subtype"=FIELD("Document Type"),
        //                                                                     "Source Ref. No."=FIELD("Line No."),
        //                                                                     "Lot No."=FILTER(<>''),
        //                                                                     "Reservation Status"=CONST(Surplus)));
        //     Caption = 'Lot Reserved Qty. (Base)';
        //     Description = 'NRQ#94671';
        //     FieldClass = FlowField;
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
        // field(2014438;"App. Prod. Posting Group";Code[10])
        // {
        //     CaptionML = ENU='App. Prod. Posting Group',
        //                 FRA='Groupe compta. produit';
        //     Description = 'DITW17.00.02 DIT-770 #144';
        //     Editable = false;
        //     TableRelation = "Gen. Product Posting Group";

        //     trigger OnValidate();
        //     begin
        //         TestStatusOpen;
        //         if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
        //           if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") then
        //             VALIDATE("VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");
        //     end;
        // }
        // field(2014439;"Approved Line Amount";Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Approved Line Amount',
        //                 FRA='Montant ligne';
        //     Description = 'DITW17.00.02 DIT-770 #144';
        //     Editable = false;

        //     trigger OnValidate();
        //     var
        //         lCurrDirectUnitCost : Decimal;
        //     begin
        //         TESTFIELD(Type);
        //         TESTFIELD(Quantity);
        //         TESTFIELD("Direct Unit Cost");
        //         // <<DITW15.00.00.19 DDR 07/04/2008
        //         TestPeriodicWkshtLine();
        //         // >>DITW15.00.00.19 DDR

        //         GetPurchHeader;
        //         // <<DITW15.00.00.30 DDR 16/01/2009
        //         UpdateItemChargeValue();
        //         // >>DITW15.00.00.30 DDR

        //         // <<DITW15.00.00.35 DDR 25/06/2009 - 13/10/2009
        //         if CurrFieldNo = FIELDNO("Line Amount") then begin
        //           if "Free Item" then
        //             ERROR(Text023,FIELDCAPTION("Line Amount"),FIELDCAPTION("Free Item"));
        //         end;
        //         // >>DITW15.00.00.35 DDR

        //         // <<DITW15.00.00.19 DDR 07/04/2008
        //         if (Type = Type::Item) and (not "Is Item Charge") then
        //           lCurrDirectUnitCost := "Item Charge Value"
        //         else
        //           lCurrDirectUnitCost := "Direct Unit Cost";

        //         "Line Amount" := ROUND("Line Amount",Currency."Amount Rounding Precision");
        //         VALIDATE(
        //           "Line Discount Amount",ROUND(Quantity * lCurrDirectUnitCost,Currency."Amount Rounding Precision") - "Line Amount");
        //         // >>DITW15.00.00.19
        //     end;
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
        //     var
        //         PackagingType : Record "Packaging Type";
        //     begin
        //         // <<DITW18.00.06 DDR 20/10/2015 DIT-770 #1449
        //         if (CurrFieldNo = FIELDNO("Packaging Type Code")) and ("Tax Item No." <> '') and
        //           ("Packaging Type Code" <> '') and (xRec."Packaging Type Code" <> "Packaging Type Code")
        //         then
        //           TESTFIELD("Packaging Type Code",xRec."Packaging Type Code");
        //         // >>DITW18.00.06 DDR DIT-770 #1449

        //         // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148) - 16/03/2011 (DIT711 161)
        //         if "Packaging Type Code" <> '' then begin
        //           PackagingType.GET("Packaging Type Code");
        //           if "Tax Item No." <> '' then begin
        //             Item.GET("Tax Item No.");
        //             ItemUnitOfMeasure.GET("Tax Item No.",Item."Sales Unit of Measure");
        //           end else
        //             ItemUnitOfMeasure.GET("No.","Unit of Measure Code");
        //           if "Packaging Type Code" = ItemUnitOfMeasure."Packaging Type Code" then begin
        //             ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
        //             "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
        //           end else
        //             "Pack Qty. per Unit of Measure" := 1;
        //           TESTFIELD("Pack Qty. per Unit of Measure");
        //         end else
        //           "Pack Qty. per Unit of Measure" := 0;
        //         // >>DITW15.00.00.38 DDR #1217 (DIT711 148) (DIT711 161)
        //         // <<DITW16.00.00.44 DDR 24/03/2014 DIT-715 #912 - DITW18.00.06 DDR 26/10/2015 DIT-770 #1412
        //         "No. of Packages" := ROUND(Quantity * "Pack Qty. per Unit of Measure",1,'>');
        //         // >>DITW16.00.00.44 DDR DIT-715 #912 - DITW18.00.06 DDR DIT-770 #1412
        //     end;
        // }
        // field(2014477;"No. of Packages";Decimal)
        // {
        //     CaptionML = ENU='No. of Packages',
        //                 FRA='Nbre de colis';
        //     DecimalPlaces = 0:2;
        //     Description = 'DITW18.00.06 DIT-770 #1412';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
        //         TestStatusOpen;
        //         TESTFIELD("ARC No. Mandatory",true);
        //         TESTFIELD("ARC No.",'');
        //         // >>DITW16.00.00.43 DDR DIT-715 #720
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
        // field(2014482;"Pack Qty. per Unit of Measure";Decimal)
        // {
        //     CaptionML = ENU='Packaging Qty. per Unit of Measure',
        //                 FRA='Quantité conditionnement par unité';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW15.00.00.38 #1217 (DIT711 148)';
        // }
        // field(2014497;"Resp. Center Table Filter";Code[10])
        // {
        //     CaptionML = ENU='Resp. Center Table Filter',
        //                 FRA='Filtre Centre de gestion (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1191';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Responsibility Center";
        // }
        // field(2014498;"Phys. Location Table Filter";Code[10])
        // {
        //     CaptionML = ENU='Phys. Location Table Filter',
        //                 FRA='Filtre groupe magasin réel (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1191';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014499;"Location Table Filter";Code[10])
        // {
        //     CaptionML = ENU='Location Table Filter',
        //                 FRA='Filtre Magasin (table)';
        //     Description = 'DITW18.00.06 DIT-770 #1191';
        //     FieldClass = FlowFilter;
        //     TableRelation = Location;
        // }
        // field(2014500;"Has Item Charge";Boolean)
        // {
        //     CalcFormula = Exist("Purchase Line" WHERE ("Document Type"=FIELD("Document Type"),
        //                                                "Document No."=FIELD("Document No."),
        //                                                "Attached to Line No."=FIELD("Line No.")));
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
        //     Description = 'DITW17.00.02 DIT-770 #183-NRQ#14143';
        //     OptionCaptionML = ENU=' ,Under,Over,Until,Until Including Min,Recurring Minimum,Recurring Over,Recurring Under,Recurring Until',
        //                       FRA=' ,Under,Over,Until,Until Including Min,Recurring Minimum,Recurring Over,Recurring Under,Recurring Until';
        //     OptionMembers = " ",Under,Over,"Until","Until Including Min",Recurring,"Recurring Over","Recurring Under","Recurring Until";
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
        // field(2029610;"Tariff No. XL";Code[20])
        // {
        //     CaptionML = ENU='Tariff No. XL',
        //                 FRA='Nomenclature produits';
        //     Description = 'FINXL7.00.001';
        //     Enabled = false;
        //     NotBlank = true;
        //     TableRelation = "Tariff Number";

        //     trigger OnValidate();
        //     begin
        //         //<<FINXL9.00.001 RGO 21/06/2016
        //         ////<<FINXL7.00.001 RBE 20/03/2013
        //         //IF recFinXLSetup.READPERMISSION THEN
        //         //  TESTFIELD(Type,Type::"G/L Account");
        //         ////>>FINXL7.00.001 RBE 20/03/2013
        //         //>>FINXL9.00.001 RGO 21/06/2016
        //     end;
        // }
        // field(2029611;"Auto. Acc. Group";Code[10])
        // {
        //     CaptionML = ENU='Auto. Acc. Group',
        //                 FRA='Groupe compte autom.';
        //     Description = 'FINXL7.00.001';
        //     TableRelation = "Automatic Acc. Header";

        //     trigger OnValidate();
        //     var
        //         lrecGeneralLedgerSetup : Record "General Ledger Setup";
        //     begin
        //         //<<FINXL8.00.001 BSA 25/05/2015 #174
        //         lrecGeneralLedgerSetup.GET;
        //         lrecGeneralLedgerSetup.TESTFIELD("Jnl. Template Name (Aut. Acc.)");
        //         lrecGeneralLedgerSetup.TESTFIELD("Jnl. Batch Name (Aut. Acc.)");
        //         //>>FINXL8.00.001 BSA 25/05/2015 #174
        //     end;
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
        // field(2029615;"Emergency Order";Boolean)
        // {
        //     CaptionML = ENU='Emergency',
        //                 FRA='Urgence';
        //     Description = 'FINXL8.00.001';
        // }
        // field(2034850;"DIT Sub-Contract Type";Option)
        // {
        //     CaptionML = ENU='Sub Contract Type',
        //                 FRA='Sous type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392';
        //     OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA=' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        //         TestStatusOpen;
        //         if (xRec."DIT Sub-Contract Type" <> "DIT Sub-Contract Type") and
        //           (CurrFieldNo = FIELDNO("DIT Sub-Contract Type"))
        //         then begin
        //           VALIDATE("Contract Group Code",'');
        //           //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //           case "Contract Type" of
        //             "Contract Type"::Service:
        //               VALIDATE("Service Contract No.");
        //             "Contract Type"::Financial :
        //               VALIDATE("Financial Contract No.");
        //           end;
        //           //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //         end;

        //         SetFilterSubContractPostType();
        //     end;
        // }
        // field(2034872;"Contract Group Code";Code[10])
        // {
        //     CaptionML = ENU='Contract Group Code',
        //                 FRA='Code groupe contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392';
        //     TableRelation = IF ("Contract Type"=CONST(Service)) "Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"))
        //                     else IF ("Contract Type"=CONST(Financial)) "Financial Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        //         TestStatusOpen;
        //         if "Contract Group Code" <> '' then begin
        //             case "Contract Type" of
        //               "Contract Type"::Service:
        //                 begin
        //                  if ContractGroup.Code <> "Contract Group Code" then
        //                    ContractGroup.GET("Contract Group Code");
        //                  "DIT Sub-Contract Type" := ContractGroup."DIT Sub-Contract Type";
        //                 end;
        //               "Contract Type"::Financial:
        //                 begin
        //                  if ContractGroupDIT.Code <> "Contract Group Code" then
        //                    ContractGroupDIT.GET("Contract Group Code");
        //                  "DIT Sub-Contract Type" := ContractGroupDIT."DIT Sub-Contract Type";
        //                 end;
        //             end;
        //         end else begin
        //           CLEAR(ContractGroup);
        //           CLEAR(ContractGroupDIT);
        //         end;
        //         if "Service Contract No." <> '' then
        //           VALIDATE("Service Contract No.");
        //         //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //         if "Financial Contract No." <> '' then
        //           VALIDATE("Financial Contract No.");
        //         //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //     end;
        // }
        // field(2034915;"Service Contract No.";Code[20])
        // {
        //     CaptionML = ENU='Service Contract No.',
        //                 FRA='N° contrat de service';
        //     Description = 'DITW16.00.00.41 DIT-715 #392';
        //     TableRelation = IF ("DIT Sub-Contract Type"=CONST(" ")) "Service Purch. Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract))
        //                     else IF ("DIT Sub-Contract Type"=FILTER(<>" ")) "Service Purch. Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
        //                                                                                                                            "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));

        //     trigger OnValidate();
        //     var
        //         FA2 : Record "Fixed Asset";
        //     begin
        //         // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        //         TestStatusOpen;
        //         if "Service Contract No." <> '' then begin
        //           //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           "Contract Type" := "Contract Type"::Service;
        //           TESTFIELD("Financial Contract No.",'');
        //           //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           if (CurrFieldNo = FIELDNO("Service Contract No.")) and
        //             (xRec."Service Contract No." <> "Service Contract No.")
        //           then begin
        //             "Service Contract Line No." := 0;
        //             "Contract Group Code" := '';
        //           end;
        //           ServContract.GET(ServContract."Contract Type"::Contract,"Service Contract No.");
        //           //IF purchheader."Building No." <> '' THEN
        //           // ServContract.TESTFIELD("Building No.",purchheader."Building No.");
        //           if ("DIT Sub-Contract Type" <> 0) or
        //             ((xRec."DIT Sub-Contract Type" <> 0) and ("DIT Sub-Contract Type" = 0) and
        //             (xRec."Service Contract No." = "Service Contract No."))
        //           then
        //             TESTFIELD("DIT Sub-Contract Type",ServContract."DIT Sub-Contract Type")
        //           else
        //             "DIT Sub-Contract Type" := ServContract."DIT Sub-Contract Type";
        //           if ("Contract Group Code" <> '') or
        //             ((xRec."Contract Group Code" <> '') and ("Contract Group Code" = '') and
        //             (xRec."Service Contract No." = "Service Contract No."))
        //           then
        //             TESTFIELD("Contract Group Code",ServContract."Contract Group Code")
        //           else
        //             "Contract Group Code" := ServContract."Contract Group Code";
        //         end else begin
        //           //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           CLEAR("Contract Type");
        //           //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           CLEAR("Service Contract Line No.");
        //           CLEAR("Contract Group Code");
        //         end;

        //         CreateDim(
        //           DimMgt.TypeToTableID2034932(2,"Contract Type"),"Service Contract No.",
        //           DimMgt.TypeToTableID3(Type),"No.",
        //           DATABASE::Job,"Job No.",
        //           DATABASE::"Responsibility Center","Responsibility Center",
        //           DATABASE::"Work Center","Work Center No.",
        //           // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //           DimMgt.TypeToTableID3(Type::Item),"Tax Item No.",
        //           // >>DITW16.00.00.43 DDR DIT-715 #768
        //           //<<DITW110.00.10 MSF 21/05/2017 NRQ#13382
        //           DATABASE::Customer,"Linked Customer No.");
        //           //>>DITW110.00.10 MSF 21/05/2017 NRQ#13382

        //         SetFilterSubContractPostType();
        //     end;
        // }
        // field(2035090;"No. of Quality Tests";Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" WHERE ("Document Type"=CONST("Lot/SN Test"),
        //                                                      "Source Type"=CONST(39),
        //                                                      "Source Subtype"=FIELD("Document Type"),
        //                                                      "Source ID"=FIELD("Document No."),
        //                                                      "Source Ref. No."=FIELD("Line No."),
        //                                                      "Item No."=FIELD("No.")));
        //     CaptionML = ENU='No. of Quality Tests',
        //                 FRA='<Nbre de Tests Qualité>';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035209;"Last Operation";Boolean)
        // {
        //     CalcFormula = Exist("Prod. Order Routing Line" WHERE (Status=FILTER(Planned|Released),
        //                                                           "Prod. Order No."=FIELD("Prod. Order No."),
        //                                                           "Routing No."=FIELD("Routing No."),
        //                                                           "Routing Reference No."=FIELD("Routing Reference No."),
        //                                                           "Operation No."=FIELD("Operation No."),
        //                                                           "Next Operation No."=CONST('')));
        //     CaptionML = ENU='Last Operation No.',
        //                 FRA='Dern. N° opération';
        //     Description = 'DIT-715 #182';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035390;"Linked Customer No.";Code[20])
        // {
        //     CaptionML = ENU='Linked Customer No.',
        //                 FRA='N° Cilent Lié';
        //     Description = 'DITW17.00.02 DIT-770 #153';
        //     TableRelation = Customer."No.";

        //     trigger OnValidate();
        //     var
        //         RecDimesionSetEntry : Record "Dimension Set Entry";
        //         Tgtext0001 : TextConst ENU='Please remove the header Link Customer No. before changing line Link Customer No..',FRA='S''il vous plaît enlever la tête Lien n ° de client avant de changer de ligne Lien N° client';
        //     begin
        //         //<<DITW17.00.02 SR 12/09/2013 DIT-770 #153
        //         ///DITW110.00.10 MSF 21/05/2017 NRQ#13382
        //         CreateDim(
        //           DATABASE::Customer,"Linked Customer No.",
        //           DimMgt.TypeToTableID3(Type),"No.",
        //           //<<DITW110.00.10 MSF 21/05/2017 NRQ#13382
        //           DATABASE::Job,"Job No.",
        //           //>>DITW110.00.10 MSF 21/05/2017 NRQ#13382
        //           DATABASE::"Responsibility Center","Responsibility Center",
        //           DATABASE::"Work Center","Work Center No.",
        //           //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //           DimMgt.TypeToTableID2034932(2,"Contract Type"),GetContractNo(),
        //           //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        //           // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
        //           DimMgt.TypeToTableID3(Type::Item),"Tax Item No.");
        //           // >>DITW16.00.00.43 DDR DIT-715 #768
        //         //>>DITW17.00.02 SR DIT-770 #153
        //     end;
        // }
        // field(2035393;"Contract Type";Option)
        // {
        //     CaptionML = ENU='Contract Type',
        //                 FRA='Type contrat';
        //     Description = 'DITW16.00.00.41 DIT-715 #392 - DIT-770 #690 -DITW18.00.06 MSF 31/07/2015 DIT-770 #1368';
        //     OptionCaptionML = ENU=' ,Service,Financial',
        //                       FRA=' ,Service,Financier';
        //     OptionMembers = " ",Service,Financial;

        //     trigger OnValidate();
        //     begin
        //         //<<DITW17.10.05 MSF 16/07/2014 DIT-770 #690
        //         //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //         if rPropertyPurchServMgtSetup.READPERMISSION or
        //            ContractDIT.READPERMISSION
        //         then begin
        //         //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //         //>>DITW17.10.05 MSF 16/07/2014 DIT-770 #690
        //           // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        //           TestStatusOpen;
        //           if "Contract Type" <> xRec."Contract Type" then begin
        //             "Contract Group Code" := '';
        //              "Service Contract Line No." := 0;
        //              //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //              if "Service Contract No." <> '' then
        //                VALIDATE("Service Contract No.",'');
        //              if "Financial Contract No." <> '' then
        //                VALIDATE("Financial Contract No.",'');
        //              //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
        //           end;
        //           SetFilterSubContractPostType();
        //         end;
        //         //<<DITW17.10.05 MSF 16/07/2014 DIT-770 #690
        //     end;
        // }
        // field(2036301;"Valid Until";Date)
        // {
        //     CaptionML = ENU='Valid Until',
        //                 FRA='Valide jusqu''au';
        //     Description = 'MANXL7.00.001';
        // }
        // field(2036302;"Document Date";Date)
        // {
        //     CaptionML = ENU='Document Date',
        //                 FRA='Date document';
        //     Description = 'MANXL7.00.001';
        // }
        // field(2036304;"Revision No.";Code[10])
        // {
        //     CaptionML = ENU='Revision No.',
        //                 FRA='N° révision';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = IF (Type=CONST(Item)) "Item Minor Revision"."Revision No." WHERE ("Item No."=FIELD("No."));
        // }
        // field(2036305;"Requester ID";Code[50])
        // {
        //     CaptionML = ENU='Requester ID',
        //                 FRA='ID demandeur';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = User;
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnLookup();
        //     var
        //         LoginMgt : Codeunit "User Management";
        //     begin
        //         //<<MANXL7.00.001 DAT 05/03/2014 #18
        //         LoginMgt.LookupUserID("Requester ID");
        //         //>>MANXL7.00.001 DAT 05/03/2014 #18
        //     end;

        //     trigger OnValidate();
        //     var
        //         LoginMgt : Codeunit "User Management";
        //     begin
        //         //<<MANXL7.00.001 DAT 05/03/2014 #18
        //         LoginMgt.ValidateUserID("Requester ID");
        //         //>>MANXL7.00.001 DAT 05/03/2014 #18
        //     end;
        // }
        // field(2036306;"Intrastat Mandatory";Boolean)
        // {
        //     CalcFormula = Lookup("VAT Posting Setup"."Create Intrastat Ledg. Entries" WHERE ("VAT Bus. Posting Group"=FIELD("VAT Bus. Posting Group"),
        //                                                                                      "VAT Prod. Posting Group"=FIELD("VAT Prod. Posting Group")));
        //     Description = 'FINXL9.00.000.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        //BC UPGRADE SHARMP16 end>>
    }
    keys
    {

        //Unsupported feature: PropertyChange on ""Document Type","Document No.","Line No."(Key)". Please convert manually.


        //Unsupported feature: PropertyChange on ""Document Type","Blanket Order No.","Blanket Order Line No."(Key)". Please convert manually.


        //Unsupported feature: PropertyChange on ""Document Type","Document No.","Location Code"(Key)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Type",Type,"No.","Variant Code","Drop Shipment","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code","Location Code","Expected Receipt Date"(Key)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Type",Type,"No.","Variant Code","Drop Shipment","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code","Location Code","Expected Receipt Date"(Key)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Type",Type,"No.","Variant Code","Drop Shipment","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code","Location Code","Expected Receipt Date"(Key)". Please convert manually.


        //Unsupported feature: Deletion on ""Document Type","Pay-to Vendor No.","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code","Currency Code"(Key)". Please convert manually.

        // key(Key25; "Document Type", "Pay-to Vendor No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Currency Code", "Item Charge Type")
        // {
        //     MaintainSIFTIndex = false;
        //     MaintainSQLIndex = false;
        //     SumIndexFields = "Outstanding Amount", "Amt. Rcd. Not Invoiced", "Outstanding Amount (LCY)", "Amt. Rcd. Not Invoiced (LCY)";
        // }
        key(Key2; "Document Type", "Document No.", "Sales Order Line No.")
        {
        }
        // key(Key5; "Document Type", "Document No.", "Attached to Line No.", "Is Item Charge", "ItemCharge Incl. Price", "Extra Charge Type")
        // {
        //     SumIndexFields = "Line Amount";
        // }//BC UPGRADE SHARMP16 -drinkit fields used in keys.
        // key(Key6; "Document Type", "Document No.", "Attached to Line No.", Collapse)
        // {
        //     SumIndexFields = "Line Amount";
        // }/BC UPGRADE SHARMP16 -drinkit fields used in keys.
        // key(Key38; "Document Type", "Document No.", "Item Charge Type", "Attached to Line No.")
        // {
        //     SumIndexFields = Amount, "Amount Including VAT", Weight, Cubage;
        // }/BC UPGRADE SHARMP16 -drinkit fields used in keys.
        // key(Key6; "Document Type", "Document No.", "AAD No. Series", "Company Tax Registration No.", "Tariff No.", Type, "No.")
        // {
        // }
        // key(Key7; "Service Order No.", "Service Order Line No.")
        // {
        // }/BC UPGRADE SHARMP16 -drinkit fields used in keys.
        key(Key26; "Pay-to Vendor No.")
        {
        }
        key(Key27; "Document Type", "Document No.", "Location Code", Type, "No.")
        {
            SQLIndex = "Location Code", "Document No.";
        }
        // key(Key28; "Document Type", "Document No.", Type, "No.", "Variant Code", "Location Code", "Document Date", "Valid Until")
        // {
        // }
        // key(Key29; "Document Type", "SC Source Type", "SC Source No.", "SC Line No.")
        // {
        // }
        // key(Key12; "Document Type", "Document No.", "WHT Business Posting Group", "WHT Product Posting Group")
        // {
        //     SumIndexFields = "Prepmt. Amt. Inv.", "Prepmt Amt to Deduct";
        // }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatusOpen;
    IF NOT StatusCheckSuspended AND (PurchHeader.Status = PurchHeader.Status::Released) AND
       (Type IN [Type::"G/L Account",Type::"Charge (Item)"])
    THEN
      VALIDATE(Quantity,0);

    IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
      ReservePurchLine.DeleteLine(Rec);
      IF "Receipt No." = '' THEN
        TESTFIELD("Qty. Rcd. Not Invoiced",0);
      IF "Return Shipment No." = '' THEN
        TESTFIELD("Return Qty. Shipped Not Invd.",0);

      CALCFIELDS("Reserved Qty. (Base)");
      TESTFIELD("Reserved Qty. (Base)",0);
      WhseValidateSourceLine.PurchaseLineDelete(Rec);
    end;

    IF ("Document Type" = "Document Type"::Order) AND (Quantity <> "Quantity Invoiced") THEN
      TESTFIELD("Prepmt. Amt. Inv.","Prepmt Amt Deducted");

    IF "Sales Order Line No." <> 0 THEN BEGIN
      LOCKTABLE;
      SalesOrderLine.LOCKTABLE;
      SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Sales Order No.","Sales Order Line No.");
      SalesOrderLine."Purchase Order No." := '';
      SalesOrderLine."Purch. Order Line No." := 0;
      SalesOrderLine.MODIFY;
    end;

    IF "Special Order Sales Line No." <> 0 THEN BEGIN
      LOCKTABLE;
      SalesOrderLine.LOCKTABLE;
      IF "Document Type" = "Document Type"::Order THEN BEGIN
        SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Special Order Sales No.","Special Order Sales Line No.");
        SalesOrderLine."Special Order Purchase No." := '';
        SalesOrderLine."Special Order Purch. Line No." := 0;
        SalesOrderLine.MODIFY;
      end else
        IF SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Special Order Sales No.","Special Order Sales Line No.") THEN
          BEGIN
          SalesOrderLine."Special Order Purchase No." := '';
          SalesOrderLine."Special Order Purch. Line No." := 0;
          SalesOrderLine.MODIFY;
        end;
    end;

    NonstockItemMgt.DelNonStockPurch(Rec);

    IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
      PurchLine2.RESET;
      PurchLine2.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
      PurchLine2.SETRANGE("Blanket Order No.","Document No.");
      PurchLine2.SETRANGE("Blanket Order Line No.","Line No.");
      IF PurchLine2.FINDFIRST THEN
        PurchLine2.TESTFIELD("Blanket Order Line No.",0);
    end;

    IF Type = Type::Item THEN
      DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");

    IF Type = Type::"Charge (Item)" THEN
      DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");

    IF "Line No." <> 0 THEN BEGIN
      PurchLine2.RESET;
      PurchLine2.SETRANGE("Document Type","Document Type");
      PurchLine2.SETRANGE("Document No.","Document No.");
      PurchLine2.SETRANGE("Attached to Line No.","Line No.");
      PurchLine2.SETFILTER("Line No.",'<>%1',"Line No.");
      PurchLine2.DELETEALL(TRUE);
    end;

    PurchCommentLine.SETRANGE("Document Type","Document Type");
    PurchCommentLine.SETRANGE("No.","Document No.");
    PurchCommentLine.SETRANGE("Document Line No.","Line No.");
    IF NOT PurchCommentLine.ISEMPTY THEN
      PurchCommentLine.DELETEALL;

    IF ("Line No." <> 0) AND ("Attached to Line No." = 0) THEN BEGIN
      PurchLine2.COPY(Rec);
      IF PurchLine2.FIND('<>') THEN BEGIN
        PurchLine2.VALIDATE("Recalculate Invoice Disc.",TRUE);
        PurchLine2.MODIFY;
      end;
    end;

    IF "Deferral Code" <> '' THEN
      DeferralUtilities.DeferralCodeOnDelete(
        DeferralUtilities.GetPurchDeferralDocType,'','',
        "Document Type","Document No.","Line No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TestStatusOpen;
    if not StatusCheckSuspended and (PurchHeader.Status = PurchHeader.Status::Released) and
       (Type in [Type::"G/L Account",Type::"Charge (Item)"])
    then
      VALIDATE(Quantity,0);

    if (Quantity <> 0) and ItemExists("No.") then begin
      ReservePurchLine.DeleteLine(Rec);
      //<<QXL9.00.001 DAT 23/03/2016
      if QualitySetup.READPERMISSION then
        cduQualityMgt.DeletePurchLine(Rec);
      //>>QXL9.00.001 DAT 23/03/2016
      if "Receipt No." = '' then
        TESTFIELD("Qty. Rcd. Not Invoiced",0);
      if "Return Shipment No." = '' then
    #12..16
    end;

    //DITW17.10.05 MSF 08/12/2014 DIT-770 #701 - DITW17.10.05 MSF 11/12/2014 DIT-770 #701

    if ("Document Type" = "Document Type"::Order) and (Quantity <> "Quantity Invoiced") then
      TESTFIELD("Prepmt. Amt. Inv.","Prepmt Amt Deducted");

    // <<DITW18.00.06 DDR 03/11/2015 DIT-770 #1395
    if ("Line No." <> 0) and ("BOM Line No." <> 0) and
      ("Is Item Charge" or ("Item Charge Type" <> "Item Charge Type"::" ")) and
      not (BatchInsertCheckSuspended or StatusCheckSuspended)
    then
      TESTFIELD("BOM Line No.",0);
    // >>DITW18.00.06 DDR DIT-770 #1395

    // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
    if ("Line No." <> 0) and not (BatchInsertCheckSuspended or StatusCheckSuspended) then
      TESTFIELD("ItemCharge Incl. Price",false);
    // >>DITW110.00.11 DDR NRQ#24875

    if "Sales Order Line No." <> 0 then begin
    #23..28
    end;

    if "Special Order Sales Line No." <> 0 then begin
      LOCKTABLE;
      SalesOrderLine.LOCKTABLE;
      if "Document Type" = "Document Type"::Order then begin
    #35..38
      end else
        if SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Special Order Sales No.","Special Order Sales Line No.") then
          begin
    #42..44
        end;
    end;
    #47..49
    if "Document Type" = "Document Type"::"Blanket Order" then begin
    #51..54
      if PurchLine2.FINDFIRST then
        PurchLine2.TESTFIELD("Blanket Order Line No.",0);
    end;

    // <<DITW15.00.00.38 DDR 15/10/2010 #1217
    // <<DITW16.00.00.43 DDR 15/10/2013 DIT-715 #765
    if ("Document Type" in ["Document Type"::Order,"Document Type"::"Return Order"]) and ("ARC No." <> '') then
    // >>DITW16.00.00.43 DDR DIT-715 #765
      EDIUpdateInboxDocNo(xRec."ARC No.",'');
    // >>DITW15.00.00.38 DDR

    if Type = Type::Item then
      DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");

    if Type = Type::"Charge (Item)" then
      DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");

    // <<DITW15.00.00.36 DDR 18/11/2009 - DITW15.00.00.37 DDR 28/04/2010
    if (Type <> Type::"Charge (Item)") and "Is Item Charge"  and
      ("Item Charge Calculate per" <> "Item Charge Calculate per"::Item)
    then
      DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
    // >>DITW15.00.00.37 DDR

    // <<DITW15.00.00.19 DDR 07/04/2008 - DITW15.00.00.39 DDR 01/07/2011 #730
    if "Quantity Received" = 0 then
      DiscPromoPostLine.ReopenFromPurchLine(Rec)
     else
      DiscPromoPostLine.CloseFromPurchLine(Rec);
    // >>DITW15.00.00.39 DDR #730

    if "Line No." <> 0 then begin
      PurchLine2.RESET;
      // <<DITW15.00.00.39 DDR 05/07/2011 #1349
      PurchLine2.SETCURRENTKEY("Document Type","Document No.","Attached to Line No.");
      // >>DITW15.00.00.39 DDR #1349
    #67..70
      // <<DITW15.00.00.01 DDR 18/12/2007
      //PurchLine2.DELETEALL(TRUE);

      // <<DITW15.00.00.39 DDR 01/08/2011 #1415 - DITW19.00.08 DDR 22/08/2016 BL#9858
      if Type = Type::Item then begin
      // >>DITW15.00.00.39 DDR DIT-715 #1415 - DITW19.00.08 DDR BL#9858
      // >>DITW15.00.00.39 DDR DIT-715 #1415
        // <<DITW15.00.00.39 DDR 05/07/2011 #1349
        if PurchLine2.findset(true,true) then begin
          repeat
            // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
            TESTFIELD("ItemCharge Incl. Price",false);
            // >>DITW110.00.11 DDR NRQ#24875
            // <<DITW15.00.00.39 DDR 01/08/2011 #1415 - DITW19.00.08 DDR 22/08/2016 BL#9858
            PurchLine2.SetBatchInsertCheck(true);
            PurchLine2.SuspendStatusCheck(StatusCheckSuspended);
            // >>DITW15.00.00.39 DDR DIT-715 #1415 - DITW19.00.08 DDR BL#9858
            // <<DITW16.00.00.40 DDR 25/01/2012 DIT-715 #207
            PurchLine2.SetSkipUpdateShippingHeader(true);
            // >>DITW16.00.00.40 DDR DIT-715 #207
            PurchLine2.DELETE(true);
          until PurchLine2.NEXT = 0;
        end;
      end else
        PurchLine2.DELETEALL(true);
      // >>DITW15.00.00.01 DDR

      // <<DITW15.00.00.19 DDR 20/05/2008 - DITW15.00.00.23 DDR 01/08/2008
      if (Type = Type::Item) and
         (not "Is Item Charge")
      then
        DeleteAllChargePurchLines(Rec,true);
      // >>DITW15.00.00.23 DDR

      // <<DITW15.00.00.37 DDR 04/02/2010 - 30/03/2010
      if ("Item Charge Calculate per" = "Item Charge Calculate per"::Order) and
        ("Attached to Line No." <> 0) and
        not (BatchInsertCheckSuspended or StatusCheckSuspended)
      then begin
        if PurchLine2.GET("Document Type","Document No.","Attached to Line No.") and
          PurchLine2."Disc.Promo. Order Calculated"
        then begin
          PurchLine2."Disc.Promo. Order Calculated" := false;
          PurchLine2.MODIFY;
        end;
      end;
      // >>DITW15.00.00.37 DDR

      // <<DITW15.00.00.39 DDR 05/07/2011 #1349
      if not (BatchInsertCheckSuspended or StatusCheckSuspended) and
        (Type <> Type::" ") and
        ("Attached to Line No." <> 0) and
        ("Item Charge Type" = "Item Charge Type"::Tax)
      then begin
        PurchLine2.RESET;
        PurchLine2.SETCURRENTKEY("Document Type","Document No.","Attached to Line No.");
        PurchLine2.SETRANGE("Document Type","Document Type");
        PurchLine2.SETRANGE("Document No.","Document No.");
        PurchLine2.SETRANGE("Attached to Line No.","Line No.");
        PurchLine2.SETRANGE("Item Charge Type","Item Charge Type"::Tax);
        PurchLine2.SETFILTER("Line No.",'<>%1',"Line No.");
        if PurchLine2.ISEMPTY then begin
          if PurchLine2.GET("Document Type","Document No.","Attached to Line No.") and
            // <<DITW15.00.00.39 DDR 01/08/2011 #1415
            ((PurchLine2."AAD No. Series" <> '') or
            (PurchLine2."LRN No. Series" <> '') or
            (PurchLine2."ARC No. Mandatory"))
            // >>DITW15.00.00.39 DDR DIT-715 #1415
          then begin
            PurchLine2."AAD No. Series" := '';
            PurchLine2."LRN No. Series" := '';
            PurchLine2."ARC No. Mandatory" := false;
            PurchLine2.MODIFY;
          end;
        end;
      end;
      // >>DITW15.00.00.39 DDR #1349
    end;
    #73..76
    if not PurchCommentLine.ISEMPTY then
      PurchCommentLine.DELETEALL;

    // <<DITW15.00.00.24 DDR 27/06/2008 - DITW15.00.00.25 DDR 17/10/2008
    if not StatusCheckSuspended then begin
      PurchLine2 := Rec;
      PurchLine2.INIT;
      PurchLine2.Type := Type;
      UpdateShippingPurchHeader(PurchLine2);
    end;
    // >>DITW15.00.00.25 DDR

    /// DITW19.00.08 DDR 05/08/2016 BL#9879 from NAV'2016
    /// DITW110.00.08 DDR 02/01/2017 NRQ@0 from NAV'2017
    if ("Line No." <> 0) and ("Attached to Line No." = 0) then begin
      PurchLine2.COPY(Rec);
      // <<DITW19.00.08 DDR 05/08/2016 BL#9879
      PurchLine2.SETRANGE("Item Charge Type","Item Charge Type"::" ");
      // >>DITW19.00.08 DDR BL#9879
      if PurchLine2.FIND('<>') then begin
        PurchLine2.VALIDATE("Recalculate Invoice Disc.",true);
        PurchLine2.MODIFY;
      end;
    end;

    if "Deferral Code" <> '' then
    #89..91

    /// FINXL8.00.001 BSA 27/05/2015 #183 - FINXL9.00.000.01 AKH 13/01/2017
    //HEI.24>>
    if PurchSetup.GET then begin
      PurchaseLine.SETRANGE("Document Type","Document Type");
      PurchaseLine.SETRANGE("Document No.","Document No.");
      PurchaseLine.SETFILTER(Type,'%1',PurchaseLine.Type::Item);
      PurchaseLine.SETFILTER("Item Category Code",PurchSetup."Item Category");
      if not PurchaseLine.FINDFIRST then
        ItemCategoryBool := false
      else
        ItemCategoryBool := true;
      if ItemCategoryBool then begin
    //HEI.24<<
    //HEI.22>>
    if ("SRM Order No." = '') and (("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::"Return Order"))
      and (Type = Type::Item) and ("Item Category Code" = PurchSetup."Item Category") then begin //HEI.43
        PurchHdrArch.RESET;
        PurchHdrArch.SETRANGE(PurchHdrArch."Document Type","Document Type");
        PurchHdrArch.SETRANGE(PurchHdrArch."No.","Document No.");
        if PurchHdrArch.FINDFIRST then begin
          PurchHeader.RESET;
          PurchHeader.SETRANGE(PurchHeader."No.","Document No.");
          if PurchHeader.FINDFIRST then begin
            if PurchHeader."Purch. Reason Code" = '' then
               ERROR(ReasonCodeErr);
            end;
        end;
    end;
    //HEI.22<<
    //HEI.24>>
      end;
    end;
    //HEI.24<<

    //<<Hei.25
    HeinekenGlobal.CreatePODocumentLogOnDelete(Rec);
    //Hei.25>>
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInsert". Please convert manually.

    //trigger (Variable: VendorSPL)();
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
    TestStatusOpen;
    IF Quantity <> 0 THEN
      ReservePurchLine.VerifyQuantity(Rec,xRec);

    LOCKTABLE;
    PurchHeader."No." := '';
    IF ("Deferral Code" <> '') AND (GetDeferralAmount <> 0) THEN
      UpdateDeferralAmounts;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TestStatusOpen;
    if Quantity <> 0 then
    #3..6
    if ("Deferral Code" <> '') and (GetDeferralAmount <> 0) then
      UpdateDeferralAmounts;

    //<<FINXL8.00.001 BSA 10/06/2015 #85
    //<< FINXL9.00.000.01 AKH 12/01/2017
    // <<DITW19.00.08 DDR 08/08/2016 BL#9713
    //IF recFinXLSetup.READPERMISSION THEN
    if recFinXLSetup.READPERMISSION and ("Line No." <> 0) and (CurrFieldNo <> 0) and not BatchInsertCheckSuspended then
    // >>DITW19.00.08 DDR BL#9713
    //>> FINXL9.00.000.01 AKH 12/01/2017
      fctUpdateHeaderDocAfterModify;
    //>>FINXL8.00.001 BSA 10/06/2015 #85

    // <<DITW15.00.00.21 DDR 27/06/2008
    UpdateShippingPurchHeader(Rec);
    // >>DITW15.00.00.21 DDR
    // << DITW15.00.00.23 DDR 30/07/2008
    if (Type = Type::Item) and
       ("No." <> '') and
       (not "Is Item Charge") and
       (not BatchInsertCheckSuspended) and
       ("Line No." <> 0)
    then begin
      // <<DITW15.00.00.35 DDR 29/06/2009
      if TransferExtText.PurchCheckIfAnyExtText(Rec,false) then
        TransferExtText.InsertPurchExtText(Rec);
      // >>DITW15.00.00.35 DDR
    end;
    // >>DITW15.00.00.23 DDR


    //HEI.24>>
    if PurchSetup.GET then begin
      PurchaseLine.SETRANGE("Document Type","Document Type");
      PurchaseLine.SETRANGE("Document No.","No.");
      PurchaseLine.SETFILTER(Type,'%1',PurchaseLine.Type::Item);
      PurchaseLine.SETFILTER("Item Category Code",PurchSetup."Item Category");
      if not PurchaseLine.FINDFIRST then
        ItemCategoryBool := false
      else
        ItemCategoryBool := true;
      if ItemCategoryBool then begin
    //HEI.24<<
    //HEI.22>>
    if ("SRM Order No." = '') and (("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::"Return Order"))
      and (Type = Type::Item) and ("Item Category Code" = PurchSetup."Item Category") then begin //HEI.43
        PurchHdrArch.RESET;
        PurchHdrArch.SETRANGE(PurchHdrArch."Document Type","Document Type");
        PurchHdrArch.SETRANGE(PurchHdrArch."No.","Document No.");
        if PurchHdrArch.FINDFIRST then begin
          PurchHeader.RESET;
          PurchHeader.SETRANGE(PurchHeader."No.","Document No.");
          if PurchHeader.FINDFIRST then begin
            if PurchHeader."Purch. Reason Code" = '' then
               ERROR(ReasonCodeErr);
            end;
        end;
    end;
    //HEI.22<<
    //HEI.24>>
      end;
    end;
    //HEI.24<<

    //<<Hei.25
    HeinekenGlobal.CreatePODocumentLogOnInsert(Rec);
    //Hei.25>>
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Document Type" = "Document Type"::"Blanket Order") AND
       ((Type <> xRec.Type) OR ("No." <> xRec."No."))
    THEN BEGIN
      PurchLine2.RESET;
      PurchLine2.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
      PurchLine2.SETRANGE("Blanket Order No.","Document No.");
      PurchLine2.SETRANGE("Blanket Order Line No.","Line No.");
      IF PurchLine2.findset THEN
        REPEAT
          PurchLine2.TESTFIELD(Type,Type);
          PurchLine2.TESTFIELD("No.","No.");
        UNTIL PurchLine2.NEXT = 0;
    end;

    IF ((Quantity <> 0) OR (xRec.Quantity <> 0)) AND ItemExists(xRec."No.") THEN
      ReservePurchLine.VerifyChange(Rec,xRec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if ("Document Type" = "Document Type"::"Blanket Order") and
       ((Type <> xRec.Type) or ("No." <> xRec."No."))
    then begin
    #4..7
      if PurchLine2.findset then
        repeat
          PurchLine2.TESTFIELD(Type,Type);
          PurchLine2.TESTFIELD("No.","No.");
        until PurchLine2.NEXT = 0;
    end;

    if ((Quantity <> 0) or (xRec.Quantity <> 0)) and ItemExists(xRec."No.") then
      ReservePurchLine.VerifyChange(Rec,xRec);

    // <<DITW15.00.00.21 DDR 27/06/2008 - DITW15.00.00.24 DDR 14/08/2008
    if ((Type <> xRec.Type) or ("No." <> xRec."No.")) and
       (Type = Type::Item)
    then
      UpdateShippingPurchHeader(Rec);
    // >>DITW15.00.00.24 DDR

    //<<FINXL9.00.001 DAT 23/12/2015
    if not blnChangedfromHeader then
    //<<FINXL8.00.001 BSA 10/06/2015 #85
    //<< FINXL9.00.000.01 AKH 12/01/2017
      // <<DITW19.00.08 DDR 08/08/2016 BL#9713
      //IF recFinXLSetup.READPERMISSION THEN
      if recFinXLSetup.READPERMISSION and ("Line No." <> 0) and (CurrFieldNo <> 0) and not BatchInsertCheckSuspended then
      // >>DITW19.00.08 DDR BL#9713
    //>> FINXL9.00.000.01 AKH 12/01/2017
        fctUpdateHeaderDocAfterModify;
      //>>FINXL8.00.001 BSA 10/06/2015 #85

    //HEI.26>>
    if "Document Type" in ["Document Type"::Quote,"Document Type"::Order] then
      if (("Blanket Order Line No." <> 0) and ((Rec.Type <> xRec.Type) or (Rec."No." <> xRec."No."))) then
        ERROR(Text50002);
    //HEI.26<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        PaymentTerms: Record "Payment Terms";
        ServItemGroup: Record "Service Item Group";
        Vend: Record Vendor;
        ItemLocationCode: Code[10];
        lTempCurrfieldno: Integer;

    var
        lTempBatchInsertCheckSuspended: Boolean;

    var
        lrPurchRcptLine: Record "Purch. Rcpt. Line";
        lrBlankedOrderLine: Record "Purchase Line";
        lrPurchaseOrderLine: Record "Purchase Line";

    var
    // lCurrDirectUnitCost: Decimal;
    // lTempBatchInsertCheckSuspended: Boolean;

    var
    // lCurrDirectUnitCost: Decimal;

    var
        VATProdPostingGroup: Code[10];

    var
    // lCurrDirectUnitCost: Decimal;

    var
        PhysLocGrCode: Code[10];
        LocationCode: Code[20];

    var
    // lTempCurrfieldNo: Integer;

    var
        VendorSPL: Record "Vendor SPL Relation FND";

    var
    // lTempBatchInsertCheckSuspended: Boolean;

    var
        GLAcc2: Record "G/L Account";

    var
        DepreciationBook: Record "Depreciation Book";

    var
        lDimensionSetEntry: Record "Dimension Set Entry";
        lGLSetup: Record "General Ledger Setup";
        lPurchBlanketOrdHdr: Record "Purchase Header";
        lPurchHeader3: Record "Purchase Header";
        PurchHeader2: Record "Purchase Header";
        lBlanketPurchOrdLines: Record "Purchase Line";
        lPL: Record "Purchase Line";
        lPurchLine2: Record "Purchase Line";
        lPurchLineTmp: Record "Purchase Line" temporary;
        lSameBPOLineFound: Boolean;
        lDimensionValueCode: Code[20];
        lPurchLine2Qty: Decimal;
        lCurrLineDimensionSetID: Integer;
        lDimensionValueID: Integer;
        LineNo: Integer;
        // lPurchLine: Record "Purchase Line";
        lLineNo: Integer;
        lText50000: Label 'No Blanket Purchase Order Lines were found. Do you want to open Blanket Purchase Order Header list?';
        lText50001: Label 'Do you want to add a new line type: %1 No.: %2 to BPO No. %3?';

    var
        // GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionSetEntry: Record "Dimension Set Entry";
        DimensionSetEntry2: Record "Dimension Set Entry";

    var
    // QualityManagement: Codeunit "Quality Management";

    var
        lAssignableQty: Decimal;

    var
        lrPurchLineCopy: Record "Purchase Line";
        lrTempPurchLine: Record "Purchase Line" temporary;
        // VATPostingSetup2: Record "VAT Posting Setup";
        CADAmount: Decimal;

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        VATPostingSetup2: Record "VAT Posting Setup";

    var
        lOldItemNo: Code[20];
    // lTempCurrfieldNo: Integer;

    var
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";

    var
    // RetReasonLocationRelation: Record "Ret. Reason Location Relation";


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot change %1 because the order line is associated with sales order %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot change %1 because the order line is associated with sales order %2.;FRA=Vous ne pouvez pas modifier %1 car la commande est associée à la commande vente %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=Prices including VAT cannot be calculated when %1 is %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=Prices including VAT cannot be calculated when %1 is %2.;FRA=Les prix TTC ne peuvent pas être calculés quand %1 est identique à %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=You cannot purchase resources.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=You cannot purchase resources.;FRA=Vous ne pouvez pas acheter de ressources.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=must not be less than %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=must not be less than %1;FRA=ne doit pas être inférieur(e) à %1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=You cannot invoice more than %1 units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=You cannot invoice more than %1 units.;FRA=Vous ne pouvez pas facturer plus de %1 unité(s).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=You cannot invoice more than %1 base units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=You cannot invoice more than %1 base units.;FRA=Vous ne pouvez pas facturer plus de %1 unité(s) de base.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=You cannot receive more than %1 units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=You cannot receive more than %1 units.;FRA=Vous ne pouvez pas recevoir plus de %1 unité(s).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=You cannot receive more than %1 base units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=You cannot receive more than %1 base units.;FRA=Vous ne pouvez pas recevoir plus de %1 unité(s) de base.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text010(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text010 : ENU=You cannot change %1 when %2 is %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text010 : ENU=You cannot change %1 when %2 is %3.;FRA=Vous ne pouvez pas modifier %1 si %2 est %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text011(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=" must be 0 when %1 is %2";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=" must be 0 when %1 is %2";FRA=" doit être 0 quand %1 est %2";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text012(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : ENU="must not be specified when %1 = %2";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : ENU="must not be specified when %1 = %2";FRA="ne doit pas être spécifié(e) quand %1 = %2";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text016(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text016 : ENU="%1 is required for %2 = %3.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text016 : ENU="%1 is required for %2 = %3.";FRA="%1 requis(e) lorsque %2 = %3.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text017(Variable 1015)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text017 : ENU=\The entered information may be disregarded by warehouse operations.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text017 : ENU=\The entered information may be disregarded by warehouse operations.;FRA=\Les informations entrées peuvent être ignorées par les opérations de distribution.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text018(Variable 1016)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text018 : ENU=%1 %2 is earlier than the work date %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text018 : ENU=%1 %2 is earlier than the work date %3.;FRA=La %1 %2 est antérieure à la date de travail %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text020(Variable 1018)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text020 : ENU=You cannot return more than %1 units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text020 : ENU=You cannot return more than %1 units.;FRA=Vous ne pouvez pas retourner plus de %1 unité(s).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text021(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text021 : ENU=You cannot return more than %1 base units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text021 : ENU=You cannot return more than %1 base units.;FRA=Vous ne pouvez pas retourner plus de %1 unité(s) de base.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text022(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text022 : ENU=You cannot change %1, if item charge is already posted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text022 : ENU=You cannot change %1, if item charge is already posted.;FRA=Vous ne pouvez pas modifier %1 si les frais annexes ont été validés.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text023(Variable 1072)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text023 : ENU=You cannot change the %1 when the %2 has been filled in.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text023 : ENU=You cannot change the %1 when the %2 has been filled in.;FRA=Vous ne pouvez pas modifier le champ %1 lorsque le champ %2 a été renseigné.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text029(Variable 1077)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text029 : ENU=must be positive.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text029 : ENU=must be positive.;FRA=doit être de signe positif.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text030(Variable 1076)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text030 : ENU=must be negative.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text030 : ENU=must be negative.;FRA=doit être de signe négatif.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text031(Variable 1056)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text031 : ENU=You cannot define item tracking on this line because it is linked to production order %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text031 : ENU=You cannot define item tracking on this line because it is linked to production order %1.;FRA=Vous ne pouvez pas définir de traçabilité pour cette ligne car elle est liée à l'O.F. %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text032(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text032 : ENU=%1 must not be greater than the sum of %2 and %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text032 : ENU=%1 must not be greater than the sum of %2 and %3.;FRA=%1 ne doit pas être supérieur à la somme de %2 et de %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text033(Variable 1078)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text033 : ENU="Warehouse ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text033 : ENU="Warehouse ";FRA="Entrepôt ";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text034(Variable 1079)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text034 : ENU="Inventory ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text034 : ENU="Inventory ";FRA="Stocks ";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text035(Variable 1048)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text035 : ENU=%1 units for %2 %3 have already been returned or transferred. Therefore, only %4 units can be returned.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text035 : ENU=%1 units for %2 %3 have already been returned or transferred. Therefore, only %4 units can be returned.;FRA=%1 unités pour %2 %3 ont déjà été renvoyées ou transférées. Seules %4 unités peuvent donc être renvoyées.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text037(Variable 1082)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text037 : ENU=cannot be %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text037 : ENU=cannot be %1.;FRA=ne peut pas être %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text038(Variable 1083)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text038 : ENU=cannot be less than %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text038 : ENU=cannot be less than %1.;FRA=ne peut pas être inférieur(e) à %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text039(Variable 1084)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text039 : ENU=cannot be more than %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text039 : ENU=cannot be more than %1.;FRA=ne peut pas être supérieur(e) à %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text040(Variable 1090)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text040 : ENU=You must use form %1 to enter %2, if item tracking is used.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text040 : ENU=You must use form %1 to enter %2, if item tracking is used.;FRA=Si vous utilisez la traçabilité, vous devez employer le formulaire %1 pour entrer %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text99000000(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000000 : ENU=You cannot change %1 when the purchase order is associated to a production order.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000000 : ENU=You cannot change %1 when the purchase order is associated to a production order.;FRA=Vous ne pouvez pas modifier %1 lorsque la commande achat est associée à un O.F.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text042(Variable 1088)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text042 : ENU=You cannot return more than the %1 units that you have received for %2 %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text042 : ENU=You cannot return more than the %1 units that you have received for %2 %3.;FRA=Vous ne pouvez pas retourner plus que les %1 unités que vous avez reçues pour %2 %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text043(Variable 1089)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text043 : ENU=must be positive when %1 is not 0.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text043 : ENU=must be positive when %1 is not 0.;FRA=doit être de signe positif si %1 est différent de 0.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text044(Variable 1080)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text044 : ENU=You cannot change %1 because this purchase order is associated with %2 %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text044 : ENU=You cannot change %1 because this purchase order is associated with %2 %3.;FRA=Impossible de modifier %1 car cette commande achat est associée à %2 %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text046(Variable 1091)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text046 : @@@=%1 - product name;ENU=%3 will not update %1 when changing %2 because a prepayment invoice has been posted. Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text046 : @@@=%1 - product name;ENU=%3 will not update %1 when changing %2 because a prepayment invoice has been posted. Do you want to continue?;FRA=%3 ne mettra pas à jour %1 si vous modifiez %2 car une facture d'acompte a été validée. Útes-vous certain de vouloir continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text047(Variable 1092)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text047 : ENU=%1 can only be set when %2 is set.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text047 : ENU=%1 can only be set when %2 is set.;FRA=%1 ne peut être déterminé que si %2 est défini.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text048(Variable 1093)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text048 : ENU=%1 cannot be changed when %2 is set.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text048 : ENU=%1 cannot be changed when %2 is set.;FRA=%1 ne peut pas être modifié si %2 est défini.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text049(Variable 1085)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text049 : ENU=You have changed one or more dimensions on the %1, which is already shipped. When you post the line with the changed dimension to General Ledger, amounts on the Inventory Interim account will be out of balance when reported per dimension.\\Do you want to keep the changed dimension?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text049 : ENU=You have changed one or more dimensions on the %1, which is already shipped. When you post the line with the changed dimension to General Ledger, amounts on the Inventory Interim account will be out of balance when reported per dimension.\\Do you want to keep the changed dimension?;FRA=Vous avez modifié un ou plusieurs axes analytiques dans %1, qui a déjà été expédié. Lorsque vous validez la ligne avec l'axe analytique modifié dans la comptabilité, les montants de l'état intermédaire stock présentent un déséquilibre si un état est généré par axe analytique.\\Voulez-vous conserver l'axe analytique modifié ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text050(Variable 1086)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text050 : ENU=Cancelled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text050 : ENU=Cancelled.;FRA=Annulé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text051(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text051 : ENU=must have the same sign as the receipt;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text051 : ENU=must have the same sign as the receipt;FRA=doit avoir le même signe que le bon de réception;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text052(Variable 1053)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text052 : ENU=The quantity that you are trying to invoice is greater than the quantity in receipt %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text052 : ENU=The quantity that you are trying to invoice is greater than the quantity in receipt %1.;FRA=La quantité que vous tentez de facturer est supérieure à la quantité de la réception %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text053(Variable 1054)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text053 : ENU=must have the same sign as the return shipment;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text053 : ENU=must have the same sign as the return shipment;FRA=doit avoir le même signe que l'expédition retour;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text054(Variable 1055)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text054 : ENU=The quantity that you are trying to invoice is greater than the quantity in return shipment %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text054 : ENU=The quantity that you are trying to invoice is greater than the quantity in return shipment %1.;FRA=La quantité que vous tentez de facturer est supérieure à la quantité de l'expédition retour %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "AnotherItemWithSameDescrQst(Variable 1033)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //AnotherItemWithSameDescrQst : @@@="%1=Item no., %2=item description";ENU=Item No. %1 also has the description "%2".\Do you want to change the current item no. to %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AnotherItemWithSameDescrQst : @@@="%1=Item no., %2=item description";ENU=Item No. %1 also has the description "%2".\Do you want to change the current item no. to %1?;FRA=L'article n° %1 possède également la description « %2 ».\Souhaitez-vous modifier le numéro d'article actuel en %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DataConflictQst(Variable 1094)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DataConflictQst : ENU=The change creates a date conflict with existing reservations. Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DataConflictQst : ENU=The change creates a date conflict with existing reservations. Do you want to continue?;FRA=Cette modification crée un conflit de dates avec les réservations existantes. Souhaitez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ItemNoFieldCaptionTxt(Variable 1031)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ItemNoFieldCaptionTxt : ENU=Item;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemNoFieldCaptionTxt : ENU=Item;FRA=Article;
    //Variable type has not been exported.
    //BC UPGRADE SHARMP16 begin<<
    procedure SetDefaultSPLCode()
    var
        myInt: Integer;
    begin
        //HEI.61 >>
        IF "Buy-from Vendor No." = '' THEN BEGIN
            "SPL Code FND" := '';
            EXIT;
        end;

        VendorSPL.SETRANGE("Vendor No.", "Buy-from Vendor No.");
        VendorSPL.SETRANGE("SPL Code", "SPL Code FND");
        VendorSPL.SETRANGE(Blocked, FALSE);
        IF NOT VendorSPL.ISEMPTY THEN
            EXIT;

        VendorSPL.SETRANGE("SPL Code");
        VendorSPL.SETRANGE(Default, TRUE);
        IF VendorSPL.FINDFIRST() THEN BEGIN
            VALIDATE("SPL Code FND", VendorSPL."SPL Code");
            EXIT;
        end;

        VendorSPL.SETRANGE(Default);
        IF VendorSPL.FINDFIRST() THEN BEGIN
            VALIDATE("SPL Code FND", VendorSPL."SPL Code");
            EXIT;
        end;
        //HEI.61 <<

    end;

    procedure GetBlanketOrderPrice()
    var
        PurchBlanketOrderLine: Record "Purchase Line";
    //SRMInterfaceManagement:Codeunit 
    begin
        //HEI.11>>
        IF PurchBlanketOrderLine.GET(PurchBlanketOrderLine."Document Type"::"Blanket Order", "Blanket Order No.", "Blanket Order Line No.") THEN;
        // IF SRMInterfaceManagement.IsSRMPurchaseBlanketOrderLine(PurchBlanketOrderLine) THEN
        //     SRMInterfaceManagement.GetBlanketOrderPurchPrice(PurchBlanketOrderLine, Rec, TRUE);
        //HEI.11<<

    end;

    procedure UpdateTINBAndVATProdPostGrByLocation()
    var
        TINbyLocation: Record "TIN by Location FND";
    begin
        //HEI.19>>
        GeneralLedgerSetup.GET();
        IF GeneralLedgerSetup."Enable TIN By Location FND" THEN BEGIN
            TINbyLocation.GET("VAT Prod. Posting Group", "Location Code");
            "VAT Prod. Posting Group" := TINbyLocation."VAT Prod. Posting Group by Loc";
            TINbyLocation.CALCFIELDS("TIN No.");
            "TIN No. FND" := TINbyLocation."TIN No.";

            TESTFIELD("TIN No. FND");
            CheckDifferentTINNo();
        end;
        //HEI.19<<
    end;

    procedure CheckDifferentTINNo()
    var
        myInt: Integer;
    begin
        //HEI.19>>
        PurchaseLine.SETRANGE("Document No.", "Document No.");
        PurchaseLine.SETRANGE("Document Type", "Document Type");
        PurchaseLine.SETFILTER("Line No.", '<>%1', "Line No.");
        PurchaseLine.SETFILTER("TIN No. FND", '<>%1', "TIN No. FND");
        IF PurchaseLine.findset() THEN
            REPEAT
                IF PurchaseLine."TIN No. FND" <> '' THEN
                    ERROR(DifferentTINNoErr, FIELDCAPTION("Document No."), "Document No.");
            UNTIL PurchaseLine.NEXT() = 0;
        //HEI.19<<

    end;

    procedure SetCurrFieldNo(NewCurrFieldNo: Integer)

    var
        myInt: Integer;
    begin
        CurrFieldNo := NewCurrFieldNo;//HEI.27
    end;

    //BC UPGRADE ATHUKUS01 FDDSTP_008>>  
    procedure UpdateOriginalQuantity()
    begin
        IF ("Original Quantity FND" = 0) OR (CurrFieldNo = FIELDNO(Quantity)) THEN BEGIN
            IF "Original Quantity FND" = 0 THEN BEGIN
                "Original Quantity FND" := Quantity;
            END ELSE BEGIN
                Rec.GetLocation("Location Code");
                GetPurchHeader();
                //IF PurchHeader."Receipt Status" < Location."Manually Close Receipt Status" THEN
                //  "Original Quantity" := Quantity;
            END;
        END;
    end;

    procedure GetLocation(LocationCode: Code[10])
    var
        Location: Record Location;
    begin
        IF LocationCode = '' THEN
            CLEAR(Location)
        ELSE
            IF Location.Code <> LocationCode THEN
                Location.GET(LocationCode);
    end;
    //BC UPGRADE ATHUKUS01 FDDSTP_008<<


    local procedure fctUpdateHeaderDocAfterModify()
    var
        myInt: Integer;
    begin
        //BC UPGRADE ATHUKS01>>
        //    IF PurchHeader.FIND() THEN; //HEI.32
        //  GetPurchHeader();
        //BC UPGRADE SIVA>>
        // PurchHeader.SystemModifiedBy := CreateGuid();
        // PurchHeader.SystemModifiedAt := CURRENTDATETIME;
        //BC UPGRADE ATHUKS01<<
        if PurchHeader.get(rec."Document Type", Rec."Document No.") then begin
            //BC Upgrade SHARMP16 BEGIN<< ---IBM GAP STP 48
            PurchHeader."Last changed User ID IBM FND" := USERID;
            PurchHeader."Last changed Date/time IBM FND" := CURRENTDATETIME;
            //BC Upgrade SHARMP16 END>> ---IBM GAP STP 48
            //<<Hei.25
            IF NOT HeinekenGlobal.CheckNewPurchLine(Rec) THEN BEGIN
                IF (((Rec."No." <> xRec."No.") OR (Rec.Quantity <> xRec.Quantity) OR (xRec."Unit of Measure" <> Rec."Unit of Measure") OR
                  (xRec."Expected Receipt Date" <> Rec."Expected Receipt Date") OR (xRec."Direct Unit Cost" <> Rec."Direct Unit Cost"))
                    AND (PurchHeader."No. Printed" >= 1)) THEN
                    //IF PurchHeader."No. Printed" >= 1 THEN
                    PurchHeader."Changed FND" := TRUE;
                PurchHeader.MODIFY();
            end;
            //>>Hei.25
        end;
    end;

    trigger OnAfterInsert()
    var
        myInt: Integer;
    begin
        //HEI.24>>
        IF PurchSetup.GET() THEN BEGIN
            PurchaseLine.SETRANGE("Document Type", "Document Type");
            PurchaseLine.SETRANGE("Document No.", "No.");
            PurchaseLine.SETFILTER(Type, '%1', PurchaseLine.Type::Item);
            PurchaseLine.SETFILTER("Item Category Code", PurchSetup."Item Category FND");
            IF NOT PurchaseLine.FINDFIRST() THEN
                ItemCategoryBool := FALSE
            else
                ItemCategoryBool := TRUE;
            IF ItemCategoryBool THEN BEGIN
                //HEI.24<<
                //HEI.22>>
                IF ("SRM Order No. FND" = '') AND (("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order"))
                  AND (Type = Type::Item) AND ("Item Category Code" = PurchSetup."Item Category FND") THEN BEGIN //HEI.43
                    PurchHdrArch.RESET();
                    PurchHdrArch.SETRANGE(PurchHdrArch."Document Type", "Document Type");
                    PurchHdrArch.SETRANGE(PurchHdrArch."No.", "Document No.");
                    IF PurchHdrArch.FINDFIRST() THEN BEGIN
                        PurchHeader.RESET();
                        PurchHeader.SETRANGE(PurchHeader."No.", "Document No.");
                        IF PurchHeader.FINDFIRST() THEN BEGIN
                            IF PurchHeader."Purch. Reason Code FND" = '' THEN
                                ERROR(ReasonCodeErr);
                        end;
                    end;
                end;
                //HEI.22<<
                //HEI.24>>
            end;
        end;
        //HEI.24<<
        //BC UPGRADE ATHUKS01<<
        if ("Line No." <> 0) then
            fctUpdateHeaderDocAfterModify();
        //BC UPGRADE ATHUKS01>>    
        //<<Hei.25
        HeinekenGlobal.CreatePODocumentLogOnInsert(Rec);
        //Hei.25>>

    end;

    trigger OnAfterDelete()
    var
        myInt: Integer;
    begin
        //HEI.24>>
        IF PurchSetup.GET() THEN BEGIN
            PurchaseLine.SETRANGE("Document Type", "Document Type");
            PurchaseLine.SETRANGE("Document No.", "Document No.");
            PurchaseLine.SETFILTER(Type, '%1', PurchaseLine.Type::Item);
            PurchaseLine.SETFILTER("Item Category Code", PurchSetup."Item Category FND");
            IF NOT PurchaseLine.FINDFIRST() THEN
                ItemCategoryBool := FALSE
            else
                ItemCategoryBool := TRUE;
            IF ItemCategoryBool THEN BEGIN
                //HEI.24<<
                //HEI.22>>
                IF ("SRM Order No. FND" = '') AND (("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::"Return Order"))
                  AND (Type = Type::Item) AND ("Item Category Code" = PurchSetup."Item Category FND") THEN BEGIN //HEI.43
                    PurchHdrArch.RESET();
                    PurchHdrArch.SETRANGE(PurchHdrArch."Document Type", "Document Type");
                    PurchHdrArch.SETRANGE(PurchHdrArch."No.", "Document No.");
                    IF PurchHdrArch.FINDFIRST() THEN BEGIN
                        PurchHeader.RESET();
                        PurchHeader.SETRANGE(PurchHeader."No.", "Document No.");
                        IF PurchHeader.FINDFIRST() THEN BEGIN
                            IF PurchHeader."Purch. Reason Code FND" = '' THEN
                                ERROR(ReasonCodeErr);
                        end;
                    end;
                end;
                //HEI.22<<
                //HEI.24>>
            end;
        end;
        //HEI.24<<

        //<<Hei.25
        HeinekenGlobal.CreatePODocumentLogOnDelete(Rec);
        //Hei.25>>
    end;

    trigger OnAfterModify()
    var
        myInt: Integer;
    begin
        //HEI.26>>
        IF "Document Type" IN ["Document Type"::Quote, "Document Type"::Order] THEN
            IF (("Blanket Order Line No." <> 0) AND ((Rec.Type <> xRec.Type) OR (Rec."No." <> xRec."No."))) THEN
                ERROR(Text50002);
        //HEI.26<<

        //BC UPGRADE ATHUKS01<<  
        if ("Line No." <> 0) then
            fctUpdateHeaderDocAfterModify();
        //BC UPGRADE ATHUKS01>>    
    end;
    //BC UPGRADE SHARMP16 end>>

    var
        Text014: TextConst ENU = 'Change %1 from %2 to %3?', FRA = 'Remplacer %2 par %3 dans le champ %1 ?';

    var
        CompanyInfo: Record "Company Information";
        // ServContract: Record "Service Purch. Contract Header";
        // ContractDIT: Record "Financial Contract Header";
        ContractGroup: Record "Contract Group";
        // QualitySetup: Record "Quality Setup";
        SaveCurrency: Record Currency;
        SaveGLSetup: Record "General Ledger Setup";
        ItemCategory: Record "Item Category";
        SaveTempItemChrgAssgnPurch: Record "Item Charge Assignment (Purch)" temporary;
        TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary;
        // cduQualityMgt: Codeunit "Quality Management";
        // EmcsSetup: Record "EMCS Setup";
        // LocationGr: Record "Location Group";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        recPurchRcptHeader: Record "Purch. Rcpt. Header";
        recPurchRcptLine: Record "Purch. Rcpt. Line";
        PurchHeader: Record "Purchase Header";
        lPurchHeaderAdd: Record "Purchase Header Additional FND";
        PurchHdrArch: Record "Purchase Header Archive";
        lPurchLine: Record "Purchase Line";
        PurchaseLine: Record "Purchase Line";
        SaveTempPurchChargeLine: Record "Purchase Line" temporary;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        //    rMANXLSetup: Record "Manufacturing XL Setup";
        ReservEntry: Record "Reservation Entry";
        RespCenter: Record "Responsibility Center";
        //    PhysLocationGr: Record "Physical Location Group";
        //   rPropertyPurchServMgtSetup: Record "Property Purch Serv Mgt. Setup";
        Vendor: Record Vendor;
        // DiscPromoPostLine: Codeunit "Purch.Disc. & Promo.-Post Line";
        // ItemExcluCheckAvail: Codeunit "Item Exclusivity-Check";
        WhseSetup: Record "Warehouse Setup";
        HeinekenGlobal: Codeunit "Heineken Global";
        // NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade NANDIS03 - Blocked
        NoSeriesMgt: Codeunit "No. Series";  // BC Upgrade NANDIS03 - Added
        TransferExtText: Codeunit "Transfer Extended Text";
        SaveTransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
        //     BomItemCharges: Codeunit "Bom Item Charges Mgt.";
        UserSetupMgt: Codeunit "User Setup Management";
        //  AADDocMgt: Codeunit "AAD Document Mgt.";
        // CommonItemChrgMgt: Codeunit "Common Item Charges Mgt.";
        BatchInsertCheckSuspended: Boolean;
        blnChangedfromHeader: Boolean;
        blnChangedFromWarehouseRcpt: Boolean;
        CompanySetupRead: Boolean;
        CurrencyRead: Boolean;
        DelFinalForAll: Boolean;
        //    recFinXLSetup: Record "Finance XL Setup";
        DropSpecialCheckSuspended: Boolean;
        // ContractGroupDIT: Record "Financial Contract Group";
        ForceDeleteDiscItemCharges: Boolean;
        ForceDeleteItemCharges: Boolean;
        HasGotPurchSetup: Boolean;
        HideValidationDialog: Boolean;
        ItemCategoryBool: Boolean;
        RunSyncDropShipOrder: Boolean;
        SkipUpdateShippingHeader: Boolean;
        //  rFreeReasonCode: Record "Free Reason Code";
        SkipValidationDimensions: Boolean;
        DifferentTINNoErr: Label 'It is not allowed to have different TIN Nos on %1 %2.';
        ReasonCodeErr: Label 'You must fill in Reason Code';
        Text50000: Label 'Dimension changes are not allowed in PO Invoices';
        Text50001: Label 'Trading Partner Dimension changes are not allowed in PO Invoices that are manually inserted.';
        Text50002: Label 'Blanket Order Line No. is not blank! Please create a new line!';
        Text50003: Label 'The Document Type should be Order or Blanket Order';
        Text50005: Label 'Outstanding Qty is already 0. Full Quantity is already Received. Delivery Finalized cannot be FALSE for Purchase Line No. %1 for PO No. %2.';
        CannotReturnBaseUnitsErr: TextConst ENU = 'You cannot return more than %1 base units.', ESP = 'No se pueden devolver más de %1 unidades base.', FRA = 'Vous ne pouvez pas retourner plus de %1 unité(s) de base.';
        CannotReturnUnitsErr: TextConst ENU = 'You cannot return more than %1 units.', ESP = 'No se pueden devolver más de %1 unidades.', FRA = 'Vous ne pouvez pas retourner plus de %1 unité(s).';
        Text50004: TextConst ENU = '%1 must not be greater than the sum of %2 with Document no %3.', FRA = '%1 ne doit pas être supérieur à la somme de %2 avec le document n° %3.';
        Text2013660: TextConst ENU = 'cannot be greater than %1.', FRA = 'Ne peut pas être superieur à %1';
        Text2013661: TextConst ENU = 'cannot be lower than %1.', FRA = 'Ne peut pas être inferieur à %1';
        Text2013662: TextConst ENU = 'You cannot change %1 because the value is automatically calculated with %2.', FRA = 'Vous ne pouvez pas modifier %1 car la valeur est calculé automatiquement avec %2.';
        Text2013663: TextConst ENU = 'At least one item charge tax line must exist with the %1 %2.', FRA = 'Il doit exister au moins une ligne de type taxe avec le %1 %2.';
        Text2013664: TextConst ENU = 'You must specify %1 in %2 or %3 or %4 when %5 %6.', FRA = 'Vous devez spécifier %1 dans %2 ou %3 ou %4 quand %5 %6.';
        Text2013760: TextConst ENU = 'You cannot input more than %1 units because it is attached to %2 %3 as %4.', FRA = 'Vous ne pouvez pas entrer plus de %1 unités car il est attaché à %2 %3 comme %4.';
        Text2013761: TextConst ENU = 'You cannot modify because it is attached to %1 %2 as %3.', FRA = 'Vous ne pouvez pas modifier, car il est attaché à %1 %2 comme %3.';
        Text2013763: TextConst ENU = 'If the item carries serial or lot numbers, then you must use the %1 field in the %2 window.', FRA = 'Si l''article porte des numéros de série ou de lot, alors vous devez utiliser le champ %1 dans la fenêtre %2.';
        // VendDrinkTaxGr: Record "Drink Tax Group";
        // ItemDrinkTaxGr: Record "Drink Tax Group";
        // TransferTaxCharges: Codeunit "Tax Item Charges Mgt.";
        // TransferDepositCharges: Codeunit "Deposit Item Charges Mgt.";
        // TransferDiscountCharges: Codeunit "Discount Item Charges Mgt.";
        // TransferPromotionCharges: Codeunit "Promotion Item Charges Mgt.";
        Text2014060: TextConst ENU = 'Do you want to reduce the order quantity for this manco receipt?', FRA = 'Voulez vous diminuer la quantité pour cette manco réception ?';
        Text2014061: TextConst ENU = 'Do you want to increase the order quantity for this surplus receipt?', FRA = 'Voulez vous augmenter la quantité pour cette manco réception ?';
        Text2014260: TextConst ENU = 'You must specify %1 in %2 %3.', FRA = 'Vous devez indiquer %1 dans %2 %3.';
        Text2014261: TextConst ENU = 'The warehouse document %1 is already assigned to %2 %3.', FRA = 'Le document entrepôt %1 possède déjà un %2 %3.';
        Text2014410: TextConst ENU = 'The %1 combination ''%2'' ''%3'' does not exist for %4 %5.', FRA = 'La %1 combinaison %2 %3 n''existe pas pour %4 %5.';
        Text2014411: TextConst ENU = 'Do you want to insert the item charges for all lines?', FRA = 'Souhaitez-vous insérer les frais annexes pour toutes les lignes?';
        Text2014412: TextConst ENU = 'Do you want to replace the existing %1 %2 using the item selection?', FRA = 'Souhaitez-vous remplacer l''actuel %1 %2 par les articles sélectionnés?';
        Text2014413: TextConst ENU = 'Your identification is set up to process from %1 %2 only.', FRA = 'Le paramétrage de votre code utilisateur ne vous permet de travailler que sur %1 %2.';
        Text2014414: TextConst ENU = 'You cannot use the %1 %2 because your identification is not set up to process from this Responsibility Center.', FRA = 'Vous ne pouvez pas utiliser le %1 %2 parce que votre identification n''est pas paramétrée pour ce centre de gestion';
}

