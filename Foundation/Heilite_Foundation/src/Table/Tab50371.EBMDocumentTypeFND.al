table 50371 "EBM Document Type FND"
{
    // Heilite Navision Old Id - 50073
    // version HEI.01

    // HEI.01 RW-GAPLOG08 IBM LAZARE02 31.10.2018 # New table for EBM interface

    // BC UPGRADE PATELS08 >>
    // # Table moved from INTERFACES to Foundation Layer
    // # Table name changed from "EBM Document Type" to "EBM Document Type FND"
    // BC UPGRADE PATELS08 <<

    Caption = 'EBM Document Type';

    fields
    {
        field(1; "Document Type"; Option)
        {
            CaptionML = ENU = 'Document Type',
                        FRA = 'Type document';
            OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order',
                              FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Document Subtype Code"; Code[10])
        {
            CaptionML = ENU = 'Document Subtype Code',
                        FRA = 'Code Sous-Type Document';
            //TableRelation = "Document Subtype Code".Code WHERE ("Report Selection Type"=FILTER(Sales|"Fin.Contract"));  // BC Upgrade NANDIS03 - Blocked as dependent on APtean
        }
        field(5; "Customer Tax Group Code"; Code[20])
        {
            CaptionML = ENU = 'Customer Tax Group Code',
                        FRA = 'Code groupe taxe client';
            // TableRelation = "Drink Tax Group".Code WHERE("Source Type" = CONST(Customer));  // BC Upgrade NANDIS03 - Blocked as dependent on APtean
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document Subtype Code", "Customer Tax Group Code")
        {
        }
    }

    fieldgroups
    {
    }
}

