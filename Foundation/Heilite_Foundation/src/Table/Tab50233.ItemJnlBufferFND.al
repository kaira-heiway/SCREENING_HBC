table 50233 "Item Jnl. Buffer FND"
{
    // version HEI.01

    // HEI.01 CHG2140470 SAHAL01 14.09.2022 # Created New Table: 50233 - Item Jnl. Buffer

    Caption = 'Item Jnl. Buffer';

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Description = 'HEI.01';
            Editable = false;
        }
        field(2; "Journal Template Name"; Code[10])
        {
            CaptionML = ENU = 'Journal Template Name',
                        FRA = 'Nom modèle feuille';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Item Journal Template";
        }
        field(3; "Journal Batch Name"; Code[10])
        {
            CaptionML = ENU = 'Journal Batch Name',
                        FRA = 'Nom feuille';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(4; "Posting Date"; Date)
        {
            CaptionML = ENU = 'Posting Date',
                        FRA = 'Date comptabilisation';
            Description = 'HEI.01';
        }
        field(5; "Entry Type"; Option)
        {
            CaptionML = ENU = 'Entry Type',
                        FRA = 'Type écriture';
            Description = 'HEI.01';
            OptionCaptionML = ENU = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output',
                              FRA = 'Achat,Vente,Positif (ajust.),Négatif (ajust.),Transfert,Consommation,Production, ,Consommation d''assemblage,Résultat d''assemblage';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(6; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                        FRA = 'N° document';
            Description = 'HEI.01';
        }
        field(7; "Source Type"; Option)
        {
            CaptionML = ENU = 'Source Type',
                        FRA = 'Type origine';
            Description = 'HEI.01';
            Editable = false;
            OptionCaptionML = ENU = ' ,Customer,Vendor,Item',
                              FRA = ' ,Client,Fournisseur,Article';
            OptionMembers = " ",Customer,Vendor,Item;
        }
        field(8; "Source No."; Code[20])
        {
            CaptionML = ENU = 'Source No.',
                        FRA = 'N° origine';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = IF ("Source Type" = CONST(Customer)) Customer
            else IF ("Source Type" = CONST(Vendor)) Vendor
            else IF ("Source Type" = CONST(Item)) Item;
        }
        field(9; "Source Code"; Code[10])
        {
            CaptionML = ENU = 'Source Code',
                        FRA = 'Code journal';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Source Code";
        }
        field(10; "Item No."; Code[20])
        {
            CaptionML = ENU = 'Item No.',
                        FRA = 'N° article';
            Description = 'HEI.01';
            TableRelation = Item;
        }
        field(11; Description; Text[50])
        {
            CaptionML = ENU = 'Description',
                        FRA = 'Désignation';
            Description = 'HEI.01';
            Editable = false;
        }
        field(12; "Unit of Measure Code"; Code[10])
        {
            CaptionML = ENU = 'Unit of Measure Code',
                        FRA = 'Code unité';
            Description = 'HEI.01';
            TableRelation = "Item Unit of Measure".Code where("Item No." = FIELD("Item No."));
        }
        field(13; "Qty. per Unit of Measure"; Decimal)
        {
            CaptionML = ENU = 'Qty. per Unit of Measure',
                        FRA = 'Quantité par unité';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.01';
            Editable = false;
            InitValue = 1;
        }
        field(14; Quantity; Decimal)
        {
            CaptionML = ENU = 'Quantity',
                        FRA = 'Quantité';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.01';
        }
        field(15; "Quantity (Base)"; Decimal)
        {
            CaptionML = ENU = 'Quantity (Base)',
                        FRA = 'Quantité (base)';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.01';
        }
        field(17; "Variant Code"; Code[10])
        {
            CaptionML = ENU = 'Variant Code',
                        FRA = 'Code variante';
            Description = 'HEI.01';
            TableRelation = "Item Variant".Code where("Item No." = FIELD("Item No."));
        }
        field(18; "Location Code"; Code[10])
        {
            CaptionML = ENU = 'Location Code',
                        FRA = 'Code magasin';
            Description = 'HEI.01';
        }
        field(19; "Zone Code"; Code[10])
        {
            Description = 'HEI.01';
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"),
                                             "Use As In-Transit FND" = FILTER(false));
        }
        field(20; "Bin Code"; Code[20])
        {
            CaptionML = ENU = 'Bin Code',
                        FRA = 'Code emplacement';
            Description = 'HEI.01';
        }
        field(21; "Lot No."; Code[20])
        {
            CaptionML = ENU = 'Lot No.',
                        FRA = 'N° lot';
            Description = 'HEI.01';
            Editable = false;
        }
        field(22; "Expiration Date"; Date)
        {
            CaptionML = ENU = 'Expiration Date',
                        FRA = 'Date d''expiration';
            Description = 'HEI.01';
        }
        field(26; "Order Type"; Option)
        {
            CaptionML = ENU = 'Order Type',
                        FRA = 'Type de commande';
            Description = 'HEI.01';
            Editable = false;
            OptionCaptionML = ENU = ' ,Production,Transfer,Service,Assembly',
                              FRA = ' ,Production,Transfert,Service,Assemblage';
            OptionMembers = " ",Production,Transfer,Service,Assembly;
        }
        field(27; "Order No."; Code[20])
        {
            CaptionML = ENU = 'Order No.',
                        FRA = 'N° commande';
            Description = 'HEI.01';
            TableRelation = IF ("Order Type" = CONST(Production)) "Production Order"."No." where(Status = CONST(Released));
        }
        field(28; "Order Line No."; Integer)
        {
            CaptionML = ENU = 'Order Line No.',
                        FRA = 'N° ligne commande';
            Description = 'HEI.01';
            TableRelation = IF ("Order Type" = CONST(Production)) "Prod. Order Line"."Line No." where(Status = CONST(Released),
                                                                                                     "Prod. Order No." = FIELD("Order No."));
        }
        field(29; "Prod. Order Comp. Line No."; Integer)
        {
            CaptionML = ENU = 'Prod. Order Comp. Line No.',
                        FRA = 'N° ligne composant O.F.';
            Description = 'HEI.01';
            TableRelation = IF ("Order Type" = CONST(Production)) "Prod. Order Component"."Line No." where(Status = CONST(Released),
                                                                                                          "Prod. Order No." = FIELD("Order No."),
                                                                                                          "Prod. Order Line No." = FIELD("Order Line No."));
        }
        field(30; "Order Date"; Date)
        {
            CaptionML = ENU = 'Order Date',
                        FRA = 'Date commande';
            Description = 'HEI.01';
        }
        field(31; "User ID"; Code[50])
        {
            CaptionML = ENU = 'User ID',
                        FRA = 'Code utilisateur';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

