table 58014 "Cash Van Sales Interf. Stp INT"
{
    // Heilite Navision Old Id - 50065
    // version HEI.01


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(4; "CVS Currency Request Interface"; Code[20])
        {
            Caption = 'Cash Van Sales Currency Request Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(5; "CVS Curr Exch. Rate Req Interf"; Code[20])
        {
            Caption = 'Cash Van Sales Currency Exch. Rate Request Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(6; "CVS Route Request Interface"; Code[20])
        {
            Caption = 'Cash Van Sales Route Request Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(7; "CVS SalesP/Purch. Req. Interf"; Code[20])
        {
            Caption = 'Cash Van Sales SalesP/Purchaser Request Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(8; "CVS Customer Request Interface"; Code[20])
        {
            Caption = 'Cash Van Sales Customer Request Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(9; "CVS Item Request Interface"; Code[20])
        {
            Caption = 'Cash Van Sales Item Request Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(10; "CVS Sales Price Request Interf"; Code[20])
        {
            Caption = 'Cash Van Sales Sales Price Request Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(11; "CVS Brand Request Interface"; Code[20])
        {
            Caption = 'Cash Van Sales Brand Request Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(12; "CVS Transfer Orders Interface"; Code[20])
        {
            Caption = 'Cash Van Sales Transfer Orders Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(13; "CVS Sales Orders Interface"; Code[20])
        {
            Caption = 'Cash Van Sales Sales Orders Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(15; "CVS Cust Price List Req Interf"; Code[20])
        {
            Caption = 'CVS Customer Price List Request Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(16; "CVS Salesman Cust Req Interf"; Code[20])
        {
            Caption = 'CVS Salesman Customer Request Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(17; "CVS Product Gen. Prod. Posting"; Text[50])
        {
            Caption = 'Item Gen. Product Posting Gr. Export';
            Description = 'HEI.01';
        }
        field(18; "CVS Transfer Order Interf"; Code[20])
        {
            Caption = 'Cash Van Sales Transfer Order Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(20; "CVS Cash Receipt Interf"; Code[20])
        {
            Caption = 'Cash Van Sales Cash Receipt Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(21; "CVS Cash Receipt Jnl. Template"; Code[10])
        {
            Caption = 'Cash Van Sales Cash Receipt Jnl. Template';
            Description = 'HEI.01';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(22; "CVS Cash Receipt Jnl. Batch"; Code[10])
        {
            Caption = 'Cash Van Sales Cash Receipt Jnl. Batch';
            Description = 'HEI.01';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("CVS Cash Receipt Jnl. Template"));
        }
        field(25; "CVS Currency Response Interf."; Code[20])
        {
            Caption = 'Cash Van Sales Currency Response Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(26; "CVS Curr Exch. Rate Res Interf"; Code[20])
        {
            Caption = 'Cash Van Sales Currency Exch. Rate Response Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(27; "CVS Route Response Interface"; Code[20])
        {
            Caption = 'Cash Van Sales Route Response Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(28; "CVS SalesP/Purch. Resp. Interf"; Code[20])
        {
            Caption = 'Cash Van Sales SalesP/Purchaser Response Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(29; "CVS Customer Respons Interface"; Code[20])
        {
            Caption = 'Cash Van Sales Customer Response Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(30; "CVS Item Response Interface"; Code[20])
        {
            Caption = 'Cash Van Sales Item Request Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(31; "CVS Sales Price Resp Interf"; Code[20])
        {
            Caption = 'Cash Van Sales Sales Price Response Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(32; "CVS Brand Response Interface"; Code[20])
        {
            Caption = 'Cash Van Sales Brand Response Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(33; "CVS Cust Price List Res Interf"; Code[20])
        {
            Caption = 'CVS Customer Price List Response Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(34; "CVS Salesman Cust Resp Interf"; Code[20])
        {
            Caption = 'CVS Salesman Customer Response Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(35; "CVS WarehouseProduct Req Inter"; Code[20])
        {
            Caption = 'CVS WarehouseProduct Request Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(36; "CVS WarehouseProduct Res Inter"; Code[20])
        {
            Caption = 'CVS WarehouseProduct Response Interface';
            Description = 'HEI.01';
            TableRelation = "Interface Setup INT";
        }
        field(100; "Item Category Filter"; Text[100])
        {
            Caption = 'Item Category Filter';
            Description = 'HEI.01';
        }
        field(101; "Customer Price Group Code"; Code[20])
        {
            Caption = 'Customer Price Group Code';
            Description = 'HEI.01';
            TableRelation = "Customer Price Group".Code;
        }
        field(102; "Transfer-from Code"; Code[20])
        {
            Caption = 'Transfer-from Code';
            Description = 'HEI.01';
            TableRelation = Location;
        }
        field(103; "Movement Type Dimension Code"; Code[20])
        {
            Caption = 'Movement Type Dimension Code';
            Description = 'HEI.01';
            TableRelation = Dimension.Code;
        }
        field(104; "Movement Type Dimension Value"; Code[20])
        {
            Description = 'HEI.01';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Movement Type Dimension Code"));
        }
        field(105; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            Description = 'HEI.01';
            TableRelation = "G/L Account"."No.";
        }
        field(106; "Account Type"; Option)
        {
            Caption = 'Account Type';
            Description = 'HEI.01';
            OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner',
                              FRA = 'Général,Client,Fournisseur,Banque,Immobilisation,Partenaire IC';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(107; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            Description = 'HEI.01';
            OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner',
                              FRA = 'Général,Client,Fournisseur,Banque,Immobilisation,Partenaire IC';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(108; "In-Transit Code"; Code[10])
        {
            Caption = 'In-Transit Code';
            Description = 'HEI.01';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(true));
        }
        field(109; Type; Option)
        {
            Caption = 'Type';
            Description = 'HEI.01';
            OptionCaptionML = ENU = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)',
                              FRA = ' ,Compte général,Article,Ressource,Immobilisation,Frais annexes';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(110; Status; Option)
        {
            CaptionML = ENU = 'Status',
                        FRA = 'Statut';
            Description = 'HEI.01';
            Editable = false;
            OptionCaptionML = ENU = 'Open,Released',
                              FRA = 'Ouvert,Lancé';
            OptionMembers = Open,Released;
        }
        field(111; "Document Type"; Option)
        {
            CaptionML = ENU = 'Document Type',
                        FRA = 'Type document';
            Description = 'HEI.01';
            OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order',
                              FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(112; "SO G/L Account Difference"; Code[20])
        {
            Caption = 'Sales Order g/l account difference';
            Description = 'HEI.01';
            TableRelation = "G/L Account"."No.";
        }
        field(113; "Max Order Difference Amt."; Decimal)
        {
            Caption = 'Max. Order Difference Amount (LCY)';
            Description = 'HEI.01';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

