tableextension 50091 TransferHeaderExtFND extends "Transfer Header"
{

    //   DITW15.00.00.25 DDR 10/10/2008 Added fields
    //                                  2014077 Truck Code
    //                                  2014078 Driver Code
    //                     24/10/2008 clear truck & driver codes when change transfer-from code
    // DITW15.00.00.30 DDR 09/01/2009 Added function CheckCombLocations() to verify the location combination is valid.
    // DITW15.00.00.36 DDR 17/12/2009 issue 594 Added AAD fields
    //                                   2013726 From Tax Registration No.
    //                                   2013730 Fiscal Representative No.
    // DITW15.00.00.37 DDR 04/02/2010 issue 480 Added fields
    //                                   2013695 Item Charge Type Filter
    //                                   2013696 Transf.-from Location Gr. Code
    //                                   2013758 Transf.-to Location Gr. Code
    //                                   2014094 Trsf-from Ph. Location Gr Code
    //                                   2014101 Trsf-to Ph. Location Gr Code
    //                                Added functions InternalChargesExists(),SuspendStatusCheck(),GetLocation()
    // DITW15.00.00.38 DDR 20/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Renamed field "From Tax Registration No." -> "Tax Registration no." (means "Transfer-to Code")
    //                                  Added fields
    //                                    2014271 Tax Warehouse Reference
    //                     27/01/2011 issue 1217 (DIT711 137)
    //                                  Modified Caption field2013730 "Fiscal Representative No."
    //                                  Added fields
    //                                    2014460 Tax Office Code
    //                     11/03/2011 issue 458 Replaced caption field2013696 'Location Group' -> 'Location Tax Group'
    //                                                           field2013758
    // DITW15.00.00.39 DDR 06/07/2011 issue 1353 Added fields
    //                                   2014290 Journey Time
    //                     04/08/2011 issue 1353 Modified caption field2014290 "Journey Time"
    //                     19/08/2011 issue 1363
    //                                  Added text constant Text2013664
    //                                  Added fields
    //                                    2013733 Tax Date
    //                     12/10/2011 issue 1433 bugfix to refresh tax & AAD/ARC data while changing Transfer from-to Locations
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields
    //                                    2014495 Delivery Sequence
    //                     22/12/2011 DIT-715 issue 187
    //                                  Added fields
    //                                    2014277 Transport Mode (flowfield)
    //                                    2014291 Transport Mode Comment (flowfield)
    //                                DIT-715 #244 Added functions GetCaptionClassUom(),ShowShortcutUomValue()
    //                     20/02/2012 DIT-715 #245
    //                                  Added fields
    //                                    2014065 Truck Size
    //                                  Modified 'TableRelation' property field2014077 Truck Code
    //                     27/02/2012 DIT-715 #245 Remove flowfield 2014065 Truck Size
    //                                             Added Lookup trigger field2014077 Truck Code
    //                                             Modified 'TableRelation' property field2014077 Truck Code
    // DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457
    //                                  Added fields
    //                                    2034983 Work Order No.
    // DITW16.00.00.42 DDR 18/12/2012 DIT-715 #517 Added "Location Filter" with function ShowShortcutUomValue()
    //                 DDR 10/01/2013 DIT-715 #537 Bugfix while validating "Posting date" from Whse document (while posting)

    // FINXL7.00.001 RBE 20/03/2013 : Added new field 2029610 - Automatic Ship & Receive
    // FINXL8.00.001 BSA 04/06/2015 #180: Added Function FCTSetShowConfirmation
    // FINXL8.00.001 BSA 05/06/2015 #182: Added Field "Emergency Order","Logistics Group"

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 New Field "Auto Create Shipping Cost" + Function CreateShippingCost
    // DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Delete Document Shipping Costs
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 New Field Flowfield "Document Shipping Costs"
    //                                           Moved Function CreateShippingCost to CU "Warehouse & Transport Mgt." as CreateTransHdrShippingCost
    //                                           Moved to be called later WhseTransportMgt.CreateTransHdrShippingCost(Rec);
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field 2014421 "Document Subtype Code"
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 16/02/2017 NRQ#20755 Update document subtype code table relation filter
    // ITW110.00.11 MSF 11/09/2017 NRQ#16082 Route Planning and Warehouse Documents
    //                                       Added fields Route planning No.
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Delete Field Route planning No.
    // DITW111.00.13A MSF 30/04/2019 NRQ#106834 AUTO FEFO and Undo Tracking Lines functions for transfer orders
    //                                           Added function FEFOTrackingTransferOrder

    //    HEI.01 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New Field created: 50001 - Request Order No.
    // HEI.02 FDD-BA-LOGGAP01 IBM NASTAA02 09.10.2018 # Request Order
    //   # Table Relation "Request Order Header" removed from "Request Order No."
    //   # Code added on OnLookup Trigger of "Request Order No." Field to open the Request Order Archive Page
    // DITW110.00.12 AKH 30/03/2018 NRQ#16026 Order Shipment Planning: Sync Sales - Transfer
    // DITW110.00.12 AKH 02/05/2018 NRQ#16026 Several Adjustments
    // HEI.03 FDD-HT658 IBM.GUNERE01 04.09.2019 # "Driver Code", "Truck Code" fields TableRelation modified
    //                               06.09.2019 # code added to Distance - OnValidate()
    //                               16.09.2019 # code added to Route - OnValidate()
    //                                          # code added to Transfer-to Code - OnValidate()
    //                                            code added to Shipping Agent Service Code - OnValidate()
    //                               24.09.2019 # Transfer-to Code - OnValidate, Shipping Agent Service Code - OnValidate,
    //                                            Distance - OnValidate() funcs. modified
    //                               30.09.2019 # Shipment Method Code - OnValidate func. modified
    // HEI.04 FDD-HT604 IBM.GAVANM01 13.01.2020 # WMS integration Heilite BASE and Reflex
    //   # New field added : 50002 - WMS Export
    // HEI.05 FDD-HT1075 CHG2039144 IBM.GUNERE01 15.01.2020 # FilterShippingAgentServiceCode func. added
    //                                                        "Shipping Agent Service Code" - OnValidate func. modified
    // HEI.06 FDD-HT1075 CHG2039144 IBM.GUNERE01 16.03.2020 # FilterShippingAgentServiceCode func. modified
    // HEI.07 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
    //   # New Field created : 50005 - IC Document
    // HEI.08 FDD-HB1438 CHG2065311 IBM SHANKJ03 30.07.2020
    //   # New Field created : PO Reference & Extra PO reference
    //   # Code Added
    // HEI.09 CHG2069358 IBM.AK 25.08.2020
    //   # New field created : Created By
    //   # Code added on InitRecord
    // HEI.10 CHG2093869 GAVANM01 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
    //   # new field added: 50009 - LSR Order No
    // HEI.11 CHG2098629 HB2014 IBM NANDIS01 08.04.2021 - LOG_Automatic creation of Transfer Order for Import PO
    //   # Delete TO Reference field value once respective TO is deleted
    //   # If PO Reference field having some values then TO can not be modified
    // HEI.12 CHG2161266 HB3003 NORRIQ KOROLA04 06.10.2022
    //   # Import Identifier - field added
    // HEI.13 CHG2161266 HB3003 NORRIQ KOROLA04 20.10.2022
    //   # Import Identifier - field name fixed
    // HEI.14 CHG2200434 IBM COSTES04 19.05.2023 Column Data Availability of WH Shipment & WH Receipt No
    //   # New fields added Posted Whse. Receipt No. , Posted Whse. Shipment No.
    // HEI.15 CHG2216722 IBM SISUM01 03.10.2023  Request for email functionality for Transfer Order Creation
    //   # New field id 50021


    // BC Upgrade SHUKLP03 >>
    // "WMS Export" AND "LSR Order No" shared with Sakshi.
    // DrinkIT code blocked.
    // Proceduer FilterShippingAgentServiceCode() some part of code is blocked because dependency on DrinkIT field.
    // HEI.05=> Trigger OnLookup() code of field "Shipping Agent Service Code" is added on page "Transfer Orders" and "Transfer Order".
    // HEI.11 code of TestOpenStatus() is already blocked.
    // HEI.03 Procedure LOCAL FilterWhseShippingTrucks() and LOCAL FilterWhseShippingDrivers() is not added because DrinkIT object Whse.Shipping Driver, Whse.Shipping Truck is used..
    // Trigger Onvalidate() of field "Transfer-to code", "Shipping Agent Service Code","Shipment Method Code" code is not added because code is written in-between DrinkIT code.
    // HEI.03 code is not added because written on DrinkIT fields "Truck code", "Driver Code", Distance and Route.
    // BC Upgrade SHUKLP03 <<

    // BC Upgrade SHUKLP03 >> 
    // 50066 Document Subtype code field added.
    // Subscribed event OnAfterInitRecord to add Document Subtype code of procedure InitRecord.
    // BC Upgrade SHUKLP03 <<

    // "WMS Export" AND "LSR Order No" of table Transfer Header is added here.

    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Transfer-from Code")
        {

            //Unsupported feature: Change TableRelation on ""Transfer-from Code"(Field 2)". Please convert manually.

            CaptionML = ENU = 'Transfer-from Code', FRA = 'Code prov. transfert';
        }
        modify("Transfer-from Name")
        {
            CaptionML = ENU = 'Transfer-from Name', FRA = 'Nom prov. transfert';
        }
        modify("Transfer-from Name 2")
        {
            CaptionML = ENU = 'Transfer-from Name 2', FRA = 'Nom prov. transfert 2';
        }
        modify("Transfer-from Address")
        {
            CaptionML = ENU = 'Transfer-from Address', FRA = 'Adresse prov. transfert';
        }
        modify("Transfer-from Address 2")
        {
            CaptionML = ENU = 'Transfer-from Address 2', FRA = 'Adresse prov. transfert 2';
        }
        modify("Transfer-from Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Transfer-from Post Code"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Transfer-from Post Code', FRA = 'Code postal prov. transfert';
        }
        modify("Transfer-from City")
        {

            //Unsupported feature: Change TableRelation on ""Transfer-from City"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Transfer-from City', FRA = 'Ville prov. transfert';
        }
        modify("Transfer-from County")
        {
            CaptionML = ENU = 'Transfer-from County', FRA = 'Pays prov. transfert';
        }
        modify("Trsf.-from Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Trsf.-from Country/Region Code"(Field 10)". Please convert manually.

            CaptionML = ENU = 'Trsf.-from Country/Region Code', FRA = 'Code pays/région prov. transfert';
        }
        modify("Transfer-to Code")
        {

            //Unsupported feature: Change TableRelation on ""Transfer-to Code"(Field 11)". Please convert manually.

            CaptionML = ENU = 'Transfer-to Code', FRA = 'Code dest. transfert';
        }
        modify("Transfer-to Name")
        {
            CaptionML = ENU = 'Transfer-to Name', FRA = 'Nom dest. transfert';
        }
        modify("Transfer-to Name 2")
        {
            CaptionML = ENU = 'Transfer-to Name 2', FRA = 'Nom dest. transfert 2';
        }
        modify("Transfer-to Address")
        {
            CaptionML = ENU = 'Transfer-to Address', FRA = 'Adresse dest. transfert';
        }
        modify("Transfer-to Address 2")
        {
            CaptionML = ENU = 'Transfer-to Address 2', FRA = 'Adresse dest. transfert 2';
        }
        modify("Transfer-to Post Code")
        {
            CaptionML = ENU = 'Transfer-to Post Code', FRA = 'Code postal dest. transfert';
        }
        modify("Transfer-to City")
        {

            //Unsupported feature: Change TableRelation on ""Transfer-to City"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Transfer-to City', FRA = 'Ville dest. transfert';
        }
        modify("Transfer-to County")
        {
            CaptionML = ENU = 'Transfer-to County', FRA = 'Pays dest. transfert';
        }
        modify("Trsf.-to Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Trsf.-to Country/Region Code"(Field 19)". Please convert manually.

            CaptionML = ENU = 'Trsf.-to Country/Region Code', FRA = 'Code pays/région dest. transfert';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Shipment Date")
        {
            CaptionML = ENU = 'Shipment Date', FRA = 'Date d''expédition';
        }
        modify("Receipt Date")
        {
            CaptionML = ENU = 'Receipt Date', FRA = 'Date de réception';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            OptionCaptionML = ENU = 'Open,Released', FRA = 'Ouvert,Lancé';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 24)". Please convert manually.

            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("Shortcut Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 1 Code"(Field 25)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 2 Code"(Field 26)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("In-Transit Code")
        {

            //Unsupported feature: Change TableRelation on ""In-Transit Code"(Field 27)". Please convert manually.

            CaptionML = ENU = 'In-Transit Code', FRA = 'Code transit';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Last Shipment No.")
        {
            CaptionML = ENU = 'Last Shipment No.', FRA = 'Date dern. expédition';
        }
        modify("Last Receipt No.")
        {
            CaptionML = ENU = 'Last Receipt No.', FRA = 'Date dern. réception';
        }
        modify("Transfer-from Contact")
        {
            CaptionML = ENU = 'Transfer-from Contact', FRA = 'Contact prov. transfert';
        }
        modify("Transfer-to Contact")
        {
            CaptionML = ENU = 'Transfer-to Contact', FRA = 'Contact dest. transfert';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
        }
        modify("Shipping Agent Service Code")
        {

            //Unsupported feature: Change TableRelation on ""Shipping Agent Service Code"(Field 35)". Please convert manually.

            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';
        }
        modify("Shipping Time")
        {
            CaptionML = ENU = 'Shipping Time', FRA = 'Délai d''expédition';
        }
        modify("Transaction Type")
        {
            CaptionML = ENU = 'Transaction Type', FRA = 'Type de transaction';
        }
        modify("Transport Method")
        {
            CaptionML = ENU = 'Transport Method', FRA = 'Mode de transport';
        }
        modify("Entry/Exit Point")
        {
            CaptionML = ENU = 'Entry/Exit Point', FRA = 'Pays destination/provenance';
        }
        modify("Area")
        {
            CaptionML = ENU = 'Area', FRA = 'Dépt destination/provenance';
        }
        modify("Transaction Specification")
        {
            CaptionML = ENU = 'Transaction Specification', FRA = 'Régime';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Shipping Advice")
        {
            CaptionML = ENU = 'Shipping Advice', FRA = 'Option d''expédition';
            //OptionCaptionML = ENU = 'Partial,Complete', FRA = 'Partielle,Totale';
        }
        modify("Posting from Whse. Ref.")
        {
            CaptionML = ENU = 'Posting from Whse. Ref.', FRA = 'Validation à partir réf. entrepôt';
        }
        modify("Completely Shipped")
        {

            //Unsupported feature: Change CalcFormula on ""Completely Shipped"(Field 5752)". Please convert manually.

            CaptionML = ENU = 'Completely Shipped', FRA = 'Entièrement expédiée';
        }
        modify("Completely Received")
        {

            //Unsupported feature: Change CalcFormula on ""Completely Received"(Field 5753)". Please convert manually.

            CaptionML = ENU = 'Completely Received', FRA = 'Entièrement réceptionné';
        }
        modify("Location Filter")
        {
            CaptionML = ENU = 'Location Filter', FRA = 'Filtre magasin';
        }
        modify("Outbound Whse. Handling Time")
        {
            CaptionML = ENU = 'Outbound Whse. Handling Time', FRA = 'Délai désenlogement';
        }
        modify("Inbound Whse. Handling Time")
        {
            CaptionML = ENU = 'Inbound Whse. Handling Time', FRA = 'Délai enlogement';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Assigned User ID")
        {
            CaptionML = ENU = 'Assigned User ID', FRA = 'Code utilisateur affecté';
        }

        //Unsupported feature: CodeModification on ""No."(Field 1).OnValidate". Please convert manually.

        //trigger "(Field 1)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." <> xRec."No." THEN BEGIN
          GetInventorySetup;
          NoSeriesMgt.TestManual(GetNoSeriesCode);
          "No. Series" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "No." <> xRec."No." then begin
        #2..4
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Transfer-from Code"(Field 2).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF ("Transfer-from Code" = "Transfer-to Code") AND
           ("Transfer-from Code" <> '')
        THEN
          ERROR(
            Text001,
            FIELDCAPTION("Transfer-from Code"),FIELDCAPTION("Transfer-to Code"),
            TABLECAPTION,"No.");
        IF xRec."Transfer-from Code" <> "Transfer-from Code" THEN BEGIN
          IF HideValidationDialog OR
             (xRec."Transfer-from Code" = '')
          THEN
            Confirmed := TRUE
          else
            Confirmed := CONFIRM(Text002,FALSE,FIELDCAPTION("Transfer-from Code"));
          IF Confirmed THEN BEGIN
            IF Location.GET("Transfer-from Code") THEN BEGIN
              "Transfer-from Name" := Location.Name;
              "Transfer-from Name 2" := Location."Name 2";
              "Transfer-from Address" := Location.Address;
              "Transfer-from Address 2" := Location."Address 2";
              "Transfer-from Post Code" := Location."Post Code";
              "Transfer-from City" := Location.City;
              "Transfer-from County" := Location.County;
              "Trsf.-from Country/Region Code" := Location."Country/Region Code";
              "Transfer-from Contact" := Location.Contact;
              "Outbound Whse. Handling Time" := Location."Outbound Whse. Handling Time";
              TransferRoute.GetTransferRoute(
                "Transfer-from Code","Transfer-to Code","In-Transit Code",
                "Shipping Agent Code","Shipping Agent Service Code");
              TransferRoute.GetShippingTime(
                "Transfer-from Code","Transfer-to Code",
                "Shipping Agent Code","Shipping Agent Service Code",
                "Shipping Time");
              TransferRoute.CalcReceiptDate(
                "Shipment Date",
                "Receipt Date",
                "Shipping Time",
                "Outbound Whse. Handling Time",
                "Inbound Whse. Handling Time",
                "Transfer-from Code",
                "Transfer-to Code",
                "Shipping Agent Code",
                "Shipping Agent Service Code");
              TransLine.LOCKTABLE;
              TransLine.SETRANGE("Document No.","No.");
              IF TransLine.findset THEN;
              MODIFY;
            end;
            UpdateTransLines(FIELDNO("Transfer-from Code"));
          end else BEGIN
            "Transfer-from Code" := xRec."Transfer-from Code";
            EXIT;
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //TestStatusOpen;
        TestOpenStatus;
        //>> DITW110.00.12 AKH NRQ#16026
        if ("Transfer-from Code" = "Transfer-to Code") and
           ("Transfer-from Code" <> '')
        then
        #5..8
        if xRec."Transfer-from Code" <> "Transfer-from Code" then begin
          if HideValidationDialog or
             (xRec."Transfer-from Code" = '')
          then
            Confirmed := true
          else
            // <<DITW15.00.00.37 DDR 09/02/2010
            // Confirmed := CONFIRM(Text002,FALSE,FIELDCAPTION("Transfer-from Code"));
            Confirmed := CONFIRM(Text2013663,false,FIELDCAPTION("Transfer-from Code"));
            // >>DITW15.00.00.37 DDR

          if Confirmed then begin
            // <<DITW15.00.00.30 DDR 09/01/2009
            CheckCombLocations();
            // >>DITW15.00.00.30 DDR
            if Location.GET("Transfer-from Code") then begin
        #18..27
              //<<FINXL7.00.001 RBE 20/03/2013
              //TransferRoute.GetTransferRoute(
              //  "Transfer-from Code","Transfer-to Code","In-Transit Code",
              //  "Shipping Agent Code","Shipping Agent Service Code");
              if recFinXLSetup.READPERMISSION then
                TransferRoute.GetTransferRoute(
                  "Transfer-from Code","Transfer-to Code","In-Transit Code",
                  "Shipping Agent Code","Shipping Agent Service Code","Automatic Ship & Receive");
              //>>FINXL7.00.001 RBE 20/03/2013
        #31..34
              // <<DITW15.00.00.39 DDR 06/07/2011 #1353
              TransferRoute.GetJourneyTime(
                "Transfer-from Code","Transfer-to Code",
                "Shipping Agent Code","Shipping Agent Service Code",
                "Journey Time");
              // >>DITW15.00.00.39 DDR #1353
        #35..44
              //<< DITW110.00.12 AKH 30/03/2018 - 02/05/2018 NRQ#16026
              if (CurrFieldNo <> FIELDNO(Route))  and (Route <> xRec.Route) then
                SetRoute(TransferRoute);
              "Delivery Sequence" := TransferRoute."Delivery Sequence";
              //>> DITW110.00.12 AKH NRQ#16026
              TransLine.LOCKTABLE;
              TransLine.SETRANGE("Document No.","No.");
              if TransLine.findset then;

              // <<DITW15.00.00.25 DDR 24/10/2008
              "Driver Code" := '';
              "Truck Code" := '';
              // >>DITW15.00.00.25 DDR
              //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
              ClearDeliveryTimes;
              //>> DITW110.00.12 AKH NRQ#16026
              // <<DITW15.00.00.37 DDR 28/05/2010
              "Transf.-from Location Gr. Code" := Location."Location Group Code";
              "Trsf-from Ph. Location Gr Code" := Location."Physical Location Group Code";
              // >>DITW15.00.00.37 DDR
              MODIFY;
            end;
            UpdateTransLines(FIELDNO("Transfer-from Code"));
            //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
            UpdateRoutePlanRqstLines(FIELDCAPTION("Transfer-from Code"));
            //>> DITW110.00.12 AKH NRQ#16026
          end else begin
            "Transfer-from Code" := xRec."Transfer-from Code";
            // <<DITW15.00.00.37 DDR 28/05/2010
            "Transf.-from Location Gr. Code" := xRec."Transf.-from Location Gr. Code";
            "Trsf-from Ph. Location Gr Code" := xRec."Trsf-from Ph. Location Gr Code";
            // >>DITW15.00.00.37 DDR
            exit;
          end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Transfer-from Post Code"(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Transfer-from City","Transfer-from Post Code",
          "Transfer-from County","Trsf.-from Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Transfer-from City","Transfer-from Post Code",
          "Transfer-from County","Trsf.-from Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Transfer-from City"(Field 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Transfer-from City","Transfer-from Post Code",
          "Transfer-from County","Trsf.-from Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Transfer-from City","Transfer-from Post Code",
          "Transfer-from County","Trsf.-from Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Transfer-to Code"(Field 11).OnValidate". Please convert manually.

        //trigger (Variable: _Location)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Transfer-to Code"(Field 11).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF ("Transfer-from Code" = "Transfer-to Code") AND
           ("Transfer-to Code" <> '')
        THEN
          ERROR(
            Text001,
            FIELDCAPTION("Transfer-from Code"),FIELDCAPTION("Transfer-to Code"),
            TABLECAPTION,"No.");
        IF xRec."Transfer-to Code" <> "Transfer-to Code" THEN BEGIN
          IF HideValidationDialog OR
             (xRec."Transfer-to Code" = '')
          THEN
            Confirmed := TRUE
          else
            Confirmed := CONFIRM(Text002,FALSE,FIELDCAPTION("Transfer-to Code"));
          IF Confirmed THEN BEGIN
            IF Location.GET("Transfer-to Code") THEN BEGIN
              "Transfer-to Name" := Location.Name;
              "Transfer-to Name 2" := Location."Name 2";
              "Transfer-to Address" := Location.Address;
              "Transfer-to Address 2" := Location."Address 2";
              "Transfer-to Post Code" := Location."Post Code";
              "Transfer-to City" := Location.City;
              "Transfer-to County" := Location.County;
              "Trsf.-to Country/Region Code" := Location."Country/Region Code";
              "Transfer-to Contact" := Location.Contact;
              "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
              TransferRoute.GetTransferRoute(
                "Transfer-from Code","Transfer-to Code","In-Transit Code",
                "Shipping Agent Code","Shipping Agent Service Code");
              TransferRoute.GetShippingTime(
                "Transfer-from Code","Transfer-to Code",
                "Shipping Agent Code","Shipping Agent Service Code",
                "Shipping Time");
              TransferRoute.CalcReceiptDate(
                "Shipment Date",
                "Receipt Date",
                "Shipping Time",
                "Outbound Whse. Handling Time",
                "Inbound Whse. Handling Time",
                "Transfer-from Code",
                "Transfer-to Code",
                "Shipping Agent Code",
                "Shipping Agent Service Code");
              TransLine.LOCKTABLE;
              TransLine.SETRANGE("Document No.","No.");
              IF TransLine.findset THEN;
              MODIFY;
            end;
            UpdateTransLines(FIELDNO("Transfer-to Code"));
          end else BEGIN
            "Transfer-to Code" := xRec."Transfer-to Code";
            EXIT;
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //TestStatusOpen;
        TestOpenStatus;
        //>> DITW110.00.12 AKH NRQ#16026
        if ("Transfer-from Code" = "Transfer-to Code") and
           ("Transfer-to Code" <> '')
        then
        #5..8
        if xRec."Transfer-to Code" <> "Transfer-to Code" then begin
          if HideValidationDialog or
             (xRec."Transfer-to Code" = '')
          then
            Confirmed := true
          else
            // <<DITW15.00.00.37 DDR 09/02/2010
            // Confirmed := CONFIRM(Text002,FALSE,FIELDCAPTION("Transfer-to Code"));
            Confirmed := CONFIRM(Text2013663,false,FIELDCAPTION("Transfer-to Code"));
            // >>DITW15.00.00.37 DDR

          if Confirmed then begin
            // <<DITW15.00.00.30 DDR 09/01/2009
            CheckCombLocations();
            // >>DITW15.00.00.30 DDR

            if LocationTo.GET("Transfer-to Code") then begin
              "Transfer-to Name" := LocationTo.Name;
              "Transfer-to Name 2" := LocationTo."Name 2";
              "Transfer-to Address" := LocationTo.Address;
              "Transfer-to Address 2" := LocationTo."Address 2";
              "Transfer-to Post Code" := LocationTo."Post Code";
              "Transfer-to City" := LocationTo.City;
              "Transfer-to County" := LocationTo.County;
              "Trsf.-to Country/Region Code" := LocationTo."Country/Region Code";
              "Transfer-to Contact" := LocationTo.Contact;
              "Inbound Whse. Handling Time" := LocationTo."Inbound Whse. Handling Time";
              //<< DITW18.00.07 VSC 10/03/2016 DIT-770 #1066
              "Auto Create Shipping Cost" := LocationTo."Auto Create Shipping Cost";
              //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
              WhseTransportMgt.CreateTransHdrShippingCost(Rec);
              //>> DITW18.00.07 VSC DIT-770 #1066
              //>>  DITW18.00.07 VSC DIT-770 #1066
              //<<FINXL7.00.001 RBE 20/03/2013
              //TransferRoute.GetTransferRoute(
              //  "Transfer-from Code","Transfer-to Code","In-Transit Code",
              //  "Shipping Agent Code","Shipping Agent Service Code");
              if recFinXLSetup.READPERMISSION then
                TransferRoute.GetTransferRoute(
                  "Transfer-from Code","Transfer-to Code","In-Transit Code",
                  "Shipping Agent Code","Shipping Agent Service Code","Automatic Ship & Receive");
              //>>FINXL7.00.001 RBE 20/03/2013
        #31..44
              //<< DITW110.00.12 AKH 30/03/2018 - 02/05/2018 NRQ#16026
              SetRoute(TransferRoute);
              "Delivery Sequence" := TransferRoute."Delivery Sequence";
              FillDeliveryTimes("Transfer-to Code","Shipment Date");
              //>> DITW110.00.12 AKH NRQ#16026
              // <<DITW15.00.00.38 DDR 20/08/2010 #1217
              "Tax Registration No." := LocationTo."Tax Registration No.";
              "Fiscal Representative No." := '';
              // >>DITW15.00.00.38 DDR
              // <<DITW15.00.00.38 DDR 27/01/2011 #1217 (DIT711 137)
              "Tax Office Code" := LocationTo."Tax Office Code";
              // <<DITW15.00.00.38 DDR #1217 (DIT711 137)
              // <<DITW15.00.00.38 DDR 13/09/2010 #1217
              "Tax Warehouse Reference" := LocationTo."Tax Warehouse Reference";
              // >>DITW15.00.00.38 DDR
              //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
             //>> HEI.03 FDD-HT658 IBM.GUNERE01 16.09.2019
              if ("Shipping Agent Service Code" <> '') then
                //("Auto Create Shipping Cost" = "Auto Create Shipping Cost"::Always) THEN // HEI.03 FDD-HT658 IBM.GUNERE01 24.09.2019
                WhseTransportMgt.CreateTransHdrShippingCost(Rec)
              else
                WhseTransportMgt.DeleteTransHdrShippingCost(xRec,false);
              //WhseTransportMgt.CreateTransHdrShippingCost(Rec);
              //<< HEI.03 FDD-HT658 IBM.GUNERE01 16.09.2019
              //>> DITW18.00.07 VSC DIT-770 #1066

              TransLine.LOCKTABLE;
              TransLine.SETRANGE("Document No.","No.");
              if TransLine.findset then;
              // <<DITW15.00.00.37 DDR 28/05/2010
              "Transf.-to Location Gr. Code" := LocationTo."Location Group Code";
              "Trsf-to Ph. Location Gr Code" := LocationTo."Physical Location Group Code";
              // >>DITW15.00.00.37 DDR
              // <<DITW15.00.00.39 DDR 06/07/2011 #1353
              "Journey Time" := LocationTo."Journey Time";
              // >>DITW15.00.00.39 DDR #1353
              MODIFY;
            end;
            UpdateTransLines(FIELDNO("Transfer-to Code"));
            //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
            UpdateRoutePlanRqstLines(FIELDCAPTION("Transfer-to Code"));
            //>> DITW110.00.12 AKH NRQ#16026
          end else begin
            "Transfer-to Code" := xRec."Transfer-to Code";
            // <<DITW15.00.00.37 DDR 28/05/2010
            "Transf.-to Location Gr. Code" := xRec."Transf.-to Location Gr. Code";
            "Trsf-to Ph. Location Gr Code" := xRec."Trsf-to Ph. Location Gr Code";
            // >>DITW15.00.00.37 DDR
            exit;
          end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Transfer-to Post Code"(Field 16).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Transfer-to City","Transfer-to Post Code","Transfer-to County",
          "Trsf.-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Transfer-to City","Transfer-to Post Code","Transfer-to County",
          "Trsf.-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Transfer-to City"(Field 17).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Transfer-to City","Transfer-to Post Code","Transfer-to County",
          "Trsf.-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Transfer-to City","Transfer-to Post Code","Transfer-to County",
          "Trsf.-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Posting Date"(Field 20)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        // var
        //     Confirmed : Boolean;
        //begin
        /*
        // <<DITW15.00.00.39 DDR 19/08/2011 #1363
        // <<DITW16.00.00.42 DDR 10/01/2013 DIT-715 #537
        if ("Tax Date" <> "Posting Date") and (not CalledFromWhse) then begin
        // >>DITW16.00.00.42 DDR DIT-715 #537
          if (xRec."Posting Date" = "Posting Date") or
            HideValidationDialog or  (CurrFieldNo = 0) or
            (xRec."Posting Date" = 0D) or ("Posting Date" = 0D)
            then
              Confirmed := true
            else
              Confirmed :=
                CONFIRM(Text2013664,false,FIELDCAPTION("Tax Date"),FIELDCAPTION("Posting Date"),"Posting Date");
        if Confirmed then
            VALIDATE("Tax Date","Posting Date");
        end;
        // >>DITW15.00.00.39 DDR #1363
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipment Date"(Field 21).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        TransferRoute.CalcReceiptDate(
          "Shipment Date",
          "Receipt Date",
        #5..8
          "Transfer-to Code",
          "Shipping Agent Code",
          "Shipping Agent Service Code");
        UpdateTransLines(FIELDNO("Shipment Date"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        if not CheckShipmentDate() then begin
          "Shipment Date" := xRec."Shipment Date";
          exit;
        end;
        //>> DITW110.00.12 AKH NRQ#16026
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //TestStatusOpen;
        TestOpenStatus;
        //>> DITW110.00.12 AKH NRQ#16026
        //<< DITW110.00.12 AKH 02/05/2018 NRQ#16026
        VALIDATE("Posting Date","Shipment Date");
        //>> DITW110.00.12 AKH NRQ#16026
        #2..11
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        FillDeliveryTimes("Transfer-to Code","Shipment Date");
        //>> DITW110.00.12 AKH NRQ#16026
        UpdateTransLines(FIELDNO("Shipment Date"));
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        UpdateRoutePlanRqstLines(FIELDCAPTION("Shipment Date"));
        //>> DITW110.00.12 AKH NRQ#16026
        */
        //end;


        //Unsupported feature: CodeModification on ""Receipt Date"(Field 22).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        TransferRoute.CalcShipmentDate(
          "Shipment Date",
          "Receipt Date",
        #5..9
          "Shipping Agent Code",
          "Shipping Agent Service Code");
        UpdateTransLines(FIELDNO("Receipt Date"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //TestStatusOpen;
        TestOpenStatus;
        //>> DITW110.00.12 AKH NRQ#16026
        #2..12
        */
        //end;


        //Unsupported feature: CodeModification on "Status(Field 23).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdateTransLines(FIELDNO(Status));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UpdateTransLines(FIELDNO(Status));
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        UpdateRoutePlanRqstLines(FIELDCAPTION(Status));
        //>> DITW110.00.12 AKH NRQ#16026
        */
        //end;


        //Unsupported feature: CodeModification on ""In-Transit Code"(Field 27).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        UpdateTransLines(FIELDNO("In-Transit Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //TestStatusOpen;
        TestOpenStatus;
        //>> DITW110.00.12 AKH NRQ#16026
        // <<DITW15.00.00.30 DDR 09/01/2009
        CheckCombLocations();
        // >>DITW15.00.00.30 DDR
        UpdateTransLines(FIELDNO("In-Transit Code"));
        */
        //end;


        //Unsupported feature: CodeInsertion on ""External Document No."(Field 33)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        UpdateRoutePlanRqstLines(FIELDCAPTION("External Document No."));
        //>> DITW110.00.12 AKH NRQ#16026
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Agent Code"(Field 34).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF "Shipping Agent Code" <> xRec."Shipping Agent Code" THEN
          VALIDATE("Shipping Agent Service Code",'');
        UpdateTransLines(FIELDNO("Shipping Agent Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //TestStatusOpen;
        TestOpenStatus;
        if "Multiple Order Route" then
          if CurrFieldNo = FIELDNO("Shipping Agent Code") then
            ERROR(Text2014061);
        TestRouteTypeVariable(FIELDNO("Shipping Agent Code"));
        //>> DITW110.00.12 AKH NRQ#16026
        if "Shipping Agent Code" <> xRec."Shipping Agent Code" then
          VALIDATE("Shipping Agent Service Code",'');
        UpdateTransLines(FIELDNO("Shipping Agent Code"));
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        VALIDATE("Shipping Agent Service Code",'');
        UpdateRoutePlanRqstLines(FIELDCAPTION("Shipping Agent Code"));
        //>> DITW110.00.12 AKH NRQ#16026
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Shipping Agent Service Code"(Field 35)". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //begin
        /*
        //>> HEI.05
        FilterShippingAgentServiceCode;
        //<< HEI.05
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Agent Service Code"(Field 35).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        TransferRoute.GetShippingTime(
          "Transfer-from Code","Transfer-to Code",
          "Shipping Agent Code","Shipping Agent Service Code",
        #5..12
          "Transfer-to Code",
          "Shipping Agent Code",
          "Shipping Agent Service Code");

        UpdateTransLines(FIELDNO("Shipping Agent Service Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //TestStatusOpen;
        TestOpenStatus;
        if "Multiple Order Route" then
          if CurrFieldNo = FIELDNO("Shipping Agent Service Code") then
            ERROR(Text2014061);
        TestRouteTypeVariable(FIELDNO("Shipping Agent Service Code"));
        //>> DITW110.00.12 AKH NRQ#16026
        #2..15
        // <<DITW16.00.00.40 DDR 27/02/2012 DIT-715 #245
        "Truck Code" := '';
        // >>DITW16.00.00.40 DDR DIT-715 #245
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        "Trailer Code" := '';
        UpdateShippingMax();
        //>> DITW110.00.12 AKH NRQ#16026
        UpdateTransLines(FIELDNO("Shipping Agent Service Code"));
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        UpdateRoutePlanRqstLines(FIELDCAPTION("Shipping Agent Service Code"));
        //>> DITW110.00.12 AKH NRQ#16026

        //<< DITW18.00.07 VSC 10/03/2016 DIT-770 #1066
        //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
        //>> HEI.03 FDD-HT658 IBM.GUNERE01 16.09.2019
        if ("Shipping Agent Service Code" <> '') then
          //("Auto Create Shipping Cost" = "Auto Create Shipping Cost"::Always) THEN // HEI.03 FDD-HT658 IBM.GUNERE01 24.09.2019
          WhseTransportMgt.CreateTransHdrShippingCost(Rec)
        else
          WhseTransportMgt.DeleteTransHdrShippingCost(xRec,false);
        //<< HEI.03 FDD-HT658 IBM.GUNERE01 16.09.2019
        //>> DITW18.00.07 VSC DIT-770 #1066
        //>> DITW18.00.07 VSC DIT-770 #1066
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Time"(Field 36).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        TransferRoute.CalcReceiptDate(
          "Shipment Date",
          "Receipt Date",
        #5..10
          "Shipping Agent Service Code");

        UpdateTransLines(FIELDNO("Shipping Time"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //TestStatusOpen;
        TestOpenStatus;
        //>> DITW110.00.12 AKH NRQ#16026
        #2..13
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        UpdateRoutePlanRqstLines(FIELDCAPTION("Shipping Time"));
        //>> DITW110.00.12 AKH NRQ#16026
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Shipment Method Code"(Field 37)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        // var
        //     ShipmentMethod : Record "Shipment Method";
        //begin
        /*
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        TestOpenStatus;

        if "Multiple Order Route" then
          if CurrFieldNo = FIELDNO("Shipment Method Code") then
            ERROR(Text2014061);

        if ("Shipment Method Code" <> xRec."Shipment Method Code") and
           (xRec."Transfer-to Code" = "Transfer-to Code")
        then begin
          if "Shipment Method Code" <> '' then begin
            ShipmentMethod.GET("Shipment Method Code");
            WhseTransportMgt.CreateTransHdrShippingCost(Rec); //HEI.03 FDD-HT658 IBM.GUNERE01 30.09.2019
            if ShipmentMethod."Shipping Agent" <> '' then
              VALIDATE("Shipping Agent Code",ShipmentMethod."Shipping Agent");
            if ShipmentMethod."Shipping Agent Service Code" <> '' then
              VALIDATE("Shipping Agent Service Code",ShipmentMethod."Shipping Agent Service Code");
          end else begin
            //>> HEI.03 FDD-HT658 IBM.GUNERE01 30.09.2019
            if "Shipment Method Code" <> xRec."Shipment Method Code" then
              if "Shipment Method Code" = '' then
                WhseTransportMgt.DeleteTransHdrShippingCost(xRec,true);
            //<< HEI.03 FDD-HT658 IBM.GUNERE01 30.09.2019
            // DDR #1488 (to do) rollback thes values as new document within customer and shipto-codee without default shipment method code
          end;
        end;
        if xRec."Shipment Method Code" <> "Shipment Method Code" then
          UpdateRoutePlanRqstLines(FIELDCAPTION("Shipment Method Code"));
        //>> DITW110.00.12 AKH NRQ#16026
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Advice"(Field 5750).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Shipping Advice" <> xRec."Shipping Advice" THEN BEGIN
          TestStatusOpen;
          WhseSourceHeader.TransHeaderVerifyChange(Rec,xRec);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Shipping Advice" <> xRec."Shipping Advice" then begin
          //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
          //TestStatusOpen;
          TestOpenStatus;
          //>> DITW110.00.12 AKH NRQ#16026
          WhseSourceHeader.TransHeaderVerifyChange(Rec,xRec);
          //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
          UpdateRoutePlanRqstLines(FIELDCAPTION("Shipping Advice"));
          //>> DITW110.00.12 AKH NRQ#16026
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Outbound Whse. Handling Time"(Field 5793).OnValidate". Please convert manually.

        //trigger  Handling Time"(Field 5793)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        TransferRoute.CalcReceiptDate(
          "Shipment Date",
          "Receipt Date",
        #5..10
          "Shipping Agent Service Code");

        UpdateTransLines(FIELDNO("Outbound Whse. Handling Time"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //TestStatusOpen;
        TestOpenStatus;
        //>> DITW110.00.12 AKH NRQ#16026
        #2..13
        */
        //end;


        //Unsupported feature: CodeModification on ""Inbound Whse. Handling Time"(Field 5794).OnValidate". Please convert manually.

        //trigger  Handling Time"(Field 5794)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        TransferRoute.CalcReceiptDate(
          "Shipment Date",
          "Receipt Date",
        #5..10
          "Shipping Agent Service Code");

        UpdateTransLines(FIELDNO("Inbound Whse. Handling Time"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //TestStatusOpen;
        TestOpenStatus;
        //>> DITW110.00.12 AKH NRQ#16026
        #2..13
        */
        //end;
        field(50001; "Request Order No. FND"; Code[20])
        {
            Caption = 'Request Order No.';
            Description = 'HEI.01';
            Editable = false;

            trigger OnLookup();
            var
                RequestOrderHeaderArchive: Record "Request Ord Header Archive FND";
            begin
                //HEI.02>>
                RequestOrderHeaderArchive.SETRANGE("No.", "Request Order No. FND");
                if RequestOrderHeaderArchive.FINDFIRST() then
                    PAGE.RUNMODAL(50115, RequestOrderHeaderArchive);
                //HEI.02<<
            end;
        }
        field(50002; "WMS Export FND"; Boolean)
        {
            Caption = 'WMS Export';
            Description = 'HEI.04';
            Editable = false;
            InitValue = false;
        }


        field(50005; "IC Document FND"; Boolean)
        {
            Caption = 'IC Document';
            Description = 'HEI.07';
            Editable = false;
        }
        field(50006; "PO Reference FND"; Code[20])
        {
            Caption = 'PO Reference';
            Description = 'HEI.08';
            TableRelation = "Purchase Line"."Document No." where("Document No." = FIELD("No."),
                                                                  "Location Code" = FIELD("Transfer-from Code"),
                                                                  "Document Type" = CONST(Order));

            trigger OnValidate();
            var
                lrecPurchHdrAdd: Record "Purchase Header Additional FND";
            begin
                //HEI.08 >>
                PurchHdrRec.RESET();
                if PurchHdrRec.GET(PurchHdrRec."Document Type"::Order, "PO Reference FND") then
                    VALIDATE("Extra PO Reference FND", PurchHdrRec."Your Reference");
                //HEI.08 <<

                //HEI.11>>
                if ("PO Reference FND" = '') then begin
                    if lrecPurchHdrAdd.GET(lrecPurchHdrAdd."Document Type"::Order, xRec."PO Reference FND") then
                        if lrecPurchHdrAdd."Import Identifier" then
                            ERROR(Text50000, xRec."PO Reference FND");
                end;
                //HEI.11<<
            end;
        }
        field(50007; "Extra PO Reference FND"; Text[35])
        {
            Caption = 'Extra PO Reference';
            Description = 'HEI.08';
        }
        field(50008; "Created By FND"; Code[50])
        {
            Caption = 'Created By';
            Description = 'HEI.09';
            Editable = false;
            TableRelation = "User Setup";
        }

        field(50009; "LSR Order No FND"; Code[20])
        {
            Caption = 'LSR Order No';
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
            Editable = true;
        }
        field(50010; "Import Identifier FND"; Boolean)
        {
            Caption = 'Import Identifier';
            CalcFormula = Lookup("Purchase Header Additional FND"."Import Identifier" where("Document Type" = CONST(Order),
                                                                                         "No." = FIELD("PO Reference FND")));
            Description = 'HEI.13';
            FieldClass = FlowField;
        }
        field(50015; "Posted Whse. Receipt No. FND"; Code[20])
        {
            Caption = 'Posted Whse. Receipt No.';
            DataClassification = CustomerContent;
            Description = 'HEI.14';
        }
        field(50020; "Posted Whse. Shipment No. FND"; Code[20])
        {
            Caption = 'Posted Whse. Shipment No.';
            DataClassification = CustomerContent;
            Description = 'HEI.14';
        }
        field(50021; "Email Sent-Create FND"; Boolean)
        {
            Caption = 'Email Sent-Create';
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
            Editable = false;
        }
        // field(2013695;"Item Charge Type Filter";Option)
        // {
        //     CaptionML = ENU='Item Charge Type Filter',
        //                 FRA='Filtre type frais article';
        //     Description = 'DITW15.00.00.37';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU=' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA=' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost";
        // }
        // field(2013696;"Transf.-from Location Gr. Code";Code[10])
        // {
        //     CaptionML = ENU='Transfer-from Location Tax Group Code',
        //                 FRA='Transfer du Code groupe magasin taxe';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Location Group";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 31/05/2010
        //         UpdateTransLines(FIELDNO("Transf.-from Location Gr. Code"));
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         UpdateRoutePlanRqstLines(FIELDCAPTION("Transf.-from Location Gr. Code"));
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2013726;"Tax Registration No.";Text[20])
        // {
        //     CaptionML = ENU='Tax Registration No.',
        //                 FRA='N° Registration Taxe';
        //     Description = 'DITW15.00.00.36-.38';
        // }
        // field(2013730;"Fiscal Representative No.";Code[20])
        // {
        //     CaptionML = ENU='Fiscal Representative / Customs Agent No.',
        //                 FRA='N° représentant fiscal / Agent des douanes';
        //     Description = 'DITW15.00.00.36-.38 #1217';
        //     TableRelation = "Fiscal Representative";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.36 DDR 17/12/2009
        //         if "Fiscal Representative No." <> '' then begin
        //           FiscalRep.GET("Fiscal Representative No.");
        //           if  FiscalRep."TAX Registration No." <> '' then
        //             "Tax Registration No." := FiscalRep."TAX Registration No.";
        //           // <<DITW15.00.00.38 DDR 13/09/2010 #1217
        //           "Tax Warehouse Reference" := FiscalRep."Tax Warehouse Reference";
        //           // >>DITW15.00.00.38 DDR
        //           // <<DITW15.00.00.38 DDR 27/01/2011 #1217 (DIT711 137)
        //           "Tax Office Code" := FiscalRep."Tax Office Code";
        //           // <<DITW15.00.00.38 DDR #1217 (DIT711 137)
        //         end else begin
        //           // <<DITW15.00.00.37 DDR 28/05/2010 - DITW15.00.00.38 DDR 20/08/2010 #1217
        //           if Location.GET("Transfer-to Code") then begin
        //             "Tax Registration No." := Location."Tax Registration No.";
        //             // <<DITW15.00.00.38 DDR 13/09/2010 #1217
        //             "Tax Warehouse Reference" := Location."Tax Warehouse Reference";
        //             // >>DITW15.00.00.38 DDR
        //             // <<DITW15.00.00.38 DDR 27/01/2011 #1217 (DIT711 137)
        //             "Tax Office Code" := Location."Tax Office Code";
        //             // <<DITW15.00.00.38 DDR #1217 (DIT711 137)
        //             // <<DITW15.00.00.39 DDR 06/07/2011 #1353
        //             "Journey Time" := Location."Journey Time";
        //             // >>DITW15.00.00.39 DDR #1353
        //             "Transf.-to Location Gr. Code" := Location."Location Group Code";
        //             "Trsf-to Ph. Location Gr Code" := Location."Physical Location Group Code";
        //           end;
        //           // >>DITW15.00.00.38 DDR
        //         end;
        //     end;
        // }
        // field(2013733;"Tax Date";Date)
        // {
        //     CaptionML = ENU='Tax Date',
        //                 FRA='Date taxe';
        //     Description = 'DITW15.00.00.39 #1363';

        //     trigger OnValidate();
        //     var
        //         Confirmed : Boolean;
        //     begin
        //         // <<DITW15.00.00.39 DDR 19/08/2011 #1363
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         //TestStatusOpen;
        //         TestOpenStatus;
        //         //>> DITW110.00.12 AKH NRQ#16026
        //         // <<DITW16.00.00.42 DDR 10/01/2013 DIT-715 #537
        //         if not CalledFromWhse then begin
        //         // >>DITW16.00.00.42 DDR DIT-715 #537
        //           if (xRec."Tax Date" = "Tax Date") or
        //             HideValidationDialog or  (CurrFieldNo = 0) or
        //             (xRec."Tax Date" = 0D) or ("Tax Date" = 0D)
        //             then
        //               Confirmed := true
        //             else
        //               Confirmed := CONFIRM(Text2013663,false,FIELDCAPTION("Tax Date"));

        //           if Confirmed then
        //             UpdateTransLines(FIELDNO("Tax Date"));
        //         end;
        //         // >>DITW15.00.00.39 DDR #1363
        //     end;
        // }
        // field(2013758;"Transf.-to Location Gr. Code";Code[10])
        // {
        //     CaptionML = ENU='Transfer-to Location Tax Group Code',
        //                 FRA='Transfer vers code groupe magasin taxe';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Location Group";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 31/05/2010
        //         UpdateTransLines(FIELDNO("Transf.-to Location Gr. Code"));
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         UpdateRoutePlanRqstLines(FIELDCAPTION("Transf.-to Location Gr. Code"));
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2014060;"Maximum Weight";Decimal)
        // {
        //     BlankZero = true;
        //     Caption = 'Maximum Weight';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     MinValue = 0;
        // }
        // field(2014061;"Maximum Cubage";Decimal)
        // {
        //     BlankZero = true;
        //     Caption = 'Maximum Volume (Cubage)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     MinValue = 0;
        // }
        // field(2014065;"Auto Create Shipping Cost";Option)
        // {
        //     CaptionML = ENU='Auto Create Shipping Cost',
        //                 FRA='Création automatique des frais de livraison';
        //     Description = 'DIT-770 #1066';
        //     OptionCaptionML = ENU=' ,Never,Always',
        //                       FRA=' ,Jamais,Toujours';
        //     OptionMembers = " ",Never,Always;
        // }
        // field(2014071;"Document Shipping Costs";Boolean)
        // {
        //     CalcFormula = Exist("Document Shipping Cost" WHERE ("Source Type"=CONST(5740),
        //                                                         "Source No."=FIELD("No."),
        //                                                         "Sub Type"=CONST(0)));
        //     CaptionML = ENU='Document Shipping Costs',
        //                 FRA='Document Frais livraison';
        //     Description = 'DIT-770 #1066';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014077;"Truck Code";Code[10])
        // {
        //     CaptionML = ENU='Truck Code',
        //                 FRA='Code camion';
        //     Description = 'DITW15.00.00.25,HEI.03';
        //     TableRelation = "Whse. Shipping Truck";

        //     trigger OnLookup();
        //     var
        //         TruckCodeText : Text[10];
        //     begin
        //         //>> HEI.03
        //         // <<DITW16.00.00.40 DDR 27/02/2012 DIT-715 #245
        //         // TruckCodeText := "Truck Code";
        //         // IF WhseTransportMgt.LookupTrucks("Shipping Agent Code","Shipping Agent Service Code",TruckCodeText) THEN BEGIN
        //         //  EVALUATE("Truck Code",TruckCodeText);
        //         //  VALIDATE("Truck Code");
        //         // end;
        //         // >>DITW16.00.00.40 DDR DIT-715 #245
        //         FilterWhseShippingTrucks;
        //         //<< HEI.03
        //     end;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.25 DDR 10/10/2008
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         //TestStatusOpen;
        //         TestOpenStatus;
        //         if "Multiple Order Route" then
        //           if CurrFieldNo = FIELDNO("Truck Code") then
        //             ERROR(Text2014061);
        //         TestRouteTypeVariable(FIELDNO("Truck Code"));
        //         //>> DITW110.00.12 AKH NRQ#16026
        //         UpdateTransLines(FIELDNO("Truck Code"));
        //         // >>DITW15.00.00.25 DDR
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         if xRec."Truck Code" <> "Truck Code" then  begin
        //           UpdateShippingMax();
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Truck Code"));
        //         end;
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2014078;"Driver Code";Code[10])
        // {
        //     CaptionML = ENU='Driver Code',
        //                 FRA='Code chauffeur';
        //     Description = 'DITW15.00.00.25,HEI.03';
        //     TableRelation = "Whse. Shipping Driver";

        //     trigger OnLookup();
        //     begin
        //         FilterWhseShippingDrivers //HEI.03
        //     end;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.25 DDR 10/10/2008
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         //TestStatusOpen;
        //         TestOpenStatus;
        //         if "Multiple Order Route" then
        //           if CurrFieldNo = FIELDNO("Driver Code") then
        //             ERROR(Text2014061);
        //         TestRouteTypeVariable(FIELDNO("Driver Code"));
        //         //>> DITW110.00.12 AKH NRQ#16026
        //         UpdateTransLines(FIELDNO("Driver Code"));
        //         // >>DITW15.00.00.25 DDR
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         if xRec."Driver Code" <> "Driver Code" then
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Driver Code"));
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2014080;Route;Code[20])
        // {
        //     Caption = 'Route';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     TableRelation = Route;

        //     trigger OnValidate();
        //     var
        //         OldRoute : Record Route;
        //         NewRoute : Record Route;
        //     begin
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         TestOpenStatus;
        //         if (Route <> xRec.Route) then begin
        //           if Route <> '' then begin
        //             if OldRoute.GET(xRec.Route) then;
        //             NewRoute.GET(Route);
        //             if (NewRoute."Shipment Day" <> NewRoute."Shipment Day"::" ") and
        //               (NewRoute."Shipment Day" <> OldRoute."Shipment Day")
        //             then begin
        //               VALIDATE("Shipment Date",NewRoute.GetShipmentDate(WORKDATE));
        //               VALIDATE("Posting Date","Shipment Date");
        //             end;

        //             if NewRoute."Shipment Method Code" <> '' then
        //               VALIDATE("Shipment Method Code",NewRoute."Shipment Method Code");

        //             if NewRoute."Shipping Agent Code" <> '' then begin
        //               VALIDATE("Shipping Agent Code",NewRoute."Shipping Agent Code");
        //               if xRec."Shipping Agent Code" = "Shipping Agent Code" then
        //                 UpdateTransLines(FIELDNO("Shipping Agent Code"));
        //             end;
        //             if NewRoute."Shipping Agent Service Code" <> '' then
        //               VALIDATE("Shipping Agent Service Code",NewRoute."Shipping Agent Service Code");

        //             if NewRoute."Driver Code" <> '' then
        //               VALIDATE("Driver Code",NewRoute."Driver Code");
        //             if NewRoute."Trailer Code" <> '' then
        //               VALIDATE("Trailer Code",NewRoute."Trailer Code");
        //             if NewRoute."Driver Code 2" <> '' then
        //               VALIDATE("Driver 2 Code",NewRoute."Driver Code 2");
        //             if NewRoute."Truck Code" <> '' then
        //               VALIDATE("Truck Code",NewRoute."Truck Code");
        //             //>> HEI.03 FDD-HT658 IBM.GUNERE01 16.09.2019
        //             if NewRoute.Distance <> 0 then
        //               VALIDATE(Distance,NewRoute.Distance);
        //             //<< HEI.03 FDD-HT658 IBM.GUNERE01 16.09.2019
        //             "Multiple Order Route" := NewRoute."Multiple Order Route";
        //             //>> HEI.03 FDD-HT658 IBM.GUNERE01 16.09.2019
        //             WhseTransportMgt.CreateTransHdrShippingCost(Rec);
        //             if xRec.Route <> Route then
        //               WhseTransportMgt.UpdateTransHdrShippingRoutes(Rec);
        //             //<< HEI.03 FDD-HT658 IBM.GUNERE01 16.09.2019
        //           end else begin
        //             "Multiple Order Route" := false;
        //             DeleteRoutePlanRqstLine();
        //             if "Shipping Agent Service Code" <> '' then
        //               VALIDATE("Shipping Agent Service Code");
        //           end;
        //           UpdateTransLines(FIELDNO(Route));
        //           UpdateRoutePlanRqstLines(FIELDCAPTION(Route));
        //         end;
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2014081;"Route Planning No.";Code[20])
        // {
        //     Caption = 'Route Planning No.';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     TableRelation = "Route Planning Worksheet";
        // }
        // field(2014082;"Truck Zone";Option)
        // {
        //     Caption = 'Truck Zone';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     OptionCaption = '" ,Right,Left"';
        //     OptionMembers = " ",Right,Left;

        //     trigger OnValidate();
        //     begin
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         TestOpenStatus;
        //         if ("Truck Zone" <> xRec."Truck Zone") then begin
        //           UpdateTransLines(FIELDNO("Truck Zone"));
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Truck Zone"));
        //         end;
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2014083;"Driver 2 Code";Code[10])
        // {
        //     Caption = 'Driver 2 Code';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     TableRelation = "Whse. Shipping Driver";

        //     trigger OnValidate();
        //     begin
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         TestOpenStatus;
        //         if "Multiple Order Route" then
        //           if CurrFieldNo = FIELDNO("Driver 2 Code") then
        //             ERROR(Text2014061);
        //         TestRouteTypeVariable(FIELDNO("Driver 2 Code"));
        //         if ("Driver 2 Code" <> xRec."Driver 2 Code") then
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Driver 2 Code"));
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2014085;"Shipment Status";Option)
        // {
        //     Caption = 'Shipping Status';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     OptionCaption = 'Open,Picklist Printed,Assigned,Picked,Shipped,Return completed,Invoice';
        //     OptionMembers = Open,"Picklist Printed",Assigned,Picked,Shipped,"Return completed",Invoice;

        //     trigger OnValidate();
        //     begin
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         if ("Shipment Status" <> xRec."Shipment Status") then begin
        //           UpdateTransLines(FIELDNO("Shipment Status"));
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Shipment Status"));
        //         end;
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2014086;"Delivery Time 1 From";Time)
        // {
        //     Caption = 'Delivery Time 1 From';
        //     Description = 'DITW110.00.12 NRQ#16026';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         if ("Delivery Time 1 From" <> xRec."Delivery Time 1 From") then
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Delivery Time 1 From"));
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2014087;"Delivery Time 1 To";Time)
        // {
        //     Caption = 'Delivery Time 1 To';
        //     Description = 'DITW110.00.12 NRQ#16026';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         if ("Delivery Time 1 To" <> xRec."Delivery Time 1 To") then
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Delivery Time 1 To"));
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2014088;"Delivery Time 2 From";Time)
        // {
        //     Caption = 'Delivery Time 2 From';
        //     Description = 'DITW110.00.12 NRQ#16026';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         if ("Delivery Time 2 From" <> xRec."Delivery Time 2 From") then
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Delivery Time 2 From"));
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2014089;"Delivery Time 2 To";Time)
        // {
        //     Caption = 'Delivery Time 2 To';
        //     Description = 'DITW110.00.12 NRQ#16026';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         if ("Delivery Time 2 To" <> xRec."Delivery Time 2 To") then
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Delivery Time 2 To"));
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2014090;Distance;Decimal)
        // {
        //     Caption = 'Distance';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     MinValue = 0;

        //     trigger OnValidate();
        //     begin
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         TestOpenStatus;
        //         WhseTransportMgt.UpdateTransHdrShippingDistances(Rec); //HEI.03 FDD-HT658 IBM.GUNERE01 06.09.2019
        //         if (Distance <> xRec.Distance) then begin
        //           UpdateTransLines(FIELDNO(Distance));
        //           UpdateRoutePlanRqstLines(FIELDCAPTION(Distance));
        //         end;
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2014091;"Delivery Time";Time)
        // {
        //     Caption = 'Delivery Time';
        //     Description = 'DITW110.00.12 NRQ#16026';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         if ("Delivery Time" <> xRec."Delivery Time") then
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Delivery Time"));
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2014092;"Total Weight";Decimal)
        // {
        //     CalcFormula = Sum("Transfer Line".Weight WHERE ("Document No."=FIELD("No."),
        //                                                     "Transfer-from Code"=FIELD("Location Filter"),
        //                                                     "Outstanding Quantity"=FILTER(>0)));
        //     Caption = 'Total Outstanding Weight';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014093;"Total Cubage";Decimal)
        // {
        //     CalcFormula = Sum("Transfer Line".Cubage WHERE ("Document No."=FIELD("No."),
        //                                                     "Transfer-from Code"=FIELD("Location Filter"),
        //                                                     "Outstanding Quantity"=FILTER(>0)));
        //     Caption = 'Total Outstanding Volume (Cubage)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014094;"Trsf-from Ph. Location Gr Code";Code[10])
        // {
        //     CaptionML = ENU='Transfer-from Physical Location Group Code',
        //                 FRA='Transf. du Code groupe magasin réel';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Physical Location Group";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 04/02/2010 - 31/05/2010
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         //TestStatusOpen;
        //         TestOpenStatus;
        //         //>> DITW110.00.12 AKH NRQ#16026
        //         InvtSetup.GET;

        //         if xRec."Trsf-from Ph. Location Gr Code" <> "Trsf-from Ph. Location Gr Code" then begin
        //           if "Trsf-from Ph. Location Gr Code" <> '' then
        //             if InvtSetup."Location Mandatory" then
        //               TESTFIELD("Transfer-from Code");
        //         end;

        //         GetLocation("Transfer-from Code");
        //         if (Location."Physical Location Group Code" <> '') and
        //           ("Trsf-from Ph. Location Gr Code" <> '')
        //         then
        //           TESTFIELD("Trsf-from Ph. Location Gr Code",Location."Physical Location Group Code");

        //         UpdateTransLines(FIELDNO("Trsf-from Ph. Location Gr Code"));

        //         if (CurrFieldNo = FIELDNO("Trsf-from Ph. Location Gr Code")) and ("Trsf-from Ph. Location Gr Code" <> '') then
        //           VALIDATE("Transfer-from Code");
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         UpdateRoutePlanRqstLines(FIELDCAPTION("Trsf-from Ph. Location Gr Code"));
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2014095;"Total Weight (Base)";Decimal)
        // {
        //     CalcFormula = Sum("Transfer Line".Weight WHERE ("Document No."=FIELD("No."),
        //                                                     "Transfer-from Code"=FIELD("Location Filter")));
        //     Caption = 'Total Weight';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014096;"Total Cubage (Base)";Decimal)
        // {
        //     CalcFormula = Sum("Transfer Line".Cubage WHERE ("Document No."=FIELD("No."),
        //                                                     "Transfer-from Code"=FIELD("Location Filter")));
        //     Caption = 'Total Volume (Cubage)';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014097;"Multiple Order Route";Boolean)
        // {
        //     Caption = 'Multiple Order Route';
        //     Description = 'DITW110.00.12 NRQ#16026';
        // }
        // field(2014098;"Shipment Time";Time)
        // {
        //     Caption = 'Shipment Time';
        //     Description = 'DITW110.00.12 NRQ#16026';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         if xRec."Shipment Time" <> "Shipment Time" then
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Shipment Time"));
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2014100;"Trailer Code";Code[10])
        // {
        //     Caption = 'Trailer Code';
        //     Description = 'DITW110.00.12 NRQ#16026';
        //     TableRelation = "Whse. Shipping Truck".Code WHERE ("Transport Unit Type"=CONST(Trailer));

        //     trigger OnValidate();
        //     begin
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         TestOpenStatus;
        //         if "Multiple Order Route" then
        //           if CurrFieldNo = FIELDNO("Trailer Code") then
        //             ERROR(Text2014061);
        //         TestRouteTypeVariable(FIELDNO("Trailer Code"));
        //         if xRec."Trailer Code" <> "Trailer Code" then begin
        //           UpdateShippingMax();
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Trailer Code"));
        //         end;
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2014101;"Trsf-to Ph. Location Gr Code";Code[10])
        // {
        //     CaptionML = ENU='Transfer-to Physical Location Group Code',
        //                 FRA='Transfer vers code groupe magasin réel';
        //     Description = 'DITW15.00.00.37';
        //     TableRelation = "Physical Location Group";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.37 DDR 04/02/2010 - 31/05/2010
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         //TestStatusOpen;
        //         TestOpenStatus;
        //         //>> DITW110.00.12 AKH NRQ#16026
        //         InvtSetup.GET;

        //         if xRec."Trsf-to Ph. Location Gr Code" <> "Trsf-to Ph. Location Gr Code" then begin
        //           if "Trsf-to Ph. Location Gr Code" <> '' then
        //             if InvtSetup."Location Mandatory" then
        //               TESTFIELD("Transfer-to Code");
        //         end;

        //         GetLocation("Transfer-to Code");
        //         if (Location."Physical Location Group Code" <> '') and
        //           ("Trsf-to Ph. Location Gr Code" <> '')
        //         then
        //           TESTFIELD("Trsf-to Ph. Location Gr Code",Location."Physical Location Group Code");

        //         UpdateTransLines(FIELDNO("Trsf-to Ph. Location Gr Code"));

        //         if (CurrFieldNo = FIELDNO("Trsf-to Ph. Location Gr Code")) and ("Trsf-to Ph. Location Gr Code" <> '') then
        //           VALIDATE("Transfer-to Code");
        //     end;
        // }
        // field(2014271;"Tax Warehouse Reference";Text[20])
        // {
        //     CaptionML = ENU='Tax Warehouse Reference',
        //                 FRA='Entrepôt fiscal de référence';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014277;"Transport Mode";Option)
        // {
        //     CalcFormula = Lookup("Transport Method"."Transport Mode" WHERE (Code=FIELD("Transport Method")));
        //     CaptionML = ENU='Transport Mode (EMCS)',
        //                 FRA='Mode de transport (EMCS)';
        //     Description = 'DITW16.00.00.40 DIT715 #187';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     OptionCaptionML = ENU='Other,Sea,Rail,Road,Air,Post,N/A,Fixed,Waterway',
        //                       FRA='Autre,Mer,Chemin de fer,Route,Air,Poste,N/C,Installation de transport fixes,Transport par voies navigables';
        //     OptionMembers = Other,Sea,Rail,Road,Air,Post,"N/A","Fixed",Waterway;
        // }
        // field(2014290;"Journey Time";DateFormula)
        // {
        //     CaptionML = ENU='Journey Time (EMCS)',
        //                 FRA='Temps de trajet (EMCS)';
        //     Description = 'DITW15.00.00.39 #1353';
        // }
        // field(2014291;"Transport Mode Comment";Boolean)
        // {
        //     CalcFormula = Exist("EMCS Comment Line" WHERE ("Table ID"=CONST(5740),
        //                                                    "Document Type"=CONST(0),
        //                                                    "Document No."=FIELD("No."),
        //                                                    "Document Line No."=CONST(0),
        //                                                    "Field ID"=CONST(2014277)));
        //     CaptionML = ENU='Transport Mode Comment',
        //                 FRA='Commentaires Mode de transport';
        //     Description = 'DITW16.00.00.40 DIT715 #187';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(50066; "Document Subtype Code FND"; Code[10])
        {
            CaptionML = ENU = 'Document Subtype Code',
                        FRA = 'Code Sous-Type Document';
            Description = 'DITW18.00.07 DIT-770 #1508';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = CONST(Inventory));
        }
        // field(2014460;"Tax Office Code";Code[10])
        // {
        //     CaptionML = ENU='Tax Office Code',
        //                 FRA='Code Bureau de taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Office";
        // }
        // field(2014495;"Delivery Sequence";Integer)
        // {
        //     BlankZero = true;
        //     Caption = 'Delivery Sequence';
        //     Description = 'DITW16.00.00.40 #1002';
        //     MinValue = 0;

        //     trigger OnValidate();
        //     begin
        //         //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
        //         if xRec."Delivery Sequence" <> "Delivery Sequence" then
        //           UpdateRoutePlanRqstLines(FIELDCAPTION("Delivery Sequence"));
        //         //>> DITW110.00.12 AKH NRQ#16026
        //     end;
        // }
        // field(2029610;"Automatic Ship & Receive";Boolean)
        // {
        //     CaptionML = ENU='Automatic Ship & Receive Transfer Order',
        //                 FRA='Expéd. et Récept. auto sur Ordre de transfert';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029611;"Emergency Order";Boolean)
        // {
        //     CaptionML = ENU='Emergency',
        //                 FRA='Urgence';
        //     Description = 'FINXL8.00.001';
        // }
        // field(2029613;"Logistics Group";Code[10])
        // {
        //     CaptionML = ENU='Logistics Group',
        //                 FRA='Groupe logisitique';
        //     Description = 'FINXL8.00.001';
        // }
        // field(2034983;"Work Order No.";Code[20])
        // {
        //     CaptionML = ENU='Work Order No.',
        //                 FRA='N° cmde. d''intervention';
        //     Description = 'DIT-715 #457';
        //     TableRelation = "Service Header"."No." WHERE ("Document Type"=CONST(Order),
        //                                                   "PM Order Status"=CONST(Released));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457
        //         TESTFIELD("Transfer-from Code");
        //         GetLocation("Transfer-from Code");
        //         if Location."Work Order Mandatory" then
        //           TESTFIELD("Work Order No.");
        //         if (Location."W.Order Alloc. Location Code" <> '') and ("Work Order No." <> '') then begin
        //           "Trsf-to Ph. Location Gr Code" := '';
        //           "Transf.-to Location Gr. Code" := '';
        //           VALIDATE("Transfer-to Code",Location."W.Order Alloc. Location Code");
        //           if (xRec."In-Transit Code" <> '') and ("In-Transit Code" = '') then
        //             VALIDATE("In-Transit Code",xRec."In-Transit Code");
        //         end;
        //         TESTFIELD("Transfer-to Code");
        //         GetLocation("Transfer-to Code");
        //         if Location."Work Order Mandatory" then
        //           TESTFIELD("Work Order No.");
        //     end;
        // }
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: EmcsCommentLine)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: RoutePlanRqst2)();
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

    WhseRequest.SETRANGE("Source Type",DATABASE::"Transfer Line");
    WhseRequest.SETRANGE("Source No.","No.");
    IF NOT WhseRequest.ISEMPTY THEN
      WhseRequest.DELETEALL(TRUE);

    ReservMgt.DeleteDocumentReservation(DATABASE::"Transfer Line",0,"No.",HideValidationDialog);

    TransLine.SETRANGE("Document No.","No.");
    TransLine.DELETEALL(TRUE);

    InvtCommentLine.SETRANGE("Document Type",InvtCommentLine."Document Type"::"Transfer Order");
    InvtCommentLine.SETRANGE("No.","No.");
    InvtCommentLine.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    if not WhseRequest.ISEMPTY then
      WhseRequest.DELETEALL(true);
    #7..9
    //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
    if RoutePlanRqst.READPERMISSION then begin
      RoutePlanRqst.SETRANGE("Source Type",DATABASE::"Transfer Header");
      RoutePlanRqst.SETRANGE("Source No.","No.");
      //doesn't work if need "skip" flag parameter
      //RoutePlanRqst.DELETEALL(TRUE);
      if RoutePlanRqst.findset then
        repeat
          RoutePlanRqst2.SetSkipValidationDocument(true);
          RoutePlanRqst2 := RoutePlanRqst;
          RoutePlanRqst2.DELETE(true);
        until RoutePlanRqst.NEXT = 0;
    end;
    //>> DITW110.00.12 AKH NRQ#16026

    TransLine.SETRANGE("Document No.","No.");
    TransLine.DELETEALL(true);
    #12..15

    // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
    EmcsCommentLine.SETRANGE("Table ID",DATABASE::"Transfer Header");
    EmcsCommentLine.SETRANGE("Document Type",0);
    EmcsCommentLine.SETRANGE("Document No.","No.");
    EmcsCommentLine.DELETEALL;
    // >>DITW16.00.00.40 DDR DIT-715 #187

    //<< DITW18.00.07 VSC 10/03/2016 DIT-770 #1066
    DocumentShippingCost.RESET;
    DocumentShippingCost.SETRANGE("Source Type",DATABASE::"Transfer Header");
    DocumentShippingCost.SETRANGE("Source No.","No.");
    DocumentShippingCost.SETRANGE("Sub Type",0);
    DocumentShippingCost.DELETEALL;
    //>> DITW18.00.07 VSC DIT-770 #1066
    //HEI.11>>
    grec_PurchHdrAdd.RESET;
    grec_PurchHdrAdd.SETRANGE("Document Type",grec_PurchHdrAdd."Document Type"::Order);
    grec_PurchHdrAdd.SETRANGE(grec_PurchHdrAdd."TO Reference","No.");
    if grec_PurchHdrAdd.FINDFIRST then begin
      grec_PurchHdrAdd."TO Reference" := '';
      grec_PurchHdrAdd.MODIFY;
      grec_PurchLn.RESET;
      grec_PurchLn.SETRANGE("Document Type",grec_PurchLn."Document Type"::Order);
      grec_PurchLn.SETRANGE("Document No.",grec_PurchHdrAdd."No.");
      //grec_PurchLn.SETRANGE("TO Reference",grec_PurchHdrAdd."TO Reference");
      if grec_PurchLn.findset then repeat
        grec_PurchLn."TO Reference" := '';
        grec_PurchLn.MODIFY;
      until grec_PurchLn.NEXT = 0;
    end;
    //HEI.11<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetInventorySetup;
    IF "No." = '' THEN BEGIN
      TestNoSeries;
      NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
    end;
    InitRecord;
    VALIDATE("Shipment Date",WORKDATE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GetInventorySetup;
    if "No." = '' then begin
      TestNoSeries;
      NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
    end;
    InitRecord;
    VALIDATE("Shipment Date",WORKDATE);
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //begin
    /*
    //<< DITW110.00.12 AKH 30/03/2018 NRQ#16026
    UpdateRoutePlanRqstLines('');
    //>> DITW110.00.12 AKH NRQ#16026
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    // var
    //     _Location: Record Location;

    // var
    //     LocationTo: Record Location;

    // var
    //     EmcsCommentLine: Record "EMCS Comment Line";
    //     DocumentShippingCost: Record "Document Shipping Cost";

    // var
    //     RoutePlanRqst2: Record "Route Planning Request";

    // var
    //     DocSubtypeCodeSetup: Record "Doc Subtype Code Setup FND";

    // var
    //     EmcsCommentLine: Record "EMCS Comment Line";


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer l'enregistrement %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=%1 and %2 cannot be the same in %3 %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=%1 and %2 cannot be the same in %3 %4.;FRA=%1 et %2 ne peuvent pas être identiques dans l'%3 %4.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=Do you want to change %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=Do you want to change %1?;FRA=Souhaitez-vous modifier la valeur du champ %1?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=The transfer order %1 has been deleted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=The transfer order %1 has been deleted.;FRA=L'ordre de transfert %1 a été supprimé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=You may have changed a dimension.\\Do you want to update the lines?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=You may have changed a dimension.\\Do you want to update the lines?;FRA=Vous avez probablement modifié un axe analytique.\\Souhaitez-vous mettre à jour les lignes ?;
    //Variable type has not been exported.

    var
        Location: Record Location;
        // TransRequestMgt: Codeunit "Route Transfer-Request Mgt.";////---BC Upgrade KAMNAY01 DITW
        PurchHdrRec: Record "Purchase Header";
        grec_PurchHdrAdd: Record "Purchase Header Additional FND";
        grec_PurchLn: Record "Purchase Line";
        TransportMethod: Record "Transport Method";
        WhseSetup: Record "Warehouse Setup";
        //WhseTransportMgt: Codeunit "Warehouse & Transport Mgt.";//////---BC Upgrade KAMNAY01 DITW
        blnIgnoreConfirmation: Boolean;
        //RoutePlanRqst: Record "Route Planning Request";////---BC Upgrade KAMNAY01 DITW
        StatusCheckSuspended: Boolean;
        GateEntryNo: Code[20];
        Err001: Label 'Invalid Gate Entry No.';
        Text50000: Label 'The PO Reference - %1 can not be deleted or modified as it is a Import PO';
        Text2014061: Label 'Modifcation allowed only from Order Shipmment Planning';
        Text2014062: Label 'Shipment Date does not match the Route Shipment Day. Do you want to Continue?';
        //FiscalRep: Record "Fiscal Representative";///---BC Upgrade KAMNAY01 DITW
        Text2013661: TextConst ENU = 'You must specify %1 in %2 or %3 or %4 when %5 %6.', FRA = 'Vous devez spécifier %1 dans %2 ou %3 ou %4 quand %5 %6.';
        Text2013662: TextConst ENU = 'Do you want to update the lines to reflect the new value of %1?', FRA = 'Souhaitez-vous mettre à jour les lignes pour refléter la nouvelle valeur de %1 ?';
        Text2013663: TextConst ENU = 'If you change %1, the existing transfer lines will be deleted and new transfer lines based on the header will be created.\\', FRA = 'Si vous modifiez l''enregistrement %1, les lignes transfert existantes seront supprimées et de nouvelles lignes transfert seront créées.\\';
        Text2013664: TextConst ENU = 'Do you want to change %1 with new %2 %3?', FRA = 'Souhaitez-vous modifier la valeur du champ %1 avec %2 %3?';
        Text2014060: TextConst ENU = 'The combination of locations used in transfer order %1 is blocked. %2', FRA = 'La combinaison des magasins utilisée pour l''ordre de transfert %1 est bloquée. %2';
        //recFinXLSetup: Record "Finance XL Setup";////---BC Upgrade KAMNAY01 DITW
        Text2014263: TextConst ENU = 'must be between %1 and %2  when %3 = %4.';

    procedure FilterShippingAgentServiceCode()
    var
        ShippingAgentServices: Record "Shipping Agent Services";
    begin
        //>> HEI.05
        ShippingAgentServices.RESET();
        ShippingAgentServices.SETRANGE("Shipping Agent Code", Rec."Shipping Agent Code");
        //---BC Upgrade KAMNAY01>> DITW Field
        // ShippingAgentServices.SETFILTER("Allow Shipping Cost Per", '%1|%2', ShippingAgentServices."Allow Shipping Cost Per"::Document,
        //                                                        ShippingAgentServices."Allow Shipping Cost Per"::" "); //HEI.06 ///
        //---BC Upgrade KAMNAY01<< DITW Field
        IF PAGE.RUNMODAL(0, ShippingAgentServices) = ACTION::LookupOK THEN
            VALIDATE("Shipping Agent Service Code", ShippingAgentServices.Code);
        //<< HEI.05
    end;

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        //HEI.11>>
        grec_PurchHdrAdd.RESET();
        grec_PurchHdrAdd.SETRANGE("Document Type", grec_PurchHdrAdd."Document Type"::Order);
        grec_PurchHdrAdd.SETRANGE(grec_PurchHdrAdd."TO Reference", "No.");
        IF grec_PurchHdrAdd.FINDFIRST() THEN BEGIN
            grec_PurchHdrAdd."TO Reference" := '';
            grec_PurchHdrAdd.MODIFY();
            grec_PurchLn.RESET();
            grec_PurchLn.SETRANGE("Document Type", grec_PurchLn."Document Type"::Order);
            grec_PurchLn.SETRANGE("Document No.", grec_PurchHdrAdd."No.");
            //grec_PurchLn.SETRANGE("TO Reference",grec_PurchHdrAdd."TO Reference");
            IF grec_PurchLn.findset() THEN
                REPEAT
                    grec_PurchLn."TO Reference FND" := '';
                    grec_PurchLn.MODIFY();
                UNTIL grec_PurchLn.NEXT() = 0;
        end;
        //HEI.11<<
    end;
}

