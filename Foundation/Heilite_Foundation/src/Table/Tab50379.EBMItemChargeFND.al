table 50379 "EBM Item Charge FND"
{
    // Heilite Navision Old Id - 50120
    // version HEI.01

    // HEI.01 RW-GAPLOG08 IBM LAZARE02 31.10.2018 # New table for EBM interface

    // BC Upgrade PATELP08>>
    // Moved table from Interface to Foundation Ext.
    // Changed name of table from "EBM Item Charge" to "EBM Item Charge FND"
    // BC Upgrade PATELP08<<
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
            // TableRelation = "Document Subtype Code".Code WHERE ("Report Selection Type"=FILTER(Sales|"Fin.Contract"));  // BC Upgrade NANDIS03 - Blocked as dependent on Aptean
        }
        field(5; "Customer Tax Group Code"; Code[20])
        {
            CaptionML = ENU = 'Customer Tax Group Code',
                        FRA = 'Code groupe taxe client';
            // TableRelation = "Drink Tax Group".Code WHERE("Source Type" = CONST(Customer));  // BC Upgrade NANDIS03 - Blocked as dependent on APtean
        }
        field(10; Type; Option)
        {
            CaptionML = ENU = 'Type',
                        FRA = 'Type';
            OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
                              FRA = ' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
            OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        }
        field(11; "No."; Code[20])
        {
            CaptionML = ENU = 'No.',
                        FRA = 'N°';
            // TableRelation = "Item Charge"."No." WHERE("Item Charge Type" = FIELD(Type));  // BC Upgrade NANDIS03 - Blocked as dependent on APtean
        }
        field(20; Usage; Option)
        {
            Caption = 'Usage';
            OptionCaption = 'Exclude From Transfer,Include As Separate Line,Summarize per No.,Summarize per Parent Item';
            OptionMembers = "Exclude From Transfer","Include As Separate Line","Summarize per No.","Summarize per Parent Item";
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document Subtype Code", "Customer Tax Group Code", Type, "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

