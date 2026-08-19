tableextension 50105 RegisteredWhseActLineExtFND extends "Registered Whse. Activity Line"
{
    // version NAVW19.00,DITW110.00.09,HEI.01
    //BC Upgrade PATHAA02-Fields, Key and variable linked to DIT commented
    //Check for functions which are not moved probably called from Page

    fields
    {
        modify("Activity Type")
        {
            CaptionML = ENU = 'Activity Type', FRA = 'Type activité';
           // OptionCaptionML = ENU = ' ,Put-away,Pick,Movement', FRA = ' ,Rangement,Prélèvement,Mouvement';
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Source Type")
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
        }
        modify("Source Subtype")
        {
            CaptionML = ENU = 'Source Subtype', FRA = 'Sous-type origine';
            OptionCaptionML = ENU = '0,1,2,3,4,5,6,7,8,9,10', FRA = '0,1,2,3,4,5,6,7,8,9,10';
        }
        modify("Source No.")
        {
            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
        }
        modify("Source Line No.")
        {
            CaptionML = ENU = 'Source Line No.', FRA = 'N° ligne origine';
        }
        modify("Source Subline No.")
        {
            CaptionML = ENU = 'Source Subline No.', FRA = 'N° sous-ligne origine';
        }
        modify("Source Document")
        {
            CaptionML = ENU = 'Source Document', FRA = 'Document origine';
           // OptionCaptionML = ENU = ',Sales Order,,,Sales Return Order,Purchase Order,,,Purchase Return Order,Inbound Transfer,Outbound Transfer,Prod. Consumption,,,,,,,Service Order,,Assembly Consumption,Assembly Order', FRA = ',Commande vente,,,Retour vente,Commande achat,,,Retour achat,Enlogement transfert,Désenlogement transfert,Consommation O.F.,,,,,,,Commande service,,Consommation d''assemblage,Ordre d''assemblage';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Shelf No.")
        {
            CaptionML = ENU = 'Shelf No.', FRA = 'N° emplacement';
        }
        modify("Sorting Sequence No.")
        {
            CaptionML = ENU = 'Sorting Sequence No.', FRA = 'N° séquence tri';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify("Variant Code")
        {

            //Unsupported feature: Change TableRelation on ""Variant Code"(Field 15)". Please convert manually.

            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Unit of Measure Code")
        {

            //Unsupported feature: Change TableRelation on ""Unit of Measure Code"(Field 16)". Please convert manually.

            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Qty. (Base)")
        {
            CaptionML = ENU = 'Qty. (Base)', FRA = 'Qté (base)';
        }
        modify("Shipping Advice")
        {
            CaptionML = ENU = 'Shipping Advice', FRA = 'Option d''expédition';
           // OptionCaptionML = ENU = 'Partial,Complete', FRA = 'Partielle,Totale';
        }
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Délai';
        }
        modify("Destination Type")
        {
            CaptionML = ENU = 'Destination Type', FRA = 'Type destination';
           // OptionCaptionML = ENU = ' ,Customer,Vendor,Location,Item,Family,Sales Order', FRA = ' ,Client,Fournisseur,Magasin,Article,Famille,Commande vente';
        }
        modify("Destination No.")
        {

            //Unsupported feature: Change TableRelation on ""Destination No."(Field 40)". Please convert manually.

            CaptionML = ENU = 'Destination No.', FRA = 'N° destination';
        }
        modify("Whse. Activity No.")
        {
            CaptionML = ENU = 'Whse. Activity No.', FRA = 'N° activité entrepôt';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
        }
        modify("Shipping Agent Service Code")
        {

            //Unsupported feature: Change TableRelation on ""Shipping Agent Service Code"(Field 43)". Please convert manually.

            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';
        }
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Shipment Method Code', FRA = 'Code condition livraison';
        }
        modify("Starting Date")
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';
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
        modify("Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Bin Code"(Field 7300)". Please convert manually.

            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
        }
        modify("Zone Code")
        {

            //Unsupported feature: Change TableRelation on ""Zone Code"(Field 7301)". Please convert manually.

            CaptionML = ENU = 'Zone Code', FRA = 'Code zone';
        }
        modify("Action Type")
        {
            CaptionML = ENU = 'Action Type', FRA = 'Type action';
           // OptionCaptionML = ENU = ' ,Take,Place', FRA = ' ,Prélever,Ranger';
        }
        modify("Whse. Document Type")
        {
            CaptionML = ENU = 'Whse. Document Type', FRA = 'Type document entrepôt';
           // OptionCaptionML = ENU = ' ,Receipt,Shipment,Internal Put-away,Internal Pick,Production,Movement Worksheet,,Assembly', FRA = ' ,Réception,Expédition,Rangement interne,Prélèvement interne,Production,Feuille mouvement,,Assemblage';
        }
        modify("Whse. Document No.")
        {

            //Unsupported feature: Change TableRelation on ""Whse. Document No."(Field 7307)". Please convert manually.

            CaptionML = ENU = 'Whse. Document No.', FRA = 'N° document entrepôt';
        }
        modify("Whse. Document Line No.")
        {

            //Unsupported feature: Change TableRelation on ""Whse. Document Line No."(Field 7308)". Please convert manually.

            CaptionML = ENU = 'Whse. Document Line No.', FRA = 'N° ligne document entrep.';
        }
        modify(Cubage)
        {
            CaptionML = ENU = 'Cubage', FRA = 'Cubage';
        }
        modify(Weight)
        {
            CaptionML = ENU = 'Weight', FRA = 'Poids';
        }
        modify("Special Equipment Code")
        {
            CaptionML = ENU = 'Special Equipment Code', FRA = 'Code équipement spécial';
        }
        field(50000; "Linked To Line No. FND"; Integer)
        {
            caption ='Linked To Line No.';
            Description = 'HEI.01 PRDGAP024';
            Editable = false;
            TableRelation = "Warehouse Activity Line" where("Activity Type" = FIELD("Activity Type"),
                                                             "No." = FIELD("No."),
                                                             "Linked To Line No. FND" = FIELD("Line No."));
        }
        field(50001; "In-Transit Zone Code FND"; Code[10])
        {
            caption ='In-Transit Zone Code';
            Description = 'HEI.01 PRDGAP024';
            Editable = false;
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"));
        }
        field(50002; "In-Transit Bin Code FND"; Code[20])
        {
            caption ='In-Transit Bin Code';
            Description = 'HEI.01 PRDGAP024';
            Editable = false;
        }
        field(50003; "Zone-Transfer FND"; Boolean)
        {
            caption ='Zone-Transfer';
            Description = 'HEI.01 PRDGAP024';
            Editable = false;
        }
        //BC Upgrade PATHAA02-DIT>>
        // field(2014495;"Delivery Sequence";Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU='Delivery Sequence',
        //                 FRA='Séquence de livraison';
        //     Description = 'DITW16.00.00.40 #1002';
        //     MinValue = 0;
        // }
        // field(2035040;"SSCC No.";Code[50])
        // {
        //     CaptionML = ENU='SSCC No.',
        //                 FRA='N° SSCC';
        //     Description = 'DITW16.00.00.40 DIT-715 #274';

        //     trigger OnLookup();
        //     begin
        //         // <<DITW16.00.00.40 DDR 06/03/2012 DIT-715 #274
        //         // <<DITW16.00.00.43 DDR 31/05/2013 DIT-715 #657
        //         SSCCTrackingMgt.LookupLotSSCCNoInfo("Item No.","Variant Code","Lot No.","SSCC No.");
        //     end;
        // } //BC Upgrade PATHAA02-DIT<<
    }
    keys
    {
        //BC Upgrade PATHAA02>>
        // key(Key1; "SSCC No.")
        // {
        //     Enabled = false;
        // } 
        //BC Upgrade PATHAA02<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
    //SSCCTrackingMgt : Codeunit "SSCC Tracking Management";//BC Upgrade PATHAA02-DIT
}

