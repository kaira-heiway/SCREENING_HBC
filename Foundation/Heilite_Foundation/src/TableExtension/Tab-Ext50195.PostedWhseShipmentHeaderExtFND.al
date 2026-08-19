tableextension 50195 PostedWhseShipmentHeaderExtFND extends "Posted Whse. Shipment Header"
{
    // DITW15.00.00.21 DDR 18/06/2008 added fields
    //                                  2014062 Shipping Charge Type
    //                                  2014063 Shipping Charge No.
    //                                  2014064 Shipping Charge Per
    //                                  2014067 Total Weight (sum flowfield [Lines])
    //                                  2014068 Total Cubage (sum flowfield [Lines])
    //                                  2014081 Shipping Unit Cost
    //                                  2014082 Shipping Cost Amount
    //                                  2014083 Shipping Quantity Invoiced
    //                                  2014084 Shipping Qty. Rcd. Not Invd.
    //                                added new key
    //                                  "Shipping Agent Service Code,Shipping Agent Code,Location Code,Bin Code,shipment Date"
    //                                  "Shipping Agent Code"
    //                                Added functions
    //                                  GetFieldCaption()
    //                                  GetCaptionClass()
    // DITW15.00.00.23.04 DDR 12/09/2008 Added fields
    //                                      2014078 Driver Code
    // DITW15.00.00.25 DDR 16/10/2008 Added fields
    //                                  2014077 Truck Code
    // DITW15.00.00.35 DDR 19/08/2009 issue 773 Added fields
    //                                   2014092 Shipping Currency Code
    //                                Added "Shipping Currency Code" into AutoFormatExpr property for fields
    //                                  "Shipping Unit Cost","Shipping Cost Amount"
    //                 DLE 06/09/2009 issue 516 Added fields
    //                                  2014094 Physical Location Group Code
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields
    //                                  2014087 Distance
    //                                  2014107 Route
    //                     13/02/2012 DIT-715 #244 Added functions GetCaptionClassUom(),ShowShortcutUomValue()

    // DITW17.00.02 DDR 17/05/2013 DIT-770 #95 Added fields
    //                                               2014560 Vessel info code
    //                                               2014561 Port Code
    //                                               2014562 Wharf Code
    //                                               2014563 No. of Crews
    //                                               2014564 No. of Passengers
    //                                               2014565 Estimated Voyage (Days)
    //                                               2014566 Estimated Voyage (Text)
    //                                               2014567 Voyage Details
    //                                               2014568 Voyage Destination
    //                                               2014569 Net Tonnage
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #95
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 New Field Flowfield "Document Shipping Costs"
    // DITW18.00.07 VSC 29/06/2016 DIT-770 #1066 Removed Fields and allign code
    //                                               2014062 "Shipping Charge Type"
    //                                               2014063 "Shipping Charge No."
    //                                               2014064 "Shipping Charge Per"
    //                                               2014081 "Shipping Unit Cost"
    //                                               2014082 "Shipping Cost Amount"
    //                                               2014083 "Shipping Quantity Invoiced"
    //                                               2014084 "Shipping Qty. Not Invd."
    //                                               2014092 "Shipping Currency Code"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added Fields
    //                                "Require 2 Drivers"
    //                                "Driver 2 Code"
    //                                "Route Planning No."
    //                                 "Trailer Code"
    // HEI.01 FDD-LB-GAPLOG03 IBM NASTAA02 17.07.2018 # Loading Note Almaza
    //   # New Field created 50000 - No. Printed (Load List)
    // HEI.02 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field created: 50001 - "Gate Entry No."
    // HEI.03 FDD-HT1139A IBM NASTAA02 12.05.2020 # DRC - BVM Interface
    //   # New Field created: 50002 - "Export Status"
    // HEI.04 HB2156CHG2107450 IBM GAVANM01 27.01.2022 # WMS Phase 2 - Transportation cost
    //   # new field added: 50004 - WMS Import

    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Assigned User ID")
        {
            CaptionML = ENU = 'Assigned User ID', FRA = 'Code utilisateur affecté';
        }
        modify("Assignment Date")
        {
            CaptionML = ENU = 'Assignment Date', FRA = 'Date affectation';
        }
        modify("Assignment Time")
        {
            CaptionML = ENU = 'Assignment Time', FRA = 'Heure affectation';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("Bin Code")
        {
            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
        }
        modify("Zone Code")
        {
            CaptionML = ENU = 'Zone Code', FRA = 'Code zone';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Shipment Date")
        {
            CaptionML = ENU = 'Shipment Date', FRA = 'Date d''expédition';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
        }
        modify("Shipping Agent Service Code")
        {
            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';
        }
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Shipment Method Code', FRA = 'Code condition livraison';
        }
        modify("Whse. Shipment No.")
        {
            CaptionML = ENU = 'Whse. Shipment No.', FRA = 'N° expédition entrepôt';
        }
        modify("External Document No.")
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
        }
        field(50000; "No. Printed (Load List) FND"; Integer)
        {
            caption = 'No. Printed (Load List)';
            Description = 'HEI.01';
        }
        field(50001; "Gate Entry No. FND"; Code[20])
        {
            Caption = 'Gate Entry No.';
            Description = 'HEI.02';
            Editable = false;
            TableRelation = "Gate Entry Header FND";
        }
        field(50002; "Export Status FND"; Option)
        {
            Caption = 'Export Status';
            Description = 'HEI.03';
            OptionCaption = ' ,Pending Export,Exported';
            OptionMembers = " ","Pending Export",Exported;
        }
        field(50004; "WMS Import FND"; Boolean)
        {
            Caption = 'WMS Import';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        //BC Upgrade SHARMP16 Begin<<-----------------Drink-IT fields
        // field(2014067; "Total Weight"; Decimal)
        // {
        //     CalcFormula = Sum("Posted Whse. Shipment Line".Weight where("No." = FIELD("No.")));
        //     CaptionML = ENU = 'Total Weight',
        //                 FRA = 'Poids total';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014068; "Total Cubage"; Decimal)
        // {
        //     CalcFormula = Sum("Posted Whse. Shipment Line".Cubage where("No." = FIELD("No.")));
        //     CaptionML = ENU = 'Total Volume (Cubage)',
        //                 FRA = 'Volume (Cubage) total';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014071; "Document Shipping Costs"; Boolean)
        // {
        //     CalcFormula = Exist("Posted Document Shipping Cost" where("Source Type" = CONST(7322),
        //                                                                "Source No." = FIELD("No.")));
        //     CaptionML = ENU = 'Document Shipping Costs',
        //                 FRA = 'Document Frais livraison';
        //     Description = 'DIT-770 #1066';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014077; "Truck Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Truck Code',
        //                 FRA = 'Code camion';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Whse. Shipping Truck";
        // }
        // field(2014078; "Driver Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Driver Code',
        //                 FRA = 'Code chauffeur';
        //     Description = 'DITW15.00.00.23.04';
        //     TableRelation = "Whse. Shipping Driver";
        // }
        // field(2014087; Distance; Decimal)
        // {
        //     CaptionML = ENU = 'Distance',
        //                 FRA = 'Distance';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.40 #1002';
        //     MinValue = 0;
        // }
        // field(2014094; "Physical Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Physical Location Group Code',
        //                 FRA = 'Code groupe magasin réel';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014098; "Require 2 Drivers"; Boolean)
        // {
        //     Caption = 'Require 2 Drivers';
        //     Description = 'NRQ16082';
        // }
        // field(2014099; "Driver 2 Code"; Code[10])
        // {
        //     Caption = 'Driver 2 Code';
        //     Description = 'NRQ16082';
        // }
        // field(2014100; "Trailer Code"; Code[10])
        // {
        //     Caption = 'Trailer Code';
        //     Description = 'NRQ16082';
        //     TableRelation = "Whse. Shipping Truck";
        // }
        // field(2014107; Route; Code[20])
        // {
        //     CaptionML = ENU = 'Route',
        //                 FRA = 'Itinéraire';
        //     Description = 'DITW16.00.00.40 #1002';
        //     TableRelation = Route;
        // }
        // field(2014109; "Route Planning No."; Code[20])
        // {
        //     Caption = 'Route Planning No.';
        //     Description = 'NRQ16082';
        //     TableRelation = "Route Planning Worksheet";

        //     trigger OnValidate();
        //     var
        //         RoutePlanningWorksheet: Record "Route Planning Worksheet";
        //     begin
        //     end;
        // }
        //BC Upgrade SHARMP16 End>>-----------------Drink-IT fields
    }
    keys
    {
        key(Key50000; "Shipping Agent Service Code", "Shipping Agent Code", "Location Code", "Bin Code", "Shipment Date")
        {
        }
        key(Key50001; "Shipping Agent Code")
        {
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You must first set up user %1 as a warehouse employee.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You must first set up user %1 as a warehouse employee.;FRA=Vous devez d'abord configurer l'utilisateur %1 en tant que magasinier.;
    //Variable type has not been exported.
}

