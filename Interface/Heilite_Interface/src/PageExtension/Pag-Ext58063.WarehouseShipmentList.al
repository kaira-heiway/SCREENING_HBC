pageextension 58063 WarehouseShipmentListExt extends "Warehouse Shipment List"
{
    // version NAVW110.0,DITW110.00.11
    // DITW15.00.00.21 DDR 19/06/2008 added columns
    //                                  "Shipping Charge Type","Shipping Charge No.","Shipping Charge Per"
    //                                  "Shipping Agent Code","Shipping Agent Service Code","Shipment Method Code","Shipment Date"
    //                                  "Shipping Unit Cost","Shipping Cost Amount"
    //                                  "Total Weight","Total Volume"
    //                                resize form + HorizGlue on control2
    //                                form editable and only modify (all fields not editable except "Shipping charge per")
    //                                add form's property CalcFields
    //                                added function FormatMaximumControls()
    // DITW15.00.00.25 DDR 17/10/2008 Non-Editable columns "Shipment Method Code","Shipment Date"
    //                                Addded columns "Truck Code","Driver Code"
    // DITW15.00.00.35 DDR 19/08/2009 issue 773 Added fields "Shipping Currency Code"
    //                 DDR 06/10/2009 issue 516 Added field "Physical Location Group Code"
    // DITW15.00.00.37 DDR 02/06/2010 issue 1061 Added default Not visible fields "Physical Location Group Code"
    // DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
    //                                Added shortcut (warehouse) fields
    //                                  Control1100079000 Shortcut Unit of Measure1 Code
    //                                  Control1100079001 Shortcut Unit of Measure2 Code
    //                                  Control1100079002 Shortcut Unit of Measure3 Code
    //                                Added Standard Global Dimension Lookup (see from 53 as reference)
    //                     16/02/2012 issue 1002 Added columns "Route"
    //                     17/02/2012 DIT-715 #244 Removed double columns "Shipping Agent","Shipping Agent Service","Shipment date"
    //                                             Added/Moved columns
    //                     17/02/2012 DIT-715 #246 Added menu 'Warehouse Lines' into 'Lines' button
    //                                             Added function Editablefields()
    //                                             Modified parameters for function FormatMaxControls()
    //                                             Removed 'Editable' property fields
    //                                               "Shipping Agent Code","Shipping Agent Service Code","Truck Code","Driver Code",
    //                                               "Assigned User ID"
    //                                             Non-Editable fields

    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 Added Field 2014100 "Trailer Code"
    // DITW18.00.07 VSC 29/06/2016 DIT-770 #1066 Removed Fields and allign code
    //                                               "Shipping Currency Code"
    //                                               "Shipping Charge Type"
    //                                               "Shipping Charge No."
    //                                               "Shipping Charge Per"
    //                                               "Shipping Unit Cost"
    //                                               "Shipping Cost Amount"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added Fields
    //                                "Require 2 Drivers"
    //                                "Driver 2 Code"
    //                                "Multiple Order Route"
    //                                 "Route Planning No."
    // HEI.01 HB2156CHG2107450 IBM GAVANM01 27.01.2022 # WMS Phase 2 - Transportation cost
    //   # new field added: WMS Import
    //   # new global var VisibleWMS, WMSInterfaceSetup
    //   # code added in OnInit()

    // BC Upgrade SHUKLP03 >> Added code on trigge OnOpenPage() of OnInit()

    layout
    {
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location from which the items are being shipped.', FRA = 'Spécifie le code du magasin à partir duquel les articles sont expédiés.';

            //Unsupported feature: Change Editable on ""Location Code"(Control 4)". Please convert manually.

        }
        modify("Assigned User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.', FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';

            //Unsupported feature: Change Editable on ""Assigned User ID"(Control 19)". Please convert manually.

        }
        modify("Sorting Method")
        {
            ToolTipML = ENU = 'Specifies the method by which the shipments are sorted.', FRA = 'Indique la méthode permettant de trier les expéditions.';

            //Unsupported feature: Change Editable on ""Sorting Method"(Control 6)". Please convert manually.

        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies the status of the shipment and is filled in by the program.', FRA = 'Spécifie le statut de l''expédition. La valeur est renseignée par le programme.';

            //Unsupported feature: Change Editable on "Status(Control 8)". Please convert manually.

        }
        modify("Zone Code")
        {
            ToolTipML = ENU = 'Specifies the code of the zone on this shipment header.', FRA = 'Spécifie le code de la zone qui figure sur cet en-tête réception.';

            //Unsupported feature: Change Editable on ""Zone Code"(Control 1102601001)". Please convert manually.

        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Indicates the bin code to place the items that are about to be shipped.', FRA = 'Indique le code emplacement pour positionner les articles qui vont être expédiés.';

            //Unsupported feature: Change Editable on ""Bin Code"(Control 1102601007)". Please convert manually.

        }
        modify("Document Status")
        {
            ToolTipML = ENU = 'Specifies the progress level of warehouse handling on lines in the warehouse shipment.', FRA = 'Spécifie le niveau de progression de la gestion des entrepôts sur les lignes de l''expédition entrepôt.';

            //Unsupported feature: Change Editable on ""Document Status"(Control 1102601010)". Please convert manually.

        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies a posting date. If you enter a date, the posting date of the source documents is updated during posting.', FRA = 'Spécifie une date de validation. Si vous saisissez une date, la date comptabilisation des documents origine sera mise à jour au cours de la validation.';

            //Unsupported feature: Change Editable on ""Posting Date"(Control 1102601012)". Please convert manually.

        }
        modify("Assignment Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the document was assigned to the user.', FRA = 'Spécifie la date à laquelle le document a été affecté à l''utilisateur.';
        }
        addafter("Shipment Method Code")
        {
            field("WMS Import"; Rec."WMS Import FND")  // BC Upgrade SHUKLP03 <<
            {
                Description = 'HEI.01';
                Visible = VisibleWMS;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("&Shipment")
        {
            CaptionML = ENU = '&Shipment', FRA = 'E&xpédition';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify("Pick Lines")
        {
            CaptionML = ENU = 'Pick Lines', FRA = 'Lignes prélèvement';
        }
        modify("Registered P&ick Lines")
        {
            CaptionML = ENU = 'Registered P&ick Lines', FRA = '&Lignes prélèvement enreg.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Re&lease")
        {
            CaptionML = ENU = 'Re&lease', FRA = '&Lancer';
        }
    }

    trigger OnOpenPage()
    begin
        VisibleWMS := WMSInterfaceSetup.GET() AND WMSInterfaceSetup."WMS Integration";  //HEI.01

    end;

    var
        WMSInterfaceSetup: Record "WMS Interface Setup INT";  // BC Upgrade SHUKLP03 <<
        VisibleWMS: Boolean; // BC Upgrade SHUKLP03 <<



    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

