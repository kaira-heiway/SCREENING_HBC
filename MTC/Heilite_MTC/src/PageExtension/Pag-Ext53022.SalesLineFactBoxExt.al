pageextension 53022 SalesLineFactBoxExt extends "Sales Line FactBox"
{
    // version NAVW110.0.00.16177,DITW110.00.09,HEI.01
    //BC UPGRADE SIVA Old Page ID 9087

    // DITW17.10.05 WSA 29/01/2015 DIT-770 #185 Added Ctrl   Real Time Loyalty Balance
    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //   DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    //   HEI.01 FDD-LB IBM NASTAA02 15.10.2018 # Item Availability excluding Blocked Stock
    //     # New Fields added: "Available Inv. (Whse)", "Item Availability (Unrestr.)"
    //   DITW110.00.12 MSF 27/04/2018 NRQ#10488 Loyalty Management â€“ several issues
    //                                    Remove Real Time Loyalty Balance
    //*******************************************//
    //BC UPGRADE SIVA 20/01/2026
    // SUMMARY OF CHANGES:
    //1.HEI.01 No changes.


    layout
    {
        modify(ItemNo)
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
            ToolTipML = ENU = 'Specifies the item that is handled on the sales line.', FRA = 'Spécifie l''article géré sur la ligne vente.';
        }
        modify("Required Quantity")
        {
            CaptionML = ENU = 'Required Quantity', FRA = 'Quantité requise';
            ToolTipML = ENU = 'Specifies how many units of the item are required on the sales line.', FRA = 'Spécifie le nombre d''unités de l''article nécessaires sur la ligne vente.';
        }
        modify(Availability)
        {
            CaptionML = ENU = 'Availability', FRA = 'Disponibilité';
        }
        modify("Shipment Date")
        {
            CaptionML = ENU = 'Shipment Date', FRA = 'Date d''expédition';
            ToolTipML = ENU = 'Specifies when the items on the sales line must be shipped.', FRA = 'Spécifie lorsque les articles de la ligne vente doivent être expédiés.';
        }
        modify("Item Availability")
        {
            CaptionML = ENU = 'Item Availability', FRA = 'Disponibilité article';
            ToolTipML = ENU = 'Specifies how may units of the item on the sales line are available, in inventory or incoming before the shipment date.', FRA = 'Spécifie combien d''unités de l''article de la ligne vente sont disponibles, en stock ou entrantes avant la date d''expédition.';
        }
        modify("Available Inventory")
        {
            CaptionML = ENU = 'Available Inventory', FRA = 'Stock disponible';
            ToolTipML = ENU = 'Specifies the quantity of the item that is currently in inventory and not reserved for other demand.', FRA = 'Spécifie la quantité de l''article actuellement en stock et non réservée pour une autre demande.';
        }
        modify("Scheduled Receipt")
        {
            CaptionML = ENU = 'Scheduled Receipt', FRA = 'Réception planifiée';
            ToolTipML = ENU = 'Specifies how many units of the assembly component are inbound on purchase orders, transfer orders, assembly orders, firm planned production orders, and released production orders.', FRA = 'Spécifie le nombre d''unités du composant d''assemblage qui sont entrantes sur des commandes achat, des ordres de transfert, des ordres d''assemblage, des ordres de fabrication planifiés et planifiés fermes et des ordres de fabrication lancés.';
        }
        modify("Reserved Receipt")
        {
            CaptionML = ENU = 'Reserved Receipt', FRA = 'Réception réservée';
            ToolTipML = ENU = 'Specifies how many units of the item on the sales line are reserved on incoming receipts.', FRA = 'Spécifie combien d''unités de l''article de la ligne de vente sont réservées sur les réceptions entrantes.';
        }
        modify("Gross Requirements")
        {
            CaptionML = ENU = 'Gross Requirements', FRA = 'Besoins bruts';
            ToolTipML = ENU = 'Specifies, for the item on the sales line, dependent demand plus independent demand. Dependent demand comes production order components of all statuses, assembly order components, and planning lines. Independent demand comes from sales orders, transfer orders, service orders, job tasks, and production forecasts.', FRA = 'Spécifie, pour l''article de la ligne vente, la demande dépendante plus la demande indépendante. La demande dépendante provient de composants d''ordres de fabrication de tous les statuts, de composants d''ordres d''assemblage et de lignes planning. La demande indépendante provient de commandes vente, d''ordres de transfert, de commandes service, de tâches projet et de prévisions de production.';
        }
        modify("Reserved Requirements")
        {
            CaptionML = ENU = 'Reserved Requirements', FRA = 'Besoins réservés';
            ToolTipML = ENU = 'Specifies, for the item on the sales line, how many are reserved on demand records.', FRA = 'Spécifie, pour l''article de la ligne vente, le nombre d''unités réservées sur les enregistrements de demandes.';
        }
        modify(Item)
        {
            CaptionML = ENU = 'Item', FRA = 'Article';
        }
        modify(UnitofMeasureCode)
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
            ToolTipML = ENU = 'Specifies the unit of measure that is used to determine the value in the Unit Price field on the sales line.', FRA = 'Spécifie l''unité de mesure utilisée pour déterminer la valeur dans le champ Prix unitaire de la ligne vente.';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
            ToolTipML = ENU = 'Specifies an auto-filled number if you have included Sales Unit of Measure on the item card and a quantity in the Qty. per Unit of Measure field.', FRA = 'Spécifie un numéro renseigné automatiquement si vous avez inclus l''Unité de vente sur la fiche article et une quantité dans le champ Quantité par unité.';
        }
        modify(Substitutions)
        {
            CaptionML = ENU = 'Substitutions', FRA = 'Articles de substitution';
            ToolTipML = ENU = 'Specifies other items that are set up to be traded instead of the item in case it is not available.', FRA = 'Spécifie d''autres articles qui sont configurés pour être négociés à la place de l''article, s''il n''est pas disponible.';
        }
        modify(SalesPrices)
        {
            CaptionML = ENU = 'Sales Prices', FRA = 'Prix vente';
            ToolTipML = ENU = 'Specifies how many special prices you grant for the sales line. Choose the value to see the special sales prices.', FRA = 'Spécifie le nombre de prix spéciaux que vous accordez à la ligne vente. Choisissez la valeur pour voir les prix de vente spéciaux.';
        }
        modify(SalesLineDiscounts)
        {
            CaptionML = ENU = 'Sales Line Discounts', FRA = 'Remises ligne vente';
            ToolTipML = ENU = 'Specifies how many special discounts you grant for the sales line. Choose the value to see the sales line discounts.', FRA = 'Spécifie le nombre de remises spéciales que vous accordez à la ligne vente. Choisissez la valeur pour voir les remises ligne vente.';
        }
        addafter("Item Availability")
        {
            field("Unavailable Inv. (Whse)"; Rec."Unavailable Inv. (Whse) FND" / Rec."Qty. per Unit of Measure")
            {
                ToolTip = 'Unavailable Inv. (Base-Whse)';
                ApplicationArea = all;
                Caption = 'Unavailable Inv. (Base-Whse)';
                DecimalPlaces = 0 : 5;
            }
            field("Item Availability (Unrestr.)"; SalesInfoPaneMgt.CalcAvailability(Rec) - (REC."Unavailable Inv. (Whse) FND" / Rec."Qty. per Unit of Measure"))
            {
                ToolTip = 'Item Availability (Unrestr.)';
                Caption = 'Item Availability (Unrestr.)';
                ApplicationArea = all;
                DecimalPlaces = 0 : 5;
            }
        }

    }
    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Reserved Quantity");
        Rec.CALCFIELDS("Unavailable Inv. (Whse) FND"); //HEI.0
    end;

    var
        rCust: Record Customer;
        UnavailableInvWhse: Decimal;
        ItemAvailUnrestr: Decimal;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CALCFIELDS("Reserved Quantity");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CALCFIELDS("Reserved Quantity");
    // <<DITW17.10.05 WSA 29/01/2015 DIT-770 #185
    if rCust.GET("Sell-to Customer No.") then;
    // >>DITW17.10.05 WSA 29/01/2015 DIT-770 #185

    CALCFIELDS("Unavailable Inv. (Whse)"); //HEI.01
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

