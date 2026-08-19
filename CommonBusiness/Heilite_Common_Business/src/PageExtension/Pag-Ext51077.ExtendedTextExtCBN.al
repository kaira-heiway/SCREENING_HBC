pageextension 51077 pageextension50476CBN extends "Extended Text"
{
    //    DITW15.00.00.20 DDR 04/06/2008 Drink-it Reporting functionnalities
    //                                Added fields "Sales Shipment","Sales Return Receipt","Purchase Receipt","Purchase Return Shipment"
    // DITW15.00.00.23 DDR 28/07/2008 Updated Codeunit after renumbering of fields into table279 Extended Text Header
    //                                  "Sales Shipment","Sales Return Receipt","Purchase Receipt","Purchase Return Shipment"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.02  FDD-LB-GAPLOG02 IBM NAIKH01 17.11.2018 # Transfer Order
    //   # New Field added: Print on Picklist
    // HEI.03 HT2111 - CHG2105023 IBM NASTAA02 08.04.2021 # Customer Statement of Account Congo
    //   # New Field added: Print on Customer Statement

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Language Code")
        {
            ToolTipML = ENU = 'Specifies the language code of the extended text.', FRA = 'Spécifie le code langue du texte étendu.';
        }
        modify("All Language Codes")
        {
            ToolTipML = ENU = 'Specifies whether the text should be used for all language codes. If a language code has been chosen in the Language Code field, it will be overruled by this function.', FRA = 'Spécifie si le texte doit être utilisé pour tous les codes langue. Si un code langue a été choisi dans le champ Code langue, cette fonction prévaut.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the content of the extended item description.', FRA = 'Spécifie le contenu de la description plus longue.';
        }
        modify("Starting Date")
        {
            ToolTipML = ENU = 'Specifies a date from which the text will be used on the item, account, resource or standard text.', FRA = 'Spécifie une date à partir de laquelle le texte est utilisé pour l''article, le compte, la ressource ou le texte standard.';
        }
        modify("Ending Date")
        {
            ToolTipML = ENU = 'Specifies a date on which the text will no longer be used on the item, account, resource or standard text.', FRA = 'Spécifie une date à laquelle le texte ne sera plus utilisé pour l''article, le compte, la ressource ou le texte standard.';
        }
        modify(Sales)
        {
            CaptionML = ENU = 'Sales', FRA = 'Ventes';
        }
        modify("Sales Quote")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on sales quotes.', FRA = 'Spécifie si le texte est disponible sur les devis.';
        }
        modify("Sales Blanket Order")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on sales blanket orders.', FRA = 'Spécifie si le texte est disponible sur les commandes ouvertes vente.';
        }
        modify("Sales Order")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on sales orders.', FRA = 'Spécifie si le texte est disponible sur les commandes vente.';
        }
        modify("Sales Invoice")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on sales invoices.', FRA = 'Spécifie si le texte est disponible sur les factures vente.';
        }
        modify("Sales Return Order")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on sales return orders.', FRA = 'Spécifie si le texte est disponible sur les retours vente.';
        }
        modify("Sales Credit Memo")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on sales credit memos.', FRA = 'Spécifie si le texte est disponible sur les avoirs vente.';
        }
        modify(Reminder)
        {
            ToolTipML = ENU = 'Specifies whether the extended text will be available on reminders.', FRA = 'Spécifie si le texte étendu est disponible sur les relances.';
        }
        modify("Finance Charge Memo")
        {
            ToolTipML = ENU = 'Specifies whether the extended text will be available on finance charge memos.', FRA = 'Spécifie si le texte est disponible sur les factures d''intérêts.';
        }
        modify("Prepmt. Sales Invoice")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on prepayment sales invoices.', FRA = 'Spécifie si le texte est disponible sur les factures vente acompte.';
        }
        modify("Prepmt. Sales Credit Memo")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on prepayment sales credit memos.', FRA = 'Spécifie si le texte est disponible sur les avoirs vente acompte.';
        }
        modify(Purchases)
        {
            CaptionML = ENU = 'Purchases', FRA = 'Achats';
        }
        modify("Purchase Quote")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on purchase quotes.', FRA = 'Spécifie si le texte est disponible sur les demandes de prix.';
        }
        modify("Purchase Blanket Order")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on purchase blanket orders.', FRA = 'Spécifie si le texte est disponible sur les commandes ouvertes achat.';
        }
        modify("Purchase Order")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on purchase orders.', FRA = 'Spécifie si le texte est disponible sur les commandes achat.';
        }
        modify("Purchase Invoice")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on purchase invoices.', FRA = 'Spécifie si le texte est disponible sur les factures achat.';
        }
        modify("Purchase Return Order")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on purchase return orders.', FRA = 'Spécifie si le texte est disponible sur les retours achat.';
        }
        modify("Purchase Credit Memo")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on purchase credit memos.', FRA = 'Spécifie si le texte est disponible sur les avoirs achat.';
        }
        modify("Prepmt. Purchase Invoice")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on prepayment purchase invoices.', FRA = 'Spécifie si le texte est disponible sur les factures achat acompte.';
        }
        modify("Prepmt. Purchase Credit Memo")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on prepayment purchase credit memos.', FRA = 'Spécifie si le texte est disponible sur les avoirs achat acompte.';
        }
        modify(Service)
        {
            CaptionML = ENU = 'Service', FRA = 'Service';
        }
        modify("Service Quote")
        {
            ToolTipML = ENU = 'Specifies that the extended text for an item, account or other factor will be available on service lines in service orders.', FRA = 'Spécifie que le texte étendu pour un article, un compte ou un autre facteur sera disponible sur des lignes service dans des commandes service.';
        }
        modify("Service Order")
        {
            ToolTipML = ENU = 'Specifies that the extended text for an item, account or other factor will be available on service lines in service orders.', FRA = 'Spécifie que le texte étendu pour un article, un compte ou un autre facteur sera disponible sur des lignes service dans des commandes service.';
        }
        modify("Service Invoice")
        {
            ToolTipML = ENU = 'Specifies that the extended text for an item, account or other factor will be available on service lines in service orders.', FRA = 'Spécifie que le texte étendu pour un article, un compte ou un autre facteur sera disponible sur des lignes service dans des commandes service.';
        }
        modify("Service Credit Memo")
        {
            ToolTipML = ENU = 'Specifies that the extended text for an item, account or other factor will be available on service lines in service orders.', FRA = 'Spécifie que le texte étendu pour un article, un compte ou un autre facteur sera disponible sur des lignes service dans des commandes service.';
        }
        addafter("Sales Credit Memo")
        {
            // field("Sales Shipment"; Rec."Sales Shipment")
            // {
            // }
            // field("Sales Return Receipt"; Rec."Sales Return Receipt")
            // {
            // }//BC upgrade SHARMP16 Drink-IT fields
        }
        addafter("Prepmt. Sales Credit Memo")
        {
            field("Print on Delivery Note"; Rec."Print on Delivery Note FND")
            {
                ApplicationArea = Basic, Suite;
                Description = 'HEI.02';
                ToolTip = 'Specifies the value of the Print on Delivery Note field.';
            }
            field("Print on Picklist"; Rec."Print on Picklist FND")
            {
                ApplicationArea = Basic, Suite;
                Description = 'HEI.01';
                ToolTip = 'Specifies the value of the Print on Picklist field.';
            }
            field("Print on Customer Statement"; Rec."Print on Cust Statement FND")
            {
                ApplicationArea = Basic, Suite;
                Description = 'HEI.03';
                ToolTip = 'Specifies the value of the Print on Customer Statement field.';
            }
        }
        addafter("Purchase Credit Memo")
        {
            // field("Purchase Receipt";Rec."Purchase Receipt")
            // {
            // }
            // field("Purchase Return Shipment";Rec."Purchase Return Shipment")
            // {
            // }//BC Upgrade SHARMP16 Drink-It fields
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

