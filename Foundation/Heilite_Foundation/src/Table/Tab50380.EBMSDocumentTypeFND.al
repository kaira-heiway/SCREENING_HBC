table 50380 "EBMS Document Type FND"
{
    // Heilite Navision Old Id - 50170
    // version HEI.01

    // HEI.01 CHG2151260-HB2788 SOICAD02 08.11.2022 Object created
    // BC Upgrade SHUKLP03 >> Document subtype table relation added.

    // BC Upgrade PATELP08>>
    // Moved table from Interface to Foundation Ext.
    // Changed name of table from "EBMS Document Type" to "EBMS Document Type FND"
    // BC Upgrade PATELP08<<
    Caption = 'EBMS Document Type';

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
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales | "Fin.Contract"));  // BC Upgrade SHUKLP03
        }
        field(5; "Customer Tax Group Code"; Code[20])
        {
            CaptionML = ENU = 'Customer Tax Group Code',
                        FRA = 'Code groupe taxe client';
            // TableRelation = "Drink Tax Group".Code WHERE("Source Type" = CONST(Customer));  // BC Upgrade NANDIS03 - Blocked due to Aptean
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

