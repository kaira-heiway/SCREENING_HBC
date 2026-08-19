pageextension 54032 PostedWhseShipmentExt extends "Posted Whse. Shipment"
{
    // version NAVW110.0,DITW110.00.11,HEI.03

    //     DITW15.00.00.21 DDR 18/06/2008 Added fields on tab "Shipping"
    //                                  "Shipping Charge Type","Shipping Charge No.","Shipping Charge Per"
    //                                  "Shipping Unit Cost","Shipping Cost Amount"
    //                                  "Shipping Quantity Invoiced","Shipping Qty. Rcd. Not Invd."
    //                                  "Total Weight","Total Cubage"
    //                                added property's Form: CalcFields
    // DITW15.00.00.23.04 DDR£ 12/09/2008 Added field "Driver Code"
    // DITW15.00.00.25 DDR 16/10/2008 Added "Truck Code" into "Shipping" tab
    // DITW15.00.00.35 DDR 19/08/2009 issue 773 Added fields "Shipping Currency Code"
    //                 DLE 06/09/2009 issue 516 Added field "Physical Location Group Code"
    // DITW15.00.00.35 DDR 14/10/2009 issue 788 Added Form property DeleteAllowed = No
    // DITW16.00.00.37 DDR 21/01/2011 DIT-715 #1 #53 RTC Page functionnalities & Nav SQL performances
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields "Distance","Route" into 'Shipping' tab

    // DITW17.00.02 DDR 17/05/2013 DIT-770 #95 Added 'Vessel/Port' tab + fields
    //                                               "Vessel info code","Port Code","Wharf Code","No. of Crews","No. of Passengers",
    //                                               "Estimated Voyage (Days)","Estimated Voyage (Text)","Voyage Details",
    //                                               "Voyage Destination","Net Tonnage"
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #95
    // DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1066 Removed old Shipping Costs fields from Shipping Tab
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 Add Flowfield "Document Shipping Costs" to General TAB

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added Fields
    //                                "Require 2 Drivers"
    //                                "Driver 2 Code"
    //                                "Route Planning No."
    //                                 "Trailer Code"
    // HEI.01 FDD-PA-LOGGAP05 - Loading Note IBM.NAIKH01 20.11.2017
    //    # Created a new Page Action "Loading Note" and add code.
    // FCe- Print load list from Posted Warehouse Shipment
    // HEI.02 FDD-LB-GAPLOG03 IBM NASTAA02 17.07.2018 # Loading Note Almaza
    //   # New functionality added to Page Action "Loading List".
    //   # All OpCo's will use the same button: "Loading List".
    //   # Panama and Lebanon will setup the report in Report Selection - Inventory, Usage: "Load List (Posted Whse. Shipment)"
    //    because the reports are based on Table "Posted Warehouse Shipment"
    //   # Algeria will be setup the report in Report Selection - Sales, Usage: "Load List", as it is right now.
    //   # Algeria should not fill-in in Report Selection - Inventory, Usage: "Load List (Posted Whse. Shipment)".
    // HEI.03 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field added: "Gate Entry No."

    // HEI.05 FDD- HT465 IBM SURYAS01 28.08.2019
    //   # Added code in Delivery Note Action
    // HEI.06 FDD-HT1139A IBM NASTAA02 12.05.2020 # DRC - BVM Interface
    //   # New Field added: "Export Status"
    //   # New Page Action created: "Export BVM Delivery"
    //   # Code added on 'OnAfterGetRecord' trigger
    // HEI.07 Defect4465 IBM BULIMC01 21/11/2019 #apply fixes on Delivery Note action
    // HEI.08 HB2156CHG2107450 IBM GAVANM01 27.01.2022 # WMS Phase 2 - Transportation cost
    //   # new field added in General tab: WMS Import
    //   # new global var VisibleWMS, WMSInterfaceSetup
    //   # code added in OnInit()


    //Bc Upgrade YADAVM09 Drink it fields Blocked.
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the posted warehouse shipment document header that was created.', FRA = 'Spécifie le numéro d''en-tête expédition entrepôt enregistré qui a été créé.';
        }
        modify("Whse. Shipment No.")
        {
            ToolTipML = ENU = 'Specifies the number of the warehouse shipment that the posted warehouse shipment originates from.', FRA = 'Spécifie le numéro de l''expédition entrepôt d''où est issue l''expédition entrepôt enregistrée.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location from which the items were shipped.', FRA = 'Spécifie le code du magasin à partir duquel les articles ont été expédiés.';
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
        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping', FRA = 'Livraison';
        }
        modify("External Document No.")
        {
            ToolTipML = ENU = 'Specifies an external document number. If you enter a value, the source document is updated with this number during posting.', FRA = 'Spécifie un numéro de document externe. Si vous saisissez une valeur, le document origine est mis à jour en utilisant ce numéro lors de la validation.';
        }
        modify("Shipment Date")
        {
            ToolTipML = ENU = 'Specifies the shipment date that was on the header of the warehouse shipment when it was posted.', FRA = 'Spécifie la date d''expédition qui figurait sur l''en-tête expédition entrepôt lorsqu''elle a été enregistrée.';
        }
        modify("Shipping Agent Code")
        {
            ToolTipML = ENU = 'Specifies the code of the shipping agent used for the warehouse shipment.', FRA = 'Spécifie le code du transporteur utilisé pour cette expédition entrepôt.';
        }
        modify("Shipping Agent Service Code")
        {
            ToolTipML = ENU = 'Specifies the code of the shipping agent service used for the warehouse shipment.', FRA = 'Spécifie le code du service du transporteur utilisé pour cette expédition entrepôt.';
        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies the code of the shipment method used for the warehouse shipment.', FRA = 'Spécifie le code utilisé pour trouver les conditions de livraison utilisées pour cette expédition entrepôt.';
        }
        // addafter("Location Code")
        // {
        //     field("Physical Location Group Code";Rec."Physical Location Group Code")
        //     {
        //         Editable = false;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it field blocked<<
        addafter("Assignment Time")
        {
            // field("Document Shipping Costs";Rec."Document Shipping Costs")
            // {
            // }//Bc Upgrade YADAVM09 Drink it field blocked<<
            field("Gate Entry No."; Rec."Gate Entry No. FND")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            }
            field("Export Status"; Rec."Export Status FND")
            {
                Editable = false;
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            }
            field("WMS Import"; Rec."WMS Import FND")
            {
                Description = 'HEI.08';
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                Visible = VisibleWMS;
            }
        }
        // addafter("Shipping Agent Service Code")
        // {
        //     field(Distance; Rec.Distance)
        //     {
        //         Editable = false;
        //     }
        //     field("Truck Code"; Rec."Truck Code")
        //     {
        //         Editable = false;
        //     }
        //     field("Trailer Code"; Rec."Trailer Code")
        //     {
        //     }
        //     field("Driver Code"; Rec."Driver Code")
        //     {
        //         Editable = false;
        //     }
        //     field("Require 2 Drivers"; Rec."Require 2 Drivers")
        //     {
        //     }
        //     field("Driver 2 Code"; Rec."Driver 2 Code")
        //     {
        //     }
        //     field(Route; Rec.Route)
        //     {
        //         Editable = false;
        //     }
        //     field("Route Planning No."; Rec."Route Planning No.")
        //     {
        //     }
        //     group(Control1100076000)
        //     {
        //         Caption = '""';
        //         field("Total Weight"; Rec."Total Weight")
        //         {
        //             Editable = false;
        //             Importance = Promoted;
        //         }
        //         field("Total Cubage"; Rec."Total Cubage")
        //         {
        //             Editable = false;
        //             Importance = Promoted;
        //         }
        //    }
        //}//Bc Upgrade YADAVM09 Drink it field blocked<<
        moveafter("Shipment Date"; "Shipment Method Code")
    }
    actions
    {
        modify("&Shipment")
        {
            CaptionML = ENU = '&Shipment', FRA = 'E&xpédition';
        }
        modify(List)
        {
            CaptionML = ENU = 'List', FRA = 'Lister';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }
        addafter("Co&mments")
        {
            // action("Shipping Costs")
            // {
            //     CaptionML = ENU = 'Shipping Costs',
            //                 FRA = 'Coûts transport';
            //     Image = Costs;
            //     RunObject = Page "Posted Document Shipping Cost";
            //     RunPageLink = "Source Type" = CONST(7322),
            //                   "Source No." = FIELD("No.");
            // } //Bc Upgrade YADAVM09 Drink it Action blocked<<
            // action("Export BVM Delivery")
            // {
            //     Caption = 'Export BVM Delivery';
            //     Image = Export;
            //     Promoted = true;
            //     PromotedCategory = New;
            //     PromotedIsBig = true;
            //     Visible = ExportBVMDeliveryEnabled;

            //     trigger OnAction();
            //     var
            //         BVMProcessingLauncher: Codeunit "BVM Processing Launcher";
            //     begin
            //         //HEI.06>>
            //         BVMProcessingLauncher.ManuallyProcessDeliveryResponse(Rec."No.");
            //         //HEI.06<<
            //     end;//Bc Upgrade YADAVM09 BVM Interface is out of scope<<
            // }
        }
        addafter("&Print")
        {
            // action("Loading Notes")
            // {
            //     Caption = 'Loading Notes';
            //     Image = Print;

            //     trigger OnAction();
            //     var
            //         PostedShptHeader: Record "Posted Whse. Shipment Header";
            //     begin
            //         //>>HEI.01
            //         PostedShptHeader.SETRANGE("No.", Rec."No.");
            //         REPORT.RUN(REPORT::"Posted Truck LoadingNote PAN", true, false, PostedShptHeader);
            //         //>>HEI.01
            //     end;
            // }//Bc Upgrade YADAVM09 Posted Truck LoadingNote PAN report is out of scope as it is used for Panama<<
            action("Delivery Note")
            {
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                trigger OnAction();
                var
                    PostShptHeader: Record "Posted Whse. Shipment Header";
                begin

                    //<< TDD-HNK 100102 23/11/2015 IBM.CHAUHB01
                    PostShptHeader.SETRANGE("No.", Rec."No.");
                    //PAN:FDD100400>>
                    WhseSetup.GET;
                    //if WhseSetup."Print Delivery Note" = true then//Bc Upgrade YADAVM09 functionality used for Panama which is out of scope<<
                    // REPORT.RUN(REPORT::"Delivery Note ALM",TRUE,FALSE,PostShptHeader)
                    //ELSE
                    //PrintDeliveryNote//Bc Upgrade YADAVM09 functionality used for Panama which is out of scope<<

                    //<<HEI.05
                    //else
                    if WhseSetup."Print Delivery Note FND" = false then begin //HEI.06
                        ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Delivery Note(Sales Invoice)");
                        if ReportSelection.FINDFIRST then begin
                            SalesInvoiceHeader.RESET;
                            SalesInvoiceHeader.SETRANGE("Posted Whse. Shpmt No. FND", Rec."No.");
                            if SalesInvoiceHeader.FINDSET then
                                repeat
                                    SSI.SETRANGE(SSI."No.", SalesInvoiceHeader."No.");
                                    REPORT.RUN(ReportSelection."Report ID", true, false, SSI)
                                until SalesInvoiceHeader.NEXT = 0;
                        end;
                    end; //HEI.06
                    //>>HEI.05
                    //>> TDD-HNK 100102 23/11/2015 IBM.CHAUHB01
                end;
            }
            action("Load List")
            {
                Caption = 'Load List';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<

                trigger OnAction();
                var
                    ReportSelection: Record "Report Selections";
                    PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header";
                    DocType: Option "Order",Invoice,"Credit Memo",,"Return Order";
                    PrintOrderSalesUsage: Option "Order Confirmation","Work Order","Pick Instruction",,,,,,,,,,"Order Picking","Picking List","Shipping List","Order Shipment","Combined Picking","Load List","Shipment Specif.","Return Control",,,,,,,,,,,,,,,,,,,,"Pro-forma";
                begin
                    //HEI.02>>
                    ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Load List (Pst. Whse. Shipment)");
                    if ReportSelection.FINDFIRST then begin
                        PostedWhseShipmentHeader.SETRANGE("No.", Rec."No.");
                        // PostedWhseShipmentHeader.SETRANGE(Route, Rec.Route);
                        // PostedWhseShipmentHeader.SETRANGE("Route Planning No.", Rec."Route Planning No.");
                        if PostedWhseShipmentHeader.FINDSET then
                            repeat
                                //ReportSelection.PrintWithCheck(ReportSelection.Usage::"Load List (Pst. Whse. Shipment)", PostedWhseShipmentHeader, '');//Bc Upgrade YADAVM09 Function Removed by Microsoft
                                ReportSelection.PrintWithCheckForCust(ReportSelection.Usage::"Load List (Pst. Whse. Shipment)", PostedWhseShipmentHeader, 1);//Bc Upgrade YADAVM09
                            until PostedWhseShipmentHeader.NEXT = 0;
                    end; //else//Bc Upgrade YADAVM09<<
                         // PrintSales(DocType::Order, PrintOrderSalesUsage::"Load List");//Bc Upgrade YADAVM09 Drink it Function<<
                         //HEI.02<<
                end;
            }
        }
    }

    var
        WhseSetup: Record "Warehouse Setup";
        //RouteSalesMgt: Codeunit "Route Sales-Request Mgt.";//Bc Upgrade YADAVM09 Drink it object<<
        ReportSelection: Record "Report Selections";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SSH: Record "Sales Shipment Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SSI: Record "Sales Invoice Header";
        ExportBVMDeliveryEnabled: Boolean;
        VisibleWMS: Boolean;
    //WMSInterfaceSetup: Record "WMS Interface Setup INT";//Bc Upgrade YADAVM09 Interface Variable<<


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    var
        GeneralOpCoSetup: Record "General OpCo Setup FND";
    //BVMInterfaceSetup: Record "BVM Interface Setup INT";//BC Upgrade YADAVM09 Interface Objects<<
    //InterfaceSetup: Record "Interface Setup";//BC Upgrade YADAVM09 Interface Objects<<
    //begin
    /*
    //HEI.06>>
    GeneralOpCoSetup.GET;
    if GeneralOpCoSetup."Enable BVM Integration" then
      if BVMInterfaceSetup.GET then
        if InterfaceSetup.GET(BVMInterfaceSetup."BVM Delivery Interface Code") then
          if InterfaceSetup.Enabled then
            ExportBVMDeliveryEnabled := true;
    //HEI.06<<
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    VisibleWMS := WMSInterfaceSetup.GET and WMSInterfaceSetup."WMS Integration";  //HEI.08
    */
    //end;
    //Bc Upgrade YADAVM09 Deliver Note PAN report is for Panama which is is out of scope>>
    // local procedure PrintDeliveryNote();
    // var
    //     SalesInvHeader: Record "Sales Invoice Header";
    //     SIH: Record "Sales Invoice Header";
    // begin
    //     SalesInvHeader.RESET;
    //     SalesInvHeader.SETRANGE("Posted Warehouse Shipment No.", Rec."No."); //HEI.06
    //     if SalesInvHeader.FINDSET then
    //         repeat
    //             SIH.SETRANGE(SIH."No.", SalesInvHeader."No.");
    //             REPORT.RUN(REPORT::"Delivery Note PAN", true, false, SIH)
    //until SalesInvHeader.NEXT = 0;
    //end;//Bc Upgrade YADAVM09 Deliver Note PAN report is for Panama which is is out of scope<<

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
    //         SalesHeader.SETRANGE("Shipment Date");
    //     if Route <> '' then
    //         SalesHeader.SETRANGE(Route, Route)
    //     else
    //         COPYFILTER(Route, SalesHeader.Route);
    //     COPYFILTER("Shipment Method Code", SalesHeader."Shipment Method Code");
    //     COPYFILTER("Location Code", SalesHeader."Location Code");
    //     COPYFILTER("Physical Location Group Code", SalesHeader."Physical Location Group Code");
    //     //<<DITW110.00.11 MSF 13/11/2017 NRQ#16082
    //     if SalesHeader.FINDSET then
    //         //>>DITW110.00.11 MSF 13/11/2017 NRQ#16082
    //         RouteSalesMgt.PrintSalesDocument(SalesHeader, PrintOrderUsage);
    // end;//Bc Upgrade YADAVM09 Drink it function.

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

