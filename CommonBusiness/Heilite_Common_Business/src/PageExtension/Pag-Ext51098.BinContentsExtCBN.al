pageextension 51098 BinContentsExtCBN extends "Bin Contents"
{
    //    HEI.01 FDD-LB IBM NASTAA02 15.10.2018 # Item Availability excluding Blocked Stock
    //   # New Fields added: "Available Inv. (Whse)", "Quantity Quality Hold (Base)", "Quantity Unrestricted (Base)", "Quantity Blocked (Base)"
    // HEI.02 IBM.AK CHG2117335 05-07-21
    //  # Factbox-<Lot Numbers by Bin> made Visible(true)

    layout
    {
        modify(Options)
        {
            CaptionML = ENU = 'Options', FRA = 'Options';
        }
        modify(LocationCode)
        {
            CaptionML = ENU = 'Location Filter', FRA = 'Filtre magasin';
        }
        modify(ZoneCode)
        {
            CaptionML = ENU = 'Zone Filter', FRA = 'Filtre zone';
        }
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
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code of the item in the bin.', FRA = 'Spécifie le code unité de l''article dans l''emplacement.';
        }
        modify("Qty. per Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the number of base units of measure that are in the unit of measure specified for the item in the bin.', FRA = 'Spécifie le nombre d''unités de base qui se trouvent dans l''unité spécifiée pour l''article dans l''emplacement.';
        }
        modify(Default)
        {
            ToolTipML = ENU = 'Specifies if the bin is the default bin for the associated item.', FRA = 'Indique si l''emplacement correspond à l''emplacement par défaut de l''article associé.';
        }
        modify(Dedicated)
        {
            ToolTipML = ENU = 'Specifies if the bin is used as a dedicated bin, which means that its bin content is available only to certain resources.', FRA = 'Indique si l''emplacement est utilisé comme emplacement dédié, ce qui signifie que son contenu est uniquement disponible à certaines ressources.';
        }
        modify("Warehouse Class Code")
        {
            ToolTipML = ENU = 'Specifies the warehouse class code. Only items with the same warehouse class can be stored in this bin.', FRA = 'Spécifie le code classe de l''entrepôt. Seuls les articles ayant la même classe entrepôt peuvent être triés dans cet emplacement.';
        }
        modify("Bin Type Code")
        {
            ToolTipML = ENU = 'Specifies the code of the bin type that was selected for this bin.', FRA = 'Spécifie le code du type emplacement choisi pour cet emplacement.';
        }
        modify("Bin Ranking")
        {
            ToolTipML = ENU = 'Specifies the bin ranking.', FRA = 'Spécifie le niveau de priorité de l''emplacement.';
        }
        modify("Block Movement")
        {
            ToolTipML = ENU = 'Specifies how the movement of a particular item, or bin content, into or out of this bin, is blocked.', FRA = 'Spécifie la manière dont le transfert d''un article particulier, ou le contenu de l''emplacement, dans ou en dehors de cet emplacement, est bloqué.';
        }
        modify("Min. Qty.")
        {
            ToolTipML = ENU = 'Indicates the minimum number of units of the item that you want to have in the bin at all times.', FRA = 'Indique le nombre d''unités minimum de cet article que vous souhaitez voir en permanence dans l''emplacement.';
        }
        modify("Max. Qty.")
        {
            ToolTipML = ENU = 'Indicates the maximum number of units of the item that you want to have in the bin.', FRA = 'Indique le nombre maximum d''unités de cet article que vous souhaitez avoir dans l''emplacement.';
        }
        modify(CalcQtyUOM)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Quantity (Base)")
        {
            ToolTipML = ENU = 'Specifies how many units of the item, in the base unit of measure, are stored in the bin.', FRA = 'Indique le nombre d''unités de mesure de l''article contenues dans une unité de mesure de l''article stockées dans l''emplacement.';
        }
        modify("Pick Quantity (Base)")
        {
            ToolTipML = ENU = 'Specifies how many units of the item, in the base unit of measure, will be picked from the bin.', FRA = 'Indique le nombre d''unités de mesure de l''article contenues dans une unité de mesure de l''article prélevées dans l''emplacement.';
        }
        modify("Negative Adjmt. Qty. (Base)")
        {
            ToolTipML = ENU = 'Specifies how many item units, in the base unit of measure, will be posted on journal lines as negative quantities.', FRA = 'Indique le nombre d''unités d''article, exprimé en unité de base, qui sera validé sur les lignes feuille en tant que quantités négatives.';
        }
        modify("Put-away Quantity (Base)")
        {
            ToolTipML = ENU = 'Specifies how many units of the item, in the base unit of measure, will be put away in the bin.', FRA = 'Indique le nombre d''unités de mesure de l''article contenues dans une unité de mesure de l''article rangées dans l''emplacement.';
        }
        modify("Positive Adjmt. Qty. (Base)")
        {
            ToolTipML = ENU = 'Specifies how many item units, in the base unit of measure, will be posted on journal lines as positive quantities.', FRA = 'Indique le nombre d''unités d''article, exprimé en unité de base, qui sera validé sur les lignes feuille en tant que quantités positives.';
        }
        modify(CalcQtyAvailToTakeUOM)
        {
            CaptionML = ENU = 'Available Qty. to Take', FRA = 'Qté disponible pour prélèv.';
            ToolTipML = ENU = 'Specifies the quantity of the item that is available in the bin.', FRA = 'Spécifie la quantité de l''article disponible dans l''emplacement.';
        }
        modify("Fixed")
        {
            ToolTipML = ENU = 'Specifies that the item (bin content) has been associated with this bin, and that the bin should normally contain the item.', FRA = 'Indique que l''article (contenu de l''emplacement) a été associé à cet emplacement et que ce dernier doit normalement contenir l''article.';
        }
        modify("Cross-Dock Bin")
        {
            ToolTipML = ENU = 'Specifies if the bin content is in a cross-dock bin.', FRA = 'Indique si le contenu de l''emplacement est considéré comme étant un emplacement de transbordement.';
        }
        modify("Item Description")
        {
            CaptionML = ENU = 'Item Description', FRA = 'Description article';

            //Unsupported feature: Change Name on ""Item Description"(Control 1900206101)". Please convert manually.

        }
        modify("Qty. on Adjustment Bin")
        {
            CaptionML = ENU = 'Qty. on Adjustment Bin', FRA = 'Qté emplacement ajustement';
        }
        modify(CalcQtyonAdjmtBin)
        {
            CaptionML = ENU = 'Qty. on Adjustment Bin', FRA = 'Qté emplacement ajustement';
        }
        //BC Upgrade Kamnay01>>  # Factbox-<Lot Numbers by Bin> made Visible(true)
        modify(Control2)
        {
            Visible = true;
        }
        //BC Upgrade Kamnay01<<  # Factbox-<Lot Numbers by Bin> made Visible(true)
        //Unsupported feature: PropertyDeletion on "Control2(Control 2)". Please convert manually.

        //BC Upgrade Kamnay01>> This Field Allreday Exists in Std page 
        // addafter("Item No.")
        // {
        //     field("Item Description"; Rec."Item Description")
        //     {
        //     }
        // }
        //BC Upgrade Kamnay01<< This Field Allreday Exists in Std page 
        addafter("Cross-Dock Bin")
        {
            field("Available Inv. (Whse)"; Rec."Available Inv. (Whse) FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Available Inv. (Whse) field.';
            }
            field("Quantity Quality Hold (Base)"; Rec."Quantity Qual Hold (Base) FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity Quality Hold (Base) field.';
            }
            field("Quantity Unrestricted (Base)"; Rec."Quantity Unrestrict (Base) FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity Unrestricted (Base) field.';
            }
            field("Quantity Blocked (Base)"; Rec."Quantity Blocked (Base) FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity Blocked (Base) field.';
            }
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify("Warehouse Entries")
        {
            CaptionML = ENU = 'Warehouse Entries', FRA = 'Écritures entrepôt';
        }
    }


    //Unsupported feature: PropertyModification on "Text000(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Location code is not allowed for user %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Location code is not allowed for user %1.;FRA=L'utilisateur %1 n'est pas autorisé à utiliser ce code magasin.;
    //Variable type has not been exported.

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

