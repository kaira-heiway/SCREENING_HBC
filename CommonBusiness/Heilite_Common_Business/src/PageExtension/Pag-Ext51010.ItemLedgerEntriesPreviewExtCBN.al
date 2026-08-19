pageextension 51010 ItemLedgerEntriesPreviewExtCBN extends "Item Ledger Entries Preview"
{
    // version NAVW110.0

    layout
    {
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the entry''s posting date.', FRA = 'Spécifie la date comptabilisation de l''écriture.';
        }
        modify("Entry Type")
        {
            ToolTipML = ENU = 'Specifies which type of transaction the entry is created from.', FRA = 'Spécifie le type de transaction à partir duquel l''écriture est créée.';
        }
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies what type of document was posted to create the item ledger entry.', FRA = 'Indique le type de document validé pour créer l''écriture comptable article.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the document number on the entry. The document is the voucher that the entry was based on, for example, a receipt.', FRA = 'Spécifie le numéro de document de l''écriture. Le document est la pièce justificative sur laquelle l''écriture a été basée, par exemple, une réception.';
        }
        modify("Document Line No.")
        {
            ToolTipML = ENU = 'Specifies the number of the line on the posted document that corresponds to the item ledger entry.', FRA = 'Indique le numéro de la ligne sur le document validé qui correspond à l''écriture comptable article.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item in the entry.', FRA = 'Spécifie le numéro de l''article dans l''écriture.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Shows the variant code for the items.', FRA = 'Affiche le code variante des articles.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry.', FRA = 'Spécifie une description de l''écriture.';
        }
        modify("Return Reason Code")
        {
            ToolTipML = ENU = 'Contains a code that explains why the item is returned.', FRA = 'Contient un code expliquant la raison du renvoi de l''article.';
        }
        modify("Global Dimension 1 Code")
        {
            ToolTipML = ENU = 'Shows the dimension value code that the entry is linked to.', FRA = 'Affiche le code section analytique lié à l''écriture.';
        }
        modify("Global Dimension 2 Code")
        {
            ToolTipML = ENU = 'Shows the dimension value code that the entry is linked to.', FRA = 'Affiche le code section analytique lié à l''écriture.';
        }
        modify("Expiration Date")
        {
            ToolTipML = ENU = 'Contains the last date that the item on the line can be used.', FRA = 'Contient la dernière date à laquelle l''article de la ligne peut être utilisé.';
        }
        modify("Serial No.")
        {
            ToolTipML = ENU = 'Contains a serial number if the posted item carries such a number.', FRA = 'Contient un numéro de série si l''article validé en porte un.';
        }
        modify("Lot No.")
        {
            ToolTipML = ENU = 'Contains a lot number if the posted item carries such a number.', FRA = 'Contient un numéro de lot si l''article validé en porte un.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Shows the code for the location that the entry is linked to.', FRA = 'Affiche le code du magasin lié à l''écriture.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the item in the item entry.', FRA = 'Spécifie le nombre d''unités de l''article dans l''écriture article.';
        }
        modify("Invoiced Quantity")
        {
            ToolTipML = ENU = 'Specifies how many units of the item on the line have been invoiced.', FRA = 'Spécifie le nombre d''unités de la ligne qui ont été facturées.';
        }
        modify("Remaining Quantity")
        {
            ToolTipML = ENU = 'Specifies the quantity that remains in inventory in the Quantity field if the entry is an increase (a purchase or positive adjustment). If the entry is a decrease (a sale or negative adjustment), the field shows the quantity that remains to be applied to by an increase entry.', FRA = 'Spécifie la quantité qui reste en stock dans le champ Quantité si l''écriture est une augmentation (un achat ou un ajustement positif). Si l''écriture est une diminution (une vente ou un ajustement négatif), le champ indique la quantité qui reste à lettrer avec une écriture d''augmentation.';
        }
        modify("Shipped Qty. Not Returned")
        {
            ToolTipML = ENU = 'Contains the quantity for this item ledger entry that was shipped and has not yet been returned.', FRA = 'Contient la quantité de cette écriture comptable article qui a été expédiée et pas encore retournée.';
        }
        modify("Reserved Quantity")
        {
            ToolTipML = ENU = 'Shows how many units of the item on the line have been reserved.', FRA = 'Affiche le nombre d''unités de l''article sur la ligne qui ont été réservées.';
        }
        modify("Qty. per Unit of Measure")
        {
            ToolTipML = ENU = 'Shows the quantity per item unit of measure.', FRA = 'Affiche la quantité par unité d''article.';
        }
        modify(SalesAmountExpected)
        {
            CaptionML = ENU = 'Sales Amount (Expected)', FRA = 'Montant vente (prévu)';
        }
        modify(SalesAmountActual)
        {
            CaptionML = ENU = 'Sales Amount (Actual)', FRA = 'Montant vente (réel)';
            ToolTipML = ENU = 'Specifies the sum of the actual sales amounts if you post.', FRA = 'Spécifie la somme des montants des ventes réelles dans le cas d''une publication.';
        }
        modify(CostAmountExpected)
        {
            CaptionML = ENU = 'Cost Amount (Expected)', FRA = 'Coût total (prévu)';
        }
        modify(CostAmountActual)
        {
            CaptionML = ENU = 'Cost Amount (Actual)', FRA = 'Coût total (réel)';
            ToolTipML = ENU = 'Specifies the sum of the actual cost amounts if you post.', FRA = 'Spécifie la somme des montants des coûts réels dans le cas d''une publication.';
        }
        modify(CostAmountNonInvtbl)
        {
            CaptionML = ENU = 'Cost Amount (Non-Invtbl.)', FRA = 'Coût total (non incorp.)';
            ToolTipML = ENU = 'Specifies the sum of the actual non-inventoriable cost amounts if you post. Typical non-inventoriable costs come from item charges.', FRA = 'Spécifie la somme des montants réels des dépenses non valorisables dans le cas d''une publication. En général, les dépenses non valorisables viennent des frais liés aux articles.';
        }
        modify(CostAmountExpectedACY)
        {
            CaptionML = ENU = 'Cost Amount (Expected) (ACY)', FRA = 'Montant coût (prévu) DR';
        }
        modify(CostAmountActualACY)
        {
            CaptionML = ENU = 'Cost Amount (Actual) (ACY)', FRA = 'Coût total (réel) DR';
        }
        modify(CostAmountNonInvtblACY)
        {
            CaptionML = ENU = 'Cost Amount (Non-Invtbl.) (ACY)', FRA = 'Coût total non incorp. DR';
        }
        modify("Completely Invoiced")
        {
            ToolTipML = ENU = 'Shows if the entry has been fully invoiced or if more posted invoices are expected. Only completely invoiced entries can be revalued.', FRA = 'Indique si l''écriture a été entièrement facturée ou si d''autres factures validées sont prévues. Seules les écritures entièrement facturées peuvent être réévaluées.';
        }
        modify(Open)
        {
            ToolTipML = ENU = 'Specifies if the entry has been fully applied to.', FRA = 'Spécifie si l''écriture a été totalement lettrée ou non.';
        }
        modify("Drop Shipment")
        {
            ToolTipML = ENU = 'Shows whether the items on the line have been shipped directly to the customer.', FRA = 'Affiche si les articles de la ligne ont été livrés directement au client.';
        }
        modify("Assemble to Order")
        {
            ToolTipML = ENU = 'Specifies if the posting represents an assemble-to-order sale.', FRA = 'Spécifie si la validation représente une vente Assembler pour commande.';
        }
        modify("Applied Entry to Adjust")
        {
            ToolTipML = ENU = 'Specifies whether there is one or more applied entries, which need to be adjusted.', FRA = 'Indique s''il existe des écritures lettrées qui nécessitent un ajustement.';
        }
        modify("Order Type")
        {
            ToolTipML = ENU = 'Specifies which type of transaction the entry is created from.', FRA = 'Spécifie le type de transaction à partir duquel l''écriture est créée.';
        }
        modify("Order No.")
        {
            ToolTipML = ENU = 'Contains the number of the order that created the entry.', FRA = 'Contient le numéro de l''ordre ayant créé l''écriture.';
        }
        modify("Order Line No.")
        {
            ToolTipML = ENU = 'Contains the line number of the order that created the entry.', FRA = 'Contient le numéro de ligne ayant créé l''écriture.';
        }
        modify("Prod. Order Comp. Line No.")
        {
            ToolTipML = ENU = 'Shows the line number of the production order component.', FRA = 'Affiche le numéro de ligne composant O.F.';
        }
        modify("Job No.")
        {
            ToolTipML = ENU = 'Contains the number of the job associated with the entry.', FRA = 'Contient le numéro du projet associé à l''écriture.';
        }
        modify("Job Task No.")
        {
            ToolTipML = ENU = 'Contains the number of the job task associated with the entry.', FRA = 'Contient le numéro de la tâche projet associée à l''écriture.';
        }
    }
    actions
    {
        modify("Ent&ry")
        {
            CaptionML = ENU = 'Ent&ry', FRA = 'É&criture';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        //BC Upgrade PATHAA02>>
        // modify("&Value Entries")
        // {
        //     CaptionML = ENU='&Value Entries',FRA='Écritures &valeur';
        //     ToolTipML = ENU='View amounts that relate to an item. Whenever you do something that changes a value for items in the inventory, like post an order, one or more value entries are added.',FRA='Affichez les montants liés à un article. Lorsque vous effectuez une modification de valeur d''articles présents dans l''inventaire (comme publier un ordre), une ou plusieurs écritures de valeurs sont ajoutées.';

        //     //Unsupported feature: Change RunPageView on ""&Value Entries"(Action 64)". Please convert manually.


        //     //Unsupported feature: Change RunPageLink on ""&Value Entries"(Action 64)". Please convert manually.

        // }
        //BC Upgrade PATHAA02 <<
        modify("&Application")
        {
            CaptionML = ENU = '&Application', FRA = '&Lettrage';
        }
        //BC Upgrade PATHAA02 >>
        // modify("Applied E&ntries")
        // {
        //     CaptionML = ENU='Applied E&ntries',FRA='É&critures lettrées';
        //     ToolTipML = ENU='View the ledger entries that have been applied to this record.',FRA='Affichez les écritures comptables qui ont été lettrées avec cet enregistrement.';
        // }
        // modify("Reservation Entries")
        // {
        //     CaptionML = ENU='Reservation Entries',FRA='Écritures réservation';
        //     ToolTipML = ENU='View all reservations for the item. For example, items can be reserved for production orders or production orders.',FRA='Affichez toutes les réservations de l''article. Par exemple, des articles peuvent être réservés pour des ordres de productions.';
        // }
        // modify("Application Worksheet")
        // {
        //     CaptionML = ENU='Application Worksheet',FRA='Feuille lettrage';
        //     ToolTipML = ENU='View item applications that are automatically created between item ledger entries during item transactions.',FRA='Affichez les lettrages article qui sont automatiquement créés entre les écritures comptables article pendant les transactions article.';
        // }
        ////BC Upgrade PATHAA02<<
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        //BC Upgrade PATHAA02>>
        // modify("Order &Tracking")
        // {
        //     CaptionML = ENU='Order &Tracking',FRA='C&haînage';
        //     ToolTipML = ENU='Tracks the connection of a supply to its corresponding demand. This can help you find the original demand that created a specific production order or purchase order.',FRA='Suit la connexion d''un approvisionnement selon sa demande correspondante. Ceci peut vous aider à trouver la demande d''origine qui a créé un ordre de production ou un bon de commande spécifique.';
        // }
        ////BC Upgrade PATHAA02<<

        //Unsupported feature: CodeModification on ""Reservation Entries"(Action 56).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowReservationEntries(TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShowReservationEntries(true);
        */
        //end;
    }


    //Unsupported feature: CodeModification on "Set(PROCEDURE 3)". Please convert manually.

    //procedure Set();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF TempItemLedgerEntry2.findset THEN
      REPEAT
        Rec := TempItemLedgerEntry2;
        INSERT;
      UNTIL TempItemLedgerEntry2.NEXT = 0;

    IF TempValueEntry2.findset THEN
      REPEAT
        TempValueEntry := TempValueEntry2;
        TempValueEntry.INSERT;
      UNTIL TempValueEntry2.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if TempItemLedgerEntry2.findset then
      repeat
        Rec := TempItemLedgerEntry2;
        INSERT;
      until TempItemLedgerEntry2.NEXT = 0;

    if TempValueEntry2.findset then
      repeat
        TempValueEntry := TempValueEntry2;
        TempValueEntry.INSERT;
      until TempValueEntry2.NEXT = 0;
    */
    //end;


    //Unsupported feature: CodeModification on "CalcAmounts(PROCEDURE 5)". Please convert manually.

    //procedure CalcAmounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesAmountExpected := 0;
    SalesAmountActual := 0;
    CostAmountExpected := 0;
    #4..7
    CostAmountNonInvtblACY := 0;

    TempValueEntry.SETFILTER("Item Ledger Entry No.",'%1',"Entry No.");
    IF TempValueEntry.findset THEN
      REPEAT
        SalesAmountExpected += TempValueEntry."Sales Amount (Expected)";
        SalesAmountActual += TempValueEntry."Sales Amount (Actual)";
        CostAmountExpected += TempValueEntry."Cost Amount (Expected)";
        CostAmountActual += TempValueEntry."Cost Amount (Actual)";
        CostAmountNonInvtbl += TempValueEntry."Cost Amount (Non-Invtbl.)";
        CostAmountExpectedACY += TempValueEntry."Cost Amount (Expected) (ACY)";
        CostAmountActualACY += TempValueEntry."Cost Amount (Actual) (ACY)";
        CostAmountNonInvtblACY += TempValueEntry."Cost Amount (Non-Invtbl.)(ACY)";
      UNTIL TempValueEntry.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
    if TempValueEntry.findset then
      repeat
    #13..20
      until TempValueEntry.NEXT = 0;
    */
    //end;

    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

