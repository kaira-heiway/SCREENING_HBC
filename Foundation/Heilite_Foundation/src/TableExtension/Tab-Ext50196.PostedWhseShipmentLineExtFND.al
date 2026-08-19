tableextension 50196 PostedWhseShipmentLineExtFND extends "Posted Whse. Shipment Line"
{
    // DITW15.00.00.21 DDR 13/06/2008 Added fields + sumindex primarykey
    //                                  2014079 Weight
    //                                  2014080 Cubage
    //                                Added Form property DrillDownFormID
    //                                Added key
    //                                  "Source Document,Source No."
    //                                  "Posted Source Document,Posted Source No.,Source Line No."
    //                                Change Caption of field41 "Cubage" > Caption "Volume (Cubage)"
    // DITW15.00.00.33 DDR 13/05/2009 Added fields
    //                                  2013667 Item DTax Group Code
    //                                  2013751 Src. DTax Group Code
    // DITW15.00.00.35 DLE 06/09/2009 issue 516 Added fields
    //                                  2014094 Physical Location Group Code
    // DITW15.00.00.38 DDR 01/12/2010 issue 1226 Added fields
    //                                  2014479 Correction
    // DITW15.00.00.38 DDR 11/03/2011 issue 458 Replaced caption field2014094 (dutch)
    // DITW15.00.00.39 21/06/2011 issue 1370 Bugfix TableRelation property field2013751 "Source DTax Group Code"
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields
    //                                    2014107 Route
    //                                    2014495 Delivery Sequence
    //                     02/01/2012 DIT-715 issue 185 Added fields
    //                                  2014440 Attached to Line No.
    //                     13/02/2012 DIT-715 #244
    //                                Added fields
    //                                  2014069 Shortcut Unit of Measure1 Code
    //                                  2014089 Shortcut Unit of Measure2 Code
    //                                  2014093 Shortcut Unit of Measure3 Code
    //                                Added functions GetCaptionClassUom(),ShowShortcutUomValue()

    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars

    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9

    // HEI.01 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Src. DTax Group Code" field length from 10 to 20 characters
    // HEI.02 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    //   # New fields
    // HEI.03 FDD-LB-GAPLOG03 IBM NASTAA02 17.07.2018 # Loading Note Almaza
    //   # New Field created 50008 - Print Load List Shipment
    //   # New Keys added for "Item No.", Description and "Shelf No."
    // HEI.04 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field created: 50009 - "Gate Entry No."
    // HEI.05 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    // HEI.06 CHG2095415 IBM BULIMC01 06.05.2021#new field added: 50012 -"Item Category Code"
    // HEI.07 CHG2217161 SAHAL01 02.11.2023 SPL for Returns and GR cancellations
    //   # Created New Fields: 50057 - SPL Code
    //                         50058 - SPL Name
    //                         50059 - Consumption SPL Code


    fields
    {
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
        modify("Source Document")
        {
            CaptionML = ENU = 'Source Document', FRA = 'Document origine';
            //  OptionCaptionML = ENU = ',Sales Order,,,Sales Return Order,Purchase Order,,,Purchase Return Order,,Outbound Transfer,,,,,,,,Service Order', FRA = ',Commande vente,,,Retour vente,Commande achat,,,Retour achat,,Désenlogement transfert,,,,,,,,Commande service';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Shelf No.")
        {
            CaptionML = ENU = 'Shelf No.', FRA = 'N° emplacement';
        }
        modify("Bin Code")
        {
            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
        }
        modify("Zone Code")
        {
            CaptionML = ENU = 'Zone Code', FRA = 'Code zone';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Qty. (Base)")
        {
            CaptionML = ENU = 'Qty. (Base)', FRA = 'Qté (base)';
        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify("Variant Code")
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
        }
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Délai';
        }
        modify("Destination Type")
        {
            CaptionML = ENU = 'Destination Type', FRA = 'Type destination';
            // OptionCaptionML = ENU = ' ,Customer,Vendor,Location', FRA = ' ,Client,Fournisseur,Magasin';
        }
        modify("Destination No.")
        {
            CaptionML = ENU = 'Destination No.', FRA = 'N° destination';
        }
        modify("Shipping Advice")
        {
            CaptionML = ENU = 'Shipping Advice', FRA = 'Option d''expédition';
            // OptionCaptionML = ENU = 'Partial,Complete', FRA = 'Partielle,Totale';
        }
        modify("Shipment Date")
        {
            CaptionML = ENU = 'Shipment Date', FRA = 'Date d''expédition';
        }
        modify("Posted Source Document")
        {
            CaptionML = ENU = 'Posted Source Document', FRA = 'Document origine enreg.';
            // OptionCaptionML = ENU = ' ,Posted Receipt,,Posted Return Receipt,,Posted Shipment,,Posted Return Shipment,,,Posted Transfer Shipment', FRA = ' ,Réception enreg.,,Réception retour enreg.,,Expédition enreg.,,Expédition retour enreg.,,,Réception transfert enreg.';
        }
        modify("Posted Source No.")
        {
            CaptionML = ENU = 'Posted Source No.', FRA = 'N° origine enreg.';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Whse. Shipment No.")
        {
            CaptionML = ENU = 'Whse. Shipment No.', FRA = 'N° expédition entrepôt';
        }
        modify("Whse Shipment Line No.")
        {
            CaptionML = ENU = 'Whse Shipment Line No.', FRA = 'N° ligne expédition entrep.';
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
            Caption = 'RPM Type';
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
        field(50008; "Print Load List Shipment FND"; Boolean)
        {
            Caption = 'Print Load List Shipment';
            Description = 'HEI.03';
            Editable = false;
            Enabled = false;
        }
        field(50009; "Gate Entry No. FND"; Code[20])
        {
            Caption = 'Gate Entry No.';
            Description = 'HEI.04';
            Editable = false;
            TableRelation = "Gate Entry Header FND";
        }
        field(50010; "Sequence No. FND"; Integer)
        {
            Caption = 'Sequence No.';
            Description = 'HEI.05';
        }
        field(50011; "Load No. FND"; Integer)
        {
            Caption = 'Load No.';
            Description = 'HEI.05';
        }
        field(50012; "Item Category Code FND"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
        }
        field(50057; "SPL Code FND"; Code[20])
        {
            Caption = 'SPL Code';
            Description = 'HEI.07';
            Editable = false;
            TableRelation = "Vendor SPL Relation FND"."SPL Code" where(Blocked = CONST(false));

            trigger OnValidate();
            var
                VendorSPL: Record "Vendor SPL Relation FND";
            begin
            end;
        }
        field(50058; "SPL Name FND"; Text[50])
        {
            Caption = 'SPL Name';
            Description = 'HEI.07';
            Editable = false;
        }
        field(50059; "Consumption SPL Code FND"; Code[20])
        {
            Caption = 'Consumption SPL Code';
            Description = 'HEI.07';
            Editable = false;
            TableRelation = "Vendor SPL Relation FND"."SPL Code" where(Blocked = CONST(false));
        }

        //BC Upgrade SHARMP16 Begin>>------------Drink-IT fields
        // field(2013667; "Item DTax Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Tax Group Code',
        //                 FRA = 'Code groupe taxe article';
        //     Description = 'DITW15.00.00.33';
        //     TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Item));
        // }
        // field(2013751; "Src. DTax Group Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Source Tax Group Code',
        //                 FRA = 'Code groupe taxe Source';
        //     Description = 'DITW15.00.00.33-.39 #1370,HEI.01';
        //     TableRelation = "Drink Tax Group".Code;
        // }
        // field(2014079; Cubage; Decimal)
        // {
        //     CaptionML = ENU = 'Volume (Cubage)',
        //                 FRA = 'Volume (cubage)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014080; Weight; Decimal)
        // {
        //     CaptionML = ENU = 'Weight',
        //                 FRA = 'Poids';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.21';
        // }
        // field(2014094; "Physical Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Physical Location Group Code',
        //                 FRA = 'Code groupe magasin réel';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014107; Route; Code[20])
        // {
        //     CaptionML = ENU = 'Route',
        //                 FRA = 'Itinéraire';
        //     Description = 'DITW16.00.00.40 #1002';
        //     TableRelation = Route;
        // }
        // field(2014440; "Attached to Line No."; Integer)
        // {
        //     CaptionML = ENU = 'Attached to Line No.',
        //                 FRA = 'Attaché à la ligne n°';
        //     Description = 'DITW16.00.00.40 DIT715 #185';
        //     Editable = false;
        //     TableRelation = "Warehouse Receipt Line"."Line No." where("No." = FIELD("No."),
        //                                                                "Attached to Line No." = CONST(0));
        // }
        // field(2014479; Correction; Boolean)
        // {
        //     CaptionML = ENU = 'Correction',
        //                 FRA = 'Correction';
        //     Description = 'DITW15.00.00.38 #1226';
        //     Editable = false;
        // }
        // field(2014495; "Delivery Sequence"; Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Delivery Sequence',
        //                 FRA = 'Séquence de livraison';
        //     Description = 'DITW16.00.00.40 #1002';
        //     MinValue = 0;
        // }
        //BC Upgrade SHARMP16 End<<------------Drink-IT fields
    }
    keys
    {

        //Unsupported feature: PropertyChange on ""No.","Line No."(Key)". Please convert manually.

        key(Key50000; "Source Document", "Source No.")
        {
        }
        key(Key50001; "Posted Source Document", "Posted Source No.", "Source Line No.")
        {
        }
        key(Key50002; "Item No.")
        {
        }
        key(Key50003; Description)
        {
        }
        key(Key50004; "Shelf No.")
        {
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        WhseSetup: Record "Warehouse Setup";
}

