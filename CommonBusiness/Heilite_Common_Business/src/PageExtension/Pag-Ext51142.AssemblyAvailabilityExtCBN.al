pageextension 51142 AssemblyAvailabilityExtCBN extends "Assembly Availability"
{
    // version NAVW110.0,DITW110.00.08
    //     DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //***********************************************************************************
    //BC UPGRADE PATHAA02 19.11.25
    //1. Made "Description" field non editable as it can't be handled on Table 900-Assembly Header
    //2. DIT commented

    layout
    {
        modify(Details)
        {
            CaptionML = ENU = 'Details', FRA = 'Détails';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number assigned to the assembly order from the number series that you set up in the Assembly Setup window.', FRA = 'Spécifie le numéro affecté à l''ordre d''assemblage à partir de la souche de numéro configurée dans la fenêtre Paramètres d''assemblage.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item that is being assembled with the assembly order.', FRA = 'Indique le numéro de l''article qui est assemblé avec l''ordre d''assemblage.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the assembly item.', FRA = 'Spécifie la description de l''article d''assemblage.';
            Editable = false; //BC UPGRADE PATHAA02 
        }
        modify("Current Quantity")
        {
            CaptionML = ENU = 'Current Quantity', FRA = 'Quantité actuelle';
            ToolTipML = ENU = 'Specifies how many units of the assembly item remain to be posted as assembled output.', FRA = 'Spécifie le nombre d''unités de l''article d''assemblage qui doivent encore être validées comme production d''assemblage.';
        }
        modify("Reserved Quantity")
        {
            ToolTipML = ENU = 'Specifies how many units of the assembly item are reserved for this assembly order header.', FRA = 'Spécifie le nombre d''unités de l''article d''assemblage qui sont réservées pour cet en-tête d''ordre d''assemblage.';
        }
        modify(AbleToAssemble)
        {
            CaptionML = ENU = 'Able to Assemble', FRA = 'Possible à assembler';
            ToolTipML = ENU = 'Specifies how many units of the assembly item can be assembled, based on the availability of components on the assembly order lines.', FRA = 'Spécifie le nombre d''unités de l''article d''assemblage pouvant être assemblées en fonction de la disponibilité des composants sur les lignes d''ordres d''assemblage.';
        }
        modify(EarliestAvailableDate)
        {
            CaptionML = ENU = 'Earliest Available Date', FRA = 'Date disponibilité au plus tôt';
            ToolTipML = ENU = 'Specifies the late arrival date of an inbound supply order that can cover the needed quantity of the assembly item.', FRA = 'Spécifie la date d''arrivée tardive d''une commande approvisionnement entrante pouvant couvrir la quantité nécessaire de l''article d''assemblage.';
        }
        modify(Inventory)
        {
            CaptionML = ENU = 'Inventory', FRA = 'Stocks';
            ToolTipML = ENU = 'Specifies how many units of the assembly item are in inventory.', FRA = 'Indique le nombre d''unités de l''article d''assemblage présentes dans le stock.';
        }
        modify(GrossRequirement)
        {
            CaptionML = ENU = 'Gross Requirement', FRA = 'Besoin brut';
            ToolTipML = ENU = 'Specifies the total demand for the assembly item.', FRA = 'Spécifie la demande totale pour l''article d''assemblage.';
        }
        modify(ReservedRequirement)
        {
            CaptionML = ENU = 'Reserved Requirement', FRA = 'Besoin réservé';
        }
        modify(ScheduledReceipts)
        {
            CaptionML = ENU = 'Scheduled Receipts', FRA = 'Réceptions planifiées';
            ToolTipML = ENU = 'Specifies how many units of the assembly item are inbound on orders.', FRA = 'Spécifie le nombre d''unités de l''article d''assemblage entrantes sur les commandes.';
        }
        modify(ReservedReceipts)
        {
            CaptionML = ENU = 'Reserved Receipts', FRA = 'Réceptions réservées';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the code of the item variant of the item that is being assembled.', FRA = 'Indique le code de la variante article de l''article qui est assemblé.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location to which you want to post output of the assembly item.', FRA = 'Indique le magasin vers lequel vous souhaitez valider la production de l''article d''assemblage.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code of the assembly item.', FRA = 'Spécifie le code unité de l''article d''assemblage.';
        }

        //Unsupported feature: Change Visible on "AssemblyLineAvail(Control 7)". Please convert manually.

        //BC UPGRADE PATHAA02 DIT>>

        // addafter("Unit of Measure Code")
        // {
        //     field("Physical Location Group Code"; "Physical Location Group Code")
        //     {
        //         Importance = Additional;
        //     }
        //     field("Responsibility Center"; "Responsibility Center")
        //     {
        //         Importance = Additional;
        //         Visible = false;
        //     }
        // }
        //BC UPGRADE PATHAA02 DIT<<
    }

    var
    // UserMgt: Codeunit "User Setup Management"; //BC UPGRADE PATHAA02- not used


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    //<<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    SetSecurityFilterOnRespCenter();
    //>>DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

