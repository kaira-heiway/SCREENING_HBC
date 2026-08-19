tableextension 50212 PhysInventoryLedgerEntryExtFND extends "Phys. Inventory Ledger Entry"
{
    // version NAVW19.00,DITW110.00.09
    //BC UPGRADE PATHAA02 19.01.26

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
            // OptionCaptionML = ENU = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output', FRA = 'Achat,Vente,Positif (ajust.),Négatif (ajust.),Transfert,Consommation,Production, ,Consommation d''assemblage,Résultat d''assemblage';
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
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Unit Amount")
        {
            CaptionML = ENU = 'Unit Amount', FRA = 'Montant unitaire';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Salespers./Purch. Code")
        {
            CaptionML = ENU = 'Salespers./Purch. Code', FRA = 'Code vendeur/acheteur';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("Global Dimension 1 Code")
        {
            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {
            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Journal Batch Name")
        {
            CaptionML = ENU = 'Journal Batch Name', FRA = 'Nom feuille';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("Qty. (Calculated)")
        {
            CaptionML = ENU = 'Qty. (Calculated)', FRA = 'Qté (calculée)';
        }
        modify("Qty. (Phys. Inventory)")
        {
            CaptionML = ENU = 'Qty. (Phys. Inventory)', FRA = 'Qté (constatée)';
        }
        modify("Last Item Ledger Entry No.")
        {
            CaptionML = ENU = 'Last Item Ledger Entry No.', FRA = 'Dern. n° écriture comptable article';
        }
        modify("Document Date")
        {
            CaptionML = ENU = 'Document Date', FRA = 'Date document';
        }
        modify("External Document No.")
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Variant Code")
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Phys Invt Counting Period Code")
        {
            CaptionML = ENU = 'Phys Invt Counting Period Code', FRA = 'Code période inventaire stock';
        }
        modify("Phys Invt Counting Period Type")
        {
            CaptionML = ENU = 'Phys Invt Counting Period Type', FRA = 'Type période inventaire';
            OptionCaptionML = ENU = ' ,Item,SKU', FRA = ' ,Article,Point de stock';
        }
        field(50000; "Zone Code FND"; Code[10])
        {
            Caption = 'Zone Code';
            TableRelation = Zone.Code;
        }
        field(50001; "Bin Code FND"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code;
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

