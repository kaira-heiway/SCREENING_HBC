pageextension 51177 ProdOrderLineListExtCBN extends "Prod. Order Line List"
{
    // version NAVW110.0,FINXL8.00,DITW110.00.08


    // FINXL8.00.001 BSA 02/06/2015 #178: Added field "Cross Reference No."

    // DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    //BC Upgrade YADAVM09 Editable Property set to false for Description field
    layout
    {

        modify(Status)
        {
            ToolTipML = ENU = 'Specifies a value that is copied from the corresponding field on the production order header.', FRA = 'Spécifie une valeur qui est copiée à partir du champ correspondant sur l''en-tête de l''ordre de fabrication.';
        }
        modify("Prod. Order No.")
        {
            ToolTipML = ENU = 'Specifies the production order number from a subcontracting worksheet line when the line is posted.', FRA = 'Spécifie le numéro d''ordre de fabrication à partir d''une ligne proposition sous-traitance lorsque la ligne est validée.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item that is to be produced.', FRA = 'Spécifie le numéro de l''article à produire.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies a code if you have set up variant codes in the Item Variants window.', FRA = 'Spécifie un code si vous avez défini des codes variante dans la fenêtre Variantes article.';
        }
        modify(Description)
        {
            Editable = false;//BC Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the value of the Description field on the item card. If you enter a variant code, the variant description is copied to this field instead.', FRA = 'Spécifie la valeur du champ Description de la fiche article. Si vous saisissez un code variante, la description de la variante est copiée dans ce champ à la place de la description.';
        }
        modify("Description 2")
        {
            ToolTipML = ENU = 'Specifies an additional description.', FRA = 'Spécifie une description supplémentaire.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies a dimension value code for a dimension.', FRA = 'Indique un code section pour un axe analytique.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies a dimension value code for a dimension.', FRA = 'Indique un code section pour un axe analytique.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location code, if the produced items should be stored in a specific location.', FRA = 'Spécifie le code magasin, si les articles produits doivent être stockés dans un magasin spécifique.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the quantity to be produced if you manually fill in this line.', FRA = 'Indique la quantité à produire si vous renseignez manuellement cette ligne.';
        }
        modify("Finished Quantity")
        {
            ToolTipML = ENU = 'Specifies how much of the quantity on this line has been produced.', FRA = 'Spécifie la quantité produite de cette ligne.';
        }
        modify("Remaining Quantity")
        {
            ToolTipML = ENU = 'Specifies the difference between the finished and planned quantities, or zero if the finished quantity is greater than the remaining quantity.', FRA = 'Spécifie la différence entre les quantités achevées et planifiées (ou 0, si la quantité achevée est supérieure à la quantité restante).';
        }
        modify("Scrap %")
        {
            ToolTipML = ENU = 'Copies the value in this field from the Scrap Percentage field on the item card when the Item No. field is filled in.', FRA = 'Copie la valeur de ce champ à partir du champ Pourcentage rebut de la fiche article lorsque le champ N° article est renseigné.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Copies the date in this field from the corresponding field on the production order header.', FRA = 'Copie la date de ce champ à partir du champ correspondant dans l''en-tête de l''ordre de fabrication.';
        }
        modify("Starting Date")
        {
            ToolTipML = ENU = 'Specifies the entry''s starting date, which is retrieved from the production order routing.', FRA = 'Spécifie la date de début de l''écriture, qui est copiée à partir de l''ordre de fabrication.';
        }
        modify("Starting Time")
        {
            ToolTipML = ENU = 'Specifies the entry''s starting time, which is retrieved from the production order routing.', FRA = 'Spécifie l''heure de début de l''écriture, qui est copiée à partir de l''ordre de fabrication.';
        }
        modify("Ending Date")
        {
            ToolTipML = ENU = 'Specifies the entry''s ending date, which is retrieved from the production order routing.', FRA = 'Spécifie la date de fin de l''écriture, qui est copiée à partir de l''ordre de fabrication.';
        }
        modify("Ending Time")
        {
            ToolTipML = ENU = 'Specifies the entry''s ending time, which is retrieved from the production order routing.', FRA = 'Spécifie l''heure de fin de l''écriture, qui est copiée à partir de l''ordre de fabrication.';
        }
        modify("Production BOM No.")
        {
            ToolTipML = ENU = 'Specifies the number of the production BOM that is the basis for creating the Prod. Order Component list for this line.', FRA = 'Spécifie le numéro de la nomenclature de production qui est utilisé comme base pour créer la liste Composant O.F. pour cette ligne.';
        }
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Calculates the unit cost, based on the cost of the components in the production order component list, and the routing, if the costing method is not standard.', FRA = 'Calcule le coût unitaire, sur la base de celui des composants dans la liste de composants de l''ordre de fabrication et de la gamme si la méthode évaluation stock n''est pas standard.';
        }
        modify("Cost Amount")
        {
            ToolTipML = ENU = 'Calculates the amount by multiplying the Unit Cost by the Quantity.', FRA = 'Calcule le montant en multipliant le coût unitaire par la quantité.';
        }
        /* //BCUPGRADE YADAVM09 Drink it field Commented>>
        addafter("Variant Code")
        {
            field("Cross-Reference No."; "Cross-Reference No.")
            {
            }
        }
        addafter("Cost Amount")
        {
            field("Physical Location Group Code"; "Physical Location Group Code")
            {
                Visible = false;
            }
            field("Responsibility Center"; "Responsibility Center")
            {
                Visible = false;
            }
        }
         */ //BCUPGRADE YADAVM09 Drink it field COmmented>>
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }

    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

