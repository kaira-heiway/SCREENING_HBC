pageextension 51178 ProdOrderCompLineListExtCBN extends "Prod. Order Comp. Line List"
{
    // version NAVW110.0,FINXL8.00.001
    //FINXL8.00.001 BSA 02/06/2015 #178: Added field "Cross Reference No."
    //--------------------------------------------------------------------------------------------------

    //BC Upgrade YADAVM09 Editable Property set to false for Description field
    //BC Upgrade YADAVM09 Added new Item Tracking Lines action
    layout
    {
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies the status of the production order to which the component list belongs.', FRA = 'Spécifie l''état de l''ordre de fabrication auquel appartient la liste de composants.';
        }
        modify("Prod. Order No.")
        {
            ToolTipML = ENU = 'Specifies the number of the production order to which the component list belongs.', FRA = 'Spécifie le numéro de l''ordre de fabrication auquel appartient la liste de composants.';
        }
        modify("Prod. Order Line No.")
        {
            ToolTipML = ENU = 'Specifies the number of the production order line to which the component list belongs.', FRA = 'Spécifie le numéro de la ligne d''ordre de fabrication à laquelle appartient la liste de composants.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item that is a component in the production order component list.', FRA = 'Spécifie le numéro de l''article qui est un composant de la liste de composants de l''ordre de fabrication.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant code when you calculate the production order.', FRA = 'Spécifie le code variante lors du calcul de l''ordre de fabrication.';
        }
        modify(Description)
        {
            Editable = false;//BC Upgrade YADAVM09
            ToolTipML = ENU = 'Copies the description from the corresponding field in the production BOM when you calculate the production order.', FRA = 'Copie la description à partir du champ correspondant de la nomenclature production lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Copies the dimension value code from the corresponding field in the production BOM when you calculate the production order.', FRA = 'Copie le code section analytique à partir du champ correspondant de la nomenclature production lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Copies the dimension value code from the corresponding field in the production BOM when you calculate the production order.', FRA = 'Copie le code section analytique à partir du champ correspondant de la nomenclature production lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Copies the location code from the corresponding field on the production order line.', FRA = 'Copie le code magasin à partir du champ correspondant de la ligne d''ordre de fabrication.';
        }
        modify("Quantity per")
        {
            ToolTipML = ENU = 'Copies the value in this field from the corresponding field in the production BOM when you calculate the production order.', FRA = 'Copie la valeur de ce champ à partir du champ correspondant de la fiche nomenclature de production lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Expected Quantity")
        {
            ToolTipML = ENU = 'Specifies the quantity of the component expected to be consumed during the production of the quantity on this line.', FRA = 'Spécifie la quantité du composant que vous vous attendez à consommer pendant la production de la quantité de cette ligne.';
        }
        modify("Remaining Quantity")
        {
            ToolTipML = ENU = 'Specifies the remaining quantity of the component to be consumed during the production of the quantity on the production order line.', FRA = 'Spécifie la quantité restante du composant que vous vous attendez à consommer pendant la production de la quantité de la ligne d''ordre de fabrication.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Copies the date from the Starting Date on the production order line associated with the component.', FRA = 'Copie la date à partir de la date de début sur la ligne d''ordre de fabrication associée au composant.';
        }
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Copies the amount from the corresponding field on the component''s item card.', FRA = 'Copie le montant à partir du champ correspondant de la fiche article du composant.';
        }
        modify("Cost Amount")
        {
            ToolTipML = ENU = 'Calculates the amount as the Unit Cost multiplied by the Quantity.', FRA = 'Calcule le montant en multipliant le coût unitaire par la quantité.';
        }
        modify(Position)
        {
            ToolTipML = ENU = 'Copies the position code from the production BOM when you calculate the production order.', FRA = 'Copie le code position à partir de la nomenclature de production lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Position 2")
        {
            ToolTipML = ENU = 'Copies the position code from the production BOM when you calculate the production order.', FRA = 'Copie le code position à partir de la nomenclature de production lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Position 3")
        {
            ToolTipML = ENU = 'Copies the position code from the production BOM when you calculate the production order.', FRA = 'Copie le code position à partir de la nomenclature de production lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Lead-Time Offset")
        {
            ToolTipML = ENU = 'Copies the lead-time offset from the corresponding field in the production BOM when you calculate the production order.', FRA = 'Copie le décalage du délai à partir du champ correspondant de la nomenclature production lorsque vous calculez l''ordre de fabrication.';
        }
        /* //BCUPGRADE Manisha Drink it field commented>>
        addafter("Variant Code")
        {
            // field("Cross-Reference No."; Rec."Cross-Reference No.")
            // {
            // }
            
        }
        */ //BCUPGRADE Manisha Drink it field commented<<
    }
    actions
    {

        //Bc Upgrade YADAVM09>>
        addafter("&Line")
        {
            action("Item &Tracking Lines2")
            {
                ApplicationArea = ItemTracking;
                // Caption = 'Item &Tracking Lines';
                Image = ItemTrackingLines;
                ShortCutKey = 'Ctrl+Alt+I';
                ToolTip = 'View or edit serial, lot and package numbers that are assigned to the item on the document or journal line.';
                CaptionML = ENU = 'Item &Tracking Lines', FRA = '&Lignes traçabilité';
                trigger OnAction()
                begin
                    Rec.OpenItemTrackingLines2();
                end;
            }
        }
        //Bc Upgrade YADAVM09<<
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify("Item &Tracking Lines")
        {
            Visible = false;//Bc Upgrade YADAVM09
            CaptionML = ENU = 'Item &Tracking Lines', FRA = '&Lignes traçabilité';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

