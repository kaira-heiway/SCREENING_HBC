report 51034 "Pickng Lst by Sales Ord BA CBN"
{
    // version NAVW110.0.00.16177,HEI.03

    // HEI.01 Defect #703 IBM NASTAA02 23.03.2018 # Picking List Report
    //   # Layout improvements
    // HEI.02 BugFixing IBM POSTOI01 09.08.2018 # first column not displayed properly
    //   # layout improvement : change the first column property CanGrow -> True
    // HEI.03 FDD-BA-LOGGAP07 IBM NASTAA02 14.01.2019 # Picking List
    //   # Copied Report 5752 - Picking List and created layout according to Bahamas requirements
    // HEI.04 FDD-HB597 IBM BULIMC01 23/05/2919
    //   # Source tables changed into "Warehouse Shipment Header/Line"
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Picking List by Sales Order BA.rdl';

    CaptionML = ENU = 'Picking List',
                FRA = 'Liste des prélèvements';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Warehouse Activity Header"; "Warehouse Shipment Header")
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            //RequestFilterFields = "No.", "No. Printed Combined Pick";
            column(No_WhseActivHeader; "No.")
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = CONST(1));
                column(CompanyName; COMPANYNAME)
                {
                }
                column(TodayFormatted; FORMAT(TODAY, 0, 4))
                {
                }
                column(Time; TIME)
                {
                }
                column(PickFilter; PickFilter)
                {
                }
                column(DirectedPutAwayAndPick; Location."Directed Put-away and Pick")
                {
                }
                column(BinMandatory; Location."Bin Mandatory")
                {
                }
                column(InvtPick; InvtPick)
                {
                }
                column(SumUpLines; SumUpLines)
                {
                }
                column(No_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("No."))
                {
                }
                column(WhseActivHeaderCaption; "Warehouse Activity Header".TABLECAPTION)
                {
                }
                column(LoctnCode_WhseActivHeader; "Warehouse Activity Header"."Location Code")
                {
                }
                column(SortingMtd_WhseActivHeader; "Warehouse Activity Header"."Sorting Method")
                {
                }
                column(AssgUserID_WhseActivHeader; "Warehouse Activity Header"."Assigned User ID")
                {
                }
                column(SourcDocument_WhseActLine; "Warehouse Activity Line"."Source Document")
                {
                }
                column(LoctnCode_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("Location Code"))
                {
                }
                column(SortingMtd_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("Sorting Method"))
                {
                }
                column(AssgUserID_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("Assigned User ID"))
                {
                }
                column(SourcDocument_WhseActLineCaption; "Warehouse Activity Line".FIELDCAPTION("Source Document"))
                {
                }
                column(SourceNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Source No."))
                {
                }
                column(ShelfNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Shelf No."))
                {
                }
                column(VariantCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Variant Code"))
                {
                }
                column(Description_WhseActLineCaption; WhseActLine.FIELDCAPTION(Description))
                {
                }
                column(ItemNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Item No."))
                {
                }
                column(UOMCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Unit of Measure Code"))
                {
                }
                column(QtytoHandle_WhseActLineCaption; "Warehouse Activity Line".FIELDCAPTION("Qty. to Ship"))
                {
                }
                column(QtyBase_WhseActLineCaption; "Warehouse Activity Line".FIELDCAPTION("Qty. to Ship (Base)"))
                {
                }
                column(DestinatnType_WhseActLineCaption; WhseActLine.FIELDCAPTION("Destination Type"))
                {
                }
                column(DestinationNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Destination No."))
                {
                }
                column(ZoneCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Zone Code"))
                {
                }
                column(BinCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Bin Code"))
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                column(PickingListCaption; PickingListCaptionLbl)
                {
                }
                column(WhseActLineDueDateCaption; WhseActLineDueDateCaptionLbl)
                {
                }
                column(QtyHandledCaption; QtyHandledCaptionLbl)
                {
                }
                dataitem("Warehouse Activity Line"; "Warehouse Shipment Line")
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = sorting("No.", "Line No.");

                    trigger OnAfterGetRecord();
                    begin
                        if GetLotNo("Warehouse Activity Line") = 'REQUIRED' then
                            CurrReport.SKIP();

                        if SumUpLines //AND
                                      //("Warehouse Activity Header"."Sorting Method" <>
                                      //"Warehouse Activity Header"."Sorting Method"::Document)
                        then begin
                            if TmpWhseActLine."No." = '' then begin
                                TmpWhseActLine := "Warehouse Activity Line";
                                TmpWhseActLine.INSERT();
                                MARK(true);
                            end else begin
                                //  TmpWhseActLine.SETCURRENTKEY("Activity Type","No.","Bin Code","Breakbulk No.","Action Type");
                                // TmpWhseActLine.SETRANGE("Activity Type","Activity Type");
                                TmpWhseActLine.SETRANGE("No.", "No.");
                                TmpWhseActLine.SETRANGE("Source No.", "Source No."); //HEI.03
                                                                                     //TmpWhseActLine.SETRANGE("Source Line No.","Source Line No."); //HEI.03
                                                                                     //TmpWhseActLine.SETRANGE("Bin Code","Bin Code"); //HEI.03
                                TmpWhseActLine.SETRANGE("Item No.", "Item No."); //HEI.03
                                                                                 //TmpWhseActLine.SETRANGE("Action Type","Action Type"); //HEI.03
                                                                                 //TmpWhseActLine.SETRANGE("Variant Code","Variant Code"); //HEI.03
                                                                                 //TmpWhseActLine.SETRANGE("Unit of Measure Code","Unit of Measure Code"); //HEI.03
                                TmpWhseActLine.SETRANGE("Due Date", "Due Date");
                                /*  IF "Warehouse Activity Header"."Sorting Method" =
                                     "Warehouse Activity Header"."Sorting Method"::"Ship-To"
                                  THEN BEGIN
                                    TmpWhseActLine.SETRANGE("Destination Type","Destination Type");
                                    TmpWhseActLine.SETRANGE("Destination No.","Destination No.")
                                  end;*/
                                if TmpWhseActLine.FINDFIRST() then begin
                                    //IF TmpWhseActLine."Lot No." = "Lot No." THEN BEGIN
                                    TmpWhseActLine."Qty. to Ship (Base)" := TmpWhseActLine."Qty. to Ship (Base)" + "Qty. to Ship (Base)";
                                    TmpWhseActLine."Qty. to Ship" := TmpWhseActLine."Qty. to Ship" + "Qty. to Ship";

                                    //TmpWhseActLine."Source No." := ''; //HEI.03
                                    /* IF "Warehouse Activity Header"."Sorting Method" <>
                                        "Warehouse Activity Header"."Sorting Method"::"Ship-To"
                                     THEN BEGIN
                                       TmpWhseActLine."Destination Type" := TmpWhseActLine."Destination Type"::" ";
                                       TmpWhseActLine."Destination No." := '';
                                     end;
                                     TmpWhseActLine.MODIFY; */
                                    //end;
                                end else begin
                                    TmpWhseActLine := "Warehouse Activity Line";
                                    TmpWhseActLine.INSERT();
                                    MARK(true);
                                end;
                            end;
                        end else
                            MARK(true);

                    end;

                    trigger OnPostDataItem();
                    begin
                        MARKEDONLY(true);
                    end;

                    trigger OnPreDataItem();
                    begin
                        SETCURRENTKEY("Source No.", Description); //HEI.03

                        //TmpWhseActLine.SETRANGE("Activity Type","Warehouse Activity Header".Type); //HEI.04
                        TmpWhseActLine.SETRANGE("No.", "Warehouse Activity Header"."No.");
                        TmpWhseActLine.DELETEALL();
                        //<<HEI.04
                        /*IF BreakbulkFilter THEN
                          TmpWhseActLine.SETRANGE("Original Breakbulk",FALSE);
                        CLEAR(TmpWhseActLine);
                        */
                        //>>HEI.04

                    end;
                }
                dataitem(WhseActLine; "Warehouse Shipment Line")
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = sorting("No.", "Line No.");
                    column(WhseActLine_SourceLineNo; "Source Line No.")
                    {
                    }
                    column(TmpWhseActLineQtyToShip; TmpWhseActLine."Qty. to Ship")
                    {
                    }
                    column(SourceNo_WhseActLine; "Source No.")
                    {
                    }
                    column(FormatSourcDocument_WhseActLine; FORMAT("Source Document"))
                    {
                    }
                    column(ShelfNo_WhseActLine; "Shelf No.")
                    {
                    }
                    column(ItemNo_WhseActLine; "Item No.")
                    {
                    }
                    column(Description_WhseActLine; Description)
                    {
                    }
                    column(VariantCode_WhseActLine; "Variant Code")
                    {
                    }
                    column(UOMCode_WhseActLine; "Unit of Measure Code")
                    {
                    }
                    column(DueDate_WhseActLine; FORMAT("Due Date"))
                    {
                    }
                    column(QtytoShip_WhseActLine; WhseActLine."Qty. to Ship")
                    {
                    }
                    column(QtyToShipBase_WhseActLine; WhseActLine."Qty. to Ship (Base)")
                    {
                    }
                    column(QtyBase_WsheActLine; WhseActLine."Qty. (Base)")
                    {
                    }
                    column(QtyPerUnitOfMeasure; WhseActLine."Qty. per Unit of Measure")
                    {
                    }
                    column(DestinatnType_WhseActLine; "Destination Type")
                    {
                    }
                    column(DestinationNo_WhseActLine; "Destination No.")
                    {
                    }
                    column(Customer_Name; CustomerLocationName)
                    {
                    }
                    column(ZoneCode_WhseActLine; "Zone Code")
                    {
                    }
                    column(BinCode_WhseActLine; "Bin Code")
                    {
                    }
                    column(LineNo_WhseActLine; "Line No.")
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }
                    // BC Upgrade SHUKLP03 >> DrinkIT field Shortcut Unit of Measure1 Code is blocked
                    // column(TotalShortcutQtyUomValue1Caption;STRSUBSTNO(TotalUomLbl,WarehouseSetup."Shortcut Unit of Measure1 Code"))
                    // {
                    // }
                    // BC Upgrade SHUKLP03 >> DrinkIT field Shortcut Unit of Measure1 Code is blocked

                    column(TotalShortcutQtyUomValue1; TotalShortcutQtyUomValue[1])
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(TotalShortcutQtyUomValue2Caption; STRSUBSTNO(TotalUomLbl, WarehouseSetup."Short Unit of Meas2 Filt FND"))
                    {
                    }
                    column(TotalShortcutQtyUomValue2; TotalShortcutQtyUomValue[2])
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    // BC Upgrade SHUKLP03 >> DrinkIT field Shortcut Unit of Measure3 Code is blocked
                    // column(TotalShortcutQtyUomValue3Caption; STRSUBSTNO(TotalUomLbl, WarehouseSetup."Shortcut Unit of Measure3 Code"))
                    // {
                    // }
                    // BC Upgrade SHUKLP03 >> DrinkIT field Shortcut Unit of Measure3 Code is blocked

                    column(TotalShortcutQtyUomValue3; TotalShortcutQtyUomValue[3])
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(TotalShortcutQtyUomValue4Caption; STRSUBSTNO(TotalUomLbl, WarehouseSetup."Shortcut Unit of Meas4Code FND"))
                    {
                    }
                    column(TotalShortcutQtyUomValue4; TotalShortcutQtyUomValue[4])
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    dataitem(WhseActLine2; "Warehouse Shipment Line")
                    {
                        DataItemLink = "No." = FIELD("No."), "Source No." = FIELD("Source No."), "Item No." = FIELD("Item No."), "Due Date" = FIELD("Due Date");
                        DataItemLinkReference = WhseActLine;
                        DataItemTableView = sorting("No.", "Line No.");
                        column(LotNo_WhseActLine2; LotNo)
                        {
                        }
                        column(SerialNo_WhseActLine2; SerialNo)
                        {
                        }
                        column(QtyToShipBase_WhseActLine2; WhseActLine2."Qty. to Ship (Base)")
                        {
                        }
                        column(QtytoShip_WhseActLine2; WhseActLine2."Qty. to Ship")
                        {
                        }
                        column(QtyBase_WsheActLine2; WhseActLine2."Qty. (Base)")
                        {
                        }
                        column(LineNo_WhseActLine2; "Line No.")
                        {
                        }
                        column(UOMCode_WhseActLine2; "Unit of Measure Code")
                        {
                        }
                        dataitem(ResEntry; "Integer")
                        {
                            column(Temp_LotNo; TEMPResEntry."Lot No.")
                            {
                            }
                            column(Temp_SerialNo; TEMPResEntry."Serial No.")
                            {
                            }
                            column(Temp_QtytoShipBase; TEMPResEntry."Quantity (Base)")
                            {
                            }
                            column(Temp_QtytoHandle; TEMPResEntry."Qty. to Handle (Base)")
                            {
                            }
                            column(Temp_QtyToShip; TEMPResEntry.Quantity)
                            {
                            }

                            trigger OnAfterGetRecord();
                            var
                                SalesHeader: Record "Sales Header";
                                WarehouseShipmentLine: Record "Warehouse Shipment Line";
                            begin


                                //<<HEI.04
                                if Number = 1 then
                                    TEMPResEntry.FIND('-')
                                else
                                    TEMPResEntry.NEXT();
                                //>>HEI.04
                            end;

                            trigger OnPreDataItem();
                            begin
                                SETRANGE(Number, 1, TEMPResEntry.COUNT); //HEI.04
                            end;
                        }

                        trigger OnAfterGetRecord();
                        var
                            Location2: Record Location;
                            WarehouseActivityLine: Record "Warehouse Shipment Line";
                            SalesOrderNo: Code[20];
                            Qty2H: Decimal;
                            ShortcutQtyUomValue: array[4] of Decimal;
                        begin
                            //<<HEI.04
                            //Fix
                            Qty2H := 0;
                            //Fix
                            ReservationEntry.RESET();
                            ReservationEntry.SETRANGE("Source ID", "Source No.");
                            ReservationEntry.SETRANGE("Item No.", "Item No.");
                            ReservationEntry.SETRANGE("Location Code", "Warehouse Activity Header"."Location Code");
                            if ReservationEntry.findset() then begin //Fix (BEGIN)
                                repeat
                                    /*TEMPResEntry.INIT;
                                    TEMPResEntry."Entry No." := ReservationEntry."Entry No.";
                                    TEMPResEntry."Lot No." := ReservationEntry."Lot No.";
                                    TEMPResEntry."Serial No." := ReservationEntry."Serial No.";
                                    TEMPResEntry."Quantity (Base)" := ReservationEntry."Quantity (Base)";
                                    TEMPResEntry."Qty. to Handle (Base)" := ReservationEntry."Qty. to Handle (Base)";
                                    TEMPResEntry.Quantity :=ABS(ReservationEntry."Qty. to Handle (Base)")/ "Qty. per Unit of Measure";
                                    TEMPResEntry.INSERT;*/
                                    Qty2H += ReservationEntry."Qty. to Handle (Base)";
                                until ReservationEntry.NEXT() = 0;
                                //Fix
                                TEMPResEntry.INIT();
                                TEMPResEntry."Entry No." := ReservationEntry."Entry No.";
                                TEMPResEntry."Lot No." := ReservationEntry."Lot No.";
                                TEMPResEntry."Serial No." := ReservationEntry."Serial No.";
                                TEMPResEntry."Quantity (Base)" := ReservationEntry."Quantity (Base)";
                                TEMPResEntry."Qty. to Handle (Base)" := Qty2H;
                                TEMPResEntry.Quantity := ABS(Qty2H) / "Qty. per Unit of Measure";
                                TEMPResEntry.INSERT();
                            end;//Fix
                            //>>HEI.04

                        end;

                        trigger OnPostDataItem();
                        begin
                            TEMPResEntry.DELETEALL(); //HEI.04
                        end;
                    }

                    trigger OnAfterGetRecord();
                    var
                        Location2: Record Location;
                        SalesHeader: Record "Sales Header";
                        WarehouseActivityLine: Record "Warehouse Shipment Line";
                        SalesOrderNo: Code[20];
                        ShortcutQtyUomValue: array[4] of Decimal;
                    begin
                        if SumUpLines then begin
                            // TmpWhseActLine.GET("Activity Type","No.","Line No.");
                            "Qty. to Ship (Base)" := TmpWhseActLine."Qty. to Ship (Base)";
                            "Qty. to Ship" := TmpWhseActLine."Qty. to Ship";
                        end;

                        //HEI.03>>
                        WarehouseActivityLine.SETRANGE("No.", "No.");
                        //WarehouseActivityLine.SETRANGE("Source Document",WarehouseActivityLine."Source Document"::"Sales Order");
                        WarehouseActivityLine.SETRANGE("Source No.", "Source No.");
                        if WarehouseActivityLine.findset() then
                            repeat
                                if GetLotNo(WarehouseActivityLine) <> 'REQUIRED' then begin
                                    if SalesOrderNo <> WarehouseActivityLine."Source No." then
                                        CLEAR(TotalShortcutQtyUomValue);
                                    ShowShortcutUomValue2(ShortcutQtyUomValue, WarehouseActivityLine);
                                    TotalShortcutQtyUomValue[1] += ShortcutQtyUomValue[1];
                                    TotalShortcutQtyUomValue[2] += ShortcutQtyUomValue[2];
                                    TotalShortcutQtyUomValue[3] += ShortcutQtyUomValue[3];
                                    TotalShortcutQtyUomValue[4] += ShortcutQtyUomValue[4];
                                    SalesOrderNo := WarehouseActivityLine."Source No.";
                                end;
                            until WarehouseActivityLine.NEXT() = 0;

                        if "Destination Type" = "Destination Type"::Customer then
                            if Customer.GET("Destination No.") then
                                CustomerLocationName := Customer.Name;
                        if "Destination Type" = "Destination Type"::Location then
                            if Location2.GET("Destination No.") then
                                CustomerLocationName := Location2.Name;
                        //HEI.03<<
                    end;

                    trigger OnPreDataItem();
                    begin
                        CLEAR(TotalShortcutQtyUomValue); //HEI.03

                        COPY("Warehouse Activity Line");
                        Counter := COUNT;
                        if Counter = 0 then
                            CurrReport.BREAK();

                        /*IF BreakbulkFilter THEN
                          SETRANGE("Original Breakbulk",FALSE);*/

                    end;
                }
            }

            trigger OnAfterGetRecord();
            begin
                GetLocation("Location Code");
                //InvtPick := Type = Type::"Invt. Pick"; //HEI.04
                /*
                IF NOT CurrReport.PREVIEW THEN
                  CODEUNIT.RUN(CODEUNIT::"Whse.-Printed","Warehouse Activity Header");
                */ //

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
        ShipToCustomerNoLbl = 'Ship-to Customer / Location No.'; ShipToCustomerNameLbl = 'Ship-to Customer / Location Name'; SalesOrderNoLbl = 'Sales Order No.'; LotNo = 'Lot No.'; SerialNo = 'Serial No.';
    }

    trigger OnPreReport();
    begin
        PickFilter := "Warehouse Activity Header".GETFILTERS;
        SumUpLines := true; //HEI.03
    end;

    var
        Customer: Record Customer;
        Location: Record Location;
        ReservationEntry: Record "Reservation Entry";
        TEMPResEntry: Record "Reservation Entry" temporary;
        WarehouseSetup: Record "Warehouse Setup";
        TmpWhseActLine: Record "Warehouse Shipment Line" temporary;
        WarehouseActivityLine_UoM2: Record "Warehouse Shipment Line";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        BreakbulkFilter: Boolean;
        HideOptions: Boolean;
        InvtPick: Boolean;
        SumUpLines: Boolean;

        SumUpLinesEditable: Boolean;
        LotNo: Code[20];
        SerialNo: Code[20];
        TotalShortcutQtyUomValue: array[4] of Decimal;
        Counter: Integer;
        QtyToShip: Integer;
        PickFilter: Text;
        CustomerLocationName: Text[60];
        CurrReportPageNoCaptionLbl: TextConst ENU = 'Page', FRA = 'Page';
        EmptyStringCaptionLbl: TextConst ENU = '__________', FRA = '____________';
        PickingListCaptionLbl: TextConst ENU = 'Picking List', FRA = 'Liste des prélèvements';
        QtyHandledCaptionLbl: TextConst ENU = 'Qty. Handled', FRA = 'Quantité traitée';
        TotalUomLbl: TextConst ENU = 'Total %1', FRA = 'Total %1';
        WhseActLineDueDateCaptionLbl: TextConst ENU = 'Due Date', FRA = 'Date d''échéance';

    local procedure GetLocation(LocationCode: Code[10]);
    begin
        if LocationCode = '' then
            Location.INIT()
        else
            if Location.Code <> LocationCode then
                Location.GET(LocationCode);
    end;

    local procedure ShowShortcutUomValue2(var ShortcutQtyUomValue: array[4] of Decimal; WarehouseActivityLine: Record "Warehouse Shipment Line");
    var
        WarehouseActivityLine_UoM1: Record "Warehouse Shipment Line";
        WarehouseActivityLine_UoM2: Record "Warehouse Shipment Line";
        WarehouseActivityLine_UoM3: Record "Warehouse Shipment Line";
        WarehouseActivityLine_UoM4: Record "Warehouse Shipment Line";
    begin
        //HEI.03>>
        CLEAR(ShortcutQtyUomValue);
        WarehouseSetup.GET();

        WarehouseActivityLine_UoM1.SETRANGE("No.", WarehouseActivityLine."No.");
        WarehouseActivityLine_UoM1.SETRANGE("Line No.", WarehouseActivityLine."Line No.");
        //WarehouseActivityLine_UoM1.SETRANGE("Action Type",WarehouseActivityLine_UoM1."Action Type"::Take);
        //WarehouseActivityLine_UoM1.SETRANGE("Unit of Measure Code", WarehouseSetup."Shortcut Unit of Measure1 Code"); // BC Upgrade SHUKLP03 >> DrinkIT field Shortcut Unit of Measure1 Code is blocked

        if WarehouseActivityLine_UoM1.FINDFIRST() then
            ShortcutQtyUomValue[1] := WarehouseActivityLine_UoM1."Qty. to Ship";


        WarehouseActivityLine_UoM2.SETRANGE("No.", WarehouseActivityLine."No.");
        WarehouseActivityLine_UoM2.SETRANGE("Line No.", WarehouseActivityLine."Line No.");
        //WarehouseActivityLine_UoM2.SETRANGE("Action Type",WarehouseActivityLine_UoM2."Action Type"::Take);
        WarehouseActivityLine_UoM2.SETFILTER("Unit of Measure Code", WarehouseSetup."Short Unit of Meas2 Filt FND");
        if WarehouseActivityLine_UoM2.FINDFIRST() and (WarehouseSetup."Short Unit of Meas2 Filt FND" <> '') then
            ShortcutQtyUomValue[2] := WarehouseActivityLine_UoM2."Qty. to Ship";

        WarehouseActivityLine_UoM3.SETRANGE("No.", WarehouseActivityLine."No.");
        WarehouseActivityLine_UoM3.SETRANGE("Line No.", WarehouseActivityLine."Line No.");
        //WarehouseActivityLine_UoM3.SETRANGE("Action Type",WarehouseActivityLine_UoM3."Action Type"::Take);
        //WarehouseActivityLine_UoM3.SETRANGE("Unit of Measure Code", WarehouseSetup."Shortcut Unit of Measure3 Code"); // BC Upgrade SHUKLP03 >> DrinkIT field Shortcut Unit of Measure3 Code is blocked
        if WarehouseActivityLine_UoM3.FINDFIRST() then
            ShortcutQtyUomValue[3] := WarehouseActivityLine_UoM3."Qty. to Ship";

        WarehouseActivityLine_UoM4.SETRANGE("No.", WarehouseActivityLine."No.");
        WarehouseActivityLine_UoM4.SETRANGE("Line No.", WarehouseActivityLine."Line No.");
        //WarehouseActivityLine_UoM4.SETRANGE("Action Type",WarehouseActivityLine_UoM4."Action Type"::Take);
        WarehouseActivityLine_UoM4.SETRANGE("Unit of Measure Code", WarehouseSetup."Shortcut Unit of Meas4Code FND");
        if WarehouseActivityLine_UoM4.FINDFIRST() then
            ShortcutQtyUomValue[4] := WarehouseActivityLine_UoM4."Qty. to Ship";
        //HEI.03<<
    end;

    local procedure GetLotNo(WarehouseShipmentLine: Record "Warehouse Shipment Line"): Code[20];
    var
        //QualityManagement: Codeunit "Quality Management";
        TransferLine: Record "Transfer Line";
        Direction: Option Outbound,Inbound;
    begin
        // BC Upgrade SHUKLP03 << code is blocked because DrinkIT Codeunit "Quality Management" is Used.
        // case WarehouseShipmentLine."Source Type" of
        //     DATABASE::"Purchase Line":
        //         begin
        //             LotNo :=
        //               QualityManagement.GetWhseLotNo(
        //                 DATABASE::"Purchase Line", WarehouseShipmentLine."Source Subtype", WarehouseShipmentLine."Source No.", '', 0, WarehouseShipmentLine."Source Line No.", WarehouseShipmentLine."Item No.", WarehouseShipmentLine.Quantity < 0);
        //         end;
        //     DATABASE::"Sales Line":
        //         begin
        //             LotNo :=
        //               QualityManagement.GetWhseLotNo(
        //                 DATABASE::"Sales Line", WarehouseShipmentLine."Source Subtype", WarehouseShipmentLine."Source No.", '', 0, WarehouseShipmentLine."Source Line No.", WarehouseShipmentLine."Item No.", WarehouseShipmentLine.Quantity < 0);
        //         end;
        //     DATABASE::"Transfer Line":
        //         begin
        //             Direction := Direction::Outbound;
        //             if TransferLine.GET(WarehouseShipmentLine."Source No.", WarehouseShipmentLine."Source Line No.") then
        //                 LotNo :=
        //                   QualityManagement.GetWhseLotNo(DATABASE::"Transfer Line",
        //                     Direction, WarehouseShipmentLine."Source No.", '', TransferLine."Derived From Line No.", WarehouseShipmentLine."Source Line No.", WarehouseShipmentLine."Item No.", WarehouseShipmentLine.Quantity < 0);
        //         end
        // end;

        // exit(LotNo);
        // BC Upgrade SHUKLP03 << code is blocked because DrinkIT Codeunit "Quality Management" is Used.
    end;
}

