tableextension 50193 WarehouseShipmentHeaderExtFND extends "Warehouse Shipment Header"
{
    //     DITW15.00.00.21 DDR 18/06/2008 added fields
    //                                  2014060 Maximum Weight
    //                                  2014061 Maximum Cubage
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
    //                                  "Shipping Agent Service Code,Shipping Agent Code,Location Code,Bin Code,Status,shipment Date"
    //                                Added functions
    //                                  GetFieldCaption(),GetCaptionClass()
    //                                  UpdateShippingUnitCost()
    // DITW15.00.00.23.04 DDR£ 12/09/2008 Rename flowfields + Caption + CalcFormula
    //                                      2014067 "Weight to ship"
    //                                      2014068 "Cubage to ship"
    //                                    Changed key
    //                                      "Shipping Agent Service Code,Shipping Agent Code,Assigned User ID,
    //                                         Location Code,Bin Code,Status,Shipment Date"
    //                                    Added field
    //                                      2014078 Driver Code
    // DITW15.00.00.25 DDR 16/10/2008 Added fields
    //                                  2014077 Truck Code
    // DITW15.00.00.26 DDR 17/11/2008 Copy Max. Weight/Cubage from Truck code
    // DITW15.00.00.28 DDR 02/12/2008 Added fields
    //                                  2014087 Distance
    //                                  2014090 Shipping Cost by Distance
    //                                Updated function UpdateShippingUnitCost() to use new fields
    // DITW15.00.00.30 DDR 08/01/2009 Bugfix function UpdateShippingUnitCost()
    // DITW15.00.00.25.01 DDR 12/01/2009 License problem
    // DITW15.00.00.30 DDR 21/01/2009 merge DITW15.00.00.25.01
    // DITW15.00.00.32 DDR 03/04/2009 Added fields
    //                                  2014091 System-Created Header
    //                                Keep the Value "Distance" when header is not created manually.
    //                                Bugfix clear "Shipping Agent Service Code" when "Shipping Agent Code" is different
    // DITW15.00.00.35 DDR 19/08/2009 issue 773 Added fields
    //                                   2014092 Shipping Currency Code
    //                                Copy vendor currency code while add/change Agent Service code
    //                                Added "Shipping Currency Code" into AutoFormatExpr property for fields
    //                                  "Shipping Unit Cost","Shipping Cost Amount"
    //                     21/08/2009 issue 626 Skipped check if Posting date is not filled in yet
    //                 DLE 06/09/2009 issue 516 Added fields
    //                                  2014094 Physical Location Group Code
    // DITW15.00.00.36 DDR 06/11/2009 issue 777 Bugfix to test "Physical Location Group Code"
    // DITW15.00.00.37 DDR 10/06/2010 issue 1061 Added function LookupPhysLocation()
    //                     17/06/2010 issue 1061 Reviewed to open header with hidden filters in function OpenWhseShptHeader()
    // DITW16.00.00.38 DDR 01/04/2011 DIT-715 issue 87 Upgraded function OpenWhseShptHeader()
    // DITW15.00.00.39 DDR 12/04/2011 issue 1314 Skip to set Physical location when Whse setup "Whse. Doc. per Phys. Location" = No
    // DITW15.00.00.39 DDR 22/08/2011 issue 1399
    //                                  Added 'Pending Pick','Pending Shipping'  optionstring field47 "Status"
    //                                  Added functions ExistWhsePickLine()
    //                                  Added fields
    //                                    2014105 Exist Posting Error Lines (flowfield)
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002
    //                                  Added fields
    //                                    2014107 Route
    //                                  Added 'Delivery Sequence','Route','Route + Destination' optionstring field6 "Sorting Meting"
    //                                  Added functions CountNoOfCustomers()
    //                                  Added "Default Route" from Whse Setup while inserting new record
    //                                  Added keys
    //                                    "Route"
    //                                    "Shipment Date,Truck Code"
    //                     03/02/2012 DIT-715 #152 Bugfix upgrade function OpenWhseShptHeader() while called by NewRecord() form trigger
    //                     03/02/2012 #1331 (HIT0069.1 VVE 19/04/2011) FEFO tracking
    //                                  Added function FEFOTrackingShipment()
    //                                DIT-715 #244 Added functions GetCaptionClassUom(),ShowShortcutUomValue()
    //                     20/02/2012 DIT-715 #245
    //                                  Added fields
    //                                    2014065 Truck Size
    //                                  Modified 'TableRelation' property field2014077 Truck Code
    //                     21/02/2012 DIT-715 #246 Modified function CountNoOfCustomers()
    //                                             Modified FRB caption field2014068
    //                     27/02/2012 DIT-715 #245 Remove flowfield 2014065 Truck Size
    //                                             Added Lookup trigger field2014077 Truck Code
    //                                             Modified 'TableRelation' property field2014077 Truck Code
    //                     01/03/2012 DIT-715 #246 Added functions ShowComments()
    // DITW16.00.00.43 DDR 27/08/2013 DIT-715 #720 Added functions TestIfEmcsSalesHeaderExist()
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    //                                             NORRIQ owm - Online Warehouse Management
    //                                             Copyright 2008 by NORRIQ A/S, www.norriq.dk
    //                                             - Added code to Delete trigger

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
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
    //                                               2014570 C945 Printed
    //                                             Added functions TestVesselInfoMandatory();
    //              DDR 08/08/2013 DIT-770 #95 Removed mandatory on fields "Voyage Details","Voyage Destination"
    //                  27/08/2013 DIT-770 #720 merge
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #95
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 Added Field 2014100 "Trailer Code"
    // DITW18.00.06 MSF 15/05/2015 DIT-770 #884 When there is no SSCC/OWM in license ==> permission issues - part2
    // DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214 Clean Code
    // DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214 Delete Field physical location group code
    //                                                       Modify lookup property for field Driver code , Truck code , trailer code
    // DITW18.00.06 MSF 06/07/2015 DIT-770 #1212 #1213 #1214 Fix lookup field trailer and truck
    // DITW18.00.07 VSC 04/03/2016 DIT-770 #1066 New function
    // DITW18.00.07 VSC 04/03/2016 DIT-770 #1066 CreateShippingCost + Delete Lines On Delete Header
    // DITW18.00.07 VSC 05/03/2016 DIT-770 #1066 Delete Function UpdateShippingUnitCost + Old Code from unused fields.
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 New Field Flowfield "Document Shipping Costs"
    // DITW18.00.07 VSC 29/06/2016 DIT-770 #1066 Removed Fields and allign code
    //                                               2014062 "Shipping Charge Type"
    //                                               2014063 "Shipping Charge No."
    //                                               2014064 "Shipping Charge Per"
    //                                               2014081 "Shipping Unit Cost"
    //                                               2014082 "Shipping Cost Amount"
    //                                               2014090 "Shipping Cost by Distance"
    //                                               2014092 "Shipping Currency Code"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 MSF 11/09/2017 NRQ#16082 Route Planning and Warehouse Documents
    //                              Added field Route planning No & Driver 2 Code
    // DITW110.00.11 MSF 02/10/2017 NRQ#16082 Delete Field "Default Route" From Warehouse Setup
    //                                        Added Validation Trigger to Route planning No
    // DITW110.00.12 MSF 26/03/2018 NRQ65401 Warehouse shipment-receipt document shipping cost does not get correct shipping agent service code
    // DITW111.00.13 MSF 06/12/2018 NRQ#94671 Line and header alert for not fully assigned lines - in warehouse shipment and sales order
    //                                        Added Function ExitUndefinedLot
    // DITW111.00.13 MSF 13/12/2018 NRQ#94671 check base on Ouststanding Qty
    // DITW111.00.13A MSF 06/05/2019 NRQ#106834 AUTO FEFO and Undo Tracking Lines functions for transfer orders

    // HEI.02 FDD-PRDGAP024 IBM POENAB01 01.08.2017
    //   #changed table relation for field 13 Zone Code
    //   #code added in Bin Code - OnValidate()
    // HEI.03 FDD-PRDGAP024 IBM POENAB01 09.08.2017
    //   #code added in Bin Code - OnValidate()
    // HEI.04 FDD-PRDGAP024 IBM POENAB01 11.08.2017
    //   #code added in Bin Code - OnValidate()
    // HEI.05 FDD-LB-GAPLOG09_Lebanon_Almaza_Picking List Layout and FDD_RW-GAPLOG04 - Rwanda_Bralirwa_Picking List Layout_V0.2-HT63 , IBM.NAIKH01 21.08.2018
    //   # Added a new field "No. Printed Combined Pick"
    // HEI.06 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field created: 50001 - "Gate Entry No."
    //   # Migrated code from HEI2.0
    // HEI.07 FDD-HT658 IBM.GUNERE01 06.09.2019 # Code added Route - OnValidate()
    //                                          # code added to Distance - OnValidate()
    //                               10.09.2019 # FilterWhseShippingDrivers, FilterWhseShippingTrucks funcs. added
    //                                          # Driver - OnLookup(), Truck - OnLookup() modified
    //                               20.09.2019 # CreateShippingCost func. modified, GetShippingAgentServiceCreatePOOption func. added
    //                               24.09.2019 # CreateShippingCost func. modified
    //                               01.10.2019 # Shipping Agent Service Code - OnValidate func. modified
    //                                          # CreateShippingCost func. modified
    //                               16.10.2019 # Route - OnValidate func. modified
    //                                          # Truck Code, Driver Code tablerelation fix.
    // HEI.08 FDD-HT658 IBM.GUNERE01 29.10.2019 # CreateShippingCost func. modified
    // HEI.09 CHG2039144 FDD-HT949 IBM.GUNERE01 12.02.2019 # CreateShippingCost func. modified
    // HEI.10 CHG2039144 FDD-HT949 IBM.GUNERE01 12.02.2019 # CreateShippingCost func. modified
    // HEI.11 FDD-HT1075 CHG2039144 IBM.GUNERE01 14.01.2020 # FilterShippingAgentServiceCode func. added
    //                                                        Shipping Agent Service Code - OnLookUp func. modified
    //                                                        CreateShippingCost func. modified
    // HEI.12 FDD-HT1075 CHG2039144 IBM.GUNERE01 16.03.2020 # FilterShippingAgentServiceCode func. modified
    //                                                        Shipping Agent Service Code - OnValidate func. modified
    // HEI.13 CHG2039144 IBM.GUNERE01 07.04.2020 # CreateShippingCost func. modified
    //                                             Shipping Agent Service Code - OnValidate func. modified
    // HEI.14 HB2156CHG2107450 IBM GAVANM01 27.01.2022 # WMS Phase 2 - Transportation cost
    //   # new field added: 50004 - WMS Import
    //BC Upgrade SHARMP16 HEI.11 code shifted to Shipping Agent Service Code on Lookup fn on Warehouse Shipment Page
    //BC Upgrade SHARMP16 Event ubscribe in codeunit 50282 "Heineken Table Cu" HEI.01 OnAfterOnInsert
    //BC UPGRADE PATHAA02-190126 # OnBeforeValidate and OnAfterValidate code added in Zone Code field to bypass mandatory check in Location table -> "Directed Put-away and Pick" field. his workaround is done as no event is available in standard AL code.
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
        modify("Sorting Method")
        {
            CaptionML = ENU = 'Sorting Method', FRA = 'Méthode de tri';
            // OptionCaptionML = ENU = ' ,Item,Document,Shelf or Bin,Due Date,Destination,,,,,Delivery,Route,Route + Destination', FRA = ' ,Article,Document,Emplacement,Délai,Destination,,,,,Livraison,Route,Route + Destination';

            //Unsupported feature: Change OptionString on ""Sorting Method"(Field 6)". Please convert manually.


            //Unsupported feature: Change Description on ""Sorting Method"(Field 6)". Please convert manually.

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
            trigger OnAfterValidate()
            var
                myInt: Integer;
                Location: Record Location;
            begin
                //HEI.03 PRDGAP024>>
                //HEI.04 PRDGAP024>>
                if Location.Get("Location Code") then begin
                    if Bin.Get(Location.Code, Location."Shipment Bin Code") then
                        "Zone Code" := Bin."Zone Code";
                end;
                //HEI.04 PRDGAP024<<
                //HEI.03 PRDGAP024<<
            end;
            //BC Upgrade SHARMP16 end<<
        }
        modify("Zone Code")
        {
            CaptionML = ENU = 'Zone Code', FRA = 'Code zone';
            //BC UPGRADE PATHAA02 19.01.26>>
            trigger OnBeforeValidate()
            var
                location: Record Location;
            begin
                //BC Upgrade GUNREM01 added  >>
                if "Zone Code" <> xRec."Zone Code" then begin
                    //HEI.01 PRDGAP024>>
                    WHSUTILS.CheckUserAuthorizedinZone("Location Code", "Zone Code");
                    VALIDATE("Bin Code", '');
                    //HEI.01 PRDGAP024<<
                end;
                //BC Upgrade GUNREM01  added <<
                IF location.GET("Location Code") THEN BEGIN
                    DirectPickPutAwayValue := location."Directed Put-away and Pick";
                    IF NOT DirectPickPutAwayValue then begin
                        location."Directed Put-away and Pick" := true;
                        location.MODIFY(false);
                    end;
                END;
            end;

            trigger OnAfterValidate()
            var
                location: Record Location;
            begin
                IF location.GET("Location Code") THEN BEGIN
                    location."Directed Put-away and Pick" := DirectPickPutAwayValue;
                    location.MODIFY(false);
                end;
            END;
            // BC UPGRADE PATHAA02 19.01.26<<
            //Unsupported feature: Change TableRelation on ""Zone Code"(Field 13)". Please convert manually.

        }
        modify("Document Status")
        {
            CaptionML = ENU = 'Document Status', FRA = 'Statut document';
            // OptionCaptionML = ENU = ' ,Partially Picked,Partially Shipped,Completely Picked,Completely Shipped', FRA = ' ,Partiellement prélevé,Partiellement expédié,Entièrement prélevé,Entièrement expédié';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Shipping Agent Code")
        {

            //Unsupported feature: Change TableRelation on ""Shipping Agent Code"(Field 41)". Please convert manually.

            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';

            //Unsupported feature: Change Description on ""Shipping Agent Code"(Field 41)". Please convert manually.

        }
        modify("Shipping Agent Service Code")
        {
            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';


            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //>> HEI.07 FDD-HT658 IBM.GUNERE01 01.10.2019
                IF Rec."Shipping Agent Service Code" <> xRec."Shipping Agent Service Code" THEN BEGIN
                    IF xRec."Shipping Agent Service Code" <> '' THEN // HEI.12
                      BEGIN //>> HEI.13
                            //WhseTransportMgt.DeleteWhseShipmentShippingCost(xRec);//BC Upgrade SHARMP16-- Drink-IT function used
                            //  CreateShippingCost;//BC Upgrade SHARMP16-- Drink-IT function used
                    END; //<< HEI.13
                END;
                //<< HEI.07 FDD-HT658 IBM.GUNERE01 01.10.2019
            end;

        }
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Shipment Method Code', FRA = 'Code condition livraison';
        }
        modify("Shipment Date")
        {
            CaptionML = ENU = 'Shipment Date', FRA = 'Date d''expédition';
        }
        modify("Completely Picked")
        {
            CaptionML = ENU = 'Completely Picked', FRA = 'Entièrement prélévé';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            OptionCaptionML = ENU = 'Open,Released,Pending Pick,Pending Shipping', FRA = 'Ouvert,Lancé,Prélèvement suspendu,Livraison suspendue';

            //Unsupported feature: Change OptionString on "Status(Field 47)". Please convert manually.


            //Unsupported feature: Change Description on "Status(Field 47)". Please convert manually.

        }
        modify("External Document No.")
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
        }
        modify("Create Posted Header")
        {
            CaptionML = ENU = 'Create Posted Header', FRA = 'Créer en-tête enregistrée';
        }
        modify("Shipping No.")
        {
            CaptionML = ENU = 'Shipping No.', FRA = 'Utiliser B.L. N°';
        }
        modify("Last Shipping No.")
        {
            CaptionML = ENU = 'Last Shipping No.', FRA = 'N° dern. bon de livraison';
        }
        modify("Shipping No. Series")
        {
            CaptionML = ENU = 'Shipping No. Series', FRA = 'Souche de n° expédition';
        }

        //Unsupported feature: CodeModification on ""Location Code"(Field 2).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if not WmsManagement.LocationIsAllowed("Location Code") then
          ERROR(Text003,"Location Code");

        if "Location Code" <> xRec."Location Code" then begin
          "Zone Code" := '';
          "Bin Code" := '';
          WhseShptLine.SETRANGE("No.","No.");
          if not WhseShptLine.ISEMPTY then
            ERROR(
              Text001,
              FIELDCAPTION("Location Code"));
        end;

        GetLocation("Location Code");
        Location.TESTFIELD("Require Shipment");
        if Location."Directed Put-away and Pick" or Location."Bin Mandatory" then
          VALIDATE("Bin Code",Location."Shipment Bin Code");

        if USERID <> '' then begin
          FILTERGROUP := 2;
          SETRANGE("Location Code","Location Code");
          FILTERGROUP := 0;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
        if CurrFieldNo = FIELDNO("Location Code") then
          TESTFIELD("Multiple Order Route",false);
        //>>DITW110.00.11 MSF 02/10/2017 NRQ#16082
        // <<DITW15.00.00.35 DLE 06/09/2009 - 06/10/2009 - DITW15.00.00.39 DDR 12/04/2011 DIT-715 #1314
        WhseSetup.GET;
        if ("Location Code" <> '') then begin
          GetLocation("Location Code");
          if WhseSetup."Whse. Doc. per Phys. Location" then
            "Physical Location Group Code" := Location."Physical Location Group Code"
          else
            "Physical Location Group Code" := '';
        end;
        // >>DITW15.00.00.35 DDR - DITW15.00.00.39 DDR DIT-715 #87

        // <<DITW15.00.00.35 DDR 06/10/2009
        //IF NOT WmsManagement.LocationIsAllowed("Location Code") THEN
        //  ERROR(Text003,"Location Code");
        //HEI.01 PRDGAP024 BEGIN DELETE
        //IF NOT WmsManagement.LocationPhysIsAllowed("Location Code","Physical Location Group Code") AND
        //  (("Location Code" <> '') OR ("Physical Location Group Code" <> ''))
        //THEN
        //  ERROR(Text2014060,"Location Code","Physical Location Group Code");
        //HEI.01 PRDGAP024 END DELETE
        // >>DITW15.00.00.35 DDR 06/10/2009
        //HEI.01 PRDGAP024>>
        if not WmsManagement.LocationPhysIsAllowed("Location Code","Physical Location Group Code","Zone Code") and
          (("Location Code" <> '') or ("Physical Location Group Code" <> ''))
        then
          // ERROR(Text2014060,"Location Code","Physical Location Group Code");
        // >>DITW15.00.00.35 DDR 06/10/2009
          ERROR(Text50000,"Location Code","Physical Location Group Code","Zone Code");
        //HEI.01 PRDGAP024<<

        #3..7
          // <<DITW15.00.00.35 DDR 06/10/2009
          if ("Physical Location Group Code" = '') or ("Location Code" <> '')  then
          // >>DITW15.00.00.35 DDR
            if not WhseShptLine.ISEMPTY then
              ERROR(
                Text001,
                FIELDCAPTION("Location Code"));
        end;

        // <<DITW15.00.00.35 DDR 06/10/2009
        if "Location Code" = '' then begin
          WhseShptLine.SETRANGE("No.","No.");
          WhseShptLine.SETFILTER("Location Code",'<>%1','');
          if WhseShptLine.FINDSET then
            repeat
              GetLocation(WhseShptLine."Location Code");
              Location.TESTFIELD("Require Shipment");
              if Location."Directed Put-away and Pick" then
                WhseShptLine.VALIDATE("Bin Code",Location."Shipment Bin Code");
            until WhseShptLine.NEXT = 0;
        end else begin
        // >>DITW15.00.00.35 DDR
          GetLocation("Location Code");
          Location.TESTFIELD("Require Shipment");
          if Location."Directed Put-away and Pick" or Location."Bin Mandatory" then
              VALIDATE("Bin Code",Location."Shipment Bin Code");
        // <<DITW15.00.00.35 DDR 06/10/2009
        end;
        // >>DITW15.00.00.35 DDR
        #18..21
          // <<DITW15.00.00.35 DDR 06/10/2009
          SETRANGE("Physical Location Group Code","Physical Location Group Code");
          // >>DITW15.00.00.35 DDR
          FILTERGROUP := 0;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if (xRec."Bin Code" <> "Bin Code") or ("Zone Code" = '') then begin
          TESTFIELD(Status,Status::Open);
          if "Bin Code" <> '' then begin
        #4..12
          end;
          MessageIfShptLinesExist(FIELDCAPTION("Bin Code"));
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..15

        //HEI.03 PRDGAP024>>
        {
        //HEI.02 PRDGAP024>>
          Bin.GET("Location Code","Bin Code");
          "Zone Code" := Bin."Zone Code";
        //HEI.02 PRDGAP024<<
        }
        if Bin.GET(Location.Code,Location."Shipment Bin Code") then
          //HEI.04 PRDGAP024>>
          //VALIDATE("Zone Code",Bin."Zone Code");
          "Zone Code" := Bin."Zone Code";
          //HEI.04 PRDGAP024<<
        //HEI.03 PRDGAP024>>
        */
        //end;


        //Unsupported feature: CodeModification on ""Zone Code"(Field 13).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Zone Code" <> xRec."Zone Code" then begin
          TESTFIELD(Status,Status::Open);
          if "Zone Code" <> '' then begin
            GetLocation("Location Code");
            Location.TESTFIELD("Directed Put-away and Pick");
          end;
          "Bin Code" := '';
          MessageIfShptLinesExist(FIELDCAPTION("Zone Code"));
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
            //HEI.01 PRDGAP024 delete line Location.TESTFIELD("Directed Put-away and Pick");
            //HEI.01 PRDGAP024>>
            WHSUTILS.CheckUserAuthorizedinZone("Location Code","Zone Code");
            VALIDATE("Bin Code",'');
            //HEI.01 PRDGAP024<<
        #6..9
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Posting Date"(Field 39)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
        if CurrFieldNo = FIELDNO("Posting Date") then
          TESTFIELD("Multiple Order Route",false);
        //>>DITW110.00.11 MSF 02/10/2017 NRQ#16082
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Agent Code"(Field 41).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if xRec."Shipping Agent Code" = "Shipping Agent Code" then
          exit;

        "Shipping Agent Service Code" := '';
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
        if CurrFieldNo = FIELDNO("Shipping Agent Code") then
          TESTFIELD("Multiple Order Route",false);
        //>>DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        if (xRec."Shipping Agent Code" <> Rec."Shipping Agent Code") and (Rec."Shipping Agent Code" <>'') then
          if "Physical Location Group Code" <> '' then begin
            ResponsibilityCenter.RESET;
            ResponsibilityCenter.SETRANGE("Physical Location Group Code","Physical Location Group Code");
            if not ResponsibilityCenter.ISEMPTY then begin
              ResponsibilityCenter.FINDFIRST;
              UserSetupMgt.CheckShipmentAgent(ResponsibilityCenter.Code,"Shipping Agent Code");
            end;
          end;
        //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        TestRouteTypeVariable(FIELDNO("Shipping Agent Code"));
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        // <<DITW16.00.00.43 DDR 27/08/2013 DIT-715 #720
        TestIfEmcsSalesHeaderExist(FIELDCAPTION("Shipping Agent Code"));
        // >>DITW16.00.00.43 DDR DIT-715 #720

        // <<DITW15.00.00.32 DDR 03/04/2009
        if (xRec."Shipping Agent Code" <> "Shipping Agent Code") and
           (CurrFieldNo = FIELDNO("Shipping Agent Code"))
        then
          VALIDATE("Shipping Agent Service Code",'');
        // >>DITW15.00.00.32 DDR
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Shipping Agent Service Code"(Field 42)". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //begin
        /*
        //>> HEI.11
        FilterShippingAgentServiceCode;
        //<< HEI.11
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Shipping Agent Service Code"(Field 42)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
        if CurrFieldNo = FIELDNO("Shipping Agent Service Code") then
          TESTFIELD("Multiple Order Route",false);
        //>>DITW110.00.11 MSF 02/10/2017 NRQ#16082
        // <<DITW15.00.00.21 DDR 19/06/2008
        CALCFIELDS("Total Weight To Ship","Total Cubage To Ship");
        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        TestRouteTypeVariable(FIELDNO("Shipping Agent Service Code"));
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        if "Shipping Agent Service Code" <> '' then begin
          rShippingAgentService.GET("Shipping Agent Code","Shipping Agent Service Code");
          "Maximum Weight" := rShippingAgentService."Maximum Weight";
          "Maximum Cubage" := rShippingAgentService."Maximum Cubage";
          // <<DITW15.00.00.28 DDR 02/12/2008 - DITW15.00.00.32 DDR 03/04/2009
          if (not "System-Created Header") and (rShippingAgentService.Distance <> 0) then
            Distance := rShippingAgentService.Distance;
          // >>DITW15.00.00.32 DDR
        end
        else begin
          "Maximum Weight" := 0;
          "Maximum Cubage" := 0;
          // <<DITW15.00.00.28 DDR 02/12/2008 - DITW15.00.00.32 DDR 03/04/2009
          if not "System-Created Header" then
            Distance := 0;
          // >>DITW15.00.00.32 DDR
        end;
        // <<DITW16.00.00.40 DDR 27/02/2012 DIT-715 #245
        "Truck Code" := '';
        // >>DITW16.00.00.40 DDR DIT-715 #245
        // <<DITW15.00.00.26 DDR 17/11/2008
        VALIDATE("Truck Code");
        // >>DITW15.00.00.26 DDR

        //<< DITW18.00.07 VSC 04/03/2016 DIT-770 #1066
        CreateShippingCost;
        //>> DITW18.00.07 VSC DIT-770 #1066

        //>> HEI.07 FDD-HT658 IBM.GUNERE01 01.10.2019
        if Rec."Shipping Agent Service Code" <> xRec."Shipping Agent Service Code" then begin
          if xRec."Shipping Agent Service Code" <> '' then // HEI.12
            begin //>> HEI.13
              WhseTransportMgt.DeleteWhseShipmentShippingCost(xRec);
              CreateShippingCost;
            end; //<< HEI.13
        end;
        //<< HEI.07 FDD-HT658 IBM.GUNERE01 01.10.2019
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Shipment Method Code"(Field 43)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
        if CurrFieldNo = FIELDNO("Shipment Method Code") then
          TESTFIELD("Multiple Order Route",false);
        //>>DITW110.00.11 MSF 02/10/2017 NRQ#16082
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipment Date"(Field 45).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Shipment Date" <> xRec."Shipment Date" then begin
          WhseShptLine.SETRANGE("No.","No.");
          if not WhseShptLine.ISEMPTY then
            if CONFIRM(
                 STRSUBSTNO(Text008,FIELDCAPTION("Shipment Date")),false)
            then
              WhseShptLine.MODIFYALL("Shipment Date","Shipment Date");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        if CurrFieldNo <> 0 then
          TESTFIELD("Multiple Order Route",false);
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        if "Shipment Date" <> xRec."Shipment Date" then begin
          //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
          VALIDATE("Posting Date","Shipment Date");
          //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        #2..8
        */
        //end;


        //Unsupported feature: CodeInsertion on "Status(Field 47)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.39 DDR 22/08/2011 #1399
        if (Status <> Status::Open) and (Status = Status::"Pending Pick") then begin
          if not ExistWhsePickLine(0) then
            FIELDERROR(Status);
        end;
        // >>DITW15.00.00.39 DDR #1399
        */
        //end;
        field(50000; "No. Printed Combined Pick FND"; Integer)
        {
            Caption = 'No. Printed Combined Pick';
            Description = 'HEI.05';
        }
        field(50001; "Gate Entry No. FND"; Code[20])
        {
            Caption = 'Gate Entry No.';
            Description = 'HEI.06';
            TableRelation = "Gate Entry Header FND"."Gate Entry Document No." WHERE(Status = FILTER(Released),
                                                                                 "Gate Entry Type" = FILTER(Outbound | Stay),
                                                                                 "Location Code" = FIELD("Location Code"),
                                                                                 // "Driver Code" = FIELD("Driver Code"),//BC Upgrade SHARMP16-- Drink-IT fields used
                                                                                 // "Vehicle No." = FIELD("Truck Code"),//BC Upgrade SHARMP16-- Drink-IT fields use
                                                                                 "Driver Code" = field("Log Driver 107FDW"),//BC UPGRADE KUMARR78 FDD-MTC-007
                                                                                 "Vehicle No." = field("Vehicle Code 101FDW"),//BC UPGRADE KUMARR78 FDD-MTC-007
                                                                                 Registered = CONST(false));

            trigger OnLookup();
            begin
                //HEI.06>>
                GateEntryNo := LookupGateEntryNo();
                if GateEntryNo <> '' then begin
                    "Gate Entry No. FND" := GateEntryNo;
                    if not CheckGateEntryNo() then
                        ERROR(Err001);
                end;
                //HEI.06<<
            end;

            trigger OnValidate();
            begin
                //HEI.06>>
                if not CheckGateEntryNo() then
                    ERROR(Err001);
                //HEI.06<<
            end;
        }
        field(50002; "Source Document Type FND"; Option)
        {
            Caption = 'Source Document Type';
            Description = 'HEI.07';
            Editable = false;
            OptionCaption = '" ,Sales Order,,,Sales Return Order,Purchase Order,,,Purchase Return Order,Inbound Transfer,Outbound Transfer"';
            OptionMembers = " ","Sales Order",,,"Sales Return Order","Purchase Order",,,"Purchase Return Order","Inbound Transfer","Outbound Transfer";
        }
        field(50003; "Source No. FND"; Code[20])
        {
            CaptionML = ENU = 'Source No.',
                        FRA = 'N° origine';
            Description = 'HEI.07';
            Editable = false;
            TableRelation = IF ("Source Document Type FND" = CONST("Sales Order")) "Sales Header"."No." WHERE("Document Type" = CONST(Order), "No." = FIELD("Source No. FND"))
            ELSE IF ("Source Document Type FND" = CONST("Sales Return Order")) "Sales Header"."No." WHERE("Document Type" = CONST("Return Order"), "No." = FIELD("Source No. FND"))
            ELSE IF ("Source Document Type FND" = CONST("Purchase Order")) "Purchase Header"."No." WHERE("Document Type" = CONST(Order), "No." = FIELD("Source No. FND"))
            ELSE IF ("Source Document Type FND" = CONST("Purchase Return Order")) "Purchase Header"."No." WHERE("Document Type" = CONST("Return Order"), "No." = FIELD("Source No. FND"))
            ELSE IF ("Source Document Type FND" = CONST("Inbound Transfer")) "Transfer Header"."No." WHERE("No." = FIELD("Source No. FND"))
            ELSE IF ("Source Document Type FND" = CONST("Outbound Transfer")) "Transfer Header"."No." WHERE("No." = FIELD("Source No. FND"));
        }
        field(50004; "WMS Import FND"; Boolean)
        {
            Caption = 'WMS Import';
            DataClassification = ToBeClassified;
            Description = 'HEI.14';
            Editable = false;
        }
        //BC Upgrade SHARMP16 Begin>> --------- Drink-IT fields
        // field(2014060; "Maximum Weight"; Decimal)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Maximum Weight',
        //                 FRA = 'Poids maximum';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.21';
        //     MinValue = 0;
        // }
        // field(2014061; "Maximum Cubage"; Decimal)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Maximum Volume (Cubage)',
        //                 FRA = 'Volume (Cubage) maximum';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.21';
        //     MinValue = 0;
        // }
        // field(2014067; "Total Weight To Ship"; Decimal)
        // {
        //     CalcFormula = Sum("Warehouse Shipment Line"."Weight to Ship" WHERE("No." = FIELD("No.")));
        //     CaptionML = ENU = 'Total Weight To Ship',
        //                 FRA = 'Poids total à expédier';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.23.04';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014068; "Total Cubage To Ship"; Decimal)
        // {
        //     CalcFormula = Sum("Warehouse Shipment Line"."Cubage to Ship" WHERE("No." = FIELD("No.")));
        //     CaptionML = ENU = 'Total Volume To Ship (Cubage)',
        //                 FRA = 'Total volume (cubage) à expédier';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.23.04';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014071; "Document Shipping Costs"; Boolean)
        // {
        //     CalcFormula = Exist("Document Shipping Cost" WHERE("Source Type" = CONST(7320),
        //                                                         "Source No." = FIELD("No."),
        //                                                         "Sub Type" = CONST(0)));
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
        //     Description = 'DITW15.00.00.25 -  DITW18.00.06 MSF 06/07/2015 DIT-770 #1212 #1213 #1214,HEI.07';
        //     TableRelation = "Whse. Shipping Truck";

        //     trigger OnLookup();
        //     begin
        //         //>> HEI.07 FDD-HT658 IBM.GUNERE01 10.09.2019
        //         FilterWhseShippingTrucks;
        //         //<< HEI.07 FDD-HT658 IBM.GUNERE01 10.09.2019
        //     end;

        //     trigger OnValidate();
        //     var
        //         lrWhseShippingTruck: Record "Whse. Shipping Truck";
        //     begin
        //         //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //         if CurrFieldNo = FIELDNO("Truck Code") then
        //             TESTFIELD("Multiple Order Route", false);
        //         //>>DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //         //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        //         if (xRec."Truck Code" <> Rec."Truck Code") and (Rec."Truck Code" <> '') then
        //             if "Physical Location Group Code" <> '' then begin
        //                 ResponsibilityCenter.RESET;
        //                 ResponsibilityCenter.SETRANGE("Physical Location Group Code", "Physical Location Group Code");
        //                 if not ResponsibilityCenter.ISEMPTY then begin
        //                     ResponsibilityCenter.FINDFIRST;
        //                     UserSetupMgt.CheckTruck(ResponsibilityCenter.Code, "Truck Code");
        //                 end;
        //             end;
        //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        //         //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         TestRouteTypeVariable(FIELDNO("Truck Code"));
        //         //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         // <<DITW16.00.00.43 DDR 27/08/2013 DIT-715 #720
        //         TestIfEmcsSalesHeaderExist(FIELDCAPTION("Truck Code"));
        //         // >>DITW16.00.00.43 DDR DIT-715 #720
        //         // <<DITW15.00.00.26 DDR 17/11/2008

        //         // <<DITW18.00.06 MSF 14/05/2015 DIT-770 #1212
        //         UpdateShippingMax;
        //         // >>DITW18.00.06 MSF 14/05/2015 DIT-770 #1212
        //     end;
        // }
        // field(2014078; "Driver Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Driver Code',
        //                 FRA = 'Code chauffeur';
        //     Description = 'DITW15.00.00.23.04 -  DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214,HEI.07';
        //     TableRelation = "Whse. Shipping Driver";

        //     trigger OnLookup();
        //     begin
        //         //>> HEI.07 FDD-HT658 IBM.GUNERE01 10.09.2019
        //         FilterWhseShippingDrivers;
        //         //<< HEI.07 FDD-HT658 IBM.GUNERE01 10.09.2019
        //     end;

        //     trigger OnValidate();
        //     begin
        //         //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //         if CurrFieldNo = FIELDNO("Driver Code") then
        //             TESTFIELD("Multiple Order Route", false);
        //         //>>DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //         //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        //         if (xRec."Driver Code" <> Rec."Driver Code") and (Rec."Driver Code" <> '') then
        //             if "Physical Location Group Code" <> '' then begin
        //                 ResponsibilityCenter.RESET;
        //                 ResponsibilityCenter.SETRANGE("Physical Location Group Code", "Physical Location Group Code");
        //                 if not ResponsibilityCenter.ISEMPTY then begin
        //                     ResponsibilityCenter.FINDFIRST;
        //                     UserSetupMgt.CheckDriver(ResponsibilityCenter.Code, "Driver Code");
        //                 end;
        //             end;
        //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        //         //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         TestRouteTypeVariable(FIELDNO("Driver Code"));
        //         //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         // <<DITW16.00.00.43 DDR 27/08/2013 DIT-715 #720
        //         TestIfEmcsSalesHeaderExist(FIELDCAPTION("Driver Code"));
        //         // >>DITW16.00.00.43 DDR DIT-715 #720
        //     end;
        // }
        // field(2014087; Distance; Decimal)
        // {
        //     CaptionML = ENU = 'Distance',
        //                 FRA = 'Distance';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.28';
        //     MinValue = 0;

        //     trigger OnValidate();
        //     begin
        //         //<< DITW18.00.07 VSC 05/03/2016 DIT-770 #1066
        //         //Field will be removed after onshot conversion to new tables
        //         //>> DITW18.00.07 VSC DIT-770 #1066
        //         CreateShippingCost; //HEI.07 FDD-HT658 IBM.GUNERE01 06.09.2019
        //     end;
        // }
        // field(2014091; "System-Created Header"; Boolean)
        // {
        //     CaptionML = ENU = 'System-Created Header',
        //                 FRA = 'En-tête système';
        //     Description = 'DITW15.00.00.32';
        // }
        // field(2014094; "Physical Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Physical Location Group Code',
        //                 FRA = 'Code groupe magasin réel';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Physical Location Group";

        //     trigger OnValidate();
        //     var
        //         lrWhseShptLine: Record "Warehouse Shipment Line";
        //     begin
        //         //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //         if CurrFieldNo = FIELDNO("Physical Location Group Code") then
        //             TESTFIELD("Multiple Order Route", false);
        //         //>>DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //         // <<DITW15.00.00.35 DDR 06/10/2009
        //         if xRec."Physical Location Group Code" <> "Physical Location Group Code" then begin
        //             lrWhseShptLine.SETRANGE("No.", "No.");
        //             if ("Location Code" <> '') or ("Physical Location Group Code" <> '') then
        //                 if lrWhseShptLine.FIND('-') then
        //                     ERROR(
        //                       Text001,
        //                       FIELDCAPTION("Location Code"));
        //         end;

        //         GetLocation("Location Code");

        //         // <<DITW15.00.00.36 DDR 06/11/2009
        //         if (Location."Physical Location Group Code" <> '') and
        //          ("Physical Location Group Code" <> '')
        //         then
        //             TESTFIELD("Physical Location Group Code", Location."Physical Location Group Code");
        //         //HEI.01 PRDGAP024 BEGIN DELETE
        //         //IF NOT WmsManagement.LocationPhysIsAllowed("Location Code","Physical Location Group Code") AND
        //         //  (("Location Code" <> '') OR ("Physical Location Group Code" <> ''))
        //         //THEN
        //         //  ERROR(Text2014060,"Location Code","Physical Location Group Code");
        //         //HEI.01 PRDGAP024 END DELETE
        //         //HEI.01 PRDGAP024>>
        //         if not WmsManagement.LocationPhysIsAllowed("Location Code", "Physical Location Group Code", "Zone Code") and
        //           (("Location Code" <> '') or ("Physical Location Group Code" <> ''))
        //         then
        //             ERROR(Text2014060, "Location Code", "Physical Location Group Code");
        //         //HEI.01 PRDGAP024

        //         if USERID <> '' then begin
        //             FILTERGROUP := 2;
        //             SETRANGE("Location Code", "Location Code");
        //             SETRANGE("Physical Location Group Code", "Physical Location Group Code");
        //             FILTERGROUP := 0;
        //         end;

        //         if (xRec."Physical Location Group Code" <> "Physical Location Group Code") and
        //           (CurrFieldNo = FIELDNO("Physical Location Group Code"))
        //         then
        //             VALIDATE("Location Code");
        //     end;
        // }
        // field(2014098; "Require 2 Drivers"; Boolean)
        // {
        //     Caption = 'Require 2 Drivers';
        //     Description = 'NRQ#16082';

        //     trigger OnValidate();
        //     begin
        //         //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //         if CurrFieldNo = FIELDNO("Require 2 Drivers") then
        //             TESTFIELD("Multiple Order Route", false);
        //         //>>DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //     end;
        // }
        // field(2014099; "Driver 2 Code"; Code[10])
        // {
        //     Caption = 'Driver 2 Code';
        //     Description = 'NRQ#16082';

        //     trigger OnValidate();
        //     begin
        //         //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //         if CurrFieldNo = FIELDNO("Driver 2 Code") then
        //             TESTFIELD("Multiple Order Route", false);
        //         //>>DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //         if (xRec."Driver 2 Code" <> Rec."Driver 2 Code") and (Rec."Driver 2 Code" <> '') then
        //             if "Physical Location Group Code" <> '' then begin
        //                 ResponsibilityCenter.RESET;
        //                 ResponsibilityCenter.SETRANGE("Physical Location Group Code", "Physical Location Group Code");
        //                 if not ResponsibilityCenter.ISEMPTY then begin
        //                     ResponsibilityCenter.FINDFIRST;
        //                     UserSetupMgt.CheckDriver(ResponsibilityCenter.Code, "Driver 2 Code");
        //                 end;
        //             end;
        //         TestRouteTypeVariable(FIELDNO("Driver 2 Code"));
        //     end;
        // }
        // field(2014100; "Trailer Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Trailer Code',
        //                 FRA = 'Code Remorque';
        //     Description = 'DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 - DITW18.00.06 MSF 06/07/2015 DIT-770 #1212 #1213 #1214';
        //     TableRelation = IF ("Physical Location Group Code" = CONST('')) "Whse. Shipping Truck" WHERE("Transport Unit Type" = CONST(Trailer))
        //     ELSE IF ("Physical Location Group Code" = FILTER(<> '')) "Whse. Shipping Truck" WHERE("Responsibility Center" = FIELD("Resp. Center Table Filter"),
        //                                                                                                         "Transport Unit Type" = CONST(Trailer));

        //     trigger OnValidate();
        //     begin
        //         //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //         if CurrFieldNo = FIELDNO("Trailer Code") then
        //             TESTFIELD("Multiple Order Route", false);
        //         //>>DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //         //<<DITW18.00.06 MSF 07/07/2015 DIT-770 #1212 #1213 #1214
        //         if (xRec."Truck Code" <> Rec."Truck Code") and (Rec."Truck Code" <> '') then
        //             if "Physical Location Group Code" <> '' then begin
        //                 ResponsibilityCenter.RESET;
        //                 ResponsibilityCenter.SETRANGE("Physical Location Group Code", "Physical Location Group Code");
        //                 if not ResponsibilityCenter.ISEMPTY then begin
        //                     ResponsibilityCenter.FINDFIRST;
        //                     UserSetupMgt.CheckTrailer(ResponsibilityCenter.Code, "Trailer Code");
        //                 end;
        //             end;
        //         //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         TestRouteTypeVariable(FIELDNO("Trailer Code"));
        //         //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         UpdateShippingMax;
        //         //>>DITW18.00.06 MSF 07/07/2015 DIT-770 #1212 #1213 #1214
        //     end;
        // }
        // field(2014105; "Exist Posting Error Lines"; Integer)
        // {
        //     CalcFormula = Count("Warehouse Shipment Line" WHERE("No." = FIELD("No."),
        //                                                          "Posting Error Line" = CONST(true)));
        //     CaptionML = ENU = 'Exists Posting Error Line(s)',
        //                 FRA = 'Existe lignes d''erreur de validation';
        //     Description = 'DITW15.00.00.39 #1399';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014107; Route; Code[20])
        // {
        //     CaptionML = ENU = 'Route',
        //                 FRA = 'Itinéraire';
        //     Description = 'DITW16.00.00.40 #1002';
        //     TableRelation = Route;

        //     trigger OnValidate();
        //     var
        //         lrxRoute: Record Route;
        //         lrRoute: Record Route;
        //     begin
        //         //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //         WhseSetup.GET;
        //         //>>DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //         //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         if xRec.Route <> Route then begin
        //             if Route <> '' then begin
        //                 if lrxRoute.GET(xRec.Route) then
        //                     lrxRoute.TESTFIELD("Multiple Order Route", false);

        //                 lrRoute.GET(Route);

        //                 if (lrRoute."Shipment Day" <> lrRoute."Shipment Day"::" ") and
        //                   (lrRoute."Shipment Day" <> lrxRoute."Shipment Day")
        //                 then begin
        //                     VALIDATE("Posting Date", "Shipment Date");
        //                 end;
        //                 if lrRoute."Shipment Method Code" <> '' then
        //                     VALIDATE("Shipment Method Code", lrRoute."Shipment Method Code");
        //                 if lrRoute."Shipping Agent Code" <> '' then
        //                     VALIDATE("Shipping Agent Code", lrRoute."Shipping Agent Code");
        //                 if lrRoute."Shipping Agent Service Code" <> '' then
        //                     VALIDATE("Shipping Agent Service Code", lrRoute."Shipping Agent Service Code");
        //                 //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //                 if not WhseSetup."Whse. Doc. per Phys. Location" then
        //                     //>>DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //                     if lrRoute."Location Code" <> '' then begin
        //                         "Physical Location Group Code" := '';
        //                         VALIDATE("Location Code", lrRoute."Location Code");
        //                     end;
        //                 if lrRoute."Physical Location Group Code" <> '' then
        //                     VALIDATE("Physical Location Group Code", lrRoute."Physical Location Group Code");
        //                 if lrRoute."Driver Code" <> '' then
        //                     VALIDATE("Driver Code", lrRoute."Driver Code");
        //                 if lrRoute."Trailer Code" <> '' then
        //                     VALIDATE("Trailer Code", lrRoute."Trailer Code");
        //                 if lrRoute."Driver Code 2" <> '' then
        //                     VALIDATE("Driver 2 Code", lrRoute."Driver Code 2");
        //                 if lrRoute."Truck Code" <> '' then
        //                     VALIDATE("Truck Code", lrRoute."Truck Code");
        //                 //>>HEI.07 FDD-HT658 IBM.GUNERE01 06.09.2019
        //                 if "Source Document Type" = "Source Document Type"::" " then
        //                     if lrRoute.Distance <> 0 then
        //                         VALIDATE(Distance, lrRoute.Distance);
        //                 //<<HEI.07 FDD-HT658 IBM.GUNERE01 06.09.2019
        //                 if (xRec."Location Code" <> "Location Code") or
        //                   (xRec."Shipping Agent Service Code" <> "Shipping Agent Service Code")
        //                 then
        //                     CreateShippingCost();
        //                 "Multiple Order Route" := lrRoute."Multiple Order Route";

        //             end else
        //                 "Multiple Order Route" := false;
        //         end;
        //         //>> HEI.07 FDD-HT658 IBM.GUNERE01 16.10.2019
        //         if xRec.Route <> Route then
        //             CreateShippingCost;
        //         //<< HEI.07 FDD-HT658 IBM.GUNERE01 16.10.2019
        //     end;
        // }
        // field(2014108; "Multiple Order Route"; Boolean)
        // {
        //     Caption = 'Multiple Order Route';
        //     Description = 'NRQ#16082';
        //     TableRelation = Route;

        //     trigger OnValidate();
        //     var
        //         lrxRoute: Record Route;
        //         lrRoute: Record Route;
        //     begin
        //     end;
        // }
        // field(2014109; "Route Planning No."; Code[20])
        // {
        //     Caption = 'Route Planning No.';
        //     Description = 'NRQ#16082';
        //     TableRelation = "Route Planning Worksheet"."No." WHERE("Physical Location Group Code" = FIELD("Phys. Location Table Filter"),
        //                                                             "Location Code" = FIELD("Location Table Filter"));

        //     trigger OnValidate();
        //     var
        //         RoutePlanningWorksheet: Record "Route Planning Worksheet";
        //     begin
        //         //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //         WhseSetup.GET;
        //         if RoutePlanningWorksheet.GET("Route Planning No.") then begin
        //             if (RoutePlanningWorksheet.Route <> '')
        //             then begin
        //                 VALIDATE(Route, RoutePlanningWorksheet.Route);
        //             end;
        //             if (RoutePlanningWorksheet."Shipment/Expected Receipt Date" <> "Shipment Date") and
        //               (RoutePlanningWorksheet."Shipment/Expected Receipt Date" <> 0D)
        //               then begin
        //                 VALIDATE("Posting Date", RoutePlanningWorksheet."Shipment/Expected Receipt Date");
        //             end;
        //             if RoutePlanningWorksheet."Shipment Method Code" <> '' then
        //                 VALIDATE("Shipment Method Code", RoutePlanningWorksheet."Shipment Method Code");
        //             if RoutePlanningWorksheet."Shipping Agent Code" <> '' then
        //                 VALIDATE("Shipping Agent Code", RoutePlanningWorksheet."Shipping Agent Code");
        //             if RoutePlanningWorksheet."Shipping Agent Service Code" <> '' then
        //                 VALIDATE("Shipping Agent Service Code", RoutePlanningWorksheet."Shipping Agent Service Code");

        //             if not WhseSetup."Whse. Doc. per Phys. Location" then //msf
        //                 if RoutePlanningWorksheet."Location Code" <> '' then begin
        //                     "Physical Location Group Code" := '';
        //                     VALIDATE("Location Code", RoutePlanningWorksheet."Location Code");
        //                 end;
        //             if RoutePlanningWorksheet."Physical Location Group Code" <> '' then
        //                 VALIDATE("Physical Location Group Code", RoutePlanningWorksheet."Physical Location Group Code");

        //             if RoutePlanningWorksheet."Driver Code" <> '' then
        //                 VALIDATE("Driver Code", RoutePlanningWorksheet."Driver Code");

        //             if RoutePlanningWorksheet."Trailer Code" <> '' then
        //                 VALIDATE("Trailer Code", RoutePlanningWorksheet."Trailer Code");

        //             if RoutePlanningWorksheet."Driver 2 Code" <> '' then
        //                 VALIDATE("Driver 2 Code", RoutePlanningWorksheet."Driver 2 Code");

        //             if RoutePlanningWorksheet."Truck Code" <> '' then
        //                 VALIDATE("Truck Code", RoutePlanningWorksheet."Truck Code");

        //             if (xRec."Location Code" <> "Location Code") or
        //               (xRec."Shipping Agent Service Code" <> "Shipping Agent Service Code")
        //             then
        //                 VALIDATE("Shipping Agent Service Code", RoutePlanningWorksheet."Shipping Agent Service Code")

        //         end;
        //         //>>DITW110.00.11 MSF 02/10/2017 NRQ#16082
        //     end;
        // }
        // field(2014500; "Resp. Center Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Resp. Center Table Filter',
        //                 FRA = 'Filtre Centre de gestion (table)';
        //     Description = 'DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Responsibility Center";
        // }
        // field(2014501; "Phys. Location Table Filter"; Code[10])
        // {
        //     Caption = 'Phys. Location Table Filter';
        //     Description = 'NRQ#16082';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014502; "Location Table Filter"; Code[10])
        // {
        //     Caption = 'Location Table Filter';
        //     Description = 'NRQ#16082';
        //     FieldClass = FlowFilter;
        //     TableRelation = Location;
        // }
        //BC Upgrade SHARMP16 End<< --------- Drink-IT fields
    }
    keys
    {
        key(Key50000; "Shipping Agent Service Code", "Shipping Agent Code", "Assigned User ID", "Location Code", "Bin Code", Status, "Shipment Date")
        {
        }
        //BC Upgrade SHARMP16 Begin>> --------- Drink-IT Keys
        // key(Key2; Route)
        // {
        // }
        // key(Key3; "Shipment Date", "Truck Code")
        // {
        // }
        //BC Upgrade SHARMP16 End<< --------- Drink-IT fields
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: lOWMUtil)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD(Status,Status::Open);
    DeleteWarehouseShipmentLines;
    DeleteRelatedLines;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    //<<DITW18.00.06 MSF 15/05/2015 DIT-770 #884
    if NowmSetup.READPERMISSION then
    //>>DITW18.00.06 MSF 15/05/2015 DIT-770 #884
    // <<DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
      lOWMUtil.DeleteActivity(lOWMUtil.ActShipment, "No.", "Location Code");
    //<<DITW18.00.06 MSF 15/05/2015 DIT-770 #884
    if SSCCSetup.READPERMISSION then
      lcduSSCCMixedManagement.DeletePreparation(DATABASE::"Warehouse Shipment Line",0,"No.",0);
    //>>DITW18.00.06 MSF 15/05/2015 DIT-770 #884
    // NIQ OWM >>
    //<<DITW18.00.06 MSF 15/05/2015 DIT-770 #884
    if NowmSetup.READPERMISSION then
    //>>DITW18.00.06 MSF 15/05/2015 DIT-770 #884
      lOWMUtil.DeleteActivity(lowmcustomfunctions.actPreparation, "No.", "Location Code");
    // NIQ OWM <<
    // >>DITW16.00.00.43 RBE DIT-715 #806
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInsert". Please convert manually.

    //trigger (Variable: Bin)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WhseSetup.GET;
    if "No." = '' then begin
      WhseSetup.TESTFIELD("Whse. Ship Nos.");
    #4..6
    NoSeriesMgt.SetDefaultSeries("Shipping No. Series",WhseSetup."Posted Whse. Shipment Nos.");

    GetLocation("Location Code");
    VALIDATE("Bin Code",Location."Shipment Bin Code");
    "Posting Date" := WORKDATE;
    "Shipment Date" := WORKDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
    //HEI.01
    if Bin.GET(Location.Code,Location."Shipment Bin Code") then
      VALIDATE("Zone Code",Bin."Zone Code");
    //HEI.01
    #10..12

    // <<DITW15.00.00.39 DDR 12/04/2011 DIT-712 #1314
    if WhseSetup."Whse. Doc. per Phys. Location" then
      TESTFIELD("Physical Location Group Code");
    // >>DITW15.00.00.39 DDR DIT-712 #1314

    ///DITW16.00.00.40 DDR 12/12/2011 #1002 -DITW110.00.11 MSF 02/10/2017 NRQ#16082
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
    // lOWMUtil: Codeunit "N-owm Utils";
    // lcduSSCCMixedManagement: Codeunit "SSCC Mixed Management";
    // lowmcustomfunctions: Codeunit "N-owm Custom Functions";

    var
        Bin: Record Bin;

    var
        lrWhseShptLine: Record "Warehouse Shipment Line";

    var
    //  lcduClearOWMEntries: Codeunit "Clear Open Scanning Entries";

    var
    //  WMSMgt: Codeunit "WMS Management";


    //Unsupported feature: PropertyModification on "Text000(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer l'enregistrement %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot change the %1, because the document has one or more lines.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot change the %1, because the document has one or more lines.;FRA=Vous ne pouvez pas modifier le %1 car le document contient une ou plusieurs ligne(s).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You must first set up user %1 as a warehouse employee.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You must first set up user %1 as a warehouse employee.;FRA=Vous devez d'abord configurer l'utilisateur %1 en tant que magasinier.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=You are not allowed to use location code %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=You are not allowed to use location code %1.;FRA=Vous n'êtes pas autorisé à utiliser le code magasin %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=You have changed %1 on the %2, but it has not been changed on the existing Warehouse Shipment Lines.\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=You have changed %1 on the %2, but it has not been changed on the existing Warehouse Shipment Lines.\;FRA=Vous avez modifié %1 du/de la %2, mais il/elle n'a pas été modifié(e) sur les lignes expédition entrepôt existantes.\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=You must update the existing Warehouse Shipment Lines manually.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=You must update the existing Warehouse Shipment Lines manually.;FRA=Vous devez mettre à jour manuellement les lignes expédition entrepôt existantes.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=You have modified the %1.\\Do you want to update the lines?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=You have modified the %1.\\Do you want to update the lines?;FRA=Vous avez modifié l'enregistrement %1.\\Souhaitez-vous mettre à jour les lignes ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=The items have been picked. If you delete the warehouse shipment, then the items will remain in the shipping area until you put them away.\Related item tracking information that is defined during the pick will be deleted.\Are you sure that you want to delete the warehouse shipment?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=The items have been picked. If you delete the warehouse shipment, then the items will remain in the shipping area until you put them away.\Related item tracking information that is defined during the pick will be deleted.\Are you sure that you want to delete the warehouse shipment?;FRA=Les articles ont été prélevés. Si vous supprimez l'expédition entrepôt, les articles vont rester dans la zone d'expédition jusqu'a ce que vous les rangiez.\Les informations de traçabilité associées définies lors du prélèvement seront supprimées.\Voulez-vous vraiment supprimer l'expédition entrepôt ?;
    //Variable type has not been exported.


    procedure LookupGateEntryNo(): Code[20]
    var
        myInt: Integer;
        GateEntryHdr: Record "Gate Entry Header FND";
    begin
        //HEI.06>>
        //>>HEI:EDD001:1:1
        GateEntryHdr.RESET();
        GateEntryHdr.FILTERGROUP(2);
        GateEntryHdr.SETRANGE(Status, GateEntryHdr.Status::Released);
        GateEntryHdr.SETFILTER("Gate Entry Type", '%1|%2', GateEntryHdr."Gate Entry Type"::Outbound,
          GateEntryHdr."Gate Entry Type"::Stay);
        GateEntryHdr.SETRANGE("Location Code", "Location Code");
        //IF "Driver Code" <> '' THEN
        // GateEntryHdr.SETRANGE("Driver Code", "Driver Code");//BC Upgrade SHARMP16-- Drink-IT field used
        //IF "Truck Code" <> '' THEN
        //  GateEntryHdr.SETRANGE("Vehicle No.", "Truck Code");//BC Upgrade SHARMP16-- Drink-IT field used
        GateEntryHdr.SETRANGE(Registered, FALSE);
        GateEntryHdr.SETRANGE(Assigned, FALSE);
        GateEntryHdr.FILTERGROUP(0);
        IF PAGE.RUNMODAL(50221, GateEntryHdr) = ACTION::LookupOK THEN
            EXIT(GateEntryHdr."Gate Entry Document No.")
        ELSE
            EXIT('');
        //<<HEI:EDD001:1:1
        //HEI.06<<

    end;

    procedure CheckGateEntryNo(): Boolean
    var
        GateEntryHdr: Record "Gate Entry Header FND";
    begin
        //HEI.06>>
        //>>HEI:EDD001:1:1
        IF "Gate Entry No. FND" <> '' THEN BEGIN
            GateEntryHdr.RESET();
            GateEntryHdr.SETRANGE(Status, GateEntryHdr.Status::Released);
            GateEntryHdr.SETFILTER("Gate Entry Type", '%1|%2', GateEntryHdr."Gate Entry Type"::Outbound,
              GateEntryHdr."Gate Entry Type"::Stay);
            GateEntryHdr.SETRANGE("Location Code", "Location Code");
            //BC Upgrade SHARMP16 Begin>> --- Drink-IT fields used
            // IF "Driver Code" <> '' THEN
            //     GateEntryHdr.SETRANGE("Driver Code", "Driver Code");
            // IF "Truck Code" <> '' THEN
            //     GateEntryHdr.SETRANGE("Vehicle No.", "Truck Code");
            //BC Upgrade SHARMP16 End<< --- Drink-IT fields used
            GateEntryHdr.SETRANGE("Gate Entry Document No.", "Gate Entry No. FND");
            GateEntryHdr.SETRANGE(Registered, FALSE);
            GateEntryHdr.SETRANGE(Assigned, FALSE);
            IF GateEntryHdr.FINDFIRST() THEN BEGIN
                IF GateEntryHdr."Gate Entry Type" = GateEntryHdr."Gate Entry Type"::Stay THEN BEGIN
                    GateEntryHdr."Gate Entry Type" := GateEntryHdr."Gate Entry Type"::Outbound;
                    GateEntryHdr."Document Type" := GateEntryHdr."Document Type"::"Warehouse Shipment";
                    GateEntryHdr."Document No." := "No.";
                END;
                //>>HEI:EDD151:1:1
                IF NOT GateEntryHdr."Grouped Control" THEN
                    //<<HEI:EDD151:1:1
                    GateEntryHdr.Assigned := TRUE;
                GateEntryHdr.MODIFY();
                // "Driver Code" := GateEntryHdr."Driver Code";//BC Upgrade SHARMP16  --- Drink-IT fields used
                // "Truck Code" := GateEntryHdr."Vehicle No.";//BC Upgrade SHARMP16 --- Drink-IT fields used
                EXIT(TRUE)
            END ELSE
                EXIT(FALSE);
        END ELSE BEGIN
            IF xRec."Gate Entry No. FND" <> "Gate Entry No. FND" THEN
                IF GateEntryHdr.GET(xRec."Gate Entry No. FND") THEN BEGIN
                    GateEntryHdr.Assigned := FALSE;
                    GateEntryHdr.MODIFY();
                END;
            EXIT(TRUE);
        END;
        //<<HEI:EDD001:1:1
        //HEI.06<<

    end;

    local procedure FilterShippingAgentServiceCode()
    var
        ShippingAgentServices: Record "Shipping Agent Services";
    begin
        //>> HEI.11
        ShippingAgentServices.RESET();
        ShippingAgentServices.SETRANGE("Shipping Agent Code", Rec."Shipping Agent Code");
        // ShippingAgentServices.SETFILTER("Allow Shipping Cost Per", '%1|%2', ShippingAgentServices."Allow Shipping Cost Per"::Warehouse,
        //                                                                  ShippingAgentServices."Allow Shipping Cost Per"::" "); //HEI.12//BC UpgradeSHARMP16-- Drink-IT field used.
        IF PAGE.RUNMODAL(0, ShippingAgentServices) = ACTION::LookupOK THEN
            VALIDATE("Shipping Agent Service Code", ShippingAgentServices.Code);
        //<< HEI.11
    end;

    var
        rShippingAgent: Record "Shipping Agent";
        rShippingAgentService: Record "Shipping Agent Services";
        rCurrency: Record Currency;
        // rShippingWhseSetup: Record "Shipping-Warehouse Setup";
        rInvtSetup: Record "Inventory Setup";
        // cduWhseTransport: Codeunit "Warehouse & Transport Mgt.";
        Text2014060: TextConst ENU = 'You are not allowed to use location code %1 %2. ', FRA = 'Vous n''êtes pas autorisé à utiliser le magasin %1 %2. ';
        // WhseInfoPaneMgt: Codeunit "Whse. Info-Pane Management";
        // WhseTransportMgt: Codeunit "Warehouse & Transport Mgt.";
        Text2014261: TextConst ENU = 'You cannot change the %1, because the document %2 %3 line %4 is attached to a EMCS AAD document.', FRA = 'Vous ne pouvez pas modifier %1 car le document %2 %3 et ligne %4 est lié à un document EMCS DAA.';
        // NowmSetup: Record "N-owm Setup";
        // SSCCSetup: Record "SSCC Setup";
        ResponsibilityCenter: Record "Responsibility Center";
        UserSetupMgt: Codeunit "User Setup Management";
        // DocumentShippingCost: Record "Document Shipping Cost";
        Text50000: Label '"You are not allowed to use location code %1 %2 %3. "';
        WHSUTILS: Codeunit "WHS-UTILS";
        Err001: Label 'Invalid Gate Entry No.';
        GateEntryNo: Code[20];
        DirectPickPutAwayValue: Boolean;
}

