pageextension 51161 WarehouseShipmentExtCBN extends "Warehouse Shipment"
{
    // DITW15.00.00.21 DDR 18/06/2008 added fields
    //                                  "Maximum Weight","Maximum Volume",
    //                                  "Shipping Charge Type","Shipping Charge No.","Shipping Charge Per"
    //                                  "Shipping Unit Cost","Shipping Cost Amount"
    //                                added function FormatMaximumControls()
    //                                added property's Form: CalcFields
    //                                added menu "Move Whse. Shipment Lines" into Line Button
    //                                replaced the Print button
    // DITW15.00.00.23.04 DDR£ 12/09/2008 Added field "Driver Code"
    // DITW15.00.00.25 DDR 09/10/2008 Bugfix refreshing fields "Maximum Weight","Maximum Cubage" with color
    //                                 into function FormatMaximumControls()
    //                                Added field "Truck Code"
    // DITW15.00.00.28 DDR 02/12/2008 Added field ""Shipping Cost by Distance" into "Shipping" tab
    // DITW15.00.00.34 DDR 17/06/2009 Added shortcut key CTRL+F10 to switch status 'open' the current document
    //                                Changed Editable "Status" field
    //                                Added functions DocStatusRelease(),DocStatusOpen(),
    // DITW15.00.00.35 DDR 19/08/2009 issue 773 Added fields "Shipping Currency Code"
    //                 DLE 06/09/2009 issue 516 Added field "Physical Location Group Code"
    //                                issue 880 Merge design fixing
    // DITW15.00.00.36 DDR 06/11/2009 issue 777 Added menu 'Source &Comment Lines' into 'Lines' button
    // DITW15.00.00.37 DDR 10/06/2010 issue 1061 Added OnLookup() in field "Physical Location Group Code"
    // DITW15.00.00.38 DDR 19/11/2010 issue 1139 SSCC Functionnalities
    //                                  Added menu 'SSCC Tracking Lines' in 'Line' buttton
    // DITW16.00.00.38 DDR 01/04/2011 DIT-715 issue 87 Added OpenWhseRcptHeader()
    // DITW15.00.00.39 DDR 22/08/2011 issue 1399 Added fields "Exists Posting Error Lines"
    //                                           Added 'Pending Pick','Pending Shipping' menu into 'Functions' button
    //                                           Updated field "Status"
    //                                           Added 'Picking List' menu into 'Print' button
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields "Route" into Shipping" tab
    //                     03/02/2012 #1331 (HIT0069.1 VVE 19/04/2011) FEFO tracking
    //                                           Added menuitem "Automatic FEFO Tracking" in menu Line & Functions
    //                     22/02/2012 DIT-715 #246 Moved menu1100083009 '&Move Whse. Receipt Line' ('Line' button) into 'Functions' button
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    //                                             NORRIQ owm - Online Warehouse Management
    //                                             Copyright 2008 by NORRIQ A/S, www.norriq.dk
    //                                               New menu "Show OWM Activitystatus" on Shipment Action.

    // DITW17.00.02 DDR 17/05/2013 DIT-770 #95 Added 'Vessel/Port' tab + fields
    //                                               "Vessel info code","Port Code","Wharf Code","No. of Crews","No. of Passengers",
    //                                               "Estimated Voyage (Days)","Estimated Voyage (Text)","Voyage Details",
    //                                               "Voyage Destination","Net Tonnage"
    //                                             Added 'Document C945' menu into 'Print' button
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #95
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.00.02 DDR 28/11/2013 DIT-770 #272 Upgrade N-OWM4.5 Nav2013 R1
    // DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 Added Field 2014100 "Trailer Code"
    // DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214 Filter on "Resp. Center Table Filter"
    // DITW18.00.07 VSC 16/02/2016 DIT-770 #1703 Add New Line Detail Factbox
    // DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1066 Removed old Shipping Costs fields from Shipping Tab
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 Add Flowfield "Document Shipping Costs" to General TAB

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 MSF 11/09/2017 NRQ#16082 Route Planning and Warehouse Documents
    //                               Added Fields Route planning No.
    //                               Shipping tab Field Are Editable when Route planning No is not filled
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Make Field not Editable if Multiple Route Order
    //                                        Added Fields Driver 2 Code & Multiple Route Order
    // DITW110.00.11 MSF 02/10/2017 NRQ#16082 Added Action Ribon Report
    //                                       Added function PrintSales
    // DITW110.00.11 MSF 13/11/2017 NRQ#16082 Error message when print Load list
    // DITW113.00.15 ISL 01/11/2019 NRQ#122644 Added check on Route, Truck and driver mandatory in Warehouse header on posting
    // HEI.01 FDD-PA-LOGGAP05 - Loading Note IBM.NAIKH01 20.11.2017
    //    # Created a new Page Action "Loading Note" and add code.
    // HEI.02 HORTOC01 15/03.2018
    //   # new temporary action for Algeria
    // HEI.02 FDD-LB-GAPLOG03 IBM NASTAA02 17.07.2018 # Loading Note Almaza
    //   # New Page Action created
    // HEI.03 FDD-LB-GAPLOG09_Lebanon_Almaza_Picking List Layout_v1.2 ,IBM.NAIKH01 04.09.2018
    //   # Added a new Button on the Menu "Combined Pick (shipment)"
    // HEI.04 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field added: "Gate Entry No."
    //   # New PageAction created: "CreateGateEntryOutbound"
    // DITW111.00.13 MSF 06/12/2018 NRQ#94671 Line and header alert for not fully assigned lines - in warehouse shipment and sales order
    //                                        New Group Added in tab General
    // DITW111.00.13 MSF 13/12/2018 NRQ#94671 Added field "Show Item Track. Alert on Shpt"
    // HEI.07 FDD- HB597 IBM BULIMc01 24.05.2019 #add the report "Picking list by Sales Order BA" on page
    // HEI.05 RFC-CHG0255774 IBM.AB 15.10.2018
    //   # Code added to validate Shipping Agent Code
    // HEI.08 CHG0255774_FDD_TC_Calculation_Enhancement IBM NANDIS01 08.07.2019
    //   Validation added to show error message when the shipping agent is not ticked as Own Logistics
    // HEI.09 FDD-HT658 IBM.GUNERE01 17.09.2019 # TruckMandatory, DriverMandatory, ShippingAgentMandatory
    //                                            ShippingAgentServiceMandatory variables added
    //                                          # IsTruckMandatory, IsDriverMandatory, IsShippingAgentCodeMandatory,
    //                                            IsShippingAgentServCodeMandatory funcs. added, Code added to OnAfterGetRecord()
    //                                            "Source Document Type" ,"Source No." fields added
    // HEI.10 CHG2008448 IBM.LS      12.12.2019
    //   # Property changed (Visible: FALSE) in this button "Post and &Print (Load List)".
    // HEI.11 FDD-HB503 IBM NASTAA02 31.03.2020 # Post & Print
    //   # Made Page Action "Post and &Print (Load List)" visible depending on setup
    //   # Code added on "OnAfterGetRecord" trigger
    //   # Added Global variable "PostPrintLoadingNote"
    // HEI.12 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # Code added on "Get Source Documents" Action
    // HEI.13 HT2140 - CHG2105034 IBM NANDIS01 29.04.2021 - Brasco Congo: HT2140 - License Code Process Flow
    //   # New field shown - "License Code"
    // HEI.14 HB2156CHG2107450 IBM GAVANM01 27.01.2022 # WMS Phase 2 - Transportation cost
    //   # new field added in General tab: WMS Import
    //   # new global var VisibleWMS, WMSInterfaceSetup
    //   # code added in OnInit() and in the actions: Post Shipment, Post and &Print,Post and &Print (Load List)
    // HEI.15 HB2156 CHG2107450 IBM GAVANM01 14.03.2022 # WMS Phase 2 Transportation cost
    //   # disable Auto FEFO if WMS Import = TRUE
    //   # new global var EnabledAutoFEFO
    // HEI.16 CHG2155847 HB2821 IBM NANDIS01 03.02.2023 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # control on whse shipment posting as per setups
    // HEI.17 CHG2155847 HB2821 IBM NANDIS01 09.02.2023 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Fix on whse shipment posting as it blocked for sales shipment
    // HEI.18 CHG2155847 HB2821 IBM NANDIS01 15.02.2023 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Fix on control of whse shpmnt posting
    // HEI.19 CHG2224964 CC-INC4873083 IBM MAJUMS03 20.10.2023 # Business is unable to use blocked vendor for payement
    //   # Code modified to enhance the validation based on the values in the option field Blocked. No Blocking for Blocked Value = Blank and Payment. Blocking is valid
    //   for Blocked Value = Order and All.
    //--------------------------------------------------------------------------------------------
    //BC Upgrade SHARMP16 --- interface related action Post and &Print (Load List) and onopenpage trigger shifted to Interface Extension

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the warehouse shipment header that was created.', FRA = 'Spécifie le numéro d''en-tête expédition entrepôt qui a été créé.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location from which the items are being shipped.', FRA = 'Spécifie le code du magasin à partir duquel les articles sont expédiés.';

            //Unsupported feature: Change Editable on ""Location Code"(Control 36)". Please convert manually.

        }
        modify("Zone Code")
        {
            ToolTipML = ENU = 'Specifies the code of the zone on this shipment header.', FRA = 'Spécifie le code de la zone qui figure sur cet en-tête réception.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Indicates the bin code to place the items that are about to be shipped.', FRA = 'Indique le code emplacement pour positionner les articles qui vont être expédiés.';
        }
        modify("Document Status")
        {
            ToolTipML = ENU = 'Specifies the progress level of warehouse handling on lines in the warehouse shipment.', FRA = 'Spécifie le niveau de progression de la gestion des entrepôts sur les lignes de l''expédition entrepôt.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies the status of the shipment and is filled in by the program.', FRA = 'Spécifie le statut de l''expédition. La valeur est renseignée par le programme.';

            //Unsupported feature: Change Editable on "Status(Control 47)". Please convert manually.

        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies a posting date. If you enter a date, the posting date of the source documents is updated during posting.', FRA = 'Spécifie une date de validation. Si vous saisissez une date, la date comptabilisation des documents origine sera mise à jour au cours de la validation.';

            //Unsupported feature: Change Editable on ""Posting Date"(Control 42)". Please convert manually.

        }
        modify("Assigned User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.', FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
        }
        modify("Assignment Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the document was assigned to the user.', FRA = 'Spécifie la date à laquelle le document a été affecté à l''utilisateur.';
        }
        modify("Assignment Time")
        {
            ToolTipML = ENU = 'Specifies the time that the document was assigned to the user.', FRA = 'Spécifie l''heure à laquelle le document a été affecté à l''utilisateur.';
        }
        modify("Sorting Method")
        {
            ToolTipML = ENU = 'Specifies the method by which the shipments are sorted.', FRA = 'Indique la méthode permettant de trier les expéditions.';
        }
        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping', FRA = 'Livraison';
        }
        modify("External Document No.")
        {
            ToolTipML = ENU = 'Specifies the number of an external document related to the warehouse shipment.', FRA = 'Spécifie le numéro d''un document externe lié à l''expédition entrepôt.';

            //Unsupported feature: Change Editable on ""External Document No."(Control 55)". Please convert manually.

        }
        modify("Shipment Date")
        {
            ToolTipML = ENU = 'Specifies the shipment date of the warehouse shipment.', FRA = 'Indique la date d''expédition de l''expédition entrepôt.';
            Editable = true;//BC UPGRDAE KUMARR78 FDD-MTC-007++
            //Unsupported feature: Change Description on ""Shipment Date"(Control 40)". Please convert manually.


            //Unsupported feature: Change Editable on ""Shipment Date"(Control 40)". Please convert manually.

        }
        modify("Shipping Agent Code")
        {
            ToolTipML = ENU = 'Specifies the codes of the shipping agent being used for this warehouse shipment.', FRA = 'Spécifie les codes du transporteur utilisé pour cette expédition entrepôt.';
            Editable = true;//BC UPGRDAE KUMARR78 FDD-MTC-007++
            //Unsupported feature: Change Description on ""Shipping Agent Code"(Control 6)". Please convert manually.


            //Unsupported feature: Change Editable on ""Shipping Agent Code"(Control 6)". Please convert manually.
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.05>>
                IF ShippingAgent.GET(rec."Shipping Agent Code") THEN BEGIN
                    //HEI.08>>
                    //IF ShippingAgent."Vendor No." = '' THEN
                    //BC Upgrade SHARMP16 Begin<< DRink-IT fields used
                    // IF (ShippingAgent."Vendor No." = '') AND (NOT ShippingAgent."Own Logistics") THEN
                    //     //HEI.08<<
                    //     ERROR(ShippingAgentVendorIsBlank)
                    // else IF Vend.GET(ShippingAgent."Vendor No.") THEN BEGIN
                    //IF Vend.Blocked <> 0 THEN //HEI.19
                    //BC Upgrade SHARMP16 End>> DRink-IT fields used
                    IF NOT (Vend.Blocked IN [Vend.Blocked::" ", Vend.Blocked::Payment]) THEN //HEI.19
                        ERROR(VendorBlockForShipAgent);
                    // end;BC Upgrade SHARMP16 End>> DRink-IT
                end;
                //HEI.05<<
            end;
            //BC UPGRADE KUMARR78 FDD-MTC-007--
            // trigger OnLookup(var Text: Text): Boolean
            // var
            //     myInt: Integer;
            // begin
            //     //>> HEI.11
            //     FilterShippingAgentServiceCode();
            //     //<< HEI.11
            // end;
            //BC UPGRADE KUMARR78 FDD-MTC-007--


        }
        modify("Shipping Agent Service Code")
        {
            ToolTipML = ENU = 'Specifies the code of the shipping agent service that applies to this warehouse shipment.', FRA = 'Spécifie le code prestation transporteur qui s''appliquent à cette expédition entrepôt.';
            Editable = true;//BC UPGRDAE KUMARR78 FDD-MTC-007 ++
                            //Unsupported feature: Change Description on ""Shipping Agent Service Code"(Control 11)". Please convert manually.


            //Unsupported feature: Change Editable on ""Shipping Agent Service Code"(Control 11)". Please convert manually.
            //BC UPGRADE KUMARR78 FDD-MTC-007++
            trigger OnLookup(var Text: Text): Boolean
            var
                myInt: Integer;
            begin
                //>> HEI.11
                FilterShippingAgentServiceCode();
                //<< HEI.11
            end;
            //BC UPGRADE KUMARR78 FDD-MTC-007++

        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies the code of the shipment method being used for this shipment.', FRA = 'Spécifie le code utilisé pour trouver les conditions de livraison utilisées pour cette expédition.';

            //Unsupported feature: Change Description on ""Shipment Method Code"(Control 19)". Please convert manually.


            //Unsupported feature: Change Editable on ""Shipment Method Code"(Control 19)". Please convert manually.

        }

        //Unsupported feature: CodeInsertion on "Status(Control 47)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        StatusOnValidate;
          StatusOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Shipping Agent Code"(Control 6)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.05>>
        if ShippingAgent.GET("Shipping Agent Code") then begin
          //HEI.08>>
          //IF ShippingAgent."Vendor No." = '' THEN
          if (ShippingAgent."Vendor No." = '') and (not ShippingAgent."Own Logistics") then
          //HEI.08<<
            ERROR(ShippingAgentVendorIsBlank)
          else if Vend.GET(ShippingAgent."Vendor No.") then begin
            //IF Vend.Blocked <> 0 THEN //HEI.19
            if not (Vend.Blocked in [Vend.Blocked::" ",Vend.Blocked::Payment]) then //HEI.19
              ERROR(VendorBlockForShipAgent);
          end;
        end;
        //HEI.05<<
        */
        //end;
        //BC Upgrade SHARMP16 Begin<< ---- Drink-IT fields
        // addafter("Location Code")
        // {
        //     field("Physical Location Group Code"; Rec."Physical Location Group Code")
        //     {
        //         Editable = EditableMultipleRouteOrder;

        //         trigger OnLookup(Text: Text): Boolean;
        //         begin
        //             // <<DITW15.00.00.37 DDR 10/06/2010
        //             CurrPage.SAVERECORD;
        //             LookupPhysLocation(Rec);
        //             CurrPage.UPDATE(true);
        //         end;
        //     }
        // }
        //BC Upgrade SHARMP16 End>> ---- Drink-IT fields
        addafter(Status)
        {
            //BC Upgrade SHARMP16 Begin<< ---- Drink-IT fields
            // field("Exist Posting Error Lines"; Rec."Exist Posting Error Lines")
            // {
            // }
            //BC Upgrade SHARMP16 End>> ---- Drink-IT fields
        }
        addafter("Sorting Method")
        {//BC Upgrade SHARMP16 Begin<< ---- Drink-IT fields
            // field("Document Shipping Costs"; Rec."Document Shipping Costs")
            // {
            // }
            //BC Upgrade SHARMP16 End>>---- Drink-IT fields
            field("<License Code>"; PurchHdrAddRec."License Code")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'License Code';
                Editable = false;
                ToolTip = 'Specifies the value of the License Code field.';
            }
            field("WMS Import"; Rec."WMS Import FND")
            {
                ApplicationArea = Basic, Suite;
                Visible = VisibleWMS;
                ToolTip = 'Specifies the value of the WMS Import field.';
            }
            group(Control1111000003)
            {
                Visible = LotRequired;
                field(Text2014416; Text2014416)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ShowCaption = false;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
            }
            field("Gate Entry No."; Rec."Gate Entry No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gate Entry No. field.';
            }
        }
        //BC UPGRADE KUMARR78 FDD-MTC-007
        modify("Trailer 107FDW")
        {
            Editable = true;
        }
        modify("LOG Vehicle Code 107FDW")
        {
            Editable = true;
        }
        modify("Log Driver 107FDW")
        {
            Editable = true;
        }
        //BC UPGRADE KUMARR78 FDD-MTC-007
        addafter("Shipping Agent Service Code")
        {
            //BC UPGRADE KUMARR78 >> FDD-MTC-007
            field("Vehicle Code"; Rec."Vehicle Code 101FDW")
            {

                Description = '<DITW15.00.00.25 -  DITW18.00.06 MSF 06/07/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
                Editable = true;
                Visible = false;//BC UPGRADE KUMARR78 25-06-2026+
                ApplicationArea = all;

                trigger OnValidate();
                begin
                    //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                    if (xRec."Vehicle Code 101FDW" <> Rec."Vehicle Code 101FDW") then
                        CurrPage.UPDATE(true)
                    //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                end;
            }
            field("Trailer Code"; Rec."Trailer 107FDW")
            {
                Description = 'DITW18.00.06 MSF 14/05/2015 DIT-770 #1035-NRQ#16082';
                Editable = true;
                Visible = false;//BC UPGRADE KUMARR78 25-06-2026+
                ApplicationArea = all;

                trigger OnValidate();
                begin
                    //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                    if (xRec."Trailer 107FDW" <> Rec."Trailer 107FDW") then
                        CurrPage.UPDATE(true)
                    //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                end;
            }
            field("Driver Code"; Rec."Log Driver 107FDW")
            {
                Description = '<DITW15.00.00.23.04 -  DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
                Visible = false;//BC UPGRADE KUMARR78 25-06-2026+
                Editable = true;
                ApplicationArea = all;

                trigger OnValidate();
                begin
                    //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                    if (xRec."Log Driver 107FDW" <> Rec."Log Driver 107FDW") then
                        CurrPage.UPDATE(true)
                    //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                end;
            }

            field(Route; Rec."Route 107FDW")
            {
                Description = '<DITW16.00.00.40 #1002>-NRQ#16082';
                Editable = true;//BC UPGRADE KUMARR78 FDD-MTC-007
                Enabled = true;//BC UPGRADE KUMARR78 FDD-MTC-007
                Visible = false;//BC UPGRADE KUMARR78 25-06-2026+
                ApplicationArea = all;

                trigger OnValidate();
                begin
                    CurrPage.UPDATE(true);
                    //HEI.05>>
                    if RecRoute.GET(Rec."Route 107FDW") then begin
                        if ShippingAgent.GET(RecRoute."Shipping Agent Code") then begin
                            //HEI.08>>
                            //IF ShippingAgent."Vendor No." = '' THEN
                            //BC UPGARDE KUMARR78 FDD-MTC-007 --
                            // if (ShippingAgent."Vendor No." = '') and (not ShippingAgent."Own Logistics") then
                            //     //HEI.08<<
                            //     ERROR(ShippingAgentVendorIsBlank)
                            // else if Vend.GET(ShippingAgent."Vendor No.") then begin
                            //     if Vend.Blocked <> 0 then
                            //         ERROR(VendorBlockForShipAgent);
                            // end;
                            //BC UPGARDE KUMARR78 FDD-MTC-007 --

                        end;
                    end;
                    //HEI.05<<
                end;
            }
            //BC UPGRADE KUMARR78 << FDD-MTC-007
            //BC Upgrade SHARMP16 Begin<<---- Drink-IT fields
            // field(Distance; Rec.Distance)
            // {
            //     Description = '<DITW15.00.00.28>-NRQ#16082';
            //     Editable = EditableMultipleRouteOrder;
            // }
            // field("Truck Code"; Rec."Truck Code")
            // {
            //     Description = '<DITW15.00.00.25 -  DITW18.00.06 MSF 06/07/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
            //     Editable = EditableMultipleRouteOrder;

            //     trigger OnValidate();
            //     begin
            //         //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //         if (xRec."Truck Code" <> Rec."Truck Code") then
            //             CurrPage.UPDATE(true)
            //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //     end;
            // }
            // field("Trailer Code"; Rec."Trailer Code")
            // {
            //     Description = 'DITW18.00.06 MSF 14/05/2015 DIT-770 #1035-NRQ#16082';
            //     Editable = EditableMultipleRouteOrder;

            //     trigger OnValidate();
            //     begin
            //         //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //         if (xRec."Trailer Code" <> Rec."Trailer Code") then
            //             CurrPage.UPDATE(true)
            //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //     end;
            // }
            // field("Driver Code"; Rec."Driver Code")
            // {
            //     Description = '<DITW15.00.00.23.04 -  DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
            //     Editable = EditableMultipleRouteOrder;

            //     trigger OnValidate();
            //     begin
            //         //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //         if (xRec."Driver Code" <> Rec."Driver Code") then
            //             CurrPage.UPDATE(true)
            //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //     end;
            // }
            // field("Require 2 Drivers"; Rec."Require 2 Drivers")
            // {
            //     Editable = EditableMultipleRouteOrder;

            //     trigger OnValidate();
            //     begin
            //         if (xRec."Require 2 Drivers" <> Rec."Require 2 Drivers") then
            //             CurrPage.UPDATE(true)
            //     end;
            // }
            // field("Driver 2 Code"; Rec."Driver 2 Code")
            // {
            //     Editable = EditableMultipleRouteOrder;

            //     trigger OnValidate();
            //     begin
            //         if (xRec."Driver 2 Code" <> Rec."Driver 2 Code") then
            //             CurrPage.UPDATE(true)
            //     end;
            // }
            // field(Route; Rec.Route)
            // {
            //     Description = '<DITW16.00.00.40 #1002>-NRQ#16082';
            //     Editable = EditableMultipleRouteOrder;

            //     trigger OnValidate();
            //     begin
            //         CurrPage.UPDATE(true);
            //         //HEI.05>>
            //         if RecRoute.GET(Route) then begin
            //             if ShippingAgent.GET(RecRoute."Shipping Agent Code") then begin
            //                 //HEI.08>>
            //                 //IF ShippingAgent."Vendor No." = '' THEN
            //                 if (ShippingAgent."Vendor No." = '') and (not ShippingAgent."Own Logistics") then
            //                     //HEI.08<<
            //                     ERROR(ShippingAgentVendorIsBlank)
            //                 else if Vend.GET(ShippingAgent."Vendor No.") then begin
            //                     if Vend.Blocked <> 0 then
            //                         ERROR(VendorBlockForShipAgent);
            //                 end;
            //             end;
            //         end;
            //         //HEI.05<<
            //     end;
            // }
            // field("Multiple Order Route"; Rec."Multiple Order Route")
            // {
            //     Editable = false;
            // }
            // field("Route Planning No."; Rec."Route Planning No.")
            // {
            //     Description = '<DITW18.00.07 #1488>-NRQ#16082';
            //     Editable = EditableMultipleRouteOrder;
            //     TableRelation = "Route Planning Worksheet"."No." where("Physical Location Group Code" = FIELD("Physical Location Group Code"),
            //                                                             "Location Code" = FIELD("Location Code"));

            //     trigger OnValidate();
            //     begin
            //         CurrPage.UPDATE(true);
            //     end;
            // }
            //BC Upgrade SHARMP16 End>>---- Drink-IT fields
            field("Source Document Type"; Rec."Source Document Type FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Source Document Type field.';
            }
            field("Source No."; Rec."Source No. FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Source No. field.';
            }
            //BC Upgrade SHARMP16 Begin<<---- Drink-IT fields
            // group(Control1100076005)
            // {
            //     Caption = '""';
            //     field("Maximum Weight"; Rec."Maximum Weight")
            //     {
            //         Editable = false;
            //         Style = Attention;
            //         StyleExpr = "Maximum WeightEmphasize";
            //         Visible = "Maximum WeightVisible";
            //     }
            //     field("Maximum Cubage"; Rec."Maximum Cubage")
            //     {
            //         Editable = false;
            //         Style = Attention;
            //         StyleExpr = "Maximum CubageEmphasize";
            //         Visible = "Maximum CubageVisible";
            //     }
            //     field("Total Weight To Ship"; Rec."Total Weight To Ship")
            //     {
            //         Editable = false;
            //         Importance = Promoted;
            //     }
            //     field("Total Cubage To Ship"; Rec."Total Cubage To Ship")
            //     {
            //         Editable = false;
            //         Importance = Promoted;
            //     }
            // }
            //BC Upgrade SHARMP16 End>>---- Drink-IT fields
        }
        addafter(Control1901796907)
        {
            //BC Upgrade SHARMP16 BEGIN<<-- Drink-IT page used 
            // part(Control1100710001; "Warehouse Shipment FactBox")
            // {
            //     Provider = "97";
            //     SubPageLink = "No." = FIELD("No."),
            //                   "Line No." = FIELD("Line No.");
            //     Visible = true;
            // }
            //BC Upgrade SHARMP16 end>>-- Drink-IT page used 
        }
        moveafter("Shipment Date"; "Shipment Method Code")
    }
    actions
    {
        modify("&Shipment")
        {
            CaptionML = ENU = '&Shipment', FRA = 'E&xpédition';
        }
        // modify(List)
        // {
        //     CaptionML = ENU = 'List', FRA = 'Lister';
        // }
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
        modify("Posted &Whse. Shipments")
        {
            CaptionML = ENU = 'Posted &Whse. Shipments', FRA = 'Expé&ditions entrepôt enreg.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Use Filters to Get Src. Docs.")
        {
            CaptionML = ENU = 'Use Filters to Get Src. Docs.', FRA = 'Filtrer pour extr. doc. orig.';

            //Unsupported feature: Change Name on ""Use Filters to Get Src. Docs."(Action 34)". Please convert manually.

        }
        modify("Get Source Documents")
        {
            CaptionML = ENU = 'Get Source Documents', FRA = 'Extraire documents origine';
        }
        modify("Re&lease")
        {
            CaptionML = ENU = 'Re&lease', FRA = '&Lancer';
        }
        modify("Re&open")
        {
            CaptionML = ENU = 'Re&open', FRA = 'R&ouvrir';

        }
        modify("Autofill Qty. to Ship")
        {
            CaptionML = ENU = 'Autofill Qty. to Ship', FRA = 'Remplir qté à expédier';
        }
        modify("Delete Qty. to Ship")
        {
            CaptionML = ENU = 'Delete Qty. to Ship', FRA = 'Supprimer qté à expédier';
        }
        modify("Create Pick")
        {
            CaptionML = ENU = 'Create Pick', FRA = 'Créer prélèvement';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        modify("P&ost Shipment")
        {
            CaptionML = ENU = 'P&ost Shipment', FRA = '&Valider expédition';
            //BC UPGRADE KUMARR78 FDD-MTC-007
            trigger OnBeforeAction()
            var
                ReleaseWhseShptDoc: Codeunit "Whse.-Shipment Release";
            begin
                IF Rec.Status = Rec.Status::Open THEN
                    ReleaseWhseShptDoc.Release(Rec);
            end;
            //BC UPGRADE KUMARR78 FDD-MTC-007

        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
        }


        //Unsupported feature: CodeModification on ""Get Source Documents"(Action 23).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        GetSourceDocOutbound.GetSingleOutboundDoc(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        //HEI.12>>
        if SalesHeader.GET(SalesHeader."Document Type"::Order,"Source No.") then
          if SourceSystemIdentifierAPI.GET(SalesHeader."Source System Identifier") then
            if SourceSystemIdentifierAPI."Automatic SO Posting" then
              ERROR(CantShipErr,SalesHeader."Source System Identifier");
        //HEI.12<<
        GetSourceDocOutbound.GetSingleOutboundDoc(Rec);
        */
        //end;


        //Unsupported feature: CodeModification on ""Re&lease"(Action 45).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.UPDATE(true);
        if Status = Status::Open then
          ReleaseWhseShptDoc.Release(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3

        // <<DITW15.00.00.39 DDR 22/08/2011 #1399
        if Status <> Status::Released then begin
          VALIDATE(Status, Status::Released);
          CurrPage.UPDATE(true);
        end;
        // >>DITW15.00.00.39 DDR #1399
        */
        //end;


        //Unsupported feature: CodeInsertion on ""P&ost Shipment"(Action 25).OnAction". Please convert manually.

        //trigger (Variable: ReleaseWhseShptDoc)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""P&ost Shipment"(Action 25).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostShipmentYesNo;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW113.00.15 ISL 01/11/2019 NRQ#122644
        //HEI.14<<
        if WMSInterfaceSetup.GET and WMSInterfaceSetup."WMS Integration" then begin
          WhseShptLine.RESET;
          WhseShptLine.SETRANGE("No.",Rec."No.");
          WhseShptLine.SETFILTER("Item No.",'=%1','');
          if WhseShptLine.FINDFIRST then
            ERROR(ErrorText001);
        end;
        //HEI.14>>

        //HEI.16>>
        if AstroPostingValidation(Rec) then
          ERROR(Text50000);
        //HEI.16<<

        if Status = Status::Open then
          ReleaseWhseShptDoc.Release(Rec);
        if Status = Status::Released then
        // >>DITW113.00.15 ISL NRQ#122644
        PostShipmentYesNo;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Post and &Print"(Action 26).OnAction". Please convert manually.

        //trigger (Variable: ReleaseWhseShptDoc)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Post and &Print"(Action 26).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostShipmentPrintYesNo;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW113.00.15 ISL 01/11/2019 NRQ#122644
        //HEI.14<<
        if WMSInterfaceSetup.GET and WMSInterfaceSetup."WMS Integration" then begin
          WhseShptLine.RESET;
          WhseShptLine.SETRANGE("No.",Rec."No.");
          WhseShptLine.SETFILTER("Item No.",'=%1','');
          if WhseShptLine.FINDFIRST then
            ERROR(ErrorText001);
        end;
        //HEI.14>>

        //HEI.16>>
        if AstroPostingValidation(Rec) then
          ERROR(Text50000);
        //HEI.16<<

        if Status = Status::Open then
          ReleaseWhseShptDoc.Release(Rec);
        if Status = Status::Released then
        // >>DITW113.00.15 ISL NRQ#122644
        PostShipmentPrintYesNo;
        */
        //end;

        addafter("Posted &Whse. Shipments")
        {
            separator(Separator1161021000)
            {
            }
            action("Show N-owm activities")
            {
                CaptionML = ENU = 'Show N-owm activities',
                            FRA = 'Visualiser Activitées N-owm';
                Image = NewResource;
                ApplicationArea = All;
                ToolTip = 'Executes the Show N-owm activities action.';

                trigger OnAction();
                var
                // OWMUtils: Codeunit "N-owm Utils";//BC Upgrade SHARMP16-- Out of scope
                begin
                    // NIQ OWM >>
                    // OWMUtils.ShowActivityStatus(OWMUtils.ActShipment, rec."No.", rec."Location Code");  //DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806     // OWMUtils: Codeunit "N-owm Utils";//BC Upgrade SHARMP16-- Out of scope
                    // NIQ OWM <<
                end;
            }
            action("Shipping Costs")
            {
                CaptionML = ENU = 'Shipping Costs',
                            FRA = 'Coûts transport';
                Image = Costs;
                ApplicationArea = All;
                ToolTip = 'Executes the Shipping Costs action.';
                // RunObject = Page "Document Shipping Cost";
                //                 RunPageLink = "Source Type"=CONST(7320),
                //               "Source No."=FIELD("No."),
                //               "Sub Type"=CONST(0);            //BC Upgrade SHARMP16 Begin<<---- Drink-IT page used
            }
        }
        addafter("Re&open")
        {
            action("Pending &Pick")
            {
                CaptionML = ENU = 'Pending &Pick',
                            FRA = '&Prélévement en attente';
                Image = InventoryPick;
                ApplicationArea = All;
                ToolTip = 'Executes the Pending &Pick action.';

                trigger OnAction();
                var
                // ReleaseWhseShptDoc : Codeunit "Whse.-Shipment Release";
                begin
                    // <<DITW15.00.00.39 DDR 22/08/2011 #1399
                    //BC upgrade SHARMP16 Begin>> --- Drink-IT code
                    // if xRec.Status = Status::"Pending Pick" then
                    //     exit;
                    // // >>DITW15.00.00.39 DDR #1399
                    // // <<DITW15.00.00.39 DDR 22/08/2011 #1399
                    // CurrPage.UPDATE(true);
                    // // <<DITW15.00.00.39 DDR 22/08/2011 #1399
                    // ReleaseWhseShptDoc.CheckStatusBeforeRelease(Rec, Status::"Pending Pick");
                    // // >>DITW15.00.00.39 DDR #1399
                    // if Status = Status::Open then
                    //     ReleaseWhseShptDoc.Release(Rec);
                    // // <<DITW15.00.00.39 DDR 22/08/2011 #1399
                    // VALIDATE(Status, Status::"Pending Pick");
                    // CurrPage.UPDATE(true);
                    // >>DITW15.00.00.39 DDR #1399
                    //BC upgrade SHARMP16 End<< --- Drink-IT code
                end;
            }
            action("Pending &Shipping")
            {
                CaptionML = ENU = 'Pending &Shipping',
                            FRA = '&Expédition en attente';
                Image = Shipment;
                ApplicationArea = All;
                ToolTip = 'Executes the Pending &Shipping action.';

                trigger OnAction();
                var
                //   ReleaseWhseShptDoc : Codeunit "Whse.-Shipment Release";
                begin
                    //BC upgrade SHARMP16 Begin>> --- Drink-IT code
                    // <<DITW15.00.00.39 DDR 22/08/2011 #1399
                    // if xRec.Status = Status::"Pending Ship" then
                    //     exit;
                    // // >>DITW15.00.00.39 DDR #1399
                    // // <<DITW15.00.00.39 DDR 22/08/2011 #1399
                    // CurrPage.UPDATE(true);
                    // // <<DITW15.00.00.39 DDR 22/08/2011 #1399
                    // ReleaseWhseShptDoc.CheckStatusBeforeRelease(Rec, Status::"Pending Ship");
                    // // >>DITW15.00.00.39 DDR #1399
                    // if Status = Status::Open then
                    //     ReleaseWhseShptDoc.Release(Rec);
                    // // <<DITW15.00.00.39 DDR 22/08/2011 #1399
                    // VALIDATE(Status, Status::"Pending Ship");
                    // CurrPage.UPDATE(true);
                    // // >>DITW15.00.00.39 DDR #1399
                    //BC upgrade SHARMP16 End<< --- Drink-IT code
                end;
            }
        }
        addafter("Create Pick")
        {
            separator(Separator1100076702)
            {
            }
            action("&Automatic FEFO Tracking for Order")
            {
                CaptionML = ENU = '&Automatic FEFO Tracking for Order',
                            FRA = 'Traçabilité &automatique FEFO pour commande';
                Description = '#1331';
                //Enabled = EnabledAutoFEFO;//BC Upgrade VAMSIU01 Blocked Due to EnableAutofefo is not used.
                Image = ItemTracking;
                ShortCutKey = 'Shift+Ctrl+F';
                ApplicationArea = All;
                ToolTip = 'Executes the &Automatic FEFO Tracking for Order action.';

                trigger OnAction();
                var
                    AutoFEFO: Codeunit GenFunctions108FDW;
                    WarehouseShipmentLine: Record "Warehouse Shipment Line";
                begin
                    // <<DITW16.00.00.40 DDR 03/02/2012 #1331
                    // FEFOTrackingShipment();//BC upgrade SHARMP16-- Drink-IT code
                    // BC Upgrade VAMSIU01 Added code for Assign FEFO Tracking >>
                    WarehouseShipmentLine.SetRange("No.", Rec."No.");
                    if WarehouseShipmentLine.FindSet() then begin
                        repeat
                            AutoFEFO.AssignFEFOTracking(WarehouseShipmentLine);
                        until WarehouseShipmentLine.Next() = 0;
                    end;
                    // BC Upgrade VAMSIU01 Added code for Assign FEFO Tracking <<
                end;
            }
            separator(Separator1100083008)
            {
            }
            action(CreateGateEntryOutbound)
            {
                Caption = 'Create Gate Entry Outbound';
                Enabled = CreateOutboundGEEditable;
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Create Gate Entry Outbound action.';
                trigger OnAction();
                var
                // GateEntryInOut: Codeunit "Gate Entry Inbound/Outbound";//BC UPGRADE KUMARR -- FDD-MTC-007
                begin
                    // GateEntryInOut.CreateGateEntryOutbound(Rec); //HEI.04 //BC UPGRADE KUMARR -- FDD-MTC-007
                end;
            }
        }

        addafter("Post and &Print")
        {
            //BC Upgrade SHARMP16 BEGIN>>---- Interface related code
            // action("Post and &Print (Load List)")
            // {
            //     Caption = 'Post and &Print (Load List)';
            //     Description = 'HEI.11';
            //     Ellipsis = true;
            //     Image = PostPrint;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ShortCutKey = 'Shift+F9';
            //     Visible = PostPrintLoadingNote;
            //     ApplicationArea = Basic, Suite;
            //     trigger OnAction();
            //     var
            //         WarehouseShipmentLine: Record "Warehouse Shipment Line";
            //     begin
            //         //HEI.14<<
            //         if WMSInterfaceSetup.GET and WMSInterfaceSetup."WMS Integration" then begin
            //             WhseShptLine.RESET;
            //             WhseShptLine.SETRANGE("No.", Rec."No.");
            //             WhseShptLine.SETFILTER("Item No.", '=%1', '');
            //             if WhseShptLine.FINDFIRST then
            //                 ERROR(ErrorText001);
            //         end;
            //         //HEI.14>>

            //         // //HEI.16>>
            //         // if AstroPostingValidation(Rec) then
            //         //     ERROR(Text50000);//BC Upgrade SHARMP16 -- Astro code out of scope
            //         //HEI.16<<

            //         //HEI.02>>
            //         WarehouseShipmentLine.SETRANGE("No.", rec."No.");
            //         if WarehouseShipmentLine.findset then
            //             repeat
            //                 WarehouseShipmentLine."Print Load List Shipment" := true;
            //                 WarehouseShipmentLine.MODIFY;
            //             until WarehouseShipmentLine.NEXT = 0;
            //         PostShipmentPrintYesNo;


            //         //HEI.02<<
            //     end;
            // }
            //BC Upgrade SHARMP16end<<---- Interface related code
            separator(Separator1100066008)
            {
            }
            action("Update N-owm lines.")
            {
                CaptionML = ENU = 'Update N-owm lines.',
                            FRA = 'Mettre à jour les lignes N-owm';
                Description = 'DIT-715 #806';
                Promoted = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Update N-owm lines. action.';

                trigger OnAction();
                var
                    lrecWhseShptLine: Record "Warehouse Shipment Line";
                begin
                    //BC Upgrade SHARMP16-- Drink-IT code
                    // lrecWhseShptLine.fctExcludeFromCheck("No.");  //DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
                end;
            }
            group("&&Print")
            {
                CaptionML = ENU = '&Print',
                            FRA = '&Imprimer';
                action(Shipment)
                {
                    CaptionML = ENU = 'Shipment',
                                FRA = 'Expédition';
                    Image = Print;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Shipment action.';

                    trigger OnAction();
                    begin
                        // <<DIT15.00.00.21 DDR 19/06/2008
                        //  WhseDocPrint.PrintShptHeader(Rec);Print Load List Shipment//BC Upgrade SHARMP16-- Drink-IT code
                        // >>DIT15.00.00.21 DDR
                    end;
                }
                action("Shipping Schedule")
                {
                    CaptionML = ENU = 'Shipping Schedule',
                                FRA = 'Calendrier de livraison';
                    Image = Print;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Shipping Schedule action.';

                    trigger OnAction();
                    begin
                        // <<DIT15.00.00.21 DDR 19/06/2008
                        //WhseDocPrint.PrintShptScheduleHeader(Rec);//BC Upgrade SHARMP16-- Drink-IT code
                        // >>DIT15.00.00.21 DDR
                    end;
                }
                action("Shipping Agent Notice")
                {
                    CaptionML = ENU = 'Shipping Agent Notice',
                                FRA = 'Avis d''expédition transporteur';
                    Image = Print;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Shipping Agent Notice action.';

                    trigger OnAction();
                    begin
                        // <<DIT15.00.00.21 DDR 19/06/2008
                        // WhseDocPrint.PrintShptAgentNoticeHeader(Rec);//BC Upgrade SHARMP16-- Drink-IT code
                        // >>DIT15.00.00.21 DDR
                    end;
                }
                action("Sales Order Document (Packing)")
                {
                    CaptionML = ENU = 'Sales Order Document (Packing)',
                                FRA = 'Document commande vente (Emballage)';
                    Image = Print;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Sales Order Document (Packing) action.';

                    trigger OnAction();
                    begin
                        // <<DITW15.00.00.39 DDR 22/08/2011 #1399
                        //WhseDocPrint.PrintShptSalesDocument(Rec);//BC Upgrade SHARMP16-- Drink-IT code
                    end;
                }
                action("Loading Notes")
                {
                    Caption = 'Loading Notes';
                    Image = Print;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Executes the Loading Notes action.';

                    trigger OnAction();
                    var
                        ShptHeader: Record "Warehouse Shipment Header";
                        ReportID: Integer;
                    begin
                        /*HEI.03
                        //>>HEI.01
                        ShptHeader.SETRANGE("No.","No.");
                        REPORT.RUN(REPORT::"Truck Loading Note PAN",TRUE,FALSE,ShptHeader);
                        //>>HEI.01
                        */

                        ReportSelections.RESET();
                        ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"Loading Note(Whse Ship)");
                        if ReportSelections.findset() then
                            ReportID := ReportSelections."Report ID";

                        Rec.SETRANGE("No.", rec."No.");
                        if Rec.findset() then
                            REPORT.RUNMODAL(ReportID, true, false, Rec);

                        //ReportSelections.PrintForUsage(ReportSelections.Usage::"Loading Note(Whse Ship)");
                        //HEI.03

                    end;
                }
            }
            //BC Upgrade SHARMP16 Begin<<- Drink-IT code
            // action("Order Picking Instruction")
            // {
            //     Caption = 'Order Picking Instruction';
            //     Description = 'NRQ#16082';
            //     Image = Print;
            //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //     //PromotedCategory = "Report";

            //     trigger OnAction();
            //     begin
            //         //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
            //         PrintSales(DocType::Order, PrintOrderSalesUsage::"Pick Instruction");
            //     end;
            // }
            // action("Combine Picking Instruction")
            // {
            //     Caption = 'Combine Picking Instruction';
            //     Description = 'NRQ#16082';
            //     Image = Print;
            //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //     //PromotedCategory = "Report";

            //     trigger OnAction();
            //     begin
            //         //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
            //         PrintSales(DocType::Order, PrintOrderSalesUsage::"Combined Picking");
            //     end;
            // }
            // action("Order Shipment")
            // {
            //     Caption = 'Order Shipment';
            //     Description = 'NRQ#16082';
            //     Image = Print;
            //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //     //PromotedCategory = "Report";

            //     trigger OnAction();
            //     begin
            //         //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
            //         PrintSales(DocType::Order, PrintOrderSalesUsage::"Order Shipment");
            //     end;
            // }

            // action("Load List")
            // {
            //     Caption = 'Load List';
            //     Description = 'NRQ#16082';
            //     Image = Print;
            //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //     //PromotedCategory = "Report";

            //     trigger OnAction();
            //     begin
            //         //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
            //         PrintSales(DocType::Order, PrintOrderSalesUsage::"Load List");
            //     end;
            // }
            //BC Upgrade SHARMP16 End>>- Drink-IT code
            action("Combined Pick (shipment)")
            {
                Caption = 'Combined Pick (shipment)';
                Image = Print;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Combined Pick (shipment) action.';
                trigger OnAction();
                var
                    ReportSelections1: Record "Report Selections";
                    ReportID: Integer;
                begin
                    //HEI.03>>
                    ReportSelections1.RESET();
                    ReportSelections1.SETRANGE(Usage, ReportSelections1.Usage::"Combined Pick (Whs Shipment)");
                    if ReportSelections1.findset() then
                        ReportID := ReportSelections1."Report ID";

                    WarehouseShipmentHeader.SETRANGE("No.", rec."No.");
                    if WarehouseShipmentHeader.findset() then
                        REPORT.RUNMODAL(ReportID, true, false, WarehouseShipmentHeader);
                    //HEI.03<<
                end;
            }

            action("Picking List By SO")
            {
                Caption = 'Picking List By SO';
                Image = print;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Picking List By SO action.';
                trigger OnAction();
                var
                    ReservationEntry: Record "Reservation Entry";
                    TEMPResEntry: Record "Reservation Entry" temporary;
                    SalesHeader: Record "Sales Header";
                    WarehouseShipmentLine: Record "Warehouse Shipment Line";
                begin
                    //<<HEI.07
                    ReportSelections.RESET();
                    ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"Picking List By SO");
                    if ReportSelections.findset() then
                        ReportID := ReportSelections."Report ID";

                    Rec.SETRANGE("No.", rec."No.");
                    if Rec.findset() then
                        REPORT.RUNMODAL(ReportID, true, false, Rec);
                    //<<HEI.07
                end;
            }
        }
    }

    var
        PurchHdrAddRec: Record "Purchase Header Additional FND";
        ReportSelection: Record "Report Selections";
        ReportSelections: Record "Report Selections";
        ResponsibilityCenter: Record "Responsibility Center";
        SalesHeader: Record "Sales Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SSH: Record "Sales Shipment Header";
        ShippingAgent: Record "Shipping Agent";
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        Vend: Record Vendor;
        WarehouseSetup: Record "Warehouse Setup";
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        //WMSInterfaceSetup: Record "WMS Interface Setup"; //BC Upgrade SHARMP16-- Interface related Variable
        WhseShptLine: Record "Warehouse Shipment Line";
        ButtonEnable: Boolean;
        CreateOutboundGEEditable: Boolean;
        DriverMandatory: Boolean;
        EditableMultipleRouteOrder: Boolean;
        EnabledAutoFEFO: Boolean;
        //  RecRoute: Record Route;
        RecRoute: Record Route107FDW; //BC UPGRADE KUMARR78 ++FDD-MTC-007

        LotRequired: Boolean;

        "Maximum CubageEmphasize": Boolean;

        "Maximum CubageVisible": Boolean;

        "Maximum WeightEmphasize": Boolean;

        "Maximum WeightVisible": Boolean;
        PostPrintLoadingNote: Boolean;
        ShippingAgentMandatory: Boolean;
        ShippingAgentServiceMandatory: Boolean;
        TruckMandatory: Boolean;
        VisibleWMS: Boolean;
        ReportID: Integer;


        // ReleaseWhseShptDoc : Codeunit "Whse.-Shipment Release";


        // ReleaseWhseShptDoc : Codeunit "Whse.-Shipment Release";
        TempNewStatus: Integer;
        CantShipErr: Label 'You can not ship an Order sent by %1.';
        ErrorText001: Label 'The warehouse shipment cannot be posted. Please solve the error lines.';
        ShippingAgentVendorIsBlank: Label 'There is no Vendor associated with this Shipping Agent';
        Text50000: Label 'The warehouse shipment has lines associated with Astro, so manually it can not be posted';
        Text2014416: Label 'Lot Required or Undefined Lot Tracking quantity';
        VendorBlockForShipAgent: Label 'The Vendor associated with this Shipping Agent is blocked';
        PrintOrderSalesUsage: Option "Order Confirmation","Work Order","Pick Instruction",,,,,,,,,,"Order Picking","Picking List","Shipping List","Order Shipment","Combined Picking","Load List","Shipment Specif.","Return Control",,,,,,,,,,,,,,,,,,,,"Pro-forma";

        //RouteSalesMgt : Codeunit "Route Sales-Request Mgt.";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";

    procedure PostShipmentPrintYesNo()
    begin
        CurrPage.WhseShptLines.PAGE.PostShipmentPrintYesNo();
    end;

    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
    if "Physical Location Group Code" <> '' then begin
    ResponsibilityCenter.RESET;
      ResponsibilityCenter.SETRANGE("Physical Location Group Code","Physical Location Group Code");
      if not ResponsibilityCenter.ISEMPTY then begin
        ResponsibilityCenter.FINDFIRST;
        SETFILTER("Resp. Center Table Filter",'%1|%2','',ResponsibilityCenter.Code);
      end;
    end;
    //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
    SETFILTER("Phys. Location Table Filter",'%1|%2','',"Physical Location Group Code");
    ///DITW110.00.11 MSF 02/10/2017 NRQ#16082
    EditableMultipleRouteOrder:= not "Multiple Order Route";
    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
    //<<DITW111.00.13 MSF 06/12/2018 NRQ#94671
    LotRequired := ExitUndefinedLot("No.");
    //>DITW111.00.13 MSF 06/12/2018 NRQ#94671
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    // <<DITW16.00.00.38 DDR 01/04/2011 DIT-715 #87
    MaximumCubageOnFormat;
    MaximumWeightOnFormat;
    // >>DITW16.00.00.38 DDR DIT-715 #87
    //<<DITW110.00.11 MSF 11/09/2017 NRQ#1608
    if "Route Planning No." = '' then
      EditableMultipleRouteOrder := true;
    //>>DITW110.00.11 MSF 11/09/2017 NRQ#1608

    //<<DITW111.00.13 MSF 06/12/2018 NRQ#94671-DITW111.00.13 MSF 13/12/2018 NRQ#94671
    if WarehouseSetup."Show Item Track. Alert on Shpt" then
      LotRequired := ExitUndefinedLot("No.");
    //>DITW111.00.13 MSF 06/12/2018 NRQ#94671-DITW111.00.13 MSF 13/12/2018 NRQ#94671

    CreateOutboundGEEditable := "Gate Entry No." = ''; //HEI.04
    //>> HEI.09 FDD-HT658 IBM.GUNERE01 17.09.2019
    if Route <> '' then begin
      TruckMandatory := IsTruckMandatory;
      DriverMandatory := IsDriverMandatory;
      ShippingAgentMandatory := IsShippingAgentCodeMandatory;
      ShippingAgentServiceMandatory := IsShippingAgentServCodeMandatory;
    end;
    //<< HEI.09 FDD-HT658 IBM.GUNERE01 17.09.2019

    PostPrintLoadingNote := not WarehouseSetup."Enable Post & Print on Loc"; //HEI.11

    //HEI.13>>
    PurchHdrAddRec.RESET;
    PurchHdrAddRec.SETRANGE("No.","Source No.");
    if PurchHdrAddRec.FINDFIRST then;
    //HEI.13<<
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    "Maximum WeightVisible" := true;
    "Maximum CubageVisible" := true;
    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
    EditableMultipleRouteOrder := true;
    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082

    VisibleWMS := WMSInterfaceSetup.GET and WMSInterfaceSetup."WMS Integration";  //HEI.14
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //begin
    /*
    // <<DITW16.00.00.38 DDR 01/04/2011 DIT-715 #87
    OpenWhseShptHeader(Rec);
    // >>DITW16.00.00.38 DDR DIT-715 #87
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ErrorIfUserIsNotWhseEmployee;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ErrorIfUserIsNotWhseEmployee;
    //<<DITW111.00.13 MSF 13/12/2018 NRQ#94671
    WarehouseSetup.GET;
    //>>DITW111.00.13 MSF 13/12/2018 NRQ#94671

    EnabledAutoFEFO := not "WMS Import";   //HEI.15
    */
    //end;
    //BC Upgrade SHARMP16 Begin<<-- Drink-IT code
    // procedure FormatMaximumControls(pFieldNo: Integer; pMaxValue: Decimal; pTotalValue: Decimal);
    // var
    //     lblnBold: Boolean;
    //     lcolor: Integer;
    // begin
    //     // <<DIT15.00.00.21 DDR 19/06/2008
    //     lcolor := 0;
    //     lblnBold := false;

    //     if pMaxValue < pTotalValue then
    //         lcolor := 255;

    //     lblnBold := lcolor <> 0;

    //     // <<DITW15.00.00.25 DDR 09/10/2008
    //     "Maximum CubageVisible" := false;
    //     "Maximum WeightVisible" := false;
    //     // >>DITW15.00.00.25 DDR

    //     case pFieldNo of
    //         FIELDNO("Maximum Weight"):
    //             begin
    //                 "Maximum WeightEmphasize" := lblnBold;
    //             end;
    //         FIELDNO("Maximum Cubage"):
    //             begin
    //                 "Maximum CubageEmphasize" := lblnBold;
    //             end;
    //     end;

    //     // <<DITW15.00.00.25 DDR 09/10/2008
    //     "Maximum CubageVisible" := true;
    //     "Maximum WeightVisible" := true;
    //     // >>DITW15.00.00.25 DDR
    // end;

    //BC Upgrade SHARMP16 End>>-- Drink-IT code


    //BC Upgrade SHARMP16 Begin<<-- Drink-IT code
    // local procedure DocStatusRelease();
    // var
    // //  ReleaseWhseShptDoc : Codeunit "Whse.-Shipment Release";
    // begin
    //     // <<DITW15.00.00.34 DDR 16/06/2009
    //     if Status <> Status::Open then
    //         exit;
    //     // copy of 'Release' menu (button Functions)
    //     // <<DITW15.00.00.39 DDR 22/08/2011 #1399
    //     ReleaseWhseShptDoc.CheckStatusBeforeRelease(Rec, TempNewStatus);
    //     // >>DITW15.00.00.39 DDR #1399
    //     ReleaseWhseShptDoc.Release(Rec);
    //     // <<DITW15.00.00.39 DDR 22/08/2011 #1399
    //     if (TempNewStatus <> Status) and (TempNewStatus <> Status::Open) then begin
    //         VALIDATE(Status, TempNewStatus);
    //         MODIFY(true);
    //     end;
    //     // >>DITW15.00.00.39 DDR #1399
    // end;

    //BC Upgrade SHARMP16 End>>-- Drink-IT code


    //BC Upgrade SHARMP16 Begin<<-- Drink-IT code
    // local procedure DocStatusOpen(ShowConfirmMsg: Boolean);
    // var
    // //  ReleaseWhseShptDoc : Codeunit "Whse.-Shipment Release";
    // begin
    //     // <<DITW15.00.00.34 DDR 16/06/2009
    //     if Status = Status::Open then
    //         exit;

    //     // copy of 'ReOpen' menu (button Functions)
    //     ReleaseWhseShptDoc.Reopen(Rec);
    // end;

    //BC Upgrade SHARMP16 End>>-- Drink-IT code

    //BC Upgrade SHARMP16 Begin<<- Drink-IT code
    // local procedure StatusOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.39 DDR 22/08/2011 #1399
    //     CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.39 DDR #1399
    // end;

    // local procedure StatusOnValidate();
    // var
    // //     ReleaseWhseShptDoc : Codeunit "Whse.-Shipment Release";
    // begin
    //     // <<DITW15.00.00.34 DDR 17/06/2009
    //     if xRec.Status = Rec.Status then
    //         exit;

    //     // <<DITW15.00.00.39 DDR 22/08/2011 #1399
    //     TempNewStatus := rec.Status;
    //     // >>DITW15.00.00.39 DDR #1399

    //     if xRec.Status = rec.Status::Open then begin
    //         rec.Status := xRec.Status;
    //         DocStatusRelease();
    //     end else begin
    //         // <<DITW15.00.00.39 DDR 22/08/2011 #1399
    //         if rec.Status = Status::Open then begin
    //             Status := xRec.Status;
    //             DocStatusOpen(true);
    //             // <<DITW15.00.00.39 DDR 22/08/2011 #1399
    //         end else begin
    //             Status := xRec.Status;
    //             ReleaseWhseShptDoc.CheckStatusBeforeRelease(Rec, TempNewStatus);
    //             Status := TempNewStatus;
    //         end;
    //         // >>DITW15.00.00.39 DDR #1399
    //     end;
    // end;
    //BC Upgrade SHARMP16 End>>- Drink-IT code

    //BC Upgrade SHARMP16 Begin<<- Drink-IT fields used
    // local procedure MaximumCubageOnFormat();
    // begin
    //     CALCFIELDS("Total Cubage To Ship");
    //     FormatMaximumControls(FIELDNO("Maximum Cubage"), "Maximum Cubage", "Total Cubage To Ship");
    // end;
    //BC Upgrade SHARMP16 End>> Drink-IT fields used
    //BC Upgrade SHARMP16 Begin<<- Drink-IT fields used
    // local procedure MaximumWeightOnFormat();
    // begin
    //     CALCFIELDS("Total Weight To Ship");
    //     FormatMaximumControls(FIELDNO("Maximum Weight"), "Maximum Weight", "Total Weight To Ship");
    // end;
    //BC Upgrade SHARMP16 End>>- Drink-IT fields used

    //BC Upgrade SHARMP16 Begin<<- Drink-IT fields used
    // local procedure PrintSales(DocumentType: Option "Order",Invoice,"Credit Memo",,"Return Order"; PrintOrderUsage: Integer);
    // var
    //     SalesHeader: Record "Sales Header";
    // begin
    //     //<<DITW110.00.11 MSF 02/10/2017 NRQ#16082
    //     SalesHeader."Document Type" := DocumentType;
    //     SalesHeader.FILTERGROUP(100);
    //     SalesHeader.SETRANGE("Document Type", DocumentType);
    //     SalesHeader.FILTERGROUP(0);
    //     SalesHeader.SETRANGE("Route Planning No.", "Route Planning No.");
    //     if "Shipment Date" <> 0D then
    //         SalesHeader.SETRANGE(SalesHeader."Shipment Date", "Shipment Date");//FCE Added the Salesheader Rec
    //     if Route <> '' then
    //         SalesHeader.SETRANGE(Route, Route)
    //     else
    //         COPYFILTER(Route, SalesHeader.Route);
    //     COPYFILTER("Shipment Method Code", SalesHeader."Shipment Method Code");
    //     COPYFILTER("Location Code", SalesHeader."Location Code");
    //     COPYFILTER("Physical Location Group Code", SalesHeader."Physical Location Group Code");
    //     //<<DITW110.00.11 MSF 13/11/2017 NRQ#16082
    //     if SalesHeader.findset then
    //         //>>DITW110.00.11 MSF 13/11/2017 NRQ#16082
    //         RouteSalesMgt.PrintSalesDocument(SalesHeader, PrintOrderUsage);
    // end;
    //BC Upgrade SHARMP16 End>>- Drink-IT fields used


    //BC Upgrade SHARMP16 Begin<<- Drink-IT table used
    // local procedure IsTruckMandatory(): Boolean;
    // var
    //     locRoute: Record Route;
    // begin
    //     //>> HEI.09
    //     if locRoute.GET(Route) then begin
    //         if locRoute."Truck No. Mandatory" = true then
    //             exit(true)
    //         else
    //             exit(false);
    //     end;
    //     //<< HEI.09
    // end;

    // local procedure IsDriverMandatory(): Boolean;
    // var
    //     locRoute: Record Route;
    // begin
    //     //>> HEI.09
    //     if locRoute.GET(Route) then begin
    //         if locRoute."Driver Mandatory" = true then
    //             exit(true)
    //         else
    //             exit(false);
    //     end;
    //     //<< HEI.09
    // end;

    // local procedure IsShippingAgentCodeMandatory(): Boolean;
    // var
    //     locRoute: Record Route;
    // begin
    //     //>> HEI.09
    //     if locRoute.GET(Route) then begin
    //         if locRoute."Shipping Agent Code Mantatory" = true then
    //             exit(true)
    //         else
    //             exit(false);
    //     end;
    //     //<< HEI.09
    // end;

    // local procedure IsShippingAgentServCodeMandatory(): Boolean;
    // var
    //     locRoute: Record Route;
    // begin
    //     //>> HEI.09
    //     if locRoute.GET(Route) then begin
    //         if locRoute."Ship. Ag. Serv. Code Mandatory" = true then
    //             exit(true)
    //         else
    //             exit(false);
    //     end;
    //     //<< HEI.09
    // end;
    //BC Upgrade SHARMP16 End>>- Drink-IT table used

    //BC UPgrade SHARMP16 Begin<< ---- Astro related code
    // local procedure AstroPostingValidation(WarehouseShipmentHeader: Record "Warehouse Shipment Header"): Boolean;
    // var
    //     // AstroInterfaceSetup: Record "Astro Interface Setup";//BC Upgrade SHARMP16-- Astro Out of scope
    //     WarehouseShipmentLine: Record "Warehouse Shipment Line";
    //     PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    //     PurchaseLine: Record "Purchase Line";
    //     FlagonPosting: Boolean;
    // begin
    //     //HEI.18>>
    //     //HEI.16>>
    //     //IF AstroInterfaceSetup.GET THEN BEGIN
    //     //  IF AstroInterfaceSetup."Enabled Astro Integration" THEN BEGIN
    //     //   IF (WarehouseShipmentHeader."Source Document Type" = WarehouseShipmentHeader."Source Document Type"::"Purchase Return Order") THEN BEGIN  //HEI.17
    //     //      IF AstroInterfaceSetup."Enable Purch Return Order Sync" THEN BEGIN
    //     //        PurchasesPayablesSetup.GET;
    //     //        IF (PurchasesPayablesSetup."Astro Whse Rcpt Manl Post") OR (AstroInterfaceSetup."Allow Mnl Posting Purch Shpmt") THEN BEGIN
    //     //          FlagonPosting := FALSE;
    //     //          WarehouseShipmentLine.RESET;
    //     //          WarehouseShipmentLine.SETRANGE("No.",WarehouseShipmentHeader."No.");
    //     //          WarehouseShipmentLine.SETFILTER("Qty. to Ship",'<>%1',0);
    //     //          WarehouseShipmentLine.SETRANGE("Source Document",WarehouseShipmentLine."Source Document"::"Purchase Return Order");
    //     //          IF WarehouseShipmentLine.findset THEN REPEAT
    //     //            IF PurchaseLine.GET(PurchaseLine."Document Type"::"Return Order",WarehouseShipmentLine."Source No.",WarehouseShipmentLine."Source Line No.") THEN
    //     //              IF (PurchaseLine."Astro Unique ID" <> '') THEN
    //     //                FlagonPosting := TRUE;
    //     //          UNTIL (WarehouseShipmentLine.NEXT = 0) OR FlagonPosting;
    //     //          IF FlagonPosting THEN
    //     //            EXIT(FALSE)
    //     //          else
    //     //            EXIT(TRUE);
    //     //        end;
    //     //      end;
    //     //    end; //HEI.17
    //     //  end;
    //     //end;
    //     //HEI.16<<

    //     //BC Upgrade SHARMP16 Begin<<- Astro out of scope
    //     // if not AstroInterfaceSetup.GET then
    //     //     exit(false);

    //     // if not AstroInterfaceSetup."Enabled Astro Integration" then
    //     //     exit(false);

    //     // if not (WarehouseShipmentHeader."Source Document Type" = WarehouseShipmentHeader."Source Document Type"::"Purchase Return Order") then
    //     //     exit(false);

    //     // if not AstroInterfaceSetup."Enable Purch Return Order Sync" then
    //     //     exit(false);

    //     PurchasesPayablesSetup.GET;

    //     // if (PurchasesPayablesSetup."Astro Whse Rcpt Manl Post") or (AstroInterfaceSetup."Allow Mnl Posting Purch Shpmt") then
    //     //     exit(false);
    //     //BC Upgrade SHARMP16 End>>- Astro out of scope
    //     WarehouseShipmentLine.RESET;
    //     WarehouseShipmentLine.SETRANGE("No.", WarehouseShipmentHeader."No.");
    //     WarehouseShipmentLine.SETFILTER("Qty. to Ship", '<>%1', 0);
    //     WarehouseShipmentLine.SETRANGE("Source Document", WarehouseShipmentLine."Source Document"::"Purchase Return Order");
    //     if WarehouseShipmentLine.findset then
    //         repeat
    //             if PurchaseLine.GET(PurchaseLine."Document Type"::"Return Order", WarehouseShipmentLine."Source No.", WarehouseShipmentLine."Source Line No.") then
    //                 if (PurchaseLine."Astro Unique ID" <> '') then
    //                     exit(true);
    //         until WarehouseShipmentLine.NEXT = 0;
    //     //HEI.18<<
    // end;
    //BC UPgrade SHARMP16End>> ---- Astro related code
    //BC Upgrade SHARMP16 Begin>>-

    LOCAL procedure FilterShippingAgentServiceCode()
    var
        ShippingAgentServices: Record "Shipping Agent Services";
    begin
        //>> HEI.11
        ShippingAgentServices.RESET();
        ShippingAgentServices.SETRANGE("Shipping Agent Code", Rec."Shipping Agent Code");
        // ShippingAgentServices.SETFILTER("Allow Shipping Cost Per", '%1|%2', ShippingAgentServices."Allow Shipping Cost Per"::Warehouse,
        //                                                                  ShippingAgentServices."Allow Shipping Cost Per"::" "); //HEI.12//BC Upgrade SHARMP16 -- Drink-IT fields used.
        IF PAGE.RUNMODAL(0, ShippingAgentServices) = ACTION::LookupOK THEN
            rec.VALIDATE("Shipping Agent Service Code", ShippingAgentServices.Code);
        //<< HEI.11
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CreateOutboundGEEditable := rec."Gate Entry No. FND" = ''; //HEI.04  
        PostPrintLoadingNote := NOT WarehouseSetup."Enable Post & Print on Loc FND"; //HEI.11

        //HEI.13>>
        PurchHdrAddRec.RESET();
        PurchHdrAddRec.SETRANGE("No.", rec."Source No. FND");
        IF PurchHdrAddRec.FINDFIRST() THEN;
        //HEI.13<<

    end;
    //BC Upgrade SHARMP16 BEGIN>>---- interface related code
    // trigger OnOpenPage()
    // var
    //     myInt: Integer;
    // begin
    //     VisibleWMS := WMSInterfaceSetup.GET AND WMSInterfaceSetup."WMS Integration";  //HEI.14

    //     EnabledAutoFEFO := NOT rec."WMS Import";   //HEI.15
    // end;
    //BC Upgrade SHARMP16 end<< ---- interface related code
    //BC Upgrade SHARMP16 end<<
}

