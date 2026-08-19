tableextension 50156 PurchCommentLineExtFND extends "Purch. Comment Line"
{
    // version NAVW17.00,DITW18.00.07
    // DITW17.00.02 VSC 26/05/2016 DIT-770 #1970 Add Fields "Print On Purchase Order", "Print On Delivery Note"
    // HEI.01 FDD-HT678,HT679 IBM SURYAS01 20.08.2019
    // # Created New fields - "Country of Origin","Shipment Annotation" & "Mode Of Packing"
    //HEI.02 Defect # 4875 IBM.GUNERE01 05.12.2019 # "Mode of Shipment" field added

    fields
    {
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            // OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Receipt,Posted Invoice,Posted Credit Memo,Posted Return Shipment', FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour,Réception,Facture enregistrée,Avoir enregistré,Expédition retour enregistrée';
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify(Date)
        {
            CaptionML = ENU = 'Date', FRA = 'Date';
        }
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("Document Line No.")
        {
            CaptionML = ENU = 'Document Line No.', FRA = 'N° ligne document';
        }
        field(50000; "Country of Origin FND"; Boolean)
        {
            caption = 'Country of Origin';
            Description = 'HEI.01';
        }
        field(50001; "Shipment Annotation FND"; Boolean)
        {
            caption = 'Shipment Annotation';
            Description = 'HEI.01';
        }
        field(50002; "Mode of Packing FND"; Boolean)
        {
            caption = 'Mode of Packing';
            Description = 'HEI.01';
        }
        field(50003; "Mode of Shipment FND"; Boolean)
        {
            caption = 'Mode of Shipment';
            Description = 'HEI.02';
        }

        // BC Upgrade Priya >> DrinkIT fields are blocked.
        // field(2014414;"Print On Delivery Note";Boolean)
        // {
        //     CaptionML = ENU='Delivery Note',
        //                 FRA='Note de livraison';
        //     Description = 'DITW17.00.02 DIT-770 #1970';
        // }
        // field(2014415;"Print On Purchase Order";Boolean)
        // {
        //     CaptionML = ENU='Purchase Order',
        //                 FRA='Commande achat';
        //     Description = 'DITW17.00.02 DIT-770 #1970';
        // }
        // BC Upgrade Priya << DrinkIT fields are blocked.
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

