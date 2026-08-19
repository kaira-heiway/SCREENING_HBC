table 54003 "Actual Cost Calculation DTW"
{
    // version HEI.01
    // HEI.01 FDD-BPMGAP BRD HB398 IBM NASTAA02 20.11.2019 # Actual Product Costing
    //   # New Table created to store Actual Product Cost Calculations
    // HEI.02 FDD-BPMGAP BRD HB398 IBM BULIMC01 22.01.2020 # Actual Product Costing
    //   # new fields added: "Description", "Type", Subtotal Consumption
    //   # "Description" field changed to "Description ILE"

    //  BC Upgrade KUMARS145 Nav ID Table 50160	"Actual Cost Calculation"

    Caption = 'Actual Product Cost Calculation';
    DrillDownPageID = "License Permissions";
    LookupPageID = "License Permissions";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            CaptionML = ENU = 'Entry No.',
                        FRA = 'N° séquence';
            Editable = false;
            NotBlank = true;
        }
        field(2; "Item No."; Code[20])
        {
            CaptionML = ENU = 'Item No.',
                        FRA = 'N° article';
            Editable = false;
            TableRelation = Item;
        }
        field(3; "Posting Date"; Date)
        {
            CaptionML = ENU = 'Posting Date',
                        FRA = 'Date comptabilisation';
            Editable = false;
        }
        field(4; "Entry Type"; Option)
        {
            CaptionML = ENU = 'Entry Type',
                        FRA = 'Type écriture';
            Editable = false;
            OptionCaptionML = ENU = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output',
                              FRA = 'Achat,Vente,Positif (ajust.),Négatif (ajust.),Transfert,Consommation,Production, ,Consommation d''assemblage,Résultat d''assemblage';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(5; "Document Type"; Option)
        {
            CaptionML = ENU = 'Document Type',
                        FRA = 'Type document';
            Editable = false;
            OptionCaptionML = ENU = ' ,Sales Shipment,Sales Invoice,Sales Return Receipt,Sales Credit Memo,Purchase Receipt,Purchase Invoice,Purchase Return Shipment,Purchase Credit Memo,Transfer Shipment,Transfer Receipt,Service Shipment,Service Invoice,Service Credit Memo,Posted Assembly,,,,,Service Receipt,Service P.Invoice,Service P.Credit Memo',
                              FRA = ' ,Expédition vente,Facture vente,Réception retour vente,Avoir vente,Réception achat,Facture achat,Expédition retour achat,Avoir achat,Expédition transfert,Réception transfert,Expédition service,Facture service,Avoir service,Assemblage validé,,,,,Réception service,Facture service achat,Avoir service achat';
            OptionMembers = " ","Sales Shipment","Sales Invoice","Sales Return Receipt","Sales Credit Memo","Purchase Receipt","Purchase Invoice","Purchase Return Shipment","Purchase Credit Memo","Transfer Shipment","Transfer Receipt","Service Shipment","Service Invoice","Service Credit Memo","Posted Assembly",,,,,"Service Receipt","Service P.Invoice","Service P.Credit Memo";
        }
        field(6; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                        FRA = 'N° document';
            Editable = false;
        }
        field(7; "Description ILE"; Text[50])
        {
            CaptionML = ENU = 'Description ILE',
                        FRA = 'Désignation';
            Editable = false;
        }
        field(8; "Location Code"; Code[10])
        {
            CaptionML = ENU = 'Location Code',
                        FRA = 'Code magasin';
            Editable = false;
            TableRelation = Location;
        }
        field(12; Quantity; Decimal)
        {
            CaptionML = ENU = 'Quantity',
                        FRA = 'Quantité';
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(13; "Item Category Code"; Code[20])
        {
            CaptionML = ENU = 'Item Category Code',
                        FRA = 'Code catégorie article';
            Editable = false;
            TableRelation = "Item Category";
        }
        field(14; "Order Type"; Option)
        {
            CaptionML = ENU = 'Order Type',
                        FRA = 'Type de commande';
            Editable = false;
            OptionCaptionML = ENU = ' ,Production,Transfer,Service,Assembly',
                              FRA = ' ,Production,Transfert,Service,Assemblage';
            OptionMembers = " ",Production,Transfer,Service,Assembly;
        }
        field(20; "Item Ledger Entry Type"; Option)
        {
            CaptionML = ENU = 'Item Ledger Entry Type',
                        FRA = 'Type écriture comptable article';
            Editable = false;
            OptionCaptionML = ENU = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output',
                              FRA = 'Achat,Vente,Positif (ajust.),Négatif (ajust.),Transfert,Consommation,Production, ,Consommation d''assemblage,Résultat d''assemblage';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(21; "Item Ledger Entry No."; Integer)
        {
            CaptionML = ENU = 'Item Ledger Entry No.',
                        FRA = 'N° écriture comptable article';
            Editable = false;
            TableRelation = "Item Ledger Entry";
        }
        field(25; "Order Type Value Entry"; Option)
        {
            CaptionML = ENU = 'Order Type Value Entry',
                        FRA = 'Type de commande';
            Editable = false;
            OptionCaptionML = ENU = ' ,Production,Transfer,Service,Assembly',
                              FRA = ' ,Production,Transfert,Service,Assemblage';
            OptionMembers = " ",Production,Transfer,Service,Assembly;
        }
        field(28; "Entry Type Value Entry"; Option)
        {
            CaptionML = ENU = 'Entry Type Value Entry',
                        FRA = 'Type écriture';
            Editable = false;
            OptionCaptionML = ENU = ' ,Direct Cost,Revaluation,Rounding,Indirect Cost,Variance',
                              FRA = 'Coût direct,Réévaluation,Arrondi,Coût indirect,Écart';
            OptionMembers = " ","Direct Cost",Revaluation,Rounding,"Indirect Cost",Variance;
        }
        field(30; "Source Type Value Entry"; Option)
        {
            CaptionML = ENU = 'Source Type Value Entry',
                        FRA = 'Type origine';
            Editable = false;
            OptionCaptionML = ENU = ' ,Customer,Vendor,Item',
                              FRA = ' ,Client,Fournisseur,Article';
            OptionMembers = " ",Customer,Vendor,Item;
        }
        field(31; "Source No. Value Entry"; Code[20])
        {
            CaptionML = ENU = 'Source No. Value Entry',
                        FRA = 'N° origine';
            Editable = false;
            TableRelation = IF ("Source Type Value Entry" = CONST(Customer)) Customer
            ELSE IF ("Source Type Value Entry" = CONST(Vendor)) Vendor
            ELSE IF ("Source Type Value Entry" = CONST(Item)) Item;
        }
        field(33; "Cost Amount (Actual) VE"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Cost Amount (Actual) Value Entry',
                        FRA = 'Coût total (réel)';
            Editable = false;
        }
        field(34; "Cost Amount (Purchase) VE"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Cost Amount (Purchase) Value Entry',
                        FRA = 'Coût total (réel)';
            Editable = false;
        }
        field(35; "Related Value Entry No."; Integer)
        {
            CaptionML = ENU = 'Related Value Entry No.',
                        FRA = 'N° séquence';
            Editable = false;
            TableRelation = "Value Entry";
        }
        field(36; "Std. Cost (BUoM)"; Decimal)
        {
            Editable = false;
        }
        field(37; "Item No. of Source No."; Code[20])
        {
            Caption = 'Item No. linked to Source No.';
            TableRelation = Item;
        }
        field(40; "Previous Actual Cost BUoM"; Decimal)
        {
            Editable = false;
        }
        field(41; "Calculated Actual Cost"; Decimal)
        {
            Editable = false;
        }
        field(43; "Valued Quantity VE"; Decimal)
        {
            CaptionML = ENU = 'Valued Quantity Value Entry',
                        FRA = 'Quantité';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(44; "Capacity Ledg Entry No. VE"; Integer)
        {
            Caption = 'Capacity Ledger Entry No. Value Entry';
            Editable = false;
        }
        field(50; "Calculation Type"; Option)
        {
            Caption = 'Calculation Type';
            Editable = false;
            OptionCaption = '" ,Negatives ILE,Transfers ILE,Positives VE,Purchases VE,Production Orders Not Consumption VE,Production Orders Conspumtion VE"';
            OptionMembers = " ","Negatives ILE","Transfers ILE","Positives VE","Purchases VE","Production Orders Not Consumption VE","Production Orders Conspumtion VE";
        }
        field(51; "Total Actual Product Cost Line"; Boolean)
        {
            Editable = false;
        }
        field(55; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            Editable = false;
        }
        field(56; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            Editable = false;
        }
        field(60; "Use Std Cost SKU"; Boolean)
        {
        }
        field(61; "Calculation Corrected"; Boolean)
        {
        }
        field(62; Description; Text[50])
        {
            CaptionML = ENU = 'Description',
                        FRA = 'Désignation';
            Editable = false;
        }
        field(63; Type; Option)
        {
            Caption = 'Type';
            Editable = false;
            OptionMembers = " ",Item,Source;
        }
        field(64; "Subtotal Consumption"; Boolean)
        {
            Description = 'HEI.02';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

