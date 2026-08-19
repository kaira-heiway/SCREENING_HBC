pageextension 51194 WarehouseReceiptExtCBN extends "Warehouse Receipt"
{
    // version NAVW110.0,OWM4.50,DITW110.00.11,HEI.21

    //     DITW15.00.00.21 DDR 18/06/2008 added tab "Shipping"
    //                                added fields "Maximum Weight","Maximum Volume","Shipping Charge Type","Shipping Charge No."
    //                                added function FormatMaximumControls()
    //                                added property's Form: CalcFields
    //                                added menu "Move Whse. Receipt Lines" into Line Button
    //                                replaced the Print button
    // DITW15.00.00.25 DDR 09/10/2008 Bugfix refreshing fields "Maximum Weight","Maximum Cubage" with color
    //                                  into function FormatMaximumControls()
    //                                Added field "Driver Code","Truck Code","Shipping unit cost","shipping cost amount"
    //                                Non-Editable
    //                                  "Shipping Charge Type","Shipping Charge No."
    //                                  "Maximum Weight","Maximum Cubage"
    // DITW15.00.00.26 DDR 17/11/2008 Modified property Editable for field "Shipping Charge Per"
    // DITW15.00.00.31 DDR 17/02/2009 Added fields "Distance"
    // DITW15.00.00.35 DDR 19/08/2009 issue 773 Added fields "Shipping Currency Code"
    //                 DLE 06/09/2009 issue 516 Added field "Physical Location Group Code"
    // DITW15.00.00.36 DDR 06/11/2009 issue 777 Added menu 'Source &Comment Lines' into 'Lines' button
    // DITW15.00.00.37 DDR 10/06/2010 issue 1061 Added OnLookup() in field "Physical Location Group Code"
    // DITW15.00.00.38 PRODW14.00.00.17 DDR 10/02/2011 issue 1273 Added menu 'Quality Tests' into 'Line' Button
    // DITW16.00.00.38 DDR 01/04/2011 DIT-715 issue 87 Added OpenWhseRcptHeader()
    // DITW15.00.00.39 DDR 12/04/2011 issue 1296 Added AAD/ARC functionnality
    //                                  Added menu "Get EMCS ARC No. to Apply" into 'Functions' button
    // DITW16.00.00.38 DDR 19/07/2011 DIT-715 issue 107 Moved OpenWhseRcptHeader() into Trigger OnNewRecord()
    // DITW15.00.00.39 DDR 22/08/2011 issue 1399 Added fields "Exists Posting Error Lines"
    //                     22/02/2012 DIT-715 #246 Moved menu1100083009 '&Move Whse. Receipt Line' ('Line' button) into 'Functions' button
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added menu 'SSCC Tracking Lines' in 'Line' buttton
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added menu 'SSCC Tracking Lines' in 'Line' buttton
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    //                                             NORRIQ owm - Online Warehouse Management
    //                                             Copyright 2008 by NORRIQ A/S, www.norriq.dk
    //                                               New field: Release to OWM
    //                                               New menu "Show OWM Activitystatus" on Shipment Action.

    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.00.02 DDR 28/11/2013 DIT-770 #272 Upgrade N-OWM4.5 Nav2013 R1
    // DITW18.00.06 MSF 06/07/2015 DIT-770 #1212 #1213 #1214 Added filter on responsibility center
    // DITW18.00.07 VSC 16/02/2016 DIT-770 #1703 Add New Line Detail Factbox
    // DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1066 Removed old Shipping Costs fields from Shipping Tab
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 Add Flowfield "Document Shipping Costs" to General TAB
    // DITW18.00.07 AKH 13/05/2016 DIT-770 #1409 Added "ShowMandatory" property for "Vendor Shipment No." field

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 MSF 11/09/2017 NRQ#16082  Route Planning and Warehouse Documents
    //                               Added Fields Route planning No.
    //                               Shipping tab Field Are Editable when Route planning No is not filled
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added fields
    //                                         Route
    //                                        "Driver 2 Code"
    //                                        "Multiple Order Route"
    //                                         "Route Planning No."
    //                                         Fields Editable If Multiple Route Order
    // DITW110.00.11 MSF 02/10/2017 NRQ#16082 Delete Filter on location Code
    // DITW110.00.11 MSF 04/10/2017 NRQ#39012 : Added Action Return Control
    // DITW110.00.11 MSF 06/10/2017 NRQ#39012 Return Control Only Visible if Route planning No not empty
    // DITW110.00.11 MSF 06/11/2017 NRQ#43572 Rename Variable VisibleActionReturnControl --> EnableActionReturnControl
    // HEI.01 FDD LOGGAP08, IBM, POSTOI01, 20.03.2018
    //   #add new page action Truck Unload Note (which runs report 59003 Unloading Note)
    //   #add new code in OnClosePage to delete lines from Return Register Control used for Posted Unloading Note report
    //   #add code on Page Action Post&Print to run report Posted Unloading Note
    //   #comment lines OnClosePage previously added for Posted Unloading Note
    //   #comment lines on page action Post&Print
    // HEI.02 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field added "Gate Entry No."
    // HEI.03 RFC-CHG0255774 IBM.AB 15.10.2018
    //   # Code added to validate Shipping Agent Code
    // HEI.04 FDD-RW-GAPLOG10 IBM ISYED01 30-10-2018 RPM Breakages
    //  #Added return control to home page


    // HEI.08 CHG0255774_FDD_TC_Calculation_Enhancement IBM NANDIS01 08.07.2019
    //   Validation added to show error message when the shipping agent is not ticked as Own Logistics
    // HEI.06 FDD-HT658 IBM.GUNERE01 17.09.2019 # TruckMandatory, DriverMandatory, ShippingAgentMandatory
    //                                            ShippingAgentServiceMandatory variables added
    //                                          # IsTruckMandatory, IsDriverMandatory, IsShippingAgentCodeMandatory,
    //                                            IsShippingAgentServCodeMandatory funcs. added, Code added to OnAfterGetRecord()
    // HEI.07 FDD-HT658 IBM.GUNERE01 01.11.2019 # "Source Document Type FND","Source No." fields added
    // HEI.09 CHG202448 Gate Control IBM.SAXENS01 21.11.2019
    //   code added on Post Receipt action

    // HEI.10 FDD-CHG2026322 IBM PANDES01 17/12/2019
    //    # Added Code to delete warehouse receipt after Post receipt.
    // HEI.11  FDD HT1136 CHG2055070 IBM Shankj03 16.06.2020
    //  # New Field Added License Code
    //  # Code added in triggers
    // HEI.12 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # Code added on "Get Source Documents" Action
    // HEI.13 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New fields added in General tab: LSR Order No and LSR Receipt No
    // HEI.14 CHG2155847 HB2821 IBM NANDIS01 03.08.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   #Shown the field - "Astro Integration" in General tab
    // HEI.15 CHG2155847 HB2821 IBM NANDIS01 08.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Removed "Astro Integration"
    // HEI.16 CHG2155847 HB2821 IBM NANDIS01 24.11.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Control on Astro at time of posting
    // HEI.17 CHG2155847 HB2821 IBM NANDIS01 25.11.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # AstroInterface enable fix
    // HEI.18 CHG2155847 HB2821 IBM NANDIS01 25.01.2023 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # control on whse rcpt posting as per new setups
    // HEI.19 CHG2155847 HB2821 IBM NANDIS01 03.02.2023 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # modification done on the control on whse rcpt posting as per setups
    // HEI.20 CHG2155847 HB2821 IBM NANDIS01 10.02.2023 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Fix on control of whse rcpt will only work for purchase order
    // HEI.21 CHG2155847 HB2821 IBM NANDIS01 15.02.2023 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Fix on control of whse rcpt posting
    // HEI.22 CHG2244491 HB3869 IBM COSTES04 12.11.2024 - Control relation to Zone and Bin Codes shipment and receipt
    //   # Make bin & code mandatory

    //Bc Upgrade YADAVM09 //>> HEI.06 code not added due to dependency on Drink it objects.
    //Bc Upgrade YADAVM09 Drink it field and Action Blocked.
    //Bc Upgrade YADAVM09 Astro Function Blocked.
    //Bc Upgrade YADAVM09 Function PrintUnloadingNoteWhseReceipt called from Heineken Bc Upgrade Codeunit.
    //Bc Upgrade YADAVM09 Action <Action55002> not added due to dependency on drink it object.
    //Bc Upgrade YADAVM09 WhsePostRcptYesNo function added for action Post Receipt.
    //Bc Upgrade YADAVM09 //HEI.16>> for <Action47> not added as Astro is out of Scope.
    //Bc Upgrade YADAVM09 <Action26> //HEI.16>> not Added as Astro is out of Scope.
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the warehouse receipt header number, which is generated according to the No. Series specified in the Warehouse Mgt. Setup window.', FRA = 'Spécifie le numéro de l''en-tête réception entrepôt, généré en fonction de la valeur du champ Souches de n° spécifié dans la fenêtre Paramètres entrepôts.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location in which the items are being received.', FRA = 'Spécifie le code du magasin dans lequel les articles sont réceptionnés.';

            //Unsupported feature: Change Description on ""Location Code"(Control 36)". Please convert manually.


            //Unsupported feature: Change Editable on ""Location Code"(Control 36)". Please convert manually.

        }
        modify("Zone Code")
        {
            ToolTipML = ENU = 'Specifies the zone in which the items are being received if you are using directed put-away and pick.', FRA = 'Spécifie la zone dans laquelle les articles sont réceptionnés si vous utilisez les prélèvements et rangements suggérés.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Indicates the code of the bin in which you will place the items being received.', FRA = 'Indique le code de l''emplacement de réception des articles.';
        }
        modify("Document Status")
        {
            ToolTipML = ENU = 'Specifies the status of the warehouse receipt.', FRA = 'Indique le statut de réception entrepôt.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date of the warehouse receipt.', FRA = 'Spécifie la date comptabilisation de la réception entrepôt.';

            //Unsupported feature: Change Description on ""Posting Date"(Control 42)". Please convert manually.


            //Unsupported feature: Change Editable on ""Posting Date"(Control 42)". Please convert manually.

        }
        modify("Vendor Shipment No.")
        {
            ToolTipML = ENU = 'Specifies the vendor shipment number.', FRA = 'Spécifie le numéro de bon de livraison fournisseur.';

            //Unsupported feature: Change Description on ""Vendor Shipment No."(Control 44)". Please convert manually.


            //Unsupported feature: Change Editable on ""Vendor Shipment No."(Control 44)". Please convert manually.

            ShowMandatory = VendorShipmentNoMandatory;
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
            ToolTipML = ENU = 'Specifies the time at which the document was assigned to the user.', FRA = 'Spécifie l''heure à laquelle le document a été affecté à l''utilisateur.';
        }
        modify("Sorting Method")
        {
            ToolTipML = ENU = 'Specifies the method by which the receipts are sorted.', FRA = 'Indique la méthode permettant de trier les réceptions.';
            // BC Upgrade MISHRS14 >>
            // Blocked as its enum and Sorting method is record.
            //OptionCaptionML = ENU = ' ,Item,Document,Shelf or Bin,Due Date ', FRA = ' ,Article,Document,Emplacement,Délai ';
            // BC Upgrade MISHRS14 <<

        }
        /* //Bc Upgrade YADAVM09 Drink it field Blocked>>
        addafter("Location Code")
        {
            field("Physical Location Group Code";"Physical Location Group Code")
            {
                Description = '<DITW15.00.00.35>-NRQ#16082';
                Editable = EditableMultipleRouteOrder;

                trigger OnLookup(Text : Text) : Boolean;
                begin
                    // <<DITW15.00.00.37 DDR 10/06/2010
                    CurrPage.SAVERECORD;
                    LookupPhysLocation(Rec);
                    CurrPage.UPDATE(true);
                end;
            }
        }
        addafter("Document Status")
        {
            field("Released to N-owm";"Released to N-owm")
            {
            }
            field("Exist Posting Error Lines";"Exist Posting Error Lines")
            {
            }
        }
         */ //Bc Upgrade YADAVM09 Drink it field Blocked<<
        addafter("Sorting Method")
        {
            /* //Bc Upgrade YADAVM09 Drink it field Blocked>>
              field("Document Shipping Costs";Rec."Document Shipping Costs")
              {
              }
            */ //Bc Upgrade YADAVM09 Drink it field Blocked<<
            field("Gate Entry No."; Rec."Gate Entry No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gate Entry No. field.';
                //Bc Upgrade YADAVM09                                                                                                                                                                                                                                                              ToolTip = 'Specifies the value of the Gate Entry No. field.';

            }
            field("LSR Order No."; Rec."LSR Order No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LSR Order No. field.';
            }
            field("LSR Receipt No."; Rec."LSR Receipt No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LSR Receipt No. field.';
            }
            field("<License Code>"; PurchHdrAddRec."License Code")
            {
                Caption = 'License Code';
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the License Code field.';
            }

        }
        //BC UPGRADE KUMARR78 >> FDD-MTC-007
        modify("Shipping Agent Code 107FDW")
        {
            Editable = true;
            Enabled = true;
        }
        modify("Log Driver 107FDW")
        {
            Editable = true;
            Enabled = true;
        }
        modify("LOG Vehicle Code 107FDW")
        {
            Editable = true;
            Enabled = true;
        }
        modify("LOG Shipping Agent Service 107FDW")
        {
            Editable = true;
            Enabled = true;
        }
        modify("LOG Co-driver 107FDW")
        {
            Editable = true;
            Enabled = true;
        }
        modify("Trailer 107FDW")
        {
            Editable = true;
            Enabled = true;
        }
        //BC UPGRADE KUMARR78 >> FDD-MTC-007


        addafter(WhseReceiptLines)
        {

            group(Shipping)
            {
                CaptionML = ENU = 'Shipping',
                              FRA = 'Livraison';
                /* //Bc Upgrade YADAVM09 Drink it Field>>
                field(Route; Route)
                {
                    Description = 'NRQ#16082';
                    Editable = EditableMultipleRouteOrder;

                    trigger OnValidate();
                    begin
                        if (xRec.Route <> Rec.Route) then
                            CurrPage.UPDATE(true);

                        //HEI.03>>
                        if RecRoute.GET(Route) then begin
                            if ShippingAgent.GET(RecRoute."Shipping Agent Code") then begin
                                //HEI.08>>
                                //IF ShippingAgent."Vendor No." = '' THEN
                                if (ShippingAgent."Vendor No." = '') and (not ShippingAgent."Own Logistics") then
                                    //HEI.08<<
                                    ERROR(ShippingAgentVendorIsBlank)
                                else if Vend.GET(ShippingAgent."Vendor No.") then begin
                                    if Vend.Blocked <> 0 then
                                        ERROR(VendorBlockForShipAgent);
                                end;
                            end;
                        end;
                        //HEI.03<<
                    end;
                }
                field("Multiple Order Route"; "Multiple Order Route")
                {
                    Description = 'NRQ#16082';
                    Editable = false;
                }
                field("Route Planning No."; "Route Planning No.")
                {
                    Description = 'NRQ#16082';
                    Editable = EditableMultipleRouteOrder;
                    TableRelation = "Route Planning Worksheet"."No." WHERE("Physical Location Group Code" = FIELD("Physical Location Group Code"),
                                                                              "Location Code" = FIELD("Location Code"));

                    trigger OnValidate();
                    begin
                        if (xRec."Route Planning No." <> Rec."Route Planning No.") then
                            CurrPage.UPDATE(true)
                    end;
                }
                field("Truck Code"; "Truck Code")
                {
                    Description = '<DITW15.00.00.25 -  DITW18.00.06 MSF 06/07/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
                    Editable = EditableMultipleRouteOrder;

                    trigger OnValidate();
                    begin
                        if (xRec."Truck Code" <> Rec."Truck Code") then
                            CurrPage.UPDATE(true)
                    end;
                }
                field("Trailer Code"; "Trailer Code")
                {
                    Description = 'NRQ#16082';
                    Editable = EditableMultipleRouteOrder;
                }
                field("Driver Code"; "Driver Code")
                {
                    Description = '<DITW15.00.00.25 -  DITW18.00.06 MSF 06/07/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
                    Editable = EditableMultipleRouteOrder;

                    trigger OnValidate();
                    begin
                        if (xRec."Driver Code" <> Rec."Driver Code") then
                            CurrPage.UPDATE(true)
                    end;
                }
                field("Require 2 Drivers"; "Require 2 Drivers")
                {
                    Description = 'NRQ#16082';
                    Editable = EditableMultipleRouteOrder;
                }
                field("Driver 2 Code"; "Driver 2 Code")
                {
                    Description = 'NRQ#16082';
                    Editable = EditableMultipleRouteOrder;

                    trigger OnValidate();
                    begin
                        if (xRec."Driver 2 Code" <> Rec."Driver 2 Code") then
                            CurrPage.UPDATE(true)
                    end;
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                    Description = '<DITW15.00.00.21 -  DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
                    Editable = EditableMultipleRouteOrder;

                    trigger OnValidate();
                    begin
                        //HEI.03>>
                        if RecRoute.GET(Route) then begin
                            if ShippingAgent.GET(RecRoute."Shipping Agent Code") then begin
                                //HEI.08>>
                                //IF ShippingAgent."Vendor No." = '' THEN
                                if (ShippingAgent."Vendor No." = '') and (not ShippingAgent."Own Logistics") then
                                    //HEI.08<<
                                    ERROR(ShippingAgentVendorIsBlank)
                                else if Vend.GET(ShippingAgent."Vendor No.") then begin
                                    if Vend.Blocked <> 0 then
                                        ERROR(VendorBlockForShipAgent);
                                end;
                            end;
                        end;
                        //HEI.03<<
                    end;
                }
                field("Shipping Agent Service Code"; "Shipping Agent Service Code")
                {
                    Description = '<DITW15.00.00.21>-NRQ#16082';
                    Editable = EditableMultipleRouteOrder;
                }
                field(Distance; Distance)
                {
                    Description = '<DITW15.00.00.31>-NRQ#16082';
                    Editable = EditableMultipleRouteOrder;
                }
             */ //Bc Upgrade YADAVM09 Drink it Field<<
                field("Source Document Type FND"; Rec."Source Document Type FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Document Type field.';
                }
                field("Source No."; Rec."Source No. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source No. field.';
                }
                /* //Bc Upgrade YADAVM09 Drink it Field>>
                field("Maximum Weight"; Rec."Maximum Weight")
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = "Maximum WeightEmphasize";
                    Visible = "Maximum WeightVisible";
                }
                field("Maximum Cubage"; "Maximum Cubage")
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = "Maximum CubageEmphasize";
                    Visible = "Maximum CubageVisible";
                }
                field("Total Weight To Receive"; "Total Weight To Receive")
                {
                    Editable = false;
                }
                field("Total Cubage To Receive"; "Total Cubage To Receive")
                {
                    Editable = false;
                }
                */ //Bc Upgrade YADAVM09 Drink it Field<<
            }
        }

        /* //Bc Upgrade YADVAM09 Drink it page Dependency>>
                addafter(Control1901796907)
                {
                    part(Control1100710000; "Warehouse Receipt FactBox")
                    {
                        Provider = "97";
                        SubPageLink = "No." = FIELD("No."),
                                      "Line No." = FIELD("Line No.");
                        Visible = true;
                    }
                }
                */ //Bc Upgrade YADVAM09 Drink it page Dependency>>
    }
    actions
    {
        addafter("P&osting")
        {
            action("Post Receipt2")
            {
                ApplicationArea = Warehouse;
                Caption = 'P&ost Receipt';
                Image = PostOrder;
                ShortCutKey = 'F9';
                ToolTip = 'Post the items as received. A put-away document is created automatically.';

                trigger OnAction()
                begin
                    //HEI.09
                    /* //Bc Upgrade YADAVM09 Astro is out of scope>>
                    //HEI.16>>
                    IF AstroPostingValidation(Rec) THEN
                        ERROR(Text50000);
                    //HEI.16<<
                   */ //Bc Upgrade YADAVM09 Astro is out of scope>>
                    //HEI.22>>
                    IF Location.GET(Rec."Location Code") THEN BEGIN
                        // IF ((Rec."Source Document Type FND" IN [Rec."Source Document Type FND"::"Inbound Transfer", Rec."Source Document Type FND"::"Outbound Transfer"]) AND TransferOrderPostShipment.IsTransGateEntryMandatory(Rec."Location Code", Rec."Zone Code") AND HeinekenGlobal.WhseShpmtIsTransferImportIdentifier(Rec."No.")) OR////Bc Upgrade YADAVM09 Temporary need to unblock once codeunit sales post is compiled
                        //  ((Rec."Source Document Type FND" IN [Rec."Source Document Type FND"::"Sales Order", Rec."Source Document Type FND"::"Sales Return Order"]) AND SalesPost.IsSalesGateEntryMandatory(Rec."Location Code", Rec."Zone Code")) THEN BEGIN////Bc Upgrade YADAVM09 Temporary need to unblock once codeunit sales post is compiled

                        IF Location."Bin Mandatory" THEN
                            Rec.TESTFIELD("Bin Code");
                        IF Location."Zone Mandatory FND" THEN
                            Rec.TESTFIELD("Zone Code");
                        //END;//Bc Upgrade YADAVM09 Temporary need to unblock once codeunit sales post is compiled
                    END;
                    //HEI.22<<
                    //WhsePostRcptYesNo();

                    IF Rec."Gate Entry No. FND" <> '' THEN BEGIN
                        MatchBool := FALSE;
                        IF Location.GET(Rec."Location Code") THEN
                            EnableInbound := Location."Enable Inbound Validation FND";

                        IF Zone.GET(Rec."Location Code", Rec."Zone Code") THEN BEGIN
                            Autoreg := Zone."Inbound Auto. Registration FND";
                            WeightMandatory := Zone."Gate Weighing Mandatory FND";
                        END;

                        IF GateEntryHeader.GET(Rec."Gate Entry No. FND") THEN
                            GroupControl := GateEntryHeader."Grouped Control";
                        IF NOT GroupControl AND EnableInbound THEN BEGIN

                            WarehouseReceiptLine2.RESET();
                            WarehouseReceiptLine2.SETRANGE(WarehouseReceiptLine2."No.", Rec."No.");
                            IF WarehouseReceiptLine2.FINDSET() THEN
                                REPEAT
                                    GateEntryLine1.SETRANGE("Gate Entry Document No.", Rec."Gate Entry No. FND");
                                    GateEntryLine1.SETRANGE("No.", WarehouseReceiptLine2."Item No.");
                                    IF NOT GateEntryLine1.FINDFIRST() THEN
                                        ERROR('Item %1 does not exist in gate entry %2', WarehouseReceiptLine2."Item No.", GateEntryLine1."Gate Entry Document No.")
                                    ELSE BEGIN
                                        IF WarehouseReceiptLine2."Unit of Measure Code" <> GateEntryLine1."Unit Of Measure Code" THEN
                                            ERROR(ERR02, GateEntryLine1."Gate Entry Document No.", WarehouseReceiptLine2."No.");
                                        IF WarehouseReceiptLine2."Qty. to Receive" <> GateEntryLine1."Quantity on Arrival" THEN
                                            ERROR('Quantity not matching');
                                    END
                                UNTIL WarehouseReceiptLine2.NEXT() = 0;
                            GateEntryLine1.RESET();
                            WarehouseReceiptLine2.RESET();
                            GateEntryLine1.SETRANGE("Gate Entry Document No.", Rec."Gate Entry No. FND");
                            IF GateEntryLine1.FINDSET() THEN
                                REPEAT
                                    WarehouseReceiptLine2.SETRANGE("No.", Rec."No.");
                                    WarehouseReceiptLine2.SETRANGE("Item No.", GateEntryLine1."No.");
                                    IF NOT WarehouseReceiptLine2.FINDFIRST() THEN
                                        ERROR('Item %1 does not exist in Warehouse receipt %2', GateEntryLine1."No.", WarehouseReceiptLine2."No.")
                                    ELSE BEGIN
                                        IF WarehouseReceiptLine2."Unit of Measure Code" <> GateEntryLine1."Unit Of Measure Code" THEN
                                            ERROR(ERR02, GateEntryLine1."Gate Entry Document No.", WarehouseReceiptLine2."No.");
                                        IF WarehouseReceiptLine2."Qty. to Receive" <> GateEntryLine1."Quantity on Arrival" THEN
                                            ERROR('Quantity not matching');
                                    END
                                UNTIL GateEntryLine1.NEXT() = 0;
                        END;
                        IF NOT GroupControl THEN BEGIN
                            IF EnableInbound AND Autoreg AND NOT WeightMandatory THEN BEGIN
                                WarehouseReceiptHeader.SETRANGE("Gate Entry No. FND", Rec."Gate Entry No. FND");
                                // WarehouseReceiptHeader.SETRANGE("Truck Code", Rec."Truck Code");//Bc Upgrade YADAVM09 Dependency on Drink it field
                                // WarehouseReceiptHeader.SETRANGE("Driver Code", Rec."Driver Code");//Bc Upgrade YADAVM09 Dependency on Drink it field
                                WarehouseReceiptHeader.SETRANGE("Location Code", Rec."Location Code");
                                WarehouseReceiptHeader.SETRANGE("Zone Code", Rec."Zone Code");
                                IF WarehouseReceiptHeader.FINDFIRST() THEN BEGIN
                                    WarehouseReceiptLine.SETRANGE("No.", WarehouseReceiptHeader."No.");
                                    WarehouseReceiptLine.SETFILTER(WarehouseReceiptLine."Qty. to Receive", '<>%1', 0);
                                    IF WarehouseReceiptLine.FINDSET() THEN
                                        REPEAT
                                            WarehouseReceiptLine1.SETRANGE("No.", WarehouseReceiptHeader."No.");
                                            WarehouseReceiptLine1.SETFILTER("Item No.", WarehouseReceiptLine."Item No.");
                                            WarehouseQty := 0;
                                            IF WarehouseReceiptLine1.FINDSET() THEN
                                                REPEAT
                                                    WarehouseQty += WarehouseReceiptLine1."Qty. to Receive";
                                                UNTIL WarehouseReceiptLine1.NEXT() = 0;

                                            GateEntryLines.SETRANGE("Gate Entry Document No.", Rec."Gate Entry No. FND");
                                            GateEntryLines.SETFILTER(GateEntryLines."No.", WarehouseReceiptLine."Item No.");
                                            IF GateEntryLines.FINDFIRST() THEN BEGIN
                                                IF GateEntryLines."Quantity on Arrival" <> WarehouseQty THEN BEGIN
                                                    ERROR(ERR01, GateEntryLines."Gate Entry Document No.", WarehouseReceiptHeader."No.");
                                                    MatchBool := TRUE;
                                                END;
                                                IF GateEntryLines."Unit Of Measure Code" <> WarehouseReceiptLine."Unit of Measure Code" THEN BEGIN
                                                    ERROR(ERR02, GateEntryLines."Gate Entry Document No.", WarehouseReceiptHeader."No.");
                                                    MatchBool := TRUE;
                                                END;
                                            END;
                                            IF NOT MatchBool THEN
                                                WhsePostRcptYesNo();
                                        UNTIL WarehouseReceiptLine.NEXT() = 0;
                                END;
                            END ELSE
                                WhsePostRcptYesNo();
                        END ELSE BEGIN
                            WarehouseReceiptHeader.SETRANGE("Gate Entry No. FND", Rec."Gate Entry No. FND");
                            // WarehouseReceiptHeader.SETRANGE("Truck Code", Rec."Truck Code");//Bc Upgrade YADAVM09 Dependency on Drink it field
                            // WarehouseReceiptHeader.SETRANGE("Driver Code", Rec."Driver Code");//Bc Upgrade YADAVM09 Dependency on Drink it field
                            WarehouseReceiptHeader.SETRANGE("Location Code", Rec."Location Code");
                            WarehouseReceiptHeader.SETRANGE("Zone Code", Rec."Zone Code");
                            IF WarehouseReceiptHeader.FINDFIRST() THEN BEGIN
                                WarehouseReceiptLine.SETCURRENTKEY("Unit of Measure Code");
                                WarehouseReceiptLine.SETRANGE("No.", WarehouseReceiptHeader."No.");
                                WarehouseReceiptLine.SETFILTER(WarehouseReceiptLine."Qty. to Receive", '<>%1', 0);
                                IF WarehouseReceiptLine.FINDSET() THEN
                                    REPEAT
                                        IF UOM <> WarehouseReceiptLine."Unit of Measure Code" THEN BEGIN
                                            WarehouseQty := 0;
                                            WarehouseReceiptLine1.SETRANGE("No.", WarehouseReceiptHeader."No.");
                                            WarehouseReceiptLine1.SETRANGE("Unit of Measure Code", WarehouseReceiptLine."Unit of Measure Code");
                                            IF WarehouseReceiptLine1.FINDSET() THEN
                                                REPEAT
                                                    WarehouseQty += WarehouseReceiptLine1."Qty. to Receive";
                                                    UOM := WarehouseReceiptLine1."Unit of Measure Code";
                                                UNTIL WarehouseReceiptLine1.NEXT() = 0;
                                            GateEntryLines.RESET();
                                            GateEntryLines.SETRANGE("Gate Entry Document No.", Rec."Gate Entry No. FND");
                                            GateEntryLines.SETRANGE("Unit Of Measure Code", WarehouseReceiptLine1."Unit of Measure Code");
                                            IF GateEntryLines.FINDFIRST() THEN BEGIN
                                                IF WarehouseQty <> GateEntryLines."Quantity on Arrival" THEN
                                                    MatchBool := TRUE
                                                ELSE
                                                    MatchBool := FALSE;
                                            END;
                                        END ELSE BEGIN
                                            UOM := WarehouseReceiptLine."Unit of Measure Code";
                                        END;
                                        IF MatchBool THEN
                                            ERROR(ERR01, GateEntryLines."Gate Entry Document No.", WarehouseReceiptHeader."No.")
                                    UNTIL WarehouseReceiptLine.NEXT() = 0;
                                IF NOT MatchBool THEN
                                    WhsePostRcptYesNo();
                            END
                        END
                    END ELSE
                        WhsePostRcptYesNo();
                    //HEI.09



                end;
            }
        }
        modify("&Receipt")
        {
            CaptionML = ENU = '&Receipt', FRA = '&Réception';
        }

        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'C&ommentaires';
        }
        modify("Posted &Whse. Receipts")
        {
            CaptionML = ENU = 'Posted &Whse. Receipts', FRA = 'Réceptions &entrep. enreg.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Use Filters to Get Src. Docs.")
        {
            CaptionML = ENU = 'Use Filters to Get Src. Docs.', FRA = 'Filtrer pour extr. doc. orig.';
        }
        modify("Get Source Documents")
        {
            CaptionML = ENU = 'Get Source Documents', FRA = 'Extraire documents origine';
        }
        modify("Autofill Qty. to Receive")
        {
            CaptionML = ENU = 'Autofill Qty. to Receive', FRA = 'Remplir qté à recevoir';
        }
        modify("Delete Qty. to Receive")
        {
            CaptionML = ENU = 'Delete Qty. to Receive', FRA = 'Supprimer qté à recevoir';
        }
        modify(CalculateCrossDock)
        {
            CaptionML = ENU = 'Calculate Cross-Dock', FRA = 'Calculer transbordement';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        modify("Post Receipt")
        {
            //Visible =false;//Bc Upgrade YADAVM09
            CaptionML = ENU = 'P&ost Receipt', FRA = '&Valider réception';
            //BC UPGRADE KUMARR78 FDD-MTC-007
            trigger OnBeforeAction()
            var
                myInt: Integer;
                HeinekenCusFunctions: Codeunit "Heineken BC Custom Functions";
            begin

                //HEI.22>>
                IF Location.GET(Rec."Location Code") THEN BEGIN
                    IF ((Rec."Source Document Type FND" IN [Rec."Source Document Type FND"::"Inbound Transfer", Rec."Source Document Type FND"::"Outbound Transfer"]) AND HeinekenCusFunctions.IsTransGateEntryMandatory(Rec."Location Code", Rec."Zone Code") AND HeinekenGlobal.WhseShpmtIsTransferImportIdentifier(Rec."No.")) OR
                     ((Rec."Source Document Type FND" IN [Rec."Source Document Type FND"::"Sales Order", Rec."Source Document Type FND"::"Sales Return Order"]) AND HeinekenCusFunctions.IsSalesGateEntryMandatory(Rec."Location Code", Rec."Zone Code")) THEN BEGIN
                        IF Location."Bin Mandatory" THEN
                            Rec.TESTFIELD("Bin Code");
                        IF Location."Zone Mandatory FND" THEN
                            Rec.TESTFIELD("Zone Code");
                    END;
                END;
                //HEI.22<<

                IF Rec."Gate Entry No. FND" <> '' THEN BEGIN
                    MatchBool := FALSE;
                    IF Location.GET(Rec."Location Code") THEN
                        EnableInbound := Location."Enable Inbound Validation FND";

                    IF Zone.GET(Rec."Location Code", Rec."Zone Code") THEN BEGIN
                        Autoreg := Zone."Inbound Auto. Registration FND";
                        WeightMandatory := Zone."Gate Weighing Mandatory FND";
                    END;

                    IF GateEntryHeader.GET(Rec."Gate Entry No. FND") THEN
                        GroupControl := GateEntryHeader."Grouped Control";
                    IF NOT GroupControl AND EnableInbound THEN BEGIN

                        WarehouseReceiptLine2.RESET();
                        WarehouseReceiptLine2.SETRANGE(WarehouseReceiptLine2."No.", Rec."No.");
                        IF WarehouseReceiptLine2.FINDSET() THEN
                            REPEAT
                                GateEntryLine1.SETRANGE("Gate Entry Document No.", Rec."Gate Entry No. FND");
                                GateEntryLine1.SETRANGE("No.", WarehouseReceiptLine2."Item No.");
                                IF NOT GateEntryLine1.FINDFIRST() THEN
                                    ERROR('Item %1 does not exist in gate entry %2', WarehouseReceiptLine2."Item No.", GateEntryLine1."Gate Entry Document No.")
                                ELSE BEGIN
                                    IF WarehouseReceiptLine2."Unit of Measure Code" <> GateEntryLine1."Unit Of Measure Code" THEN
                                        ERROR(ERR02, GateEntryLine1."Gate Entry Document No.", WarehouseReceiptLine2."No.");
                                    IF WarehouseReceiptLine2."Qty. to Receive" <> GateEntryLine1."Quantity on Arrival" THEN
                                        ERROR('Quantity not matching');
                                END
                            UNTIL WarehouseReceiptLine2.NEXT() = 0;
                        GateEntryLine1.RESET();
                        WarehouseReceiptLine2.RESET();
                        GateEntryLine1.SETRANGE("Gate Entry Document No.", Rec."Gate Entry No. FND");
                        IF GateEntryLine1.FINDSET() THEN
                            REPEAT
                                WarehouseReceiptLine2.SETRANGE("No.", Rec."No.");
                                WarehouseReceiptLine2.SETRANGE("Item No.", GateEntryLine1."No.");
                                IF NOT WarehouseReceiptLine2.FINDFIRST() THEN
                                    ERROR('Item %1 does not exist in Warehouse receipt %2', GateEntryLine1."No.", WarehouseReceiptLine2."No.")
                                ELSE BEGIN
                                    IF WarehouseReceiptLine2."Unit of Measure Code" <> GateEntryLine1."Unit Of Measure Code" THEN
                                        ERROR(ERR02, GateEntryLine1."Gate Entry Document No.", WarehouseReceiptLine2."No.");
                                    IF WarehouseReceiptLine2."Qty. to Receive" <> GateEntryLine1."Quantity on Arrival" THEN
                                        ERROR('Quantity not matching');
                                END
                            UNTIL GateEntryLine1.NEXT() = 0;
                    END;
                    IF NOT GroupControl THEN BEGIN
                        IF EnableInbound AND Autoreg AND NOT WeightMandatory THEN BEGIN
                            WarehouseReceiptHeader.SETRANGE("Gate Entry No. FND", Rec."Gate Entry No. FND");
                            WarehouseReceiptHeader.SETRANGE("Vehicle Code 101FDW", Rec."Vehicle Code 101FDW");
                            WarehouseReceiptHeader.SETRANGE("Log Driver 107FDW", Rec."Log Driver 107FDW");
                            WarehouseReceiptHeader.SETRANGE("Location Code", Rec."Location Code");
                            WarehouseReceiptHeader.SETRANGE("Zone Code", Rec."Zone Code");
                            IF WarehouseReceiptHeader.FINDFIRST() THEN BEGIN
                                WarehouseReceiptLine.SETRANGE("No.", WarehouseReceiptHeader."No.");
                                WarehouseReceiptLine.SETFILTER(WarehouseReceiptLine."Qty. to Receive", '<>%1', 0);
                                IF WarehouseReceiptLine.FINDSET() THEN
                                    REPEAT
                                        WarehouseReceiptLine1.SETRANGE("No.", WarehouseReceiptHeader."No.");
                                        WarehouseReceiptLine1.SETFILTER("Item No.", WarehouseReceiptLine."Item No.");
                                        WarehouseQty := 0;
                                        IF WarehouseReceiptLine1.FINDSET() THEN
                                            REPEAT
                                                WarehouseQty += WarehouseReceiptLine1."Qty. to Receive";
                                            UNTIL WarehouseReceiptLine1.NEXT() = 0;

                                        GateEntryLines.SETRANGE("Gate Entry Document No.", Rec."Gate Entry No. FND");
                                        GateEntryLines.SETFILTER(GateEntryLines."No.", WarehouseReceiptLine."Item No.");
                                        IF GateEntryLines.FINDFIRST() THEN BEGIN
                                            IF GateEntryLines."Quantity on Arrival" <> WarehouseQty THEN BEGIN
                                                ERROR(ERR01, GateEntryLines."Gate Entry Document No.", WarehouseReceiptHeader."No.");
                                                MatchBool := TRUE;
                                            END;
                                            IF GateEntryLines."Unit Of Measure Code" <> WarehouseReceiptLine."Unit of Measure Code" THEN BEGIN
                                                ERROR(ERR02, GateEntryLines."Gate Entry Document No.", WarehouseReceiptHeader."No.");
                                                MatchBool := TRUE;
                                            END;
                                        END;
                                    UNTIL WarehouseReceiptLine.NEXT() = 0;
                            END
                        end ELSE begin
                            WarehouseReceiptHeader.SETRANGE("Gate Entry No. FND", Rec."Gate Entry No. FND");
                            WarehouseReceiptHeader.SETRANGE("Vehicle Code 101FDW", Rec."Vehicle Code 101FDW");
                            WarehouseReceiptHeader.SETRANGE("Log Driver 107FDW", Rec."Log Driver 107FDW");
                            WarehouseReceiptHeader.SETRANGE("Location Code", Rec."Location Code");
                            WarehouseReceiptHeader.SETRANGE("Zone Code", Rec."Zone Code");
                            IF WarehouseReceiptHeader.FINDFIRST() THEN BEGIN
                                WarehouseReceiptLine.SETCURRENTKEY("Unit of Measure Code");
                                WarehouseReceiptLine.SETRANGE("No.", WarehouseReceiptHeader."No.");
                                WarehouseReceiptLine.SETFILTER(WarehouseReceiptLine."Qty. to Receive", '<>%1', 0);
                                IF WarehouseReceiptLine.FINDSET() THEN
                                    REPEAT
                                        IF UOM <> WarehouseReceiptLine."Unit of Measure Code" THEN BEGIN
                                            WarehouseQty := 0;
                                            WarehouseReceiptLine1.SETRANGE("No.", WarehouseReceiptHeader."No.");
                                            WarehouseReceiptLine1.SETRANGE("Unit of Measure Code", WarehouseReceiptLine."Unit of Measure Code");
                                            IF WarehouseReceiptLine1.FINDSET() THEN
                                                REPEAT
                                                    WarehouseQty += WarehouseReceiptLine1."Qty. to Receive";
                                                    UOM := WarehouseReceiptLine1."Unit of Measure Code";
                                                UNTIL WarehouseReceiptLine1.NEXT() = 0;
                                            GateEntryLines.RESET();
                                            GateEntryLines.SETRANGE("Gate Entry Document No.", Rec."Gate Entry No. FND");
                                            GateEntryLines.SETRANGE("Unit Of Measure Code", WarehouseReceiptLine1."Unit of Measure Code");
                                            IF GateEntryLines.FINDFIRST() THEN BEGIN
                                                IF WarehouseQty <> GateEntryLines."Quantity on Arrival" THEN
                                                    MatchBool := TRUE
                                                ELSE
                                                    MatchBool := FALSE;
                                            END;
                                        END ELSE BEGIN
                                            UOM := WarehouseReceiptLine."Unit of Measure Code";
                                        END;
                                        IF MatchBool THEN
                                            ERROR(ERR01, GateEntryLines."Gate Entry Document No.", WarehouseReceiptHeader."No.")
                                    UNTIL WarehouseReceiptLine.NEXT() = 0;

                            end;
                        END;
                    end;
                end;
            end;
            //BC UPGRADE KUMARR78 FDD-MTC-007
        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
        }
        modify("Post and Print P&ut-away")
        {
            CaptionML = ENU = 'Post and Print P&ut-away', FRA = 'Valider et imprimer le &rangement';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }


        //Unsupported feature: CodeModification on ""Get Source Documents"(Action 23).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSourceDocInbound.GetSingleInboundDoc(Rec);
        "Document Status" := GetHeaderStatus(0);
        MODIFY;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.12>>
        if SalesHeader.GET(SalesHeader."Document Type"::"Return Order","Source No.") then
          if SourceSystemIdentifierAPI.GET(SalesHeader."Source System Identifier") then
            if SourceSystemIdentifierAPI."Automatic SO Posting" then
              ERROR(CantReceiveErr,SalesHeader."Source System Identifier");
        //HEI.12<<
        #1..3
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Post Receipt"(Action 25).OnAction". Please convert manually.

        //trigger (Variable: WarehouseReceiptHeader)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Post Receipt"(Action 25).OnAction". Please convert manually.

        //     trigger OnAction();

        // begin

        //     WhsePostRcptYesNo;

        //     //end;
        //     //>>>> MODIFIED CODE:
        //     //begin

        //     //HEI.09
        //     /* //Bc Upgrade YADAVM09 Astro is out of Scope>>
        //     //HEI.16>>
        //     if AstroPostingValidation(Rec) then
        //       ERROR(Text50000);
        //     //HEI.16<<
        //  */ //Bc Upgrade YADAVM09 Astro is out of Scope<<
        //     //HEI.22>>
        //     if Location.GET("Location Code") then begin
        //         if (("Source Document Type FND" in ["Source Document Type FND"::"Inbound Transfer", "Source Document Type FND"::"Outbound Transfer"]) and TransferOrderPostShipment.IsTransGateEntryMandatory("Location Code", "Zone Code") and HeinekenGlobal.WhseShpmtIsTransferImportIdentifier("No.")) or
        //          (("Source Document Type FND" in ["Source Document Type FND"::"Sales Order", "Source Document Type FND"::"Sales Return Order"]) and SalesPost.IsSalesGateEntryMandatory("Location Code", "Zone Code")) then begin

        //             if Location."Bin Mandatory" then
        //                 TESTFIELD("Bin Code");
        //             if Location."Zone Mandatory" then
        //                 TESTFIELD("Zone Code");
        //         end;
        //     end;
        //     //HEI.22<<

        //     if "Gate Entry No." <> '' then begin
        //         MatchBool := false;
        //         if Location.GET("Location Code") then
        //             EnableInbound := Location."Enable Inbound Validation";

        //         if Zone.GET("Location Code", "Zone Code") then begin
        //             Autoreg := Zone."Inbound Automatic Registration";
        //             WeightMandatory := Zone."Gate Weighing Mandatory";
        //         end;

        //         if GateEntryHeader.GET("Gate Entry No.") then
        //             GroupControl := GateEntryHeader."Grouped Control";
        //         if not GroupControl and EnableInbound then begin

        //             WarehouseReceiptLine2.RESET;
        //             WarehouseReceiptLine2.SETRANGE(WarehouseReceiptLine2."No.", "No.");
        //             if WarehouseReceiptLine2.FINDSET then
        //                 repeat
        //                     GateEntryLine1.SETRANGE("Gate Entry Document No.", "Gate Entry No.");
        //                     GateEntryLine1.SETRANGE("No.", WarehouseReceiptLine2."Item No.");
        //                     if not GateEntryLine1.FINDFIRST then
        //                         ERROR('Item %1 does not exist in gate entry %2', WarehouseReceiptLine2."Item No.", GateEntryLine1."Gate Entry Document No.")
        //                     else begin
        //                         if WarehouseReceiptLine2."Unit of Measure Code" <> GateEntryLine1."Unit Of Measure Code" then
        //                             ERROR(ERR02, GateEntryLine1."Gate Entry Document No.", WarehouseReceiptLine2."No.");
        //                         if WarehouseReceiptLine2."Qty. to Receive" <> GateEntryLine1."Quantity on Arrival" then
        //                             ERROR('Quantity not matching');
        //                     end
        //                 until WarehouseReceiptLine2.NEXT = 0;
        //             GateEntryLine1.RESET;
        //             WarehouseReceiptLine2.RESET;
        //             GateEntryLine1.SETRANGE("Gate Entry Document No.", "Gate Entry No.");
        //             if GateEntryLine1.FINDSET then
        //                 repeat
        //                     WarehouseReceiptLine2.SETRANGE("No.", "No.");
        //                     WarehouseReceiptLine2.SETRANGE("Item No.", GateEntryLine1."No.");
        //                     if not WarehouseReceiptLine2.FINDFIRST then
        //                         ERROR('Item %1 does not exist in Warehouse receipt %2', GateEntryLine1."No.", WarehouseReceiptLine2."No.")
        //                     else begin
        //                         if WarehouseReceiptLine2."Unit of Measure Code" <> GateEntryLine1."Unit Of Measure Code" then
        //                             ERROR(ERR02, GateEntryLine1."Gate Entry Document No.", WarehouseReceiptLine2."No.");
        //                         if WarehouseReceiptLine2."Qty. to Receive" <> GateEntryLine1."Quantity on Arrival" then
        //                             ERROR('Quantity not matching');
        //                     end
        //                 until GateEntryLine1.NEXT = 0;
        //         end;
        //         if not GroupControl then begin
        //             if EnableInbound and Autoreg and not WeightMandatory then begin
        //                 WarehouseReceiptHeader.SETRANGE("Gate Entry No.", "Gate Entry No.");
        //                 WarehouseReceiptHeader.SETRANGE("Truck Code", "Truck Code");
        //                 WarehouseReceiptHeader.SETRANGE("Driver Code", "Driver Code");
        //                 WarehouseReceiptHeader.SETRANGE("Location Code", "Location Code");
        //                 WarehouseReceiptHeader.SETRANGE("Zone Code", "Zone Code");
        //                 if WarehouseReceiptHeader.FINDFIRST then begin
        //                     WarehouseReceiptLine.SETRANGE("No.", WarehouseReceiptHeader."No.");
        //                     WarehouseReceiptLine.SETFILTER(WarehouseReceiptLine."Qty. to Receive", '<>%1', 0);
        //                     if WarehouseReceiptLine.FINDSET then
        //                         repeat
        //                             WarehouseReceiptLine1.SETRANGE("No.", WarehouseReceiptHeader."No.");
        //                             WarehouseReceiptLine1.SETFILTER("Item No.", WarehouseReceiptLine."Item No.");
        //                             WarehouseQty := 0;
        //                             if WarehouseReceiptLine1.FINDSET then
        //                                 repeat
        //                                     WarehouseQty += WarehouseReceiptLine1."Qty. to Receive";
        //                                 until WarehouseReceiptLine1.NEXT = 0;

        //                             GateEntryLines.SETRANGE("Gate Entry Document No.", "Gate Entry No.");
        //                             GateEntryLines.SETFILTER(GateEntryLines."No.", WarehouseReceiptLine."Item No.");
        //                             if GateEntryLines.FINDFIRST then begin
        //                                 if GateEntryLines."Quantity on Arrival" <> WarehouseQty then begin
        //                                     ERROR(ERR01, GateEntryLines."Gate Entry Document No.", WarehouseReceiptHeader."No.");
        //                                     MatchBool := true;
        //                                 end;
        //                                 if GateEntryLines."Unit Of Measure Code" <> WarehouseReceiptLine."Unit of Measure Code" then begin
        //                                     ERROR(ERR02, GateEntryLines."Gate Entry Document No.", WarehouseReceiptHeader."No.");
        //                                     MatchBool := true;
        //                                 end;
        //                             end;
        //                             if not MatchBool then
        //                                 WhsePostRcptYesNo;
        //                         until WarehouseReceiptLine.NEXT = 0;
        //                 end;
        //             end else
        //                 WhsePostRcptYesNo;
        //         end else begin
        //             WarehouseReceiptHeader.SETRANGE("Gate Entry No.", "Gate Entry No.");
        //             WarehouseReceiptHeader.SETRANGE("Truck Code", "Truck Code");
        //             WarehouseReceiptHeader.SETRANGE("Driver Code", "Driver Code");
        //             WarehouseReceiptHeader.SETRANGE("Location Code", "Location Code");
        //             WarehouseReceiptHeader.SETRANGE("Zone Code", "Zone Code");
        //             if WarehouseReceiptHeader.FINDFIRST then begin
        //                 WarehouseReceiptLine.SETCURRENTKEY("Unit of Measure Code");
        //                 WarehouseReceiptLine.SETRANGE("No.", WarehouseReceiptHeader."No.");
        //                 WarehouseReceiptLine.SETFILTER(WarehouseReceiptLine."Qty. to Receive", '<>%1', 0);
        //                 if WarehouseReceiptLine.FINDSET then
        //                     repeat
        //                         if UOM <> WarehouseReceiptLine."Unit of Measure Code" then begin
        //                             WarehouseQty := 0;
        //                             WarehouseReceiptLine1.SETRANGE("No.", WarehouseReceiptHeader."No.");
        //                             WarehouseReceiptLine1.SETRANGE("Unit of Measure Code", WarehouseReceiptLine."Unit of Measure Code");
        //                             if WarehouseReceiptLine1.FINDSET then
        //                                 repeat
        //                                     WarehouseQty += WarehouseReceiptLine1."Qty. to Receive";
        //                                     UOM := WarehouseReceiptLine1."Unit of Measure Code";
        //                                 until WarehouseReceiptLine1.NEXT = 0;
        //                             GateEntryLines.RESET;
        //                             GateEntryLines.SETRANGE("Gate Entry Document No.", "Gate Entry No.");
        //                             GateEntryLines.SETRANGE("Unit Of Measure Code", WarehouseReceiptLine1."Unit of Measure Code");
        //                             if GateEntryLines.FINDFIRST then begin
        //                                 if WarehouseQty <> GateEntryLines."Quantity on Arrival" then
        //                                     MatchBool := true
        //                                 else
        //                                     MatchBool := false;
        //                             end;
        //                         end else begin
        //                             UOM := WarehouseReceiptLine."Unit of Measure Code";
        //                         end;
        //                         if MatchBool then
        //                             ERROR(ERR01, GateEntryLines."Gate Entry Document No.", WarehouseReceiptHeader."No.")
        //                     until WarehouseReceiptLine.NEXT = 0;
        //                 if not MatchBool then
        //                     WhsePostRcptYesNo;
        //             end
        //         end
        //     end else
        //         WhsePostRcptYesNo;
        //     //HEI.09

        //     //>>HEI.10
        //     if g_recDelWrhseRcptHdr.GET("No.") then begin
        //         PurchPayableSetup.GET;
        //         if PurchPayableSetup."Archive Quotes and Orders" then begin
        //             SetFlagtoDelete := false;
        //             i := 0;
        //             g_recPurchLine.SETRANGE("Document Type", g_recPurchLine."Document Type"::Order);
        //             g_recPurchLine.SETRANGE(g_recPurchLine."Whse. Receipt No. (Open)", Rec."No.");
        //             if g_recPurchLine.FINDSET then
        //                 repeat
        //                     if (g_recPurchLine."Delivery Finalized" and g_recPurchLine."Completely Received") then
        //                         i := i + 1;
        //                 until g_recPurchLine.NEXT = 0;
        //             if (i = g_recPurchLine.COUNT) then
        //                 SetFlagtoDelete := true;
        //             if SetFlagtoDelete then
        //                 g_recDelWrhseRcptHdr.DELETE(true);
        //         end;
        //     end;
        //     //<<HEI.10

        // end;


        //Unsupported feature: CodeInsertion on ""Post and &Print"(Action 47).OnAction". Please convert manually.

        //trigger (Variable: WhseRecpHdr)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Post and &Print"(Action 47).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WhsePostRcptPrintPostedRcpt;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //>>HEI.01
        //WhseRecpHdr.SETRANGE("No.", Rec."No.");
        //REPORT.RUNMODAL(50122, TRUE, TRUE, WhseRecpHdr);
        //<<HEI.01
        //HEI.16>>
        if AstroPostingValidation(Rec) then
          ERROR(Text50000);
        //HEI.16<<
        WhsePostRcptPrintPostedRcpt;
        */
        //end;


        //Unsupported feature: CodeModification on ""Post and Print P&ut-away"(Action 26).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WhsePostRcptPrint;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.16>>
        if AstroPostingValidation(Rec) then
          ERROR(Text50000);
        //HEI.16<<

        WhsePostRcptPrint;
        */
        //end;
        /* //Bc Upgrade YADAVM09 Drink it Field>>
        addfirst(ActionContainer1900000003)
        {
            action("Return Control")
            {
                Caption = 'Return Control';
                Description = 'NRQ#39012';
                Ellipsis = true;
                Enabled = EnableActionReturnControl;
                Image = ReturnRelated;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                ShortCutKey = 'Ctrl+Alt+R';

                trigger OnAction();
                var
                    ReturnRegistrationMgt: Codeunit "Return Registration Mgt.";
                begin
                    //HEI.04>>
                    ReturnRegistrationMgt.LoadReturnControlFromWhseReceipt(Rec)
                    //HEI.04<<
                end;
            }
        }
        addafter("Posted &Whse. Receipts")
        {
            separator(Separator1161021001)
            {
            }
            action("Show N-owm activities")
            {
                CaptionML = ENU = 'Show N-owm activities',
                            FRA = 'Visualiser Activitées N-owm';
                Image = NewResource;

                trigger OnAction();
                var
                    OWMUtils: Codeunit "N-owm Utils";
                begin
                    // NIQ OWM >>
                    OWMUtils.ShowActivityStatus(OWMUtils.ActReceive, "No.", "Location Code");  //DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
                    // NIQ OWM <<
                end;
            }
            action("Shipping Costs")
            {
                CaptionML = ENU = 'Shipping Costs',
                            FRA = 'Coûts transport';
                Image = Costs;
                RunObject = Page "Document Shipping Cost";
                RunPageLink = "Source Type" = CONST(7316),
                              "Source No." = FIELD("No."),
                              "Sub Type" = CONST(0);
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it Field<<
        addafter(CalculateCrossDock)
        {
            /* //Bc Upgrade YADAVM09 Drink it Field>>
              separator(Separator1100083035)
              {
              }
              action(Action1101000006)
              {
                  Caption = 'Return Control';
                  Description = 'NRQ#39012';
                  Ellipsis = true;
                  Enabled = EnableActionReturnControl;
                  Image = ReturnRelated;
                  //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                  //PromotedCategory = Process;
                  ShortCutKey = 'Ctrl+Alt+R';

                  trigger OnAction();
                  var
                      ReturnRegistrationMgt: Codeunit "Return Registration Mgt.";
                  begin
                      //<<DITW110.00.11 MSF 06/10/2017 NRQ#39012
                      ReturnRegistrationMgt.LoadReturnControlFromWhseReceipt(Rec)
                  end;
              }
              */ //Bc Upgrade YADAVM09 Drink it Field<<

            /* //Bc Upgrade YADAVM09 will add in page extension of interface>>
          action("Item Reclassification")
          {
              Image = ItemSubstitution;
              Promoted = true;
              PromotedCategory = Process;

              trigger OnAction();
              var
                  LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt.";
              begin
                  //HEI.22
                  LSRInterfaceMgmt.OpenItemReclassJournal(Rec);
              end;
          }
          */ //Bc Upgrade YADAVM09 will add in page extension of interface<<
        }

        addafter("&Print")
        {
            group(ActionGroup1100083014)
            {
                CaptionML = ENU = '&Print',
                            FRA = '&Imprimer';
                /* //Bc Upgrade YADAVM09 Drink it Field>>
                  action(Receipt)
                  {
                      CaptionML = ENU = 'Receipt',
                                  FRA = 'Réception';
                      Image = Print;

                      trigger OnAction();
                      begin
                          // <<DIT15.00.00.21 DDR 19/06/2008
                          WhseDocPrint.PrintRcptHeader(Rec);
                          // >>DIT15.00.00.21 DDR
                      end;
                  }
                  action("Shipping Agent Notice")
                  {
                      CaptionML = ENU = 'Shipping Agent Notice',
                                  FRA = 'Avis d''expédition transporteur';
                      Image = Print;

                      trigger OnAction();
                      begin
                          // <<DIT15.00.00.21 DDR 19/06/2008
                          WhseDocPrint.PrintRcptAgentNoticeHeader(Rec);
                          // >>DIT15.00.00.21 DDR
                      end;
                  }
                  */ //Bc Upgrade YADAVM09 Drink it Field<<
                action("Truck Unloading Note")
                {
                    Caption = 'Truck Unloading Note';
                    Image = Print;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Truck Unloading Note action.';

                    trigger OnAction();
                    var
                        RcptHeader: Record "Warehouse Receipt Header";
                        WhseDocPrint: Codeunit "Warehouse Document-Print";
                        HeinekenBcUpgradeCu: Codeunit "Heineken BC Upgrade";
                    begin
                        /* commented by HEI.05
                        //>>HEI.01
                        RcptHeader.SETRANGE("No.","No.");
                        REPORT.RUN(REPORT::"Unoading Note",TRUE,FALSE,RcptHeader);
                        //>>HEI.01
                        */
                        //HEI.05>>
                        //WhseDocPrint.PrintUnloadingNoteWhseReceipt(Rec);//Bc Upgrade YADAVM09
                        HeinekenBcUpgradeCu.PrintUnloadingNoteWhseReceipt(Rec);//Bc Upgrade YADAVM09
                        //HEI.05<<

                    end;
                }
            }
        }
    }

    var
        SalesHeader: Record "Sales Header";
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        CantReceiveErr: Label 'You can not receive an Order sent by %1.';

    var
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";

        WarehouseItemNo: Code[20];
        WarehouseQty: Decimal;
        GateEntryHeader: Record "Gate Entry Header FND";
        GateEntryLines: Record "Gate Entry Line FND";
        GateEntryItemNo: Code[20];
        GateEntryQty: Decimal;
        ERR01: Label 'Gate Entry %1 is not matching with the warehouse receipt %2';
        Location: Record Location;
        EnableInbound: Boolean;
        Zone: Record Zone;
        Autoreg: Boolean;
        WeightMandatory: Boolean;
        GroupControl: Boolean;
        WarehouseReceiptLine1: Record "Warehouse Receipt Line";
        ERR02: Label 'Gate Entry Unit of Measure Code %1 is not matching with the warehouse receipt %2';
        UOM: Code[10];
        MatchBool: Boolean;
        GateEntryLine1: Record "Gate Entry Line FND";
        WarehouseReceiptLine2: Record "Warehouse Receipt Line";
        PurchPayableSetup: Record "Purchases & Payables Setup";
        TransferOrderPostShipment: Codeunit "TransferOrder-Post Shipment";
        SalesPost: Codeunit "Sales-Post";
        HeinekenGlobal: Codeunit "Heineken Global";
        WhseRecpHdr: Record "Warehouse Receipt Header";
        //LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt.";//MY

        "Maximum CubageVisible": Boolean;

        "Maximum WeightVisible": Boolean;

        "Maximum WeightEmphasize": Boolean;

        "Maximum CubageEmphasize": Boolean;
        ResponsibilityCenter: Record "Responsibility Center";
        VendorShipmentNoMandatory: Boolean;
        EditableMultipleRouteOrder: Boolean;
        EnableActionReturnControl: Boolean;
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentVendorIsBlank: Label 'There is no Vendor associated with this Shipping Agent';
        VendorBlockForShipAgent: Label '"The Vendor associated with this Shipping Agent is blocked "';
        Vend: Record Vendor;
        //RecRoute: Record Route;//Bc Upgrade YADAVM09 Drink it table
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        TruckMandatory: Boolean;
        DriverMandatory: Boolean;
        ShippingAgentMandatory: Boolean;
        ShippingAgentServiceMandatory: Boolean;
        g_recDelWrhseRcptHdr: Record "Warehouse Receipt Header";
        g_recPurchLine: Record "Purchase Line";
        SetFlagtoDelete: Boolean;
        i: Integer;
        PurchHdrAddRec: Record "Purchase Header Additional FND";
        Text50000: Label 'The warehouse receipt has lines associated with Astro, so manually it can not be posted';
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    //<<DITW18.00.06 MSF 06/07/2015 DIT-770 #1212 #1213 #1214
    if "Physical Location Group Code" <> '' then begin
      ResponsibilityCenter.RESET;
      ResponsibilityCenter.SETRANGE("Physical Location Group Code","Physical Location Group Code");
      if not ResponsibilityCenter.ISEMPTY then begin
        ResponsibilityCenter.FINDFIRST;
        SETFILTER("Resp. Center Table Filter",'%1|%2','',ResponsibilityCenter.Code);
      end;
    end;
    //>>DITW18.00.06 MSF 06/07/2015 DIT-770 #1212 #1213 #1214
    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
    SETFILTER("Phys. Location Table Filter",'%1|%2','',"Physical Location Group Code");
    ///DITW110.00.11 MSF 02/10/2017 NRQ#16082
    EditableMultipleRouteOrder := not "Multiple Order Route";
    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
    //<<DITW110.00.11 MSF 06/11/2017 NRQ#43572
     EnableActionReturnControl := "Route Planning No." <> '' ;
    //>>DITW110.00.11 MSF 06/11/2017 NRQ#43572
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    trigger OnAfterGetRecord();
    begin
        /* //Bc Upgrade YADAVM09 blocked due to Drink it Dependency>>
         MaximumCubageOnFormat;
         MaximumWeightOnFormat;
         //<< DITW18.00.07 AKH 13/05/2016 DIT-770 #1409
         SetExtDocNoMandatoryCondition;
         //>> DITW18.00.07 AKH DIT-770 #1409
         //<<DITW110.00.11 MSF 11/09/2017 NRQ#16082
         if "Route Planning No." = '' then
             EditableMultipleRouteOrder := true;
         //>>DITW110.00.11 MSF 11/09/2017 NRQ#16082

         //>> HEI.06 FDD-HT658 IBM.GUNERE01 17.09.2019
         if Route <> '' then begin
             TruckMandatory := IsTruckMandatory;
             DriverMandatory := IsDriverMandatory;
             ShippingAgentMandatory := IsShippingAgentCodeMandatory;
             ShippingAgentServiceMandatory := IsShippingAgentServCodeMandatory;
         end;
         //<< HEI.06 FDD-HT658 IBM.GUNERE01 17.09.2019
      */ //Bc Upgrade YADAVM09 blocked due to Drink it Dependency<<
         //HEI.11 >>
        PurchHdrAddRec.RESET();
        PurchHdrAddRec.SETRANGE("No.", Rec."Source No. FND");
        if PurchHdrAddRec.FINDFIRST() then;
        //HEI.11 <<

    end;


    //Unsupported feature: CodeInsertion on "OnClosePage". Please convert manually.

    trigger OnClosePage();
    var
    //RetRegControl: Record "Returns Register Control";//Bc Upgrade YADAVM09 Drink it Table
    begin

        //>>HEI.01
        //RetRegControl.SETRANGE("Source No.", "No.");
        //RetRegControl.DELETEALL;
        //<<HEI.01

    end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    "Maximum WeightVisible" := true;
    "Maximum CubageVisible" := true;
    //<< DITW18.00.07 AKH 13/05/2016 DIT-770 #1409
    SetExtDocNoMandatoryCondition;
    //>> DITW18.00.07 AKH DIT-770 #1409
    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
    EditableMultipleRouteOrder := true;
    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //begin
    /*
    // <<DITW15.00.00.39 DDR 19/07/2011 DIT-715 #107
    OpenWhseRcptHeader(Rec);
    // >>DITW15.00.00.39 DDR DIT-715 #107
    */
    //end;


    /* //Bc Upgrade YADAVM09 Drink it function blocked>>
        procedure FormatMaximumControls(pFieldNo: Integer; pMaxValue: Decimal; pTotalValue: Decimal);
        var
            lblnBold: Boolean;
            lcolor: Integer;
        begin
            // <<DIT15.00.00.21 DDR 19/06/2008
            lcolor := 0;
            lblnBold := false;

            if pMaxValue < pTotalValue then
                lcolor := 255;

            lblnBold := lcolor <> 0;

            // <<DITW15.00.00.25 DDR 09/10/2008
            "Maximum CubageVisible" := false;
            "Maximum WeightVisible" := false;
            // >>DITW15.00.00.25 DDR

            case pFieldNo of
                FIELDNO("Maximum Weight"):
                    begin
                        "Maximum WeightEmphasize" := lblnBold;
                    end;
                FIELDNO("Maximum Cubage"):
                    begin
                        "Maximum CubageEmphasize" := lblnBold;
                    end;
            end;

            // <<DITW15.00.00.25 DDR 09/10/2008
            "Maximum CubageVisible" := true;
            "Maximum WeightVisible" := true;
            // >>DITW15.00.00.25 DDR
        end;

        local procedure MaximumCubageOnFormat();
        begin
            CALCFIELDS("Total Cubage To Receive");
            FormatMaximumControls(FIELDNO("Maximum Cubage"), "Maximum Cubage", "Total Cubage To Receive");
        end;

        local procedure MaximumWeightOnFormat();
        begin
            CALCFIELDS("Total Weight To Receive");
            FormatMaximumControls(FIELDNO("Maximum Weight"), "Maximum Weight", "Total Weight To Receive");
        end;

        local procedure SetExtDocNoMandatoryCondition();
        var
            PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        begin
            //<< DITW18.00.07 AKH 13/05/2016 DIT-770 #1409
            PurchasesPayablesSetup.GET;
            VendorShipmentNoMandatory := PurchasesPayablesSetup."Vendor Shipment No. Mandatory";
        end;

        local procedure IsTruckMandatory(): Boolean;
        var
            locRoute: Record Route;
        begin
            //>> HEI.06
            if locRoute.GET(Route) then begin
                if locRoute."Truck No. Mandatory" = true then
                    exit(true)
                else
                    exit(false);
            end;
            //>> HEI.06
        end;

        local procedure IsDriverMandatory(): Boolean;
        var
            locRoute: Record Route;
        begin
            //>> HEI.06
            if locRoute.GET(Route) then begin
                if locRoute."Driver Mandatory" = true then
                    exit(true)
                else
                    exit(false);
            end;
            //>> HEI.06
        end;

        local procedure IsShippingAgentCodeMandatory(): Boolean;
        var
            locRoute: Record Route;
        begin
            //>> HEI.06
            if locRoute.GET(Route) then begin
                if locRoute."Shipping Agent Code Mantatory" = true then
                    exit(true)
                else
                    exit(false);
            end;
            //>> HEI.06
        end;

        local procedure IsShippingAgentServCodeMandatory(): Boolean;
        var
            locRoute: Record Route;
        begin
            //>> HEI.06
            if locRoute.GET(Route) then begin
                if locRoute."Ship. Ag. Serv. Code Mandatory" = true then
                    exit(true)
                else
                    exit(false);
            end;
            //>> HEI.06
        end;
        */ //Bc Upgrade YADAVM09 Drink it function blocked<<

    /* //Bc Upgrade YADAVM09 Astro function blocked>>
        local procedure AstroPostingValidation(WarehouseReceiptHeader: Record "Warehouse Receipt Header"): Boolean;
        var
            WarehouseReceiptLine: Record "Warehouse Receipt Line";
            AstroInterfaceSetup: Record "Astro Interface Setup";
        begin
            //HEI.16>>
            //AstroInterfaceSetup.GET;  //HEI.17
            //HEI.21>>
            //IF AstroInterfaceSetup.GET THEN BEGIN  //HEI.17
            //  IF (WarehouseReceiptHeader."Source Document Type FND" = WarehouseReceiptHeader."Source Document Type FND"::"Purchase Order") THEN BEGIN  //HEI.20
            //    IF AstroInterfaceSetup."Enabled Astro Integration" THEN BEGIN
            //      IF AstroInterfaceSetup."Enable Dispatch Syncing StP" THEN BEGIN
            //        PurchasesPayablesSetup.GET;  //HEI.18
            //       //IF (NOT PurchasesPayablesSetup."Astro Whse Rcpt Manl Post") OR (NOT AstroInterfaceSetup."Allow Mnl Posting Purch Rcpt") THEN BEGIN  //HEI.18  //HEI.19
            //        IF (PurchasesPayablesSetup."Astro Whse Rcpt Manl Post") OR (AstroInterfaceSetup."Allow Mnl Posting Purch Rcpt") THEN BEGIN  //HEI.19
            //          WarehouseReceiptLine.RESET;
            //          WarehouseReceiptLine.SETRANGE("No.",WarehouseReceiptHeader."No.");
            //          WarehouseReceiptLine.SETFILTER("Qty. to Receive",'<>%1',0);
            //          WarehouseReceiptLine.SETFILTER("Astro Unique ID",'<>%1','');
            //          //IF NOT WarehouseReceiptLine.ISEMPTY THEN  //HEI.19
            //          IF WarehouseReceiptLine.ISEMPTY THEN  //HEI.19
            //            EXIT(TRUE)
            //          ELSE
            //            EXIT(FALSE);
            //        //END;  //HEI.19
            //        END ELSE  //HEI.19
            //          EXIT(TRUE);  //HEI.19
            //      END; //HEI.18
            //    END;
            //  END;  //HEI.20
            //END;  //HEI.17
            ////HEI.16<<
            if not AstroInterfaceSetup.GET then
                exit(false);

            if not AstroInterfaceSetup."Enabled Astro Integration" then
                exit(false);

            if not (WarehouseReceiptHeader."Source Document Type FND" = WarehouseReceiptHeader."Source Document Type FND"::"Purchase Order") then
                exit(false);

            if not AstroInterfaceSetup."Enable Dispatch Syncing StP" then
                exit(false);

            PurchasesPayablesSetup.GET;
            if (PurchasesPayablesSetup."Astro Whse Rcpt Manl Post") or (AstroInterfaceSetup."Allow Mnl Posting Purch Rcpt") then
                exit(false);

            WarehouseReceiptLine.RESET;
            WarehouseReceiptLine.SETRANGE("No.", WarehouseReceiptHeader."No.");
            WarehouseReceiptLine.SETFILTER("Qty. to Receive", '<>%1', 0);
            WarehouseReceiptLine.SETFILTER("Astro Unique ID", '<>%1', '');
            if not WarehouseReceiptLine.ISEMPTY then
                exit(true);
            //HEI.21<<
        end;
        */ //Bc Upgrade YADAVM09 Drink it function blocked<<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    local procedure WhsePostRcptYesNo()
    begin
        CurrPage.WhseReceiptLines.PAGE.WhsePostRcptYesNo();
    end;
}

