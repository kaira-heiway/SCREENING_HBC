pageextension 54027 BinContentsListExt extends "Bin Contents List"
{
    // version NAVW110.0,DITW110.00.08

    //     DITW16.00.00.40 DDR 03/05/2012 DIT-715 #292 SSCC Functionnalities
    //                                             Added fields "SSCC Quantity (Base)"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-LB IBM NASTAA02 18.12.2018 # Item Availability excluding Blocked Stock
    //   # New Fields added: "Quantity Unrestricted (Base)", "Quantity Quality Hold (Base)", "Quantity Blocked (Base)"

    // HEI.02 IBM.AK CHG2117335 05-07-21
    //  # Factbox-<Lot Numbers by Bin> made Visible(true)

    //Bc Upgrade YADAVM09 Drink it field blocked.

    //Bc Upgrade Kamnay01 visible to true for Control3-Lot Numbers by Bin FactBox factbox in Bin Contents List Page Extension

    layout
    {
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location code of the bin.', FRA = 'Spécifie le code du magasin de l''emplacement.';
        }
        modify("Zone Code")
        {
            ToolTipML = ENU = 'Specifies the zone code of the bin.', FRA = 'Spécifie le code de la zone de l''emplacement.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin code.', FRA = 'Spécifie le code de l''emplacement.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item that will be stored in the bin.', FRA = 'Spécifie le numéro de l''article à stocker dans cet emplacement.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant code for the item in the bin.', FRA = 'Spécifie le code variante pour l''article dans l''emplacement.';
        }
        modify("Bin Type Code")
        {
            ToolTipML = ENU = 'Specifies the code of the bin type that was selected for this bin.', FRA = 'Spécifie le code du type emplacement choisi pour cet emplacement.';
        }
        modify("Block Movement")
        {
            ToolTipML = ENU = 'Specifies how the movement of a particular item, or bin content, into or out of this bin, is blocked.', FRA = 'Spécifie la manière dont le transfert d''un article particulier, ou le contenu de l''emplacement, dans ou en dehors de cet emplacement, est bloqué.';
        }
        modify("Bin Ranking")
        {
            ToolTipML = ENU = 'Specifies the bin ranking.', FRA = 'Spécifie le niveau de priorité de l''emplacement.';
        }
        modify(Default)
        {
            ToolTipML = ENU = 'Specifies if the bin is the default bin for the associated item.', FRA = 'Indique si l''emplacement correspond à l''emplacement par défaut de l''article associé.';
        }
        modify("Fixed")
        {
            ToolTipML = ENU = 'Specifies that the item (bin content) has been associated with this bin, and that the bin should normally contain the item.', FRA = 'Indique que l''article (contenu de l''emplacement) a été associé à cet emplacement et que ce dernier doit normalement contenir l''article.';
        }
        modify(Dedicated)
        {
            ToolTipML = ENU = 'Specifies if the bin is used as a dedicated bin, which means that its bin content is available only to certain resources.', FRA = 'Indique si l''emplacement est utilisé comme emplacement dédié, ce qui signifie que son contenu est uniquement disponible à certaines ressources.';
        }
        modify("Warehouse Class Code")
        {
            ToolTipML = ENU = 'Specifies the warehouse class code. Only items with the same warehouse class can be stored in this bin.', FRA = 'Spécifie le code classe de l''entrepôt. Seuls les articles ayant la même classe entrepôt peuvent être triés dans cet emplacement.';
        }
        modify(CalcQtyUOM)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Quantity (Base)")
        {
            ToolTipML = ENU = 'Specifies how many units of the item, in the base unit of measure, are stored in the bin.', FRA = 'Indique le nombre d''unités de mesure de l''article contenues dans une unité de mesure de l''article stockées dans l''emplacement.';
        }
        modify(CalcQtyAvailToTakeUOM)
        {
            CaptionML = ENU = 'Available Qty. to Take', FRA = 'Qté disponible pour prélèv.';
        }
        modify("Min. Qty.")
        {
            ToolTipML = ENU = 'Indicates the minimum number of units of the item that you want to have in the bin at all times.', FRA = 'Indique le nombre d''unités minimum de cet article que vous souhaitez voir en permanence dans l''emplacement.';
        }
        modify("Max. Qty.")
        {
            ToolTipML = ENU = 'Indicates the maximum number of units of the item that you want to have in the bin.', FRA = 'Indique le nombre maximum d''unités de cet article que vous souhaitez avoir dans l''emplacement.';
        }
        modify("Qty. per Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the number of base units of measure that are in the unit of measure specified for the item in the bin.', FRA = 'Spécifie le nombre d''unités de base qui se trouvent dans l''unité spécifiée pour l''article dans l''emplacement.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code of the item in the bin.', FRA = 'Spécifie le code unité de l''article dans l''emplacement.';
        }
        modify("Cross-Dock Bin")
        {
            ToolTipML = ENU = 'Specifies if the bin content is in a cross-dock bin.', FRA = 'Indique si le contenu de l''emplacement est considéré comme étant un emplacement de transbordement.';
        }

        //Unsupported feature: PropertyDeletion on "Control3(Control 3)". Please convert manually.

        addafter("Item No.")
        {
            field("Item Description"; Rec."Item Description FND")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09
            }
        }
        // addafter("Quantity (Base)")
        // {
        //     field("SSCC Quantity (Base)"; Rec."SSCC Quantity (Base)")
        //     {
        //         ApplicationArea = ALL;//Bc Upgrade YADAVM09
        //     }
        // } //Bc Upgrade YADAVM09 Drink it field Blocked.
        addafter("Cross-Dock Bin")
        {
            field("Quantity Unrestricted (Base)"; Rec."Quantity Unrestrict (Base) FND")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09
            }
            field("Quantity Quality Hold (Base)"; Rec."Quantity Qual Hold (Base) FND")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09
            }
            field("Quantity Blocked (Base)"; Rec."Quantity Blocked (Base) FND")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09
            }
        }
        //Bc Upgrade Kamnay01>> visible to true for below factbox in Bin Contents List Page Extension   
        modify(Control3)
        {
            Visible = true;//HEI.02 IBM.AK CHG2117335 05-07-21 Factbox-<Lot Numbers by Bin> made Visible(true)
        }
        //Bc Upgrade Kamnay01<< visible to true for below factbox in Bin Contents List Page Extension
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

