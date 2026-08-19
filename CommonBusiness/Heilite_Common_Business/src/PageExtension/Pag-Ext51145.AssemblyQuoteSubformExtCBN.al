pageextension 51145 AssemblyQuoteSubformExtCBN extends "Assembly Quote Subform"
{
    // version NAVW110.0,DITW110.00.08
    //     DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //******************************************************************
    //BC UPGRADE PATHAA02 19.11.25
    //1. Made "Description" field non editable as it can't be handled on Table 901="Assembly Line";
    //2. DIT commented

    layout
    {
        modify("Avail. Warning")
        {
            ToolTipML = ENU = 'Specifies Yes if the assembly component is not available in the quantity and on the due date of the assembly order line.', FRA = 'Indique Oui si le composant d''un ordre d''assemblage n''est pas disponible dans la quantité et la date d''échéance de la ligne d''ordre d''assemblage.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies if the assembly order line is of type Item or Resource.', FRA = 'Spécifie si la ligne d''ordre d''assemblage est de type Article ou de type Ressource.';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the item or resource that is represented by the assembly order line.', FRA = 'Indique l''article ou la ressource représentée par la ligne d''ordre d''assemblage.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the assembly component.', FRA = 'Spécifie la description du composant d''assemblage.';
            Editable = false; //BC UPGRADE PATHAA02
        }
        modify("Description 2")
        {
            ToolTipML = ENU = 'Specifies the second description of the assembly component.', FRA = 'Spécifie la deuxième description du composant d''assemblage.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the code of the item variant of the assembly component.', FRA = 'Spécifie le code de variante de l''article du composant d''assemblage.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location from which you want to post consumption of the assembly component.', FRA = 'Indique le magasin à partir duquel vous souhaitez valider la consommation du composant d''assemblage.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure in which the assembly component is consumed on the assembly order.', FRA = 'Indique l''unité de mesure dans laquelle le composant d''assemblage est consommé dans l''ordre d''assemblage.';
        }
        modify("Quantity per")
        {
            ToolTipML = ENU = 'Specifies how many units of the assembly component are required to assemble one assembly item.', FRA = 'Spécifie le nombre d''unités du composant d''assemblage nécessaires à l''assemblage d''un article d''assemblage.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies how many units of the assembly component are expected to be consumed.', FRA = 'Spécifie le nombre attendu d''unités du composant d''assemblage consommées.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies the date when the assembly component must be available for consumption by the assembly order.', FRA = 'Indique la date à laquelle le composant d''assemblage doit être disponible pour la consommation par l''ordre d''assemblage.';
        }
        modify("Lead-Time Offset")
        {
            ToolTipML = ENU = 'Specifies the lead-time offset that is defined for the assembly component on the assembly BOM.', FRA = 'Spécifie le décalage du délai défini pour le composant d''assemblage sur la nomenclature d''assemblage.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code of the shortcut dimension 1 value that the assembly order line is linked to.', FRA = 'Spécifie le code du raccourci de l''axe 1 lié à la ligne de l''ordre d''assemblage.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code of the shortcut dimension 2 value that the assembly order line is linked to.', FRA = 'Spécifie le code du raccourci de l''axe 2 lié à la ligne de l''ordre d''assemblage.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies the code of the bin where assembly components must be placed prior to assembly and from where they are posted as consumed.', FRA = 'Spécifie le code de l''emplacement où les composants d''assemblage doivent être placés avant l''assemblage et d''où ils sont validés comme consommés.';
        }
        modify("Inventory Posting Group")
        {
            ToolTipML = ENU = 'Specifies the inventory posting group to which the item on this assembly order line is posted.', FRA = 'Indique le groupe comptabilisation stock dans lequel l''article sur cette ligne d''ordre d''assemblage est validé.';
        }
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the unit cost of the assembly component.', FRA = 'Spécifie le coût unitaire du composant d''assemblage.';
        }
        modify("Cost Amount")
        {
            ToolTipML = ENU = 'Specifies the cost of the assembly order line.', FRA = 'Spécifie le coût de la ligne d''ordre d''assemblage.';
        }
        modify("Qty. per Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the quantity per unit of measure of the component item on the assembly order line.', FRA = 'Spécifie la quantité par unité de mesure du composant d''article sur la ligne d''ordre d''assemblage.';
        }
        modify("Resource Usage Type")
        {
            ToolTipML = ENU = 'Specifies how the cost of the resource on the assembly order line is allocated to the assembly item.', FRA = 'Indique la manière dont le coût de la ressource de la ligne d''ordre d''assemblage est affecté à l''article d''assemblage.';
        }

        //BC UPGRADE PATHAA02-DIT>>
        // addafter("Resource Usage Type")
        // {
        //     field("Physical Location Group Code"; "Physical Location Group Code")
        //     {
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        //             if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
        //                 CurrPage.UPDATE(true);
        //             // >>DITW18.00.06 DDR DIT-770 #1192
        //         end;
        //     }
        //     field("Responsibility Center"; "Responsibility Center")
        //     {
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        //             if "Responsibility Center" <> xRec."Responsibility Center" then
        //                 CurrPage.UPDATE(true);
        //             // >>DITW18.00.06 MSF DIT-770 #1192
        //         end;
        //     }
        // }
        //BC UPGRADE PATHAA02-DIT>>
    }
    actions
    {
        //BC UPGRADE PATHAA02>>
        // modify(Line)
        // {
        //     CaptionML = ENU = 'Line', FRA = 'Ligne';
        // }
        //BC UPGRADE PATHAA02<<
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify("Item Availability by")
        {
            CaptionML = ENU = 'Item Availability by', FRA = 'Disponibilité article par';
        }
        modify("Event")
        {
            CaptionML = ENU = 'Event', FRA = 'Événement';
        }
        modify(Period)
        {
            CaptionML = ENU = 'Period', FRA = 'Période';
        }
        modify(Variant)
        {
            CaptionML = ENU = 'Variant', FRA = 'Variante';
        }
        modify(Location)
        {
            CaptionML = ENU = 'Location', FRA = 'Magasin';
        }
        modify("BOM Level")
        {
            CaptionML = ENU = 'BOM Level', FRA = 'Niveau nomenclature';
        }
        modify("Show Warning")
        {
            CaptionML = ENU = 'Show Warning', FRA = 'Afficher avertissement';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Item Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = '&Lignes traçabilité';
        }
        modify(Comments)
        {
            CaptionML = ENU = 'Comments', FRA = 'Commentaires';
        }
        modify("Assembly BOM")
        {
            CaptionML = ENU = 'Assembly BOM', FRA = 'Nomenclature d''assemblage';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Select Item Substitution")
        {
            CaptionML = ENU = 'Select Item Substitution', FRA = 'Sélectionner article de substitution';
        }
        modify("Explode BOM")
        {
            CaptionML = ENU = 'Explode BOM', FRA = 'Éclater nomenclature';
        }
    }

    var
    // UserMgt: Codeunit "User Setup Management"; //BC UPGRADE PATHAA02-not used


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    SETFILTER("Resp. Center Table Filter",UserMgt.GetRespCenterFilter(4,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",UserMgt.GetRespPhysLocationFilter(4,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",UserMgt.GetRespLocationFilter(4,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 MSF DIT-770 #1192
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

