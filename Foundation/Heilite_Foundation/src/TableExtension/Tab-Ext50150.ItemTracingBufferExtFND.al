tableextension 50150 ItemTracingBufferExtFND extends "Item Tracing Buffer"
{
    // HEI.01 CHG2012342 IBM GAVANM01 19/11/2019 # new field added 50000 - Your Reference
    // version NAVW17.00,DITW110.00.09

    fields
    {
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Parent Item Ledger Entry No.")
        {
            CaptionML = ENU = 'Parent Item Ledger Entry No.', FRA = 'N° écriture comptable nomenclature';
        }
        modify(Level)
        {
            CaptionML = ENU = 'Level', FRA = 'Niveau';
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
        modify("Source Type")
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
            // OptionCaptionML = ENU = ' ,Customer,Vendor,Item', FRA = ' ,Client,Fournisseur,Article';
        }
        modify("Source No.")
        {
            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
        }
        modify("Source Name")
        {
            CaptionML = ENU = 'Source Name', FRA = 'Nom origine';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
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
        modify(Open)
        {
            CaptionML = ENU = 'Open', FRA = 'Ouvrir';
        }
        modify(Positive)
        {
            CaptionML = ENU = 'Positive', FRA = 'Positif';
        }
        modify("Variant Code")
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Serial No.")
        {
            CaptionML = ENU = 'Serial No.', FRA = 'N° de série';
        }
        modify("Lot No.")
        {
            CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
        }
        modify("Item Ledger Entry No.")
        {
            CaptionML = ENU = 'Item Ledger Entry No.', FRA = 'N° écriture comptable article';
        }
        modify("Created by")
        {
            CaptionML = ENU = 'Created by', FRA = 'Créé par';
        }
        modify("Created on")
        {
            CaptionML = ENU = 'Created on', FRA = 'Créé le';
        }
        modify("Record Identifier")
        {
            CaptionML = ENU = 'Record Identifier', FRA = 'Identifiant enregistrement';
        }
        modify("Item Description")
        {
            CaptionML = ENU = 'Item Description', FRA = 'Description article';
        }
        modify("Already Traced")
        {
            CaptionML = ENU = 'Already Traced', FRA = 'Déjà tracé';
        }
        field(50000; "Your Reference FND"; Text[30])
        {
            CaptionML = ENU = 'Your Reference',
                        FRA = 'Votre référence';
            Description = 'HEI.01';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

