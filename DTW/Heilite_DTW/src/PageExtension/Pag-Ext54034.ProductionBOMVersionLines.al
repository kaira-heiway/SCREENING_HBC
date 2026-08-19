pageextension 54034 ProductionBOMVersionLinesExt extends "Production BOM Version Lines"
{
    // version NAVW110.0,FINXL8.00.001
    //BC UPGRADE PATHAA02-Zone Code and BIN Code added
    //BC UPGRADE PATHAA02- 11.03.26
    // FINXL8.00.001 BSA 02/06/2015 #178: Added field "Cross Reference No."
    // DITW111.00.13 ISL 13/12/2018 NRQ#95758 : Added field "Production Jnl. Flushing " with visiblity False
    // HEI.01 FDD_CHG2003754 IBM ISYED01 03.19.2019
    //  #added new fileds Zone and Bin to the page

    //***********************************************************************
    //HEI.01 BC UPGRADE PATHAA02 11.03.26 FDD-DTW002 # Functionality- "Production jnl. flushing"  
    //Field "Production jnl. flushing" added after Ending Date.

    layout
    {
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the type of production BOM line.', FRA = 'Spécifie le type de ligne nomenclature production.';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number depending on the type selected in the Type field.', FRA = 'Spécifie le numéro associé au type sélectionné dans le champ Type.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies a variant code if the component is a specific item variant.', FRA = 'Spécifie un code variante si le composant est une variante article spécifique.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the production BOM line.', FRA = 'Spécifie une description de la ligne nomenclature production.';
        }
        modify("Calculation Formula")
        {
            ToolTipML = ENU = 'Specifies how to calculate the Quantity field.', FRA = 'Spécifie la manière de calculer la valeur du champ Quantité.';
        }
        modify(Length)
        {
            ToolTipML = ENU = 'Specifies the length of the required item.', FRA = 'Spécifie la longueur de l''article requis.';
        }
        modify(Width)
        {
            ToolTipML = ENU = 'Specifies the width of the required item.', FRA = 'Spécifie la largeur de l''article requis.';
        }
        modify(Depth)
        {
            ToolTipML = ENU = 'Specifies the height of the required item.', FRA = 'Spécifie la hauteur de l''article requis.';
        }
        modify(Weight)
        {
            ToolTipML = ENU = 'Specifies the weight of the required item.', FRA = 'Indique le poids brut de l''article requis.';
        }
        modify("Quantity per")
        {
            ToolTipML = ENU = 'Specifies the quantity required to make an assembly item.', FRA = 'Indique la quantité nécessaire à la fabrication d''un article d''assemblage.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure that the production BOM line refers to.', FRA = 'Indique l''unité à laquelle la ligne nomenclature production fait référence.';
        }
        modify("Scrap %")
        {
            ToolTipML = ENU = 'Specifies the scrap percentage of the production BOM line.', FRA = 'Spécifie le pourcentage de rebut de la ligne nomenclature de production.';
        }
        modify("Routing Link Code")
        {
            ToolTipML = ENU = 'Specifies the routing link code.', FRA = 'Spécifie le code lien gamme.';
        }
        modify(Position)
        {
            ToolTipML = ENU = 'Specifies whether the components are to appear at a certain position in the BOM to represent a specific process.', FRA = 'Indique si les composants doivent apparaître à une certaine position dans la nomenclature pour représenter un processus spécifique.';
        }
        modify("Position 2")
        {
            ToolTipML = ENU = 'Specifies more exactly whether the component is to appear at a certain position in the BOM to represent a certain production process.', FRA = 'Spécifie plus précisément si le composant doit apparaître à une certaine position dans la nomenclature pour représenter un processus de production donné.';
        }
        modify("Position 3")
        {
            ToolTipML = ENU = 'Specifies even more exactly whether the component is to appear at a certain position in the BOM.', FRA = 'Spécifie encore plus précisément si le composant doit apparaître à une certaine position dans la nomenclature.';
        }
        modify("Lead-Time Offset")
        {
            ToolTipML = ENU = 'Specifies the total number of days required to produce this item.', FRA = 'Spécifie le nombre total de jours nécessaires à l''assemblage ou à la production de cet article.';
        }
        modify("Starting Date")
        {
            ToolTipML = ENU = 'Specifies the date from which this production BOM is valid.', FRA = 'Spécifie la date de début de validité de la nomenclature production.';
        }
        modify("Ending Date")
        {
            ToolTipML = ENU = 'Specifies the date from which this production BOM is no longer valid.', FRA = 'Spécifie la date de fin de validité de la nomenclature production.';
        }
        // addafter("Variant Code")
        // {
        //     field("Cross-Reference No."; "Cross-Reference No.")
        //     {
        //     }
        // } //BC UPGRADE PATHAA02-DIT
        //BC Upgrade Kamnay01 visble true 
        addafter(Description)
        {
            field("Production jnl. flushing"; Rec."Production jnl. flushing FND")
            {
                Description = 'HEI.01';
                Visible = true;
                ApplicationArea = All;
            }
            //BC upgrade Kamnay01 visble true
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = All;
            }
            field("Bin Code"; Rec."Bin Code FND")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("&Component")
        {
            CaptionML = ENU = '&Component', FRA = '&Composant';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify("Where-Used")
        {
            CaptionML = ENU = 'Where-Used', FRA = 'Cas d''emploi';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

