report 54030 "Picking List by Lot STD"
{
    // HEI.01 FDD-PA-LOGGAP09 - Picking List v1.0 26.04.2018 IBM.NAIKH01
    //   # Created a new report 50127 - Picking List by Lot No.
    // 
    // HEI.02 IBM.NAIKH01 02.05.2018
    //   # Changes the Action type to "Take"
    // BC Upgrade BHARDA11 >>
    // 1. OLD Report ID - 50256.
    // 2. Add layout path and change layout extension RDLC to RDL.
    // 3. Add ApplicationArea property in Report and requestpage fields.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Picking List by Lot STD.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.

    CaptionML = ENU = 'Picking List by Lot STD',
                FRA = 'Liste des prélèvements STD';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Warehouse Activity Header"; "Warehouse Activity Header")
        {
            DataItemTableView = SORTING(Type, "No.") WHERE(Type = FILTER(Pick | "Invt. Pick"));
            RequestFilterFields = "No.", "No. Printed";
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(No_WhseActivHeader; "No.")
            {
            }
            column(ByTotals; ByTotals)
            {
            }
            column(PrintLogo; PrintLogo)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
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
                column(ShowLotSN; ShowLotSN)
                {
                }
                column(SumUpLines; SumUpLines)
                {
                }
                column(No_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("No."))
                {
                }
                column(WhseActivHeaderCaption; "Warehouse Activity Header".TABLECAPTION + ': ' + PickFilter)
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
                column(QtytoHandle_WhseActLineCaption; WhseActLine.FIELDCAPTION("Qty. to Handle"))
                {
                }
                column(QtyBase_WhseActLineCaption; WhseActLine.FIELDCAPTION("Qty. (Base)"))
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
                column(ActionType_WhseActLineCaption; WhseActLine.FIELDCAPTION("Action Type"))
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
                dataitem("Warehouse Activity Line"; "Warehouse Activity Line")
                {
                    DataItemLink = "Activity Type" = FIELD(Type), "No." = FIELD("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = SORTING("Activity Type", "No.", "Sorting Sequence No.") WHERE("Action Type" = FILTER(Take));

                    trigger OnAfterGetRecord();
                    begin
                        if SumUpLines and
                           ("Warehouse Activity Header"."Sorting Method" <>
                            "Warehouse Activity Header"."Sorting Method"::Document)
                        then begin
                            if TmpWhseActLine."No." = '' then begin
                                TmpWhseActLine := "Warehouse Activity Line";
                                TmpWhseActLine.INSERT;
                                MARK(true);
                            end else begin
                                TmpWhseActLine.SETCURRENTKEY("Activity Type", "No.", "Bin Code", "Breakbulk No.", "Action Type");
                                TmpWhseActLine.SETRANGE("Activity Type", "Activity Type");
                                TmpWhseActLine.SETRANGE("No.", "No.");
                                TmpWhseActLine.SETRANGE("Bin Code", "Bin Code");
                                TmpWhseActLine.SETRANGE("Item No.", "Item No.");
                                TmpWhseActLine.SETRANGE("Action Type", "Action Type");
                                TmpWhseActLine.SETRANGE("Variant Code", "Variant Code");
                                TmpWhseActLine.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                                TmpWhseActLine.SETRANGE("Due Date", "Due Date");
                                if "Warehouse Activity Header"."Sorting Method" =
                                   "Warehouse Activity Header"."Sorting Method"::"Ship-To"
                                then begin
                                    TmpWhseActLine.SETRANGE("Destination Type", "Destination Type");
                                    TmpWhseActLine.SETRANGE("Destination No.", "Destination No.")
                                end;
                                if TmpWhseActLine.FINDFIRST then begin
                                    TmpWhseActLine."Qty. (Base)" := TmpWhseActLine."Qty. (Base)" + "Qty. (Base)";
                                    TmpWhseActLine."Qty. to Handle" := TmpWhseActLine."Qty. to Handle" + "Qty. to Handle";
                                    TmpWhseActLine."Source No." := '';
                                    if "Warehouse Activity Header"."Sorting Method" <>
                                       "Warehouse Activity Header"."Sorting Method"::"Ship-To"
                                    then begin
                                        TmpWhseActLine."Destination Type" := TmpWhseActLine."Destination Type"::" ";
                                        TmpWhseActLine."Destination No." := '';
                                    end;
                                    TmpWhseActLine.MODIFY;
                                end else begin
                                    TmpWhseActLine := "Warehouse Activity Line";
                                    TmpWhseActLine.INSERT;
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
                        TmpWhseActLine.SETRANGE("Activity Type", "Warehouse Activity Header".Type);
                        TmpWhseActLine.SETRANGE("No.", "Warehouse Activity Header"."No.");
                        TmpWhseActLine.DELETEALL;
                        if BreakbulkFilter then
                            TmpWhseActLine.SETRANGE("Original Breakbulk", false);
                        CLEAR(TmpWhseActLine);
                    end;
                }
                dataitem(WhseActLine; "Warehouse Activity Line")
                {
                    DataItemLink = "Activity Type" = FIELD(Type), "No." = FIELD("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = SORTING("Activity Type", "No.", "Sorting Sequence No.") WHERE("Action Type" = FILTER(Take));
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
                    column(QtytoHandle_WhseActLine; "Qty. to Handle")
                    {
                    }
                    column(QtyBase_WhseActLine; "Qty. (Base)")
                    {
                    }
                    column(DestinatnType_WhseActLine; "Destination Type")
                    {
                    }
                    column(DestinationNo_WhseActLine; "Destination No.")
                    {
                    }
                    column(ZoneCode_WhseActLine; WarehouseShipmentLine."Zone Code")
                    {
                    }
                    column(BinCode_WhseActLine; "Bin Code")
                    {
                    }
                    column(ActionType_WhseActLine; "Action Type")
                    {
                    }
                    column(LotNo_WhseActLine; "Lot No.")
                    {
                    }
                    column(SerialNo_WhseActLine; "Serial No.")
                    {
                    }
                    column(LotNo_WhseActLineCaption; FIELDCAPTION("Lot No."))
                    {
                    }
                    column(SerialNo_WhseActLineCaption; FIELDCAPTION("Serial No."))
                    {
                    }
                    column(LineNo_WhseActLine; "Line No.")
                    {
                    }
                    column(BinRanking_WhseActLine; "Bin Ranking")
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }
                    column(ShipToName; SH."Ship-to Name")
                    {
                    }
                    column(ShipToCode; SH."Sell-to Customer No.")
                    {
                    }
                    column(TransferToCode; TH."Transfer-to Code")
                    {
                    }
                    column(TransferToName; TH."Transfer-to Name")
                    {
                    }
                    column(TempUnitOfMeasure2_UOM; TempUnitOfMeasure."Currency Code")
                    {
                    }
                    column(TempUnitOfMeasure2_Quantity; TempUnitOfMeasure."Column 1 Amt.")
                    {
                    }

                    trigger OnAfterGetRecord();
                    var
                        OLDSourceNo: Code[20];
                    begin
                        if SumUpLines then begin
                            TmpWhseActLine.GET("Activity Type", "No.", "Line No.");
                            "Qty. (Base)" := TmpWhseActLine."Qty. (Base)";
                            "Qty. to Handle" := TmpWhseActLine."Qty. to Handle";
                        end;

                        if WarehouseShipmentLine.GET(WhseActLine."Whse. Document No.", WhseActLine."Whse. Document Line No.") then;
                        //MESSAGE('Count %1',WhseActLine.COUNT);

                        //Total by UOM>>
                        if not ByTotals and (OLDSourceNo <> WhseActLine."Source No.") then begin
                            TempUnitOfMeasure.DELETEALL;
                            OLDSourceNo := WhseActLine."Source No.";
                        end;

                        TempUnitOfMeasure.RESET;
                        if TempUnitOfMeasure.GET("Unit of Measure Code") then begin
                            TempUnitOfMeasure."Column 1 Amt." += Quantity;
                            TempUnitOfMeasure.MODIFY;
                        end else begin
                            TempUnitOfMeasure.INIT;
                            TempUnitOfMeasure."Currency Code" := "Unit of Measure Code";
                            TempUnitOfMeasure."Column 1 Amt." := Quantity;
                            TempUnitOfMeasure.INSERT;
                        end;
                        //Total by UOM<<

                        case WhseActLine."Source Document" of
                            WhseActLine."Source Document"::"Sales Order":
                                begin
                                    SH.RESET;
                                    if SH.GET(SH."Document Type"::Order, WhseActLine."Source No.") then;
                                end;
                            WhseActLine."Source Document"::"Inbound Transfer", WhseActLine."Source Document"::"Outbound Transfer":
                                begin
                                    TH.RESET;
                                    if TH.GET(WhseActLine."Source No.") then;
                                end;
                        end;
                    end;

                    trigger OnPreDataItem();
                    begin
                        COPY("Warehouse Activity Line");
                        Counter := COUNT;
                        if Counter = 0 then
                            CurrReport.BREAK;

                        if BreakbulkFilter then
                            SETRANGE("Original Breakbulk", false);
                    end;
                }
                dataitem(UnitOfMeasuretotal; "Integer")
                {
                    column(TempUnitOfMeasure_UOM; TempUnitOfMeasure."Currency Code")
                    {
                    }
                    column(TempUnitOfMeasure_Quantity; TempUnitOfMeasure."Column 1 Amt.")
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        if Number = 1 then begin
                            if not TempUnitOfMeasure.FIND('-') then
                                CurrReport.BREAK;
                        end else
                            if TempUnitOfMeasure.NEXT = 0 then
                                CurrReport.BREAK;
                    end;

                    trigger OnPostDataItem();
                    begin
                        TempUnitOfMeasure.DELETEALL;
                    end;

                    trigger OnPreDataItem();
                    begin
                        TempUnitOfMeasure.RESET;
                        SETRANGE(Number, 1, TempUnitOfMeasure.COUNT);
                    end;
                }
            }

            trigger OnAfterGetRecord();
            begin
                GetLocation("Location Code");
                InvtPick := Type = Type::"Invt. Pick";

                if not CurrReport.PREVIEW then
                    CODEUNIT.RUN(CODEUNIT::"Whse.-Printed", "Warehouse Activity Header");
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
                group(Filters)
                {
                    Caption = 'Filters';
                    field(ByTotalsFilter; ByTotalsFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Print by';
                    }
                    field(PrintLogo; PrintLogo)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Logo';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            SumUpLinesEditable := true;
            BreakbulkEditable := true;
        end;

        trigger OnOpenPage();
        begin
            if HideOptions then begin
                BreakbulkEditable := false;
                SumUpLinesEditable := false;
            end;
        end;
    }

    labels
    {
        LotNoLbl = 'Lot/Serial Information'; label(UomLbl; ENU = 'Unit Of Measure',
                                                         FRA = 'Unité de mesure')
        TotalLbl = 'Total'; SONoLbl = 'Sales order No.'; TONoLbl = 'Transfer order No.'; ShipToCustLbl = 'Ship to Customer No.'; ShipToNameLbl = 'Ship to Customer Name'; ShipToLocLbl = 'Ship to Location No.'; ShipToLocNameLbl = 'Ship to Location Name';
    }

    trigger OnPreReport();
    begin
        PickFilter := "Warehouse Activity Header".GETFILTERS;

        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);

        if ByTotalsFilter = ByTotalsFilter::Totals then
            ByTotals := true
        else
            ByTotals := false;
    end;

    var
        Location: Record Location;
        TmpWhseActLine: Record "Warehouse Activity Line" temporary;
        PickFilter: Text;
        BreakbulkFilter: Boolean;
        SumUpLines: Boolean;
        HideOptions: Boolean;
        InvtPick: Boolean;
        ShowLotSN: Boolean;
        Counter: Integer;
        BreakbulkEditable: Boolean;
        SumUpLinesEditable: Boolean;
        CurrReportPageNoCaptionLbl: TextConst ENU = 'Page', FRA = 'Page';
        PickingListCaptionLbl: TextConst ENU = 'Picking List by Lot', FRA = 'Liste des prélèvements';
        WhseActLineDueDateCaptionLbl: TextConst ENU = 'Due Date', FRA = 'Date d''échéance';
        QtyHandledCaptionLbl: TextConst ENU = 'Qty. Handled', FRA = 'Quantité traitée';
        EmptyStringCaptionLbl: TextConst ENU = '____________', FRA = '____________';
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        CompInfo: Record "Company Information";
        TempUnitOfMeasure: Record "Aging Band Buffer" temporary;
        ByTotals: Boolean;
        SH: Record "Sales Header";
        TH: Record "Transfer Header";
        ByTotalsFilter: Option Totals,"Sales Orders / Transfer Orders";
        PrintLogo: Boolean;

    local procedure GetLocation(LocationCode: Code[10]);
    begin
        if LocationCode = '' then
            Location.INIT
        else
            if Location.Code <> LocationCode then
                Location.GET(LocationCode);
    end;

    procedure SetBreakbulkFilter(BreakbulkFilter2: Boolean);
    begin
        BreakbulkFilter := BreakbulkFilter2;
    end;

    procedure SetInventory(SetHideOptions: Boolean);
    begin
        HideOptions := SetHideOptions;
    end;
}

