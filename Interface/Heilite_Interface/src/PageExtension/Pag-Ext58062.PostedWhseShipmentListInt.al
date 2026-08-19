pageextension 58062 PostedWhseShipmentListExt extends "Posted Whse. Shipment List"
{
    // version NAVW110.0,DITW110.00.11
    //     DITW15.00.00.21 DDR 19/06/2008 added columns
    //                                  "Shipping Charge Type","Shipping Charge No.","Shipping Charge Per"
    //                                  "Shipping Agent Code","Shipping Agent Service Code","Shipment Method Code","Shipment Date"
    //                                  "Shipping Unit Cost","Shipping Cost Amount"
    //                                  "Total Weight","Total Volume"
    //                                  "Shipment date"
    //                                resize form + HorizGlue on control8
    //                                add form's property CalcFields
    // DITW15.00.00.25 DDR 17/10/2008 Addded columns "Truck Code","Driver Code"
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
    // DITW18.00.07 VSC 15/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1066 Removed old Shipping Costs fields

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added Fields
    //                                "Require 2 Drivers"
    //                                "Driver 2 Code"
    //                                "Trailer Code"
    //                                "Route Planning No."
    //                                 Route

    // HEI.01 FDD-HT1139A IBM NASTAA02 12.05.2020 # DRC - BVM Interface
    //   # New Field added: "Export Status"
    //   # New Page Action created: "Export BVM Delivery"
    //   # Code added on 'OnOpenPage' trigger
    // HEI.02 HB2156CHG2107450 IBM GAVANM01 27.01.2022 # WMS Phase 2 - Transportation cost
    //   # new field added: WMS Import
    //   # new global var VisibleWMS, WMSInterfaceSetup
    //   # code added in OnInit()

    // BC Upgrade SHUKLP03 >> Added code on trigger OnOpenPage() of OnInit().
    // BC Upgrade SHUKLP03 >> Action("Export BVM Delivery") is blocked because this codeunit "BVM Processing Launcher" is not required anymore.

    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the posted warehouse shipment document header that was created.', FRA = 'Spécifie le numéro d''en-tête expédition entrepôt enregistré qui a été créé.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location from which the items were shipped.', FRA = 'Spécifie le code du magasin à partir duquel les articles ont été expédiés.';
        }
        modify("Assigned User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.', FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
        }
        modify("No. Series")
        {
            ToolTipML = ENU = 'Specifies the number series code to apply to the record created when you post a warehouse shipment.', FRA = 'Spécifie le code souche de numéros à appliquer à l''enregistrement créé lorsque vous validez une expédition entrepôt.';
        }
        modify("Whse. Shipment No.")
        {
            ToolTipML = ENU = 'Specifies the number of the warehouse shipment that the posted warehouse shipment originates from.', FRA = 'Spécifie le numéro de l''expédition entrepôt d''où est issue l''expédition entrepôt enregistrée.';
        }
        modify("Zone Code")
        {
            ToolTipML = ENU = 'Specifies the code of the zone on this posted shipment header.', FRA = 'Spécifie le code de la zone qui figure sur cet en-tête expédition enregistré.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies the code of the bin on the posted warehouse shipment header.', FRA = 'Spécifie le code de l''emplacement qui figure sur l''en-tête expédition entrepôt.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date of the posted warehouse shipment.', FRA = 'Indique la date comptabilisation de l''expédition entrepôt validée.';
        }
        modify("Assignment Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the document was assigned to the user.', FRA = 'Spécifie la date à laquelle le document a été affecté à l''utilisateur.';
        }
        addafter("Shipment Method Code")
        {
            field("Export Status"; Rec."Export Status FND") // BC Upgrade SHUKLP03 <<
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
            }
            field("WMS Import"; Rec."WMS Import FND") // BC Upgrade SHUKLP03 <<
            {
                Description = 'HEI.02';
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
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
        }
        // BC Upgrade SHUKLP03 >> Blocked because this codeunit "BVM Processing Launcher" is not required anymore.
        // addafter(Card)
        // {
        //     action("Export BVM Delivery")
        //     {
        //         Caption = 'Export BVM Delivery';
        //         Image = Export;
        //         Promoted = true;
        //         PromotedCategory = New;
        //         PromotedIsBig = true;
        //         Visible = ExportBVMDeliveryEnabled;
        //         ApplicationArea = All;

        //         trigger OnAction();
        //         var
        //             BVMProcessingLauncher: Codeunit "BVM Processing Launcher";
        //         begin
        //             //HEI.01>>
        //             BVMProcessingLauncher.ManuallyProcessDeliveryResponse(Rec."No.");
        //             //HEI.01<<
        //         end;
        //     }
        // }
        // BC Upgrade SHUKLP03 << Blocked because this codeunit "BVM Processing Launcher" is not required anymore.

    }

    trigger OnOpenPage()
    var
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        BVMInterfaceSetup: Record "BVM Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
    begin
        VisibleWMS := WMSInterfaceSetup.GET() AND WMSInterfaceSetup."WMS Integration";  //HEI.02
                                                                                        //HEI.01>>
        GeneralOpCoSetup.GET();

        IF GeneralOpCoSetup."Enable BVM Integration" THEN
            IF BVMInterfaceSetup.GET() THEN
                IF InterfaceSetup.GET(BVMInterfaceSetup."BVM Delivery Interface Code") THEN
                    IF InterfaceSetup.Enabled THEN
                        ExportBVMDeliveryEnabled := TRUE;
        //HEI.01<<

    end;

    var
        ExportBVMDeliveryEnabled: Boolean;
        VisibleWMS: Boolean; // BC Upgrade SHUKLP03 <<
        WMSInterfaceSetup: Record "WMS Interface Setup INT"; // BC Upgrade SHUKLP03 <<



    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

