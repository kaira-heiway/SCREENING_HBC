pageextension 54010 DemandForecastEntriesExt extends "Demand Forecast Entries"
{
    // version NAVW110.0,HEI.01

    // HEI.01 FDD-BPMGAP001_BPMGAP002 IBM HORTOC01 06.09.2017 
    //   New field "Forecast Quantity HL"


    //Bc Upgrade YADAVM09 Page name change in BC from Production Forecast Entries to Demand Forecast Entries


    layout
    {
        modify("Production Forecast Name")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the name of the production forecast to which the entry belongs.', FRA = 'Spécifie le nom de la prévision de production à laquelle l''écriture appartient.';
        }
        modify("Item No.")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the item identification number of the entry.', FRA = 'Spécifie le numéro d''identification de l''article dans l''écriture.';
        }
        modify(Description)
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies a brief description of your forecast.', FRA = 'Indique une brève description de votre prévision.';
        }
        modify("Forecast Quantity (Base)")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the quantity of the entry stated, in base units of measure.', FRA = 'Spécifie la quantité de l''écriture mentionnée, exprimée en unités de base.';
        }
        modify("Forecast Date")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the date of the production forecast to which the entry belongs.', FRA = 'Spécifie la date de la prévision de production à laquelle l''écriture appartient.';
        }
        modify("Forecast Quantity")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the quantities you have entered in the production forecast within the selected time interval.', FRA = 'Spécifie les quantités que vous avez saisies dans la prévision de production dans l''intervalle de temps sélectionné.';
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the unit of measure code that is valid for the production forecast entry.', FRA = 'Spécifie le code unité valable pour l''écriture de prévision production.';
        }
        modify("Qty. per Unit of Measure")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the valid number of units that the unit of measure code represents for the production forecast entry.', FRA = 'Spécifie le nombre d''unités valable que le code unité représente pour l''écriture prévision de production.';
        }
        modify("Location Code")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the code for the location that is linked to the entry.', FRA = 'Spécifie le code du magasin lié à l''écriture.';
        }
        modify("Component Forecast")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies that the forecast entry is for a component item.', FRA = 'Spécifie que l''écriture prévision concerne un article de composant.';
        }
        modify("Entry No.")
        {
            ApplicationArea = all;
            ToolTipML = ENU = 'Specifies the entry number of the production forecast line.', FRA = 'Spécifie le numéro d''écriture de la ligne prévision production.';
        }
        addafter("Forecast Quantity")
        {
            field("Forecast Quantity HL"; Rec."Forecast Quantity HL FND")
            {
                ApplicationArea = all;
            }
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

