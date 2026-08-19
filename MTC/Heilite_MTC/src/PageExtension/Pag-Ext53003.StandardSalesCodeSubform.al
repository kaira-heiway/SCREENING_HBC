pageextension 53003 StandardsalescodesubformExt extends "Standard Sales Code Subform"
{
    // version NAVW110.0,DITW110.00.08
    // DITW16.00.00.40 DDR 16/04/2012 DIT-715 #247 Sponsoring & Events functionnality
    //                                   Added fields "Return Receipt Date Calculation"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //BC Upgrade GUNREM01  added editable false on Decription field-Basically this property added in table level in NAV. but in BC we cant add in extension.
    layout
    {
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies whether the line is for a general ledger account, item, resource, fixed asset or item charge.', FRA = 'Spécifie si la ligne est pour un compte général, un article, une ressource, une immobilisation ou des frais annexes.';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of a general ledger account, item, resource, additional cost, or fixed asset, depending on the contents of the Type field.', FRA = 'Spécifie le numéro d''un compte général, d''un article, d''une ressource, d''un coût supplémentaire ou d''une immobilisation, selon ce que vous avez sélectionné dans le champ Type.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies a variant code for the item.', FRA = 'Spécifie un code variante pour l''article.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry, which is based on the contents of the Type and No. fields.', FRA = 'Spécifie une description de l''entrée qui est basée sur le contenu des champs Type et N°.';
            Editable = false; //BC Upgrade GUNREM01 added  

        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the item on the line.', FRA = 'Spécifie le nombre d''unités de l''article sur la ligne.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code to use to determine the unit price.', FRA = 'Spécifie le code unité à utiliser pour déterminer le prix unitaire.';
        }
        modify("Amount Excl. VAT")
        {
            ToolTipML = ENU = 'Applies only to lines with the type G/L Account or Charge (Item).', FRA = 'S''applique uniquement aux lignes de type Compte général ou Frais annexes.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code that is linked to the line.', FRA = 'Spécifie le code section analytique lié à cette ligne.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code that is linked to the line.', FRA = 'Spécifie le code section analytique lié à cette ligne.';
        }
        //BC Upgrade GUNREM01 commenetd >> Drink-It Field
        // addafter("ShortcutDimCode[8]")
        // {

        // field("Ret. Receipt Date Calculation"; "Ret. Receipt Date Calculation")
        // {
        //     Description = 'DIT-715 #247';
        //     Visible = false;
        // }
        //}
        //BC Upgrade GUNREM01 << commenetd Drink-It Field
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

