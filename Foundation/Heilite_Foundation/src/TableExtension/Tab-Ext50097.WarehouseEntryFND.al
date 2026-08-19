tableextension 50097 WarehouseEntryExtFND extends "Warehouse Entry"
{
    //    HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 # Added FIELDS Zone-Transfer, Transit-Zone, Transfer Type, Reference Line No.,Movement No.
    //   #zone validation
    //   #added new index Movement No.
    // HEI.02 FDD PRDGAP038 IBM COSTES02 07.08.2017 # Added field Quality Status
    // HEI.03 FDD-LB IBM NASTAA02 15.10.2018 # Item Availability excluding Blocked Stock
    //   # New Fields created: 50006 - Unavailable Stock (Bin)
    //                         50007 - Unavailable Stock (Quality)
    //                         50008 - Unavailable Stock

    // HEI.04 CHG2025677 IBM KUMARN15 09.08.2019
    //   # Added keys - Item No.,Bin Code,Unavailable Stock (Bin),Unavailable Stock (Quality)
    //                - Item No.,Location Code,Unavailable Stock
    //                - Location Code,Bin Code,Item No.,Variant Code,Unit of Measure Code,Lot No.,Serial No.,Quality Status
    // HEI.05 IBM MATHEJ01 25.21.2020 - #CHG2044177: Report on warehouse entries additional filter on Item category code
    //   # New Field: "Item Category Code"
    // HEI.06 IBM.AK CHG2069354-Warehouse recon report
    //  # Added blank option on the field-Source Document
    //  # Table Relation added for item Category Code field-50009
    // HEI.07 CHG2154364 SAHAL01 15.03.2023 Astro - I/F Production - ProductionOrderOperationLinePick
    //   # Created New Fields: 50010 - External Document No.
    //                         50011 - External Document No.2
    // HEI.08 CHG2258885 SAXENA03 09.07.2024 New Secondary Key & Sum index Field for warehouse entry
    //   # Added a new secondary key in table
    //   # New Secondary KEY :Item No.,Bin Code,Unavailable Stock (Bin),Unavailable Stock (Quality),Zone Code,Location Code | SumIndexFields:Quantity



    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Journal Batch Name")
        {
            CaptionML = ENU = 'Journal Batch Name', FRA = 'Nom feuille';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Registering Date")
        {
            CaptionML = ENU = 'Registering Date', FRA = 'Date enregistrement';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Zone Code")
        {

            //Unsupported feature: Change TableRelation on ""Zone Code"(Field 6)". Please convert manually.
            trigger OnBeforeValidate()
            var
                myInt: Integer;
                WHSUTILS: Codeunit "WHS-UTILS";
            begin
                //HEI.01 PRDGAP024
                IF Rec."Zone Code" = '' THEN BEGIN
                    WHSUTILS.CheckUserAuthorizedinZone("Location Code", "Zone Code");
                    VALIDATE("Bin Code", '');
                END;
                //HEI.01 PRDGAP024
            end;

        }
        modify("Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Bin Code"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
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
            //OptionCaptionML = ENU = ' ,S. Order,S. Invoice,S. Credit Memo,S. Return Order,P. Order,P. Invoice,P. Credit Memo,P. Return Order,Inb. Transfer,Outb. Transfer,Prod. Consumption,Item Jnl.,Phys. Invt. Jnl.,Reclass. Jnl.,Consumption Jnl.,Output Jnl.,BOM Jnl.,Serv. Order,Job Jnl.,Assembly Consumption,Assembly Order', FRA = ',Cde vente,Fact. vente,Avoir vente,Retour vente,Cde achat,Fact. achat,Avoir achat,Retour achat,Enlog. transf.,Désenlog. transf.,Consommation O.F.,F. article,F. inventaire,F. reclass.,F. conso.,F. prod.,F. nomencl.,Cde serv.,Feuille projet,Consommation d''assemblage,Ordre d''assemblage';

            //Unsupported feature: Change OptionString on ""Source Document"(Field 25)". Please convert manually.

        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Bin Type Code")
        {
            CaptionML = ENU = 'Bin Type Code', FRA = 'Code type emplacement';
        }
        modify(Cubage)
        {
            CaptionML = ENU = 'Cubage', FRA = 'Cubage';
        }
        modify(Weight)
        {
            CaptionML = ENU = 'Weight', FRA = 'Poids';
        }
        modify("Journal Template Name")
        {
            CaptionML = ENU = 'Journal Template Name', FRA = 'Nom modèle feuille';
        }
        modify("Whse. Document No.")
        {
            CaptionML = ENU = 'Whse. Document No.', FRA = 'N° document entrepôt';
        }
        modify("Whse. Document Type")
        {
            CaptionML = ENU = 'Whse. Document Type', FRA = 'Type document entrepôt';
            // OptionCaptionML = ENU = 'Whse. Journal,Receipt,Shipment,Internal Put-away,Internal Pick,Production,Whse. Phys. Inventory, ,Assembly', FRA = 'Feuille entrepôt,Réception,Expédition,Rangement interne,Prélèvement interne,Production,Inventaire entrepôt, ,Assemblage';
        }
        modify("Whse. Document Line No.")
        {
            CaptionML = ENU = 'Whse. Document Line No.', FRA = 'N° ligne document entrep.';
        }
        modify("Entry Type")
        {
            CaptionML = ENU = 'Entry Type', FRA = 'Type écriture';
            OptionCaptionML = ENU = 'Negative Adjmt.,Positive Adjmt.,Movement', FRA = 'Ajust. négatif,Ajust. positif,Mouvement';
        }
        modify("Reference Document")
        {
            CaptionML = ENU = 'Reference Document', FRA = 'Document référence';
            // OptionCaptionML = ENU = ' ,Posted Rcpt.,Posted P. Inv.,Posted Rtrn. Rcpt.,Posted P. Cr. Memo,Posted Shipment,Posted S. Inv.,Posted Rtrn. Shipment,Posted S. Cr. Memo,Posted T. Receipt,Posted T. Shipment,Item Journal,Prod.,Put-away,Pick,Movement,BOM Journal,Job Journal,Assembly', FRA = ' ,Récept. enreg.,Fact. achat enreg.,Récept. retour enreg.,Avoir achat enreg.,Expéd. enreg.,Fact. vente enreg.,Expéd. retour enreg.,Avoir vente enreg.,Récept. transf. enreg.,Expéd. transf. enreg.,Feuille article,Fabrication,Rangement,Prélèvement,Mouvement,Feuille nomencl.,Feuille projet,Assemblage';
        }
        modify("Reference No.")
        {
            CaptionML = ENU = 'Reference No.', FRA = 'N° référence';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Variant Code")
        {

            //Unsupported feature: Change TableRelation on ""Variant Code"(Field 5402)". Please convert manually.

            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
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
        modify("Phys Invt Counting Period Code")
        {
            CaptionML = ENU = 'Phys Invt Counting Period Code', FRA = 'Code période inventaire stock';
        }
        modify("Phys Invt Counting Period Type")
        {
            CaptionML = ENU = 'Phys Invt Counting Period Type', FRA = 'Type période inventaire';
            OptionCaptionML = ENU = ' ,Item,SKU', FRA = ' ,Article,Point de stock';
        }
        modify(Dedicated)
        {
            CaptionML = ENU = 'Dedicated', FRA = 'Dédié';
        }

        //Unsupported feature: CodeInsertion on ""Zone Code"(Field 6)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.01 PRDGAP024>>
        if "Zone Code" <> '' then begin
          WHSUTILS.CheckUserAuthorizedinZone("Location Code","Zone Code");
          VALIDATE("Bin Code",'');
        end;
        //HEI.01 PRDGAP024<<
        */
        //end;
        field(50000; "Zone-Transfer FND"; Boolean)
        {
            caption = 'Zone-Transfer';
            Description = 'HEI.01 PRDGAP024';
        }
        field(50001; "Transit-Zone FND"; Boolean)
        {
            caption = 'Transit-Zone';
            Description = 'HEI.01 PRDGAP024';
        }
        field(50002; "Transfer Type FND"; Option)
        {
            caption = 'Transfer Type';
            Description = 'HEI.01 PRDGAP024';
            OptionMembers = " ",Shipment,Receipt;
        }
        field(50003; "Reference Line No. FND"; Integer)
        {
            caption = 'Reference Line No.';
            Description = 'HEI.01 PRDGAP024';
        }
        field(50004; "Movement No. FND"; Code[20])
        {
            caption = 'Movement No.';
            Description = 'HEI.01 PRDGAP024';
        }
        //PATHAA02  GAP014_DTW, IBM GAP DTW 43 >>
        field(50005; "Quality Status FND"; Option)
        {
            Caption = 'Quality Status';
            Description = 'HEI.02 PRDGAP038';
            OptionCaption = 'Quality Hold,Unrestricted,Blocked';
            OptionMembers = "Quality Hold",Unrestricted,Blocked;
            Enabled = false; // Re-enabled temporarily and kept disabled to avoid schema synchronization and dependent extension deployment issues.
        }
        //PATHAA02  GAP014_DTW, IBM GAP DTW 43 <<
        field(50006; "Unavailable Stock (Bin) FND"; Boolean)
        {
            Caption = 'Unavailable Stock (Bin)';
            Description = 'HEI.03';
        }
        field(50007; "Unavail. Stock (Quality) FND"; Boolean)
        {
            caption = 'Unavailable Stock (Quality)';
            Description = 'HEI.03';
        }
        field(50008; "Unavailable Stock FND"; Boolean)
        {
            Caption = 'Unavailable Stock';
            Description = 'HEI.03';
            Editable = false;
        }
        field(50009; "Item Category Code FND"; Code[20])
        {
            caption = 'Item Category Code';
            CalcFormula = Lookup(Item."Item Category Code" where("No." = FIELD("Item No.")));
            Description = 'HEI.05';
            FieldClass = FlowField;
            TableRelation = "Item Category";
        }
        field(50010; "External Document No. FND"; Code[35])
        {
            Caption = 'External Document No.';
            Description = 'HEI.07';
        }
        field(50011; "External Document No.2 FND"; Code[35])
        {
            Caption = 'External Document No.2';
            Description = 'HEI.07';
        }
        //PATHAA02  GAP014_DTW, IBM GAP DTW 43 >>
        field(50012; "Inspection Status FND"; Code[10])
        {
            Caption = 'Inspection Status';
            Description = 'DTWGAP43';
        }
        //PATHAA02  GAP014_DTW, IBM GAP DTW 43 <<
        //BC Upgrade KAMNAY01>>>>
        // field(2034983;"Work Order No.";Code[20])
        // {
        //     CaptionML = ENU='Work Order No.',
        //                 FRA='N° cmde. d''intervention';
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
        //BC Upgrade KAMNAY01<<<<
    }
    keys
    {
        key(Key10; "Location Code", "Bin Code", "Item No.", "Expiration Date", "Entry No.")
        {
        }
        key(Key11; "Location Code", "Bin Code", "Item No.", "Expiration Date", "Registering Date")
        {
        }
        key(Key12; "Location Code", "Item No.", "Expiration Date", "Registering Date")
        {
        }
        key(Key13; "Expiration Date", "Location Code", "Variant Code", "Bin Code", "Item No.", "Lot No.", "Serial No.")
        {
            SumIndexFields = "Qty. (Base)";
        }
        // key(Key14;"Bin Code","Location Code","Work Order No.","Item No.")
        // {
        //     SumIndexFields = "Qty. (Base)",Cubage,Weight;
        // }
        key(Key6; "Whse. Document Type", "Whse. Document No.", "Whse. Document Line No.")
        {
        }
        //BC Upgrade KAMNAY01>>>>
        // key(Key7;"Item No.","Bin Code","Location Code","Variant Code","Registering Date")
        // {
        //     SumIndexFields = "Qty. (Base)";
        // }
        //BC Upgrade KAMNAY01<<<<
        key(Key8; "Movement No. FND")
        {
        }
        //BC Upgrade KAMNAY01>>>>
        // key(Key9;"Item No.","Bin Code","Unavailable Stock (Bin)","Unavailable Stock (Quality)")
        // {
        //     SumIndexFields = Quantity;
        // }
        // key(Key10;"Item No.","Location Code","Unavailable Stock")
        // {
        //     SumIndexFields = Quantity;
        // }
        // key(Key11;"Location Code","Bin Code","Item No.","Variant Code","Unit of Measure Code","Lot No.","Serial No.","Quality Status")
        // {
        //     SumIndexFields = "Qty. (Base)";
        // }
        // key(Key12;"Item No.","Bin Code","Unavailable Stock (Bin)","Unavailable Stock (Quality)","Zone Code","Location Code")
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


    var
    // WHSUTILS : Codeunit "WHS-UTILS"; //BC Upgrade KAMNAY01
}

