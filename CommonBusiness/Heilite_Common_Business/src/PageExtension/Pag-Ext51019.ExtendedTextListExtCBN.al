pageextension 51019 ExtendedTextListExtCBN extends "Extended Text List"
{
    //BC UPGRADE PATHAA02 01/09/25 
    DataCaptionExpression = 'No.'; //property from page 391 //BC Upgrade PathAA02 01/09/25

    layout
    {
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the content of the extended item description.', FRA = 'Spécifie le contenu de la description plus longue.';
        }
        modify("Language Code")
        {
            ToolTipML = ENU = 'Specifies the language code of the extended text.', FRA = 'Spécifie le code langue du texte étendu.';
        }
        modify("All Language Codes")
        {
            ToolTipML = ENU = 'Specifies whether the text should be used for all language codes. If a language code has been chosen in the Language Code field, it will be overruled by this function.', FRA = 'Spécifie si le texte doit être utilisé pour tous les codes langue. Si un code langue a été choisi dans le champ Code langue, cette fonction prévaut.';
        }
        modify("Starting Date")
        {
            ToolTipML = ENU = 'Specifies a date from which the text will be used on the item, account, resource or standard text.', FRA = 'Spécifie une date à partir de laquelle le texte est utilisé pour l''article, le compte, la ressource ou le texte standard.';
        }
        modify("Ending Date")
        {
            ToolTipML = ENU = 'Specifies a date on which the text will no longer be used on the item, account, resource or standard text.', FRA = 'Spécifie une date à laquelle le texte ne sera plus utilisé pour l''article, le compte, la ressource ou le texte standard.';
        }
        modify("Sales Quote")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on sales quotes.', FRA = 'Spécifie si le texte est disponible sur les devis.';
        }
        modify("Sales Invoice")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on sales invoices.', FRA = 'Spécifie si le texte est disponible sur les factures vente.';
        }
        modify("Sales Order")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on sales orders.', FRA = 'Spécifie si le texte est disponible sur les commandes vente.';
        }
        modify("Sales Credit Memo")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on sales credit memos.', FRA = 'Spécifie si le texte est disponible sur les avoirs vente.';
        }
        modify("Purchase Quote")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on purchase quotes.', FRA = 'Spécifie si le texte est disponible sur les demandes de prix.';
        }
        modify("Purchase Invoice")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on purchase invoices.', FRA = 'Spécifie si le texte est disponible sur les factures achat.';
        }
        modify("Purchase Order")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on purchase orders.', FRA = 'Spécifie si le texte est disponible sur les commandes achat.';
        }
        modify("Purchase Credit Memo")
        {
            ToolTipML = ENU = 'Specifies whether the text will be available on purchase credit memos.', FRA = 'Spécifie si le texte est disponible sur les avoirs achat.';
        }
    }

}

