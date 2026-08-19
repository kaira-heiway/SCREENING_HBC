tableextension 50169 PlanningBufferExtFND extends "Planning Buffer"
{
    // version NAVW17.00,HEI.01

    //     HEI.01 RFC-CHG0261845 IBM.SS 14.01.2019
    //   # New Fields Created: 50000 - "Location Code"
    //                         50001 - "Bin Code"
    //                         50002 - "Zone Code"
    //                         50003 - "Scheduled Quantity"
    // HEI.02 RFC-CHG0261845 IBM.LS 24.01.2019
    //   # Key Added: "Item No.,Date,Location Code,Zone Code,Bin Code"
    // HEI.03 RFC-CHG0261845 IBM.LS 30.05.2019
    //   # OptionString & OptionCaption Added in the Field - "Document Type":
    //   # ,Put-away,Pick,Movement,Invt. Put-away,Invt. Pick,Invt. Movement

    //BCUpgrade YADAVM09 Added new field Document Type2 # Document Type2


    fields
    {
        modify("Buffer No.")
        {
            CaptionML = ENU = 'Buffer No.', FRA = 'N° Tampon';
        }
        modify(Date)
        {
            CaptionML = ENU = 'Date', FRA = 'Date';
        }
        modify("Document Type")
        {
            // OptionCaption =  , Put-away, Pick, Movement, Invt. Put-away, Invt. Pick, Invt. Movement;//BC Upgrade YADAVM09

            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            OptionCaptionML = ENU = 'Requisition Line,Planned Prod. Order Comp.,Firm Planned Prod. Order Comp.,Released Prod. Order Comp.,Planning Comp.,Sales Order,Planned Prod. Order,Planning Line,Req. Worksheet Line,Firm Planned Prod. Order,Released Prod. Order,Purchase Order,Quantity at Inventory,Service Order,Transfer,Job Order,Assembly Order,Assembly Order Line,Production Forecast-Sales,Production Forecast-Component, ,Put-away,Pick,Movement,Invt. Put-away,Invt. Pick,Invt. Movement', FRA = 'Ligne demande,Composant O.F. planifié,Composant O.F. planifié ferme,Composant O.F. lancé,Composant planning,Commande vente,O.F. planifié,Ligne planning,Ligne demande achat,O.F. planifié ferme,O.F. lancé,Commande achat,Quantité en stock,Commande service,Transfert,Ordre de travail,Ordre d''assemblage,Ligne ordre d''assemblage,Prévision production-Ventes,Prévision production-Composant';

            //Unsupported feature: Change OptionString on ""Document Type"(Field 3)". Please convert manually.

        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Gross Requirement")
        {
            CaptionML = ENU = 'Gross Requirement', FRA = 'Besoin brut';
        }
        modify("Planned Receipts")
        {
            CaptionML = ENU = 'Planned Receipts', FRA = 'Réceptions prévues';
        }
        modify("Scheduled Receipts")
        {
            CaptionML = ENU = 'Scheduled Receipts', FRA = 'Réceptions planifiées';
        }
        field(50000; "Location Code FND"; Code[10])
        {
            Caption = 'Location Code';
            Description = 'HEI.01';
            TableRelation = Location;
        }
        field(50001; "Bin Code FND"; Code[20])
        {
            Caption = 'Bin Code';
            Description = 'HEI.01';
            TableRelation = IF ("Zone Code FND" = FILTER('')) Bin.Code where("Location Code" = FIELD("Location Code FND"))
            else IF ("Zone Code FND" = FILTER(<> '')) Bin.Code where("Zone Code" = FIELD("Zone Code FND"));
        }
        field(50002; "Zone Code FND"; Code[10])
        {
            Caption = 'Zone Code';
            Description = 'HEI.01';
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code FND"));
        }
        field(50003; "Scheduled Quantity FND"; Decimal)
        {
            Caption = 'Scheduled Quantity';
            Description = 'HEI.01';
        }
        //BCUpgrade YADAVM09 Added new field to update the options for base/Custom Document Type field.
        field(50004; "Document Type2 FND"; Option)
        {
            Caption = 'Document Type';
            DataClassification = SystemMetadata;
            OptionCaption = 'Requisition Line,Planned Prod. Order Comp.,Firm Planned Prod. Order Comp.,Released Prod. Order Comp.,Planning Comp.,Sales Order,Planned Prod. Order,Planning Line,Req. Worksheet Line,Firm Planned Prod. Order,Released Prod. Order,Purchase Order,Quantity at Inventory,Service Order,Transfer,Job Order,Assembly Order,Assembly Order Line,Production Forecast-Sales,Production Forecast-Component,Put-away,Pick,Movement,Invt. Put-away,Invt. Pick,Invt. Movement';
            OptionMembers = "Requisition Line","Planned Prod. Order Comp.","Firm Planned Prod. Order Comp.","Released Prod. Order Comp.","Planning Comp.","Sales Order","Planned Prod. Order","Planning Line","Req. Worksheet Line","Firm Planned Prod. Order","Released Prod. Order","Purchase Order","Quantity at Inventory","Service Order",Transfer,"Job Order","Assembly Order","Assembly Order Line","Production Forecast-Sales","Production Forecast-Component","Put-away",Pick,Movement,"Invt. Put-away","Invt. Pick","Invt. Movement";
        }
        //BCUpgrade YADAVM09 Added new field to update the options for base Document Type field.
    }
    keys
    {
        /* //BCUpgrade YADAVM09 Due to limitation, We cannot add base fields "Item No.", Date as a key in table extension
                // key(Key1; "Item No.", Date, "Location Code", "Zone Code", "Bin Code")
        // {
        // }
        */
        key(Key50000; "Location Code FND", "Zone Code FND", "Bin Code FND")//BCUpgrade YADAVM09 keys added
        {
        }
        //
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

