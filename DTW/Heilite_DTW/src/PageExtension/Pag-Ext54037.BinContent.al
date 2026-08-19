pageextension 54037 BinContentExt extends "Bin Content"
{

    // BC Upgrade – Kamnay01  
    // The page "Item Bin Content" is deprecated in Business Central, and instead they are using the standard existing page "Bin Content".  
    // In HEILITE, on the "Item Bin Content" page, we have a FactBox "Lot Number by Bin" which is hidden in standard BC.  
    // To make it visible, we are extending the "Bin Content" page and making the FactBox visible.  
    //Bc Upgrade Kamnay01 visible to true for Control3-Lot Numbers by Bin FactBox factbox in Bin Contents List Page Extension
    //BC Upgrade RD03 – Updated the Zone Code field property to make it editable
    layout
    {

        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item that will be stored in the bin.', FRA = 'Spécifie le numéro de l''article à stocker dans cet emplacement.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant code for the item in the bin.', FRA = 'Spécifie le code variante pour l''article dans l''emplacement.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location code of the bin.', FRA = 'Spécifie le code du magasin de l''emplacement.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin code.', FRA = 'Spécifie le code de l''emplacement.';
        }
        modify("Fixed")
        {
            ToolTipML = ENU = 'Specifies that the item (bin content) has been associated with this bin, and that the bin should normally contain the item.', FRA = 'Indique que l''article (contenu de l''emplacement) a été associé à cet emplacement et que ce dernier doit normalement contenir l''article.';
        }
        modify(Default)
        {
            ToolTipML = ENU = 'Specifies if the bin is the default bin for the associated item.', FRA = 'Indique si l''emplacement correspond à l''emplacement par défaut de l''article associé.';
        }
        modify(Dedicated)
        {
            ToolTipML = ENU = 'Specifies if the bin is used as a dedicated bin, which means that its bin content is available only to certain resources.', FRA = 'Indique si l''emplacement est utilisé comme emplacement dédié, ce qui signifie que son contenu est uniquement disponible à certaines ressources.';
        }
        modify(CalcQtyUOM)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code of the item in the bin.', FRA = 'Spécifie le code unité de l''article dans l''emplacement.';
        }
        modify("Quantity (Base)")
        {
            ToolTipML = ENU = 'Specifies how many units of the item, in the base unit of measure, are stored in the bin.', FRA = 'Indique le nombre d''unités de mesure de l''article contenues dans une unité de mesure de l''article stockées dans l''emplacement.';
        }
        modify("Bin Type Code")
        {
            ToolTipML = ENU = 'Specifies the code of the bin type that was selected for this bin.', FRA = 'Spécifie le code du type emplacement choisi pour cet emplacement.';
        }
        modify("Zone Code")
        {
            ToolTipML = ENU = 'Specifies the zone code of the bin.', FRA = 'Spécifie le code de la zone de l''emplacement.';
            //BC Upgrade RD03 – Updated the Zone Code field property to make it editable. --------- >>
            Editable = true;
            //BC Upgrade RD03 – Updated the Zone Code field property to make it editable. --------- <<
        }

        //Bc Upgrade Kamnay01>> visible to true for below factbox in Bin Contents List Page Extension

        //Unsupported feature: PropertyDeletion on "Control7(Control 7)". Please convert manually.
        modify(Control3)
        {
            Visible = True;//Factbox-<Lot Numbers by Bin> made Visible(true) in Bin Content Page Extension.
        }
        //Bc Upgrade Kamnay01<< visible to true for below factbox in Bin Contents List Page Extension

    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

