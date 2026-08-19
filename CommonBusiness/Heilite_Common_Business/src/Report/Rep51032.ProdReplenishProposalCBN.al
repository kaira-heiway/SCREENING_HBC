report 51032 "Prod Replenish Proposal CBN"
{
    // version HEI.01

    // HEI.01 RFC-CHG0261845 IBM.SS 14.01.2019
    //   # Code Added as per requirement.
    // HEI.02 RFC-CHG0261845 IBM.LS 24.01.2019
    //   # Code Added for applying new Filters and for calculating new fields.

    //Bc Upgrade YADAVM09 Drink it field code commented.
    //Bc Upgrade YadavM09 Option caption property is commented for boolean field.
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Prod. Replenishment Proposal.rdl';
    UsageCategory = ReportsAndAnalysis; //BC Upgrade Kamnay01
    CaptionML = ENU = 'Production Replenishment Proposal',
                FRA = 'Disponibilité planning';
    ApplicationArea = All;

    dataset
    {
        dataitem("Item Buffer FND"; "Item Buffer FND")
        {
            DataItemTableView = sorting("Item No.") ORDER(Ascending) where("Active Component" = CONST(true));
            PrintOnlyIfDetail = true;
            column(DateFilter_Cp; Text001)
            {
            }
            column(LocationFilter_Cp; Text002)
            {
            }
            column(ZoneFilter_Cp; Text003)
            {
            }
            column(BinFilter_Cp; Text004)
            {
            }
            column(StatusFilter_Cp; Text005)
            {
            }
            column(ReplenishmentSystem_Cp; Text008)
            {
            }
            column(Detailed_Cp; Text011)
            {
            }
            column(ShortageOnly_Cp; Text012)
            {
            }
            column(DateFilter; DateFilter)
            {
            }
            column(LocationFilter; LocationFilter)
            {
            }
            column(ZoneFilter; ZoneFilter)
            {
            }
            column(BinFilter; BinFilter)
            {
            }
            column(StatusFilter; FORMAT(StatusFilter))
            {
            }
            column(ReplenishmentSystem; ReplenishmentSystem)
            {
            }
            column(Detailed; Selection)
            {
            }
            column(ShortageOnly; ShortageOnly)
            {
            }
            dataitem("Production Forecast Entry"; "Production Forecast Entry")
            {
                DataItemLink = "Item No." = FIELD("Item No.");
                DataItemTableView = sorting("Production Forecast Name", "Item No.", "Component Forecast", "Forecast Date", "Location Code");

                trigger OnAfterGetRecord();
                begin
                    BufferCounter += 1;
                    TempForecastPlanningBuffer.SETRANGE("Item No.", "Item No.");
                    TempForecastPlanningBuffer.SETRANGE(Date, "Forecast Date");
                    //HEI.01>>
                    TempForecastPlanningBuffer.SETRANGE("Location Code FND", "Location Code");
                    //HEI.01<<
                    if "Component Forecast" then
                        TempForecastPlanningBuffer.SETRANGE("Document Type", TempForecastPlanningBuffer."Document Type"::"Production Forecast-Component")
                    else
                        TempForecastPlanningBuffer.SETRANGE("Document Type", TempForecastPlanningBuffer."Document Type"::"Production Forecast-Sales");

                    if TempForecastPlanningBuffer.FINDFIRST() then begin
                        TempForecastPlanningBuffer."Gross Requirement" += "Forecast Quantity";
                        TempForecastPlanningBuffer.MODIFY();
                    end else
                        InsertNewForecast("Production Forecast Entry");
                end;

                trigger OnPreDataItem();
                var
                    InvSetup: Record "Inventory Setup";
                    MfgSetup: Record "Manufacturing Setup";
                begin
                    MfgSetup.GET();
                    SETRANGE("Production Forecast Name", MfgSetup."Current Production Forecast");
                    SETRANGE("Production Forecast Name", InvSetup."Current Demand Forecast"); //BC Upgrade Kamnay01

                    //HEI.02>>
                    SETRANGE("Forecast Date", StartDate, EndDate);
                    SETFILTER("Location Code", LocationFilter);
                    //HEI.02<<
                end;
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "No." = FIELD("Item No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.") where("Document Type" = CONST(Order), Type = CONST(Item));

                trigger OnAfterGetRecord();
                begin
                    if Selection then begin
                        NewRecordWithDetails("Shipment Date", "No.", Description);
                        PlanningBuffer."Document Type" := PlanningBuffer."Document Type"::"Sales Order";
                        PlanningBuffer."Document No." := "Document No.";
                        PlanningBuffer."Gross Requirement" := "Outstanding Qty. (Base)";
                        //HEI.01>>
                        PlanningBuffer."Location Code FND" := "Location Code";
                        PlanningBuffer."Bin Code FND" := "Bin Code";
                        //HEI.01<<
                        PlanningBuffer.INSERT();
                    end else begin
                        PlanningBuffer.SETRANGE("Item No.", "No.");
                        PlanningBuffer.SETRANGE(Date, "Shipment Date");
                        //HEI.01>>
                        PlanningBuffer.SETRANGE("Location Code FND", "Location Code");
                        PlanningBuffer.SETRANGE("Bin Code FND", "Bin Code");
                        //HEI.01<<
                        if PlanningBuffer.FIND('-') then begin
                            PlanningBuffer."Gross Requirement" := PlanningBuffer."Gross Requirement" + "Outstanding Qty. (Base)";
                            PlanningBuffer.MODIFY();
                        end else begin
                            NewRecordWithDetails("Shipment Date", "No.", Description);
                            PlanningBuffer."Gross Requirement" := "Outstanding Qty. (Base)";
                            //HEI.02>>
                            PlanningBuffer."Location Code FND" := "Location Code";
                            PlanningBuffer."Bin Code FND" := "Bin Code";
                            //HEI.02<<
                            PlanningBuffer.INSERT();
                        end;
                    end;
                    ModifyForecast("No.", "Shipment Date", PlanningBuffer."Document Type"::"Production Forecast-Sales", "Outstanding Qty. (Base)");
                end;

                trigger OnPreDataItem();
                begin
                    //PlanningBuffer.DELETEALL;
                    //HEI.02>>
                    SETRANGE("Shipment Date", StartDate, EndDate);
                    SETFILTER("Location Code", LocationFilter);
                    SETFILTER("Bin Code", BinFilter);
                    //HEI.02<<
                end;
            }
            dataitem("Service Line"; "Service Line")
            {
                DataItemLink = "No." = FIELD("Item No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.") where("Document Type" = CONST(Order), Type = CONST(Item));

                trigger OnAfterGetRecord();
                begin
                    if Selection then begin
                        NewRecordWithDetails("Needed by Date", "No.", Description);
                        PlanningBuffer."Document Type" := PlanningBuffer."Document Type"::"Service Order";
                        PlanningBuffer."Document No." := "Document No.";
                        PlanningBuffer."Gross Requirement" := "Outstanding Qty. (Base)";
                        //HEI.01>>
                        PlanningBuffer."Location Code FND" := "Location Code";
                        PlanningBuffer."Bin Code FND" := "Bin Code";
                        //HEI.01<<
                        PlanningBuffer.INSERT();
                    end else begin
                        PlanningBuffer.SETRANGE("Item No.", "No.");
                        PlanningBuffer.SETRANGE(Date, "Needed by Date");
                        //HEI.01>>
                        PlanningBuffer.SETRANGE("Location Code FND", "Location Code");
                        PlanningBuffer.SETRANGE("Bin Code FND", "Bin Code");
                        //HEI.01<<
                        if PlanningBuffer.FIND('-') then begin
                            PlanningBuffer."Gross Requirement" := PlanningBuffer."Gross Requirement" + "Outstanding Qty. (Base)";
                            PlanningBuffer.MODIFY();
                        end else begin
                            NewRecordWithDetails("Posting Date", "No.", Description);
                            PlanningBuffer."Gross Requirement" := "Outstanding Qty. (Base)";
                            //HEI.02>>
                            PlanningBuffer."Location Code FND" := "Location Code";
                            PlanningBuffer."Bin Code FND" := "Bin Code";
                            //HEI.02<<
                            PlanningBuffer.INSERT();
                        end;
                    end;
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02>>
                    SETRANGE("Needed by Date", StartDate, EndDate);
                    SETFILTER("Location Code", LocationFilter);
                    SETFILTER("Bin Code", BinFilter);
                    //HEI.02<<
                end;
            }
            dataitem("Job Planning Line"; "Job Planning Line")
            {
                DataItemLink = "No." = FIELD("Item No.");
                DataItemTableView = sorting("Job No.", "Job Task No.", "Line No.") where(Status = CONST(Order), Type = CONST(Item));

                trigger OnAfterGetRecord();
                begin
                    if Selection then begin
                        NewRecordWithDetails("Planning Date", "No.", Description);
                        PlanningBuffer."Document Type" := PlanningBuffer."Document Type"::"Job Order";
                        PlanningBuffer."Document No." := "Job No.";
                        PlanningBuffer."Gross Requirement" := "Remaining Qty. (Base)";
                        //HEI.01>>
                        PlanningBuffer."Location Code FND" := "Location Code";
                        PlanningBuffer."Bin Code FND" := "Bin Code";
                        //HEI.01<<
                        PlanningBuffer.INSERT();
                    end else begin
                        PlanningBuffer.SETRANGE("Item No.", "No.");
                        PlanningBuffer.SETRANGE(Date, "Planning Date");
                        //HEI.01>>
                        PlanningBuffer.SETRANGE("Location Code FND", "Location Code");
                        PlanningBuffer.SETRANGE("Bin Code FND", "Bin Code");
                        //HEI.01<<
                        if PlanningBuffer.FIND('-') then begin
                            PlanningBuffer."Gross Requirement" := PlanningBuffer."Gross Requirement" + "Remaining Qty. (Base)";
                            PlanningBuffer.MODIFY();
                        end else begin
                            NewRecordWithDetails("Planning Date", "No.", Description);
                            PlanningBuffer."Gross Requirement" := "Remaining Qty. (Base)";
                            //HEI.02>>
                            PlanningBuffer."Location Code FND" := "Location Code";
                            PlanningBuffer."Bin Code FND" := "Bin Code";
                            //HEI.02<<
                            PlanningBuffer.INSERT();
                        end;
                    end;
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02>>
                    SETRANGE("Planning Date", StartDate, EndDate);
                    SETFILTER("Location Code", LocationFilter);
                    SETFILTER("Bin Code", BinFilter);
                    //HEI.02<<
                end;
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "No." = FIELD("Item No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.") where("Document Type" = CONST(Order), Type = CONST(Item));

                trigger OnAfterGetRecord();
                begin
                    ReqLine2.SETRANGE("Ref. Order No.", "Document No.");
                    ReqLine2.SETRANGE("Ref. Line No.", "Line No.");
                    if ReqLine2.FINDFIRST() then
                        CurrReport.SKIP();

                    if Selection then begin
                        NewRecordWithDetails("Expected Receipt Date", "No.", Description);
                        PlanningBuffer."Document Type" := PlanningBuffer."Document Type"::"Purchase Order";
                        PlanningBuffer."Document No." := "Document No.";
                        PlanningBuffer."Scheduled Receipts" := "Outstanding Qty. (Base)";
                        //HEI.01>>
                        PlanningBuffer."Location Code FND" := "Location Code";
                        PlanningBuffer."Zone Code FND" := "Zone Code FND";
                        PlanningBuffer."Bin Code FND" := "Bin Code";
                        //HEI.01<<
                        PlanningBuffer.INSERT();
                    end else begin
                        PlanningBuffer.SETRANGE("Item No.", "No.");
                        PlanningBuffer.SETRANGE(Date, "Expected Receipt Date");
                        //HEI.01>>
                        PlanningBuffer.SETRANGE("Location Code FND", "Location Code");
                        PlanningBuffer.SETRANGE("Zone Code FND", "Zone Code FND");
                        PlanningBuffer.SETRANGE("Bin Code FND", "Bin Code");
                        //HEI.01<<
                        if PlanningBuffer.FIND('-') then begin
                            PlanningBuffer."Scheduled Receipts" := PlanningBuffer."Scheduled Receipts" + "Outstanding Qty. (Base)";
                            PlanningBuffer.MODIFY();
                        end else begin
                            NewRecordWithDetails("Expected Receipt Date", "No.", Description);
                            PlanningBuffer."Scheduled Receipts" := "Outstanding Qty. (Base)";
                            //HEI.02>>
                            PlanningBuffer."Location Code FND" := "Location Code";
                            PlanningBuffer."Zone Code FND" := "Zone Code FND";
                            PlanningBuffer."Bin Code FND" := "Bin Code";
                            //HEI.02<<
                            PlanningBuffer.INSERT();
                        end;
                    end;
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02>>
                    SETRANGE("Expected Receipt Date", StartDate, EndDate);
                    SETFILTER("Location Code", LocationFilter);
                    SETFILTER("Zone Code FND", ZoneFilter);
                    SETFILTER("Bin Code", BinFilter);
                    //HEI.02<<
                    ReqLine2.RESET();
                    ReqLine2.SETCURRENTKEY("Ref. Order Type", "Ref. Order Status", "Ref. Order No.", "Ref. Line No.");
                    ReqLine2.SETRANGE("Ref. Order Type", ReqLine2."Ref. Order Type"::Purchase);
                end;
            }
            dataitem(TransferLine_Shipment; "Transfer Line")
            {
                DataItemLink = "Item No." = FIELD("Item No.");
                DataItemTableView = sorting("Transfer-from Code", Status, "Derived From Line No.", "Item No.", "Variant Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Shipment Date", "In-Transit Code");

                trigger OnAfterGetRecord();
                begin
                    if Selection then begin
                        NewRecordWithDetails("Shipment Date", "Item No.", Description);
                        PlanningBuffer."Document Type" := PlanningBuffer."Document Type"::Transfer;
                        PlanningBuffer."Document No." := "Document No.";
                        PlanningBuffer."Gross Requirement" := "Outstanding Qty. (Base)";
                        //HEI.02>>
                        PlanningBuffer."Location Code FND" := "Transfer-from Code";
                        PlanningBuffer."Bin Code FND" := "Transfer-from Bin Code";
                        //HEI.02<<
                        PlanningBuffer.INSERT();
                    end else begin
                        PlanningBuffer.SETRANGE("Item No.", "Item No.");
                        PlanningBuffer.SETRANGE(Date, "Shipment Date");
                        //HEI.02>>
                        PlanningBuffer.SETRANGE("Location Code FND", "Transfer-from Code");
                        PlanningBuffer.SETRANGE("Bin Code FND", "Transfer-from Bin Code");
                        //HEI.02<<
                        if PlanningBuffer.FIND('-') then begin
                            PlanningBuffer."Gross Requirement" := PlanningBuffer."Gross Requirement" + "Outstanding Qty. (Base)";
                            PlanningBuffer.MODIFY();
                        end else begin
                            NewRecordWithDetails("Shipment Date", "Item No.", Description);
                            PlanningBuffer."Gross Requirement" := "Outstanding Qty. (Base)";
                            //HEI.02>>
                            PlanningBuffer."Location Code FND" := "Transfer-from Code";
                            PlanningBuffer."Bin Code FND" := "Transfer-from Bin Code";
                            //HEI.02<<
                            PlanningBuffer.INSERT();
                        end;
                    end;
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Derived From Line No.", 0);
                    //HEI.02>>
                    SETRANGE("Shipment Date", StartDate, EndDate);
                    SETFILTER("Transfer-from Code", LocationFilter);
                    SETFILTER("Transfer-from Bin Code", BinFilter);
                    //HEI.02<<
                end;
            }
            dataitem(TransferLine_Receipt; "Transfer Line")
            {
                DataItemLink = "Item No." = FIELD("Item No.");
                //DataItemTableView = sorting("Transfer-to Code",Status,"Derived From Line No.","Item No.","Variant Code","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code","Receipt Date","In-Transit Code","Item Charge No.","Is Item Charge");//Bc Upgrade YADAVM09 Drink it Field Dependency
                DataItemTableView = sorting("Transfer-to Code", Status, "Derived From Line No.", "Item No.", "Variant Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Receipt Date", "In-Transit Code");//Bc Upgrade Kamnay01 Drink it Field Dependency so i removed that field from sorting as it is not required.

                trigger OnAfterGetRecord();
                begin
                    //HEI.02>>
                    if Selection then begin
                        NewRecordWithDetails("Receipt Date", "Item No.", Description);
                        PlanningBuffer."Document Type" := PlanningBuffer."Document Type"::Transfer;
                        PlanningBuffer."Document No." := "Document No.";
                        PlanningBuffer."Scheduled Receipts" := "Outstanding Qty. (Base)" + "Qty. in Transit (Base)";
                        PlanningBuffer."Location Code FND" := "Transfer-to Code";
                        PlanningBuffer."Bin Code FND" := "Transfer-To Bin Code";
                        PlanningBuffer.INSERT();
                    end else begin
                        PlanningBuffer.SETRANGE("Item No.", "Item No.");
                        PlanningBuffer.SETRANGE(Date, "Receipt Date");
                        PlanningBuffer.SETRANGE("Location Code FND", "Transfer-to Code");
                        PlanningBuffer.SETRANGE("Bin Code FND", "Transfer-To Bin Code");
                        if PlanningBuffer.FIND('-') then begin
                            PlanningBuffer."Scheduled Receipts" :=
                              PlanningBuffer."Scheduled Receipts" +
                              "Outstanding Qty. (Base)" +
                              "Qty. in Transit (Base)";
                            PlanningBuffer.MODIFY();
                        end else begin
                            NewRecordWithDetails("Receipt Date", "Item No.", Description);
                            PlanningBuffer."Scheduled Receipts" := "Outstanding Qty. (Base)" + "Qty. in Transit (Base)";
                            PlanningBuffer."Location Code FND" := "Transfer-to Code";
                            PlanningBuffer."Bin Code FND" := "Transfer-To Bin Code";
                            PlanningBuffer.INSERT();
                        end;
                    end;
                    //HEI.02<<
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Derived From Line No.", 0);
                    //HEI.02>>
                    SETRANGE("Receipt Date", StartDate, EndDate);
                    SETFILTER("Transfer-to Code", LocationFilter);
                    SETFILTER("Transfer-To Bin Code", BinFilter);
                    //HEI.02<<
                end;
            }
            dataitem("Prod. Order Line"; "Prod. Order Line")
            {
                DataItemLink = "Item No." = FIELD("Item No.");
                DataItemTableView = sorting(Status, "Prod. Order No.", "Line No.");

                trigger OnAfterGetRecord();
                begin
                    if not (Status in [Status::Simulated, Status::Finished]) then begin
                        ReqLine2.SETRANGE("Ref. Order Status", Status);
                        ReqLine2.SETRANGE("Ref. Order No.", "Prod. Order No.");
                        ReqLine2.SETRANGE("Ref. Line No.", "Line No.");
                        if ReqLine2.FINDFIRST() then
                            CurrReport.SKIP();

                        if Selection then begin
                            NewRecordWithDetails("Due Date", "Item No.", Description);
                            PlanningBuffer."Document Type" := PlanningBuffer."Document Type"::"Purchase Order";
                            PlanningBuffer."Document No." := "Prod. Order No.";
                            case Status of
                                Status::"Firm Planned":
                                    begin
                                        PlanningBuffer."Document Type" := PlanningBuffer."Document Type"::"Firm Planned Prod. Order";
                                        PlanningBuffer."Scheduled Receipts" := "Remaining Qty. (Base)";
                                    end;
                                Status::Released:
                                    begin
                                        PlanningBuffer."Document Type" := PlanningBuffer."Document Type"::"Released Prod. Order";
                                        PlanningBuffer."Scheduled Receipts" := "Remaining Qty. (Base)";
                                    end;
                            end;
                            //HEI.01>>
                            PlanningBuffer."Location Code FND" := "Location Code";
                            PlanningBuffer."Zone Code FND" := "Zone Code FND";
                            PlanningBuffer."Bin Code FND" := "Bin Code";
                            //HEI.01<<
                            PlanningBuffer.INSERT();
                        end else begin
                            PlanningBuffer.SETRANGE("Item No.", "Item No.");
                            PlanningBuffer.SETRANGE(Date, "Due Date");
                            //HEI.01>>
                            PlanningBuffer.SETRANGE("Location Code FND", "Location Code");
                            PlanningBuffer.SETRANGE("Zone Code FND", "Zone Code FND");
                            PlanningBuffer.SETRANGE("Bin Code FND", "Bin Code");
                            //HEI.01<<
                            if PlanningBuffer.FIND('-') then begin
                                if Status <> Status::Planned then
                                    PlanningBuffer."Scheduled Receipts" :=
                                      PlanningBuffer."Scheduled Receipts" +
                                      "Remaining Qty. (Base)";
                                PlanningBuffer.MODIFY();
                            end else begin
                                NewRecordWithDetails("Due Date", "Item No.", Description);
                                if Status <> Status::Planned then
                                    PlanningBuffer."Scheduled Receipts" := "Remaining Qty. (Base)";
                                //HEI.02>>
                                PlanningBuffer."Location Code FND" := "Location Code";
                                PlanningBuffer."Zone Code FND" := "Zone Code FND";
                                PlanningBuffer."Bin Code FND" := "Bin Code";
                                //HEI.02<<
                                PlanningBuffer.INSERT();
                            end;
                        end;
                    end;
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02>>
                    SETRANGE("Due Date", StartDate, EndDate);
                    SETFILTER("Location Code", LocationFilter);
                    SETFILTER("Zone Code FND", ZoneFilter);
                    SETFILTER("Bin Code", BinFilter);
                    case StatusFilter of
                        StatusFilter::All:
                            SETFILTER(Status, '%1|%2', Status::"Firm Planned", Status::Released);
                        StatusFilter::"Firm Planned":
                            SETFILTER(Status, '%1', Status::"Firm Planned");
                        StatusFilter::Released:
                            SETFILTER(Status, '%1', Status::Released);
                    end;
                    //HEI.02<<

                    ReqLine2.RESET();
                    ReqLine2.SETCURRENTKEY("Ref. Order Type", "Ref. Order Status", "Ref. Order No.", "Ref. Line No.");
                    ReqLine2.SETRANGE("Ref. Order Type", ReqLine2."Ref. Order Type"::"Prod. Order");
                end;
            }
            dataitem("Requisition Line"; "Requisition Line")
            {
                DataItemLink = "No." = FIELD("Item No.");
                DataItemTableView = sorting("Worksheet Template Name", "Journal Batch Name", "Line No.");

                trigger OnAfterGetRecord();
                begin
                    if Selection then begin
                        NewRecordWithDetails("Due Date", "No.", Description);
                        PlanningBuffer."Document Type" := PlanningBuffer."Document Type"::"Requisition Line";
                        PlanningBuffer."Document No." := "Prod. Order No.";
                        PlanningBuffer."Planned Receipts" := "Quantity (Base)";
                        //HEI.01>>
                        PlanningBuffer."Location Code FND" := "Location Code";
                        PlanningBuffer."Bin Code FND" := "Bin Code";
                        //HEI.01<<
                        PlanningBuffer.INSERT();
                    end else begin
                        PlanningBuffer.SETRANGE("Item No.", "No.");
                        PlanningBuffer.SETRANGE(Date, "Due Date");
                        //HEI.01>>
                        PlanningBuffer.SETRANGE("Location Code FND", "Location Code");
                        PlanningBuffer.SETRANGE("Bin Code FND", "Bin Code");
                        //HEI.01<<
                        if PlanningBuffer.FIND('-') then begin
                            PlanningBuffer."Planned Receipts" := PlanningBuffer."Planned Receipts" + "Quantity (Base)";
                            PlanningBuffer.MODIFY();
                        end else begin
                            NewRecordWithDetails("Due Date", "No.", Description);
                            PlanningBuffer."Planned Receipts" := "Quantity (Base)";
                            //HEI.02>>
                            PlanningBuffer."Location Code FND" := "Location Code";
                            PlanningBuffer."Bin Code FND" := "Bin Code";
                            //HEI.02<<
                            PlanningBuffer.INSERT();
                        end;
                    end;
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02>>
                    SETRANGE("Due Date", StartDate, EndDate);
                    SETFILTER("Location Code", LocationFilter);
                    SETFILTER("Bin Code", BinFilter);
                    //HEI.02<<
                end;
            }
            dataitem("Prod. Order Component"; "Prod. Order Component")
            {
                DataItemLink = "Item No." = FIELD("Item No.");
                DataItemTableView = sorting(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");

                trigger OnAfterGetRecord();
                begin
                    if not (Status in [Status::Simulated, Status::Finished]) then begin
                        ReqLine2.SETRANGE("Ref. Order Status", Status);
                        ReqLine2.SETRANGE("Ref. Order No.", "Prod. Order No.");
                        ReqLine2.SETRANGE("Ref. Line No.", "Prod. Order Line No.");
                        if ReqLine2.FINDFIRST() then
                            CurrReport.SKIP();

                        if Selection then begin
                            NewRecordWithDetails("Due Date", "Item No.", Description);
                            PlanningBuffer."Document Type" := PlanningBuffer."Document Type"::"Purchase Order";
                            PlanningBuffer."Document No." := "Prod. Order No.";
                            PlanningBuffer."Gross Requirement" := "Remaining Qty. (Base)";
                            case Status of
                                Status::"Firm Planned":
                                    PlanningBuffer."Document Type" := PlanningBuffer."Document Type"::"Firm Planned Prod. Order Comp.";
                                Status::Released:
                                    PlanningBuffer."Document Type" := PlanningBuffer."Document Type"::"Released Prod. Order Comp.";
                            end;
                            //HEI.01>>
                            PlanningBuffer."Location Code FND" := "Location Code";
                            PlanningBuffer."Zone Code FND" := "Zone Code FND";
                            PlanningBuffer."Bin Code FND" := "Bin Code";
                            //HEI.01<<
                            PlanningBuffer.INSERT();
                        end else begin
                            PlanningBuffer.SETRANGE("Item No.", "Item No.");
                            PlanningBuffer.SETRANGE(Date, "Due Date");
                            //HEI.01>>
                            PlanningBuffer.SETRANGE("Location Code FND", "Location Code");
                            PlanningBuffer.SETRANGE("Zone Code FND", "Zone Code FND");
                            PlanningBuffer.SETRANGE("Bin Code FND", "Bin Code");
                            //HEI.01<<
                            if PlanningBuffer.FIND('-') then begin
                                PlanningBuffer."Gross Requirement" := PlanningBuffer."Gross Requirement" + "Remaining Qty. (Base)";
                                PlanningBuffer.MODIFY();
                            end else begin
                                NewRecordWithDetails("Due Date", "Item No.", Description);
                                PlanningBuffer."Gross Requirement" := "Remaining Qty. (Base)";
                                //HEI.02>>
                                PlanningBuffer."Location Code FND" := "Location Code";
                                PlanningBuffer."Zone Code FND" := "Zone Code FND";
                                PlanningBuffer."Bin Code FND" := "Bin Code";
                                //HEI.02<<
                                PlanningBuffer.INSERT();
                            end;
                        end;
                    end;
                    ModifyForecast("Item No.", "Due Date", PlanningBuffer."Document Type"::"Production Forecast-Component", "Remaining Qty. (Base)");
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02>>
                    SETRANGE("Due Date", StartDate, EndDate);
                    SETFILTER("Location Code", LocationFilter);
                    SETFILTER("Zone Code FND", ZoneFilter);
                    SETFILTER("Bin Code", BinFilter);
                    case StatusFilter of
                        StatusFilter::All:
                            SETFILTER(Status, '%1|%2', Status::"Firm Planned", Status::Released);
                        StatusFilter::"Firm Planned":
                            SETFILTER(Status, '%1', Status::"Firm Planned");
                        StatusFilter::Released:
                            SETFILTER(Status, '%1', Status::Released);
                    end;
                    //HEI.02<<

                    ReqLine2.RESET();
                    ReqLine2.SETCURRENTKEY("Ref. Order Type", "Ref. Order Status", "Ref. Order No.", "Ref. Line No.");
                    ReqLine2.SETRANGE("Ref. Order Type", ReqLine2."Ref. Order Type"::"Prod. Order");
                end;
            }
            dataitem("Planning Component"; "Planning Component")
            {
                DataItemLink = "Item No." = FIELD("Item No.");
                DataItemTableView = sorting("Worksheet Template Name", "Worksheet Batch Name", "Worksheet Line No.", "Line No.");

                trigger OnAfterGetRecord();
                begin
                    if Selection then begin
                        NewRecordWithDetails("Due Date", "Item No.", Description);
                        PlanningBuffer."Document Type" := PlanningBuffer."Document Type"::"Planning Comp.";
                        PlanningBuffer."Document No." := ReqLine."Ref. Order No.";
                        PlanningBuffer."Gross Requirement" := "Expected Quantity (Base)";
                        //HEI.01>>
                        PlanningBuffer."Location Code FND" := "Location Code";
                        PlanningBuffer."Bin Code FND" := "Bin Code";
                        //HEI.01<<
                        PlanningBuffer.INSERT();
                    end else begin
                        PlanningBuffer.SETRANGE("Item No.", "Item No.");
                        PlanningBuffer.SETRANGE(Date, "Due Date");
                        //HEI.01>>
                        PlanningBuffer.SETRANGE("Location Code FND", "Location Code");
                        PlanningBuffer.SETRANGE("Bin Code FND", "Bin Code");
                        //HEI.01<<
                        if PlanningBuffer.FIND('-') then begin
                            PlanningBuffer."Gross Requirement" := PlanningBuffer."Gross Requirement" + "Expected Quantity (Base)";
                            PlanningBuffer.MODIFY();
                        end else begin
                            NewRecordWithDetails("Due Date", "Item No.", Description);
                            PlanningBuffer."Gross Requirement" := "Expected Quantity (Base)";
                            //HEI.02>>
                            PlanningBuffer."Location Code FND" := "Location Code";
                            PlanningBuffer."Bin Code FND" := "Bin Code";
                            //HEI.02<<
                            PlanningBuffer.INSERT();
                        end;
                    end;
                    ModifyForecast("Item No.", "Due Date", PlanningBuffer."Document Type"::"Production Forecast-Component", "Expected Quantity (Base)");
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02>>
                    SETRANGE("Due Date", StartDate, EndDate);
                    SETFILTER("Location Code", LocationFilter);
                    SETFILTER("Bin Code", BinFilter);
                    //HEI.02<<
                end;
            }
            dataitem("Warehouse Activity Line"; "Warehouse Activity Line")
            {
                DataItemLink = "Item No." = FIELD("Item No.");
                DataItemTableView = sorting("Item No.", "Location Code", "Activity Type", "Bin Type Code", "Unit of Measure Code", "Variant Code", "Breakbulk No.", "Action Type", "Lot No.", "Serial No.", "Assemble to Order");

                trigger OnAfterGetRecord();
                var
                    WHActivityType: Text[50];
                begin
                    if Selection then begin
                        NewRecordWithDetails("Due Date", "Item No.", Description);
                        //HEI.02>>
                        WHActivityType := FORMAT("Activity Type");
                        EVALUATE(PlanningBuffer."Document Type", WHActivityType);
                        //HEI.02<<
                        PlanningBuffer."Document No." := "No.";
                        QtyInTransit := 0;
                        WarehouseEntry.SETCURRENTKEY("Movement No. FND");
                        WarehouseEntry.SETRANGE("Movement No. FND", "No.");
                        WarehouseEntry.SETRANGE("Transit-Zone FND", true);
                        WarehouseEntry.SETFILTER("Reference Line No. FND", '%1|%2', "Line No.", "Linked To Line No. FND");
                        if WarehouseEntry.findset() then
                            repeat
                                QtyInTransit += WarehouseEntry.Quantity;
                            until WarehouseEntry.NEXT() = 0;
                        PlanningBuffer."Scheduled Quantity FND" := QtyInTransit;
                        //HEI.01>>
                        PlanningBuffer."Location Code FND" := "Location Code";
                        PlanningBuffer."Zone Code FND" := "Zone Code";
                        PlanningBuffer."Bin Code FND" := "Bin Code";
                        //HEI.01<<
                        PlanningBuffer.INSERT();
                    end else begin
                        PlanningBuffer.SETRANGE("Item No.", "No.");
                        PlanningBuffer.SETRANGE(Date, "Due Date");
                        //HEI.01>>
                        PlanningBuffer.SETRANGE("Location Code FND", "Location Code");
                        PlanningBuffer.SETRANGE("Zone Code FND", "Zone Code");
                        PlanningBuffer.SETRANGE("Bin Code FND", "Bin Code");
                        //HEI.01<<
                        if PlanningBuffer.FIND('-') then begin
                            PlanningBuffer."Scheduled Quantity FND" := PlanningBuffer."Gross Requirement" + QtyInTransit;
                            PlanningBuffer.MODIFY();
                        end else begin
                            NewRecordWithDetails("Due Date", "No.", Description);
                            PlanningBuffer."Scheduled Quantity FND" := QtyInTransit;
                            //HEI.02>>
                            PlanningBuffer."Location Code FND" := "Location Code";
                            PlanningBuffer."Zone Code FND" := "Zone Code";
                            PlanningBuffer."Bin Code FND" := "Bin Code";
                            //HEI.02<<
                            PlanningBuffer.INSERT();
                        end;
                    end;
                    //ModifyForecast("No.","Due Date",PlanningBuffer."Document Type"::"Production Forecast-Sales",QtyInTransit);
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02>>
                    SETRANGE("Due Date", StartDate, EndDate);
                    SETFILTER("Location Code", LocationFilter);
                    SETFILTER("Zone Code", ZoneFilter);
                    SETFILTER("Bin Code", BinFilter);
                    //HEI.02<<
                end;
            }
            dataitem("Warehouse Entry"; "Warehouse Entry")
            {
                DataItemLink = "Item No." = FIELD("Item No.");
                DataItemTableView = sorting("Location Code", "Item No.", "Variant Code", "Zone Code", "Bin Code", "Lot No.");

                trigger OnAfterGetRecord();
                begin
                    //HEI.02>>
                    if Selection then begin
                        NewRecordWithDetails("Registering Date", "Item No.", Description);
                        //PlanningBuffer."Document Type" := PlanningBuffer."Document Type"::"Quantity at Inventory";
                        PlanningBuffer."Document No." := "Whse. Document No.";
                        PlanningBuffer."Scheduled Quantity FND" := "Qty. (Base)";
                        PlanningBuffer."Location Code FND" := "Location Code";
                        PlanningBuffer."Zone Code FND" := "Zone Code";
                        PlanningBuffer."Bin Code FND" := "Bin Code";
                        PlanningBuffer.INSERT();
                    end else begin
                        PlanningBuffer.SETRANGE("Item No.", "Item No.");
                        PlanningBuffer.SETRANGE(Date, "Registering Date");
                        PlanningBuffer.SETRANGE("Location Code FND", "Location Code");
                        PlanningBuffer.SETRANGE("Zone Code FND", "Zone Code");
                        PlanningBuffer.SETRANGE("Bin Code FND", "Bin Code");
                        if PlanningBuffer.FIND('-') then begin
                            PlanningBuffer."Scheduled Quantity FND" := PlanningBuffer."Scheduled Quantity FND" + "Qty. (Base)";
                            PlanningBuffer.MODIFY();
                        end else begin
                            NewRecordWithDetails("Registering Date", "Item No.", Description);
                            PlanningBuffer."Scheduled Quantity FND" := "Qty. (Base)";
                            PlanningBuffer."Location Code FND" := "Location Code";
                            PlanningBuffer."Zone Code FND" := "Zone Code";
                            PlanningBuffer."Bin Code FND" := "Bin Code";
                            PlanningBuffer.INSERT();
                        end;
                    end;
                    //HEI.02<<
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02>>
                    CurrReport.BREAK();
                    SETRANGE("Registering Date", StartDate, EndDate);
                    SETFILTER("Location Code", LocationFilter);
                    SETFILTER("Zone Code", ZoneFilter);
                    SETFILTER("Bin Code", BinFilter);
                    //HEI.02<<
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = FILTER(1 ..));
                column(CompanyName; COMPANYNAME)
                {
                }
                column(TodayFormatted; FORMAT(TODAY, 0, 4))
                {
                }
                column(PlngBuffTableCaptFilter; PlanningBuffer.TABLECAPTION + ': ' + PlanningFilter)
                {
                }
                column(PlanningFilter; PlanningFilter)
                {
                }
                column(ItemInventory; ItemInventory)
                {
                }
                column(AvailableInventoryProd; ItemInventoryProd)
                {
                }
                column(ItemCheck_BaseUoM; BaseUoM)
                {
                }
                column(PlanningBuff_ItemNo; PlanningBuffer."Item No.")
                {
                }
                column(PlanningBuff_Desc; PlanningBuffer.Description)
                {
                }
                column(PlanningBuff_DocNo; PlanningBuffer."Document No.")
                {
                }
                column(PlanningBuff_DocType; FORMAT(PlanningBuffer."Document Type"))
                {
                }
                column(ScheduledQty; PlanningBuffer."Scheduled Quantity FND")
                {
                }
                column(ProjectedBalance; ProjectedBalance)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(ProjectedBalanceBin; ProjectedBalanceBin)
                {
                }
                column(PlngBuff_ScheduledReceipts; PlanningBuffer."Scheduled Receipts")
                {
                }
                column(PlngBuff_PlannedReceipts; PlanningBuffer."Planned Receipts")
                {
                }
                column(PlngBuff_GrossRequirement; PlanningBuffer."Gross Requirement")
                {
                }
                column(PlanningBuff_Date; FORMAT(PlanningBuffer.Date))
                {
                }
                column(ShowIntBody1; PrintBoolean and Selection)
                {
                }
                column(ShowIntBody2; PrintBoolean2 and Selection)
                {
                }
                column(ShowIntBody3; PrintBoolean and (not Selection))
                {
                }
                column(ShowIntBody4; PrintBoolean2 and (not Selection))
                {
                }
                column(PlanningAvailabilityCaptn; PlanningAvailabilityCaptnLbl)
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                column(DocumentNoCaption; DocumentNoCaptionLbl)
                {
                }
                column(DocumentTypeCaption; DocumentTypeCaptionLbl)
                {
                }
                column(ProjBalanceProducCp; ProjBalanceProducCaption)
                {
                }
                column(SchedWHMovementCp; SchedWHMovementCaption)
                {
                }
                column(ProjectedBalanceCaption; ProjectedBalanceCaptionLbl)
                {
                }
                column(ScheduledReceiptsCaption; ScheduledReceiptsCaptionLbl)
                {
                }
                column(PlannedReceiptsCaption; PlannedReceiptsCaptionLbl)
                {
                }
                column(GrossRequirementCaption; GrossRequirementCaptionLbl)
                {
                }
                column(AvailableInventoryCaption; AvailableInventoryCaptionLbl)
                {
                }
                column(AvailableInventoryProdCp; AvailableInventoryProdCaptionLbl)
                {
                }
                column(BaseUoMCp; BaseUoMCaptionLbl)
                {
                }
                column(DateCaption; DateCaptionLbl)
                {
                }

                trigger OnAfterGetRecord();
                var
                    ItemLedgerEntryL: Record "Item Ledger Entry";
                    WarehouseEntryL: Record "Warehouse Entry";
                begin
                    if Number = 1 then
                        PlanningBuffer.FIND('-')
                    else
                        if PlanningBuffer.NEXT() = 0 then
                            CurrReport.BREAK();

                    //HEI.02>>
                    if PlanningBuffer."Item No." = '' then
                        CurrReport.SKIP();

                    Item.RESET();
                    Item.SETRANGE("Date Filter", StartDate, EndDate);
                    Item.SETFILTER("Location Filter", LocationFilter);
                    Item.SETFILTER("Bin Filter", BinFilter);
                    //HEI.02<<
                    if Item.GET(PlanningBuffer."Item No.") then begin
                        //HEI.02>>
                        if not DataExist then
                            DataExist := true;
                        if PlanningBuffer.Description = '' then
                            PlanningBuffer.Description := Item.Description;
                        //HEI.02<<
                        PrintBoolean2 := true;
                        if PlanningBuffer."Item No." = OldItem then
                            PrintBoolean := false
                        else begin
                            //HEI.02>>
                            CLEAR(ProjectedBalance);
                            CLEAR(ProjectedBalanceBin);
                            //HEI.02<<
                            PrintBoolean := true;
                            OldItem := Item."No.";
                        end;

                        //HEI.02>>
                        ItemCheck.GET(Item."No.");
                        if not ItemCheck.MARK() then begin
                            CLEAR(ItemInventory);
                            CLEAR(ItemInventoryProd);
                            CLEAR(BaseUoM);
                            BaseUoM := ItemCheck."Base Unit of Measure";
                            ItemLedgerEntryL.SETRANGE("Item No.", Item."No.");
                            ItemLedgerEntryL.SETRANGE("Posting Date", 0D, (StartDate - 1));
                            ItemLedgerEntryL.SETFILTER("Location Code", LocationFilter);
                            if ItemLedgerEntryL.findset() then
                                repeat
                                    ItemInventory += ItemLedgerEntryL.Quantity;
                                until ItemLedgerEntryL.NEXT() = 0;

                            WarehouseEntryL.SETRANGE("Item No.", Item."No.");
                            WarehouseEntryL.SETRANGE("Registering Date", 0D, (StartDate - 1));
                            WarehouseEntryL.SETFILTER("Location Code", LocationFilter);
                            WarehouseEntryL.SETFILTER("Zone Code", ZoneFilter);
                            WarehouseEntryL.SETFILTER("Bin Code", BinFilter);
                            if WarehouseEntryL.findset() then
                                repeat
                                    ItemInventoryProd += WarehouseEntryL."Qty. (Base)";
                                until WarehouseEntryL.NEXT() = 0;
                            ItemCheck.MARK(true);
                            ProjectedBalance := ItemInventory;
                            ProjectedBalanceBin := ItemInventoryProd;
                        end;

                        ProjectedBalance :=
                          ProjectedBalance -
                          PlanningBuffer."Gross Requirement" +
                          PlanningBuffer."Planned Receipts" +
                          PlanningBuffer."Scheduled Receipts";

                        ProjectedBalanceBin :=
                          ProjectedBalanceBin -
                          PlanningBuffer."Gross Requirement" +
                          PlanningBuffer."Scheduled Quantity FND";

                        if ShortageOnly and (ProjectedBalanceBin >= 0) then
                            CurrReport.SKIP();
                        //HEI.02<<
                    end else
                        PrintBoolean2 := false;
                end;

                trigger OnPreDataItem();
                begin
                    TempForecastPlanningBuffer.RESET();
                    //HEI.02>>
                    TempForecastPlanningBuffer.SETFILTER("Item No.", "Item Buffer FND"."Item No.");
                    TempForecastPlanningBuffer.SETRANGE(Date, StartDate, EndDate);
                    TempForecastPlanningBuffer.SETFILTER("Location Code FND", LocationFilter);
                    TempForecastPlanningBuffer.SETFILTER("Zone Code FND", ZoneFilter);
                    TempForecastPlanningBuffer.SETFILTER("Bin Code FND", BinFilter);
                    //HEI.02<<
                    TempForecastPlanningBuffer.SETFILTER("Gross Requirement", '>0');
                    if TempForecastPlanningBuffer.findset() then
                        repeat
                            if Selection then begin
                                NewRecord();
                                PlanningBuffer := TempForecastPlanningBuffer;
                                PlanningBuffer."Buffer No." := BufferCounter;
                                //HEI.02>>
                                PlanningBuffer."Location Code FND" := TempForecastPlanningBuffer."Location Code FND";
                                PlanningBuffer."Zone Code FND" := TempForecastPlanningBuffer."Zone Code FND";
                                PlanningBuffer."Bin Code FND" := TempForecastPlanningBuffer."Bin Code FND";
                                //HEI.02<<
                                PlanningBuffer.INSERT();
                            end else begin
                                PlanningBuffer.SETRANGE("Item No.", TempForecastPlanningBuffer."Item No.");
                                PlanningBuffer.SETRANGE(Date, TempForecastPlanningBuffer.Date);
                                //HEI.02>>
                                PlanningBuffer.SETFILTER("Location Code FND", TempForecastPlanningBuffer."Location Code FND");
                                PlanningBuffer.SETFILTER("Zone Code FND", TempForecastPlanningBuffer."Zone Code FND");
                                PlanningBuffer.SETFILTER("Bin Code FND", TempForecastPlanningBuffer."Bin Code FND");
                                //HEI.02<<
                                if PlanningBuffer.findset(true) then begin
                                    PlanningBuffer."Gross Requirement" += TempForecastPlanningBuffer."Gross Requirement";
                                    PlanningBuffer.MODIFY();
                                end else begin
                                    NewRecord();
                                    PlanningBuffer := TempForecastPlanningBuffer;
                                    PlanningBuffer."Buffer No." := BufferCounter;
                                    //HEI.02>>
                                    PlanningBuffer."Location Code FND" := TempForecastPlanningBuffer."Location Code FND";
                                    PlanningBuffer."Zone Code FND" := TempForecastPlanningBuffer."Zone Code FND";
                                    PlanningBuffer."Bin Code FND" := TempForecastPlanningBuffer."Bin Code FND";
                                    //HEI.02<<
                                    PlanningBuffer.INSERT();
                                end;
                            end;
                        until TempForecastPlanningBuffer.NEXT() = 0;

                    //HEI.02>>
                    PlanningBuffer.RESET();
                    PlanningBuffer.SETCURRENTKEY("Item No.", Date, "Location Code FND", "Zone Code FND", "Bin Code FND");
                    PlanningBuffer.SETFILTER("Item No.", "Item Buffer FND"."Item No.");
                    PlanningBuffer.SETRANGE(Date, StartDate, EndDate);
                    PlanningBuffer.SETFILTER("Location Code FND", LocationFilter);
                    PlanningBuffer.SETFILTER("Zone Code FND", ZoneFilter);
                    PlanningBuffer.SETFILTER("Bin Code FND", BinFilter);
                    if not PlanningBuffer.FINDFIRST() then begin
                        "Item Buffer FND"."Active Component" := false;
                        "Item Buffer FND".MODIFY();
                        CurrReport.BREAK();
                    end;
                    //HEI.02<<
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    field(Selection; Selection)
                    {
                        CaptionML = ENU = 'Detailed',
                                    FRA = 'Détaillé';
                        DrillDown = true;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Selection field.';
                        //OptionCaption = 'Oui,Non';//Bc Upgrade YADAVM09 property can be used for option type field
                    }
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Start Date field.';
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the End Date field.';
                    }
                    field(LocationFilter; LocationFilter)
                    {
                        Caption = 'Location Code Filter';
                        TableRelation = Location;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Location Code Filter field.';

                        trigger OnValidate();
                        begin
                            //HEI.02>>
                            CLEAR(ZoneFilter);
                            CLEAR(BinFilter);
                            //HEI.02<<
                        end;
                    }
                    field(ZoneFilter; ZoneFilter)
                    {
                        Caption = 'Zone Code Filter';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Zone Code Filter field.';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ZoneL: Record Zone;
                        begin
                            //HEI.02>>
                            ZoneL.SETFILTER("Location Code", LocationFilter);
                            if PAGE.RUNMODAL(0, ZoneL, ZoneL.Code) = ACTION::LookupOK then
                                ZoneFilter := ZoneL.Code;
                            //HEI.02<<
                        end;
                    }
                    field(BinFilter; BinFilter)
                    {
                        Caption = 'Bin Code Filter';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Bin Code Filter field.';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            BinL: Record Bin;
                        begin
                            //HEI.02>>
                            BinL.SETFILTER("Location Code", LocationFilter);
                            BinL.SETFILTER("Zone Code", ZoneFilter);
                            if PAGE.RUNMODAL(0, BinL, BinL.Code) = ACTION::LookupOK then
                                BinFilter := BinL.Code;
                            //HEI.02<<
                        end;
                    }
                    field(StatusFilter; StatusFilter)
                    {
                        Caption = 'Status Filter';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Status Filter field.';
                    }
                    field(ShortageOnly; ShortageOnly)
                    {
                        Caption = 'Display Shortage Only';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Display Shortage Only field.';
                    }
                    field("Replenishment System"; ReplenishmentSystem)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the ReplenishmentSystem field.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        Selection := true;
    end;

    trigger OnPostReport();
    begin
        //HEI.02>>
        if not DataExist then
            ERROR(Text007);
        //HEI.02<<
    end;

    trigger OnPreReport();
    var
        ReplItemL: Record Item;
        ProdOrderCompL: Record "Prod. Order Component";
        ReplSKUL: Record "Stockkeeping Unit";
    begin
        //HEI.02>>
        if StartDate = 0D then
            ERROR(Text009);
        if EndDate = 0D then
            ERROR(Text010);
        DateFilter := FORMAT(StartDate) + '..' + FORMAT(EndDate);
        PlanningBuffer.DELETEALL();
        ItemBuffer.RESET();
        ItemBuffer.MODIFYALL("Active Component", false);
        case StatusFilter of
            StatusFilter::All:
                ProdOrderCompL.SETFILTER(Status, '%1|%2', ProdOrderCompL.Status::"Firm Planned", ProdOrderCompL.Status::Released);
            StatusFilter::"Firm Planned":
                ProdOrderCompL.SETFILTER(Status, '%1', ProdOrderCompL.Status::"Firm Planned");
            StatusFilter::Released:
                ProdOrderCompL.SETFILTER(Status, '%1', ProdOrderCompL.Status::Released);
        end;
        if ProdOrderCompL.findset() then begin
            repeat
                if LocationFilter = '' then begin
                    ReplItemL.RESET();
                    ReplItemL.SETRANGE("No.", ProdOrderCompL."Item No.");
                    ReplItemL.SETRANGE("Replenishment System", ReplenishmentSystem);
                    if ReplItemL.FINDFIRST() then
                        InsertItemBuffer(ProdOrderCompL."Item No.");
                end else begin
                    ReplSKUL.RESET();
                    ReplSKUL.SETFILTER("Location Code", LocationFilter);
                    ReplSKUL.SETRANGE("Item No.", ProdOrderCompL."Item No.");
                    ReplSKUL.SETRANGE("Replenishment System", ReplenishmentSystem);
                    if ReplSKUL.FIND('-') then
                        repeat
                            InsertItemBuffer(ProdOrderCompL."Item No.");
                        until ReplSKUL.NEXT() = 0;
                end;
            until ProdOrderCompL.NEXT() = 0;
        end else
            ERROR(Text006, FORMAT(StatusFilter));
        //HEI.02<<
    end;

    var
        Item: Record Item;
        ItemCheck: Record Item;
        ItemBuffer: Record "Item Buffer FND";
        PlanningBuffer: Record "Planning Buffer" temporary;
        TempForecastPlanningBuffer: Record "Planning Buffer" temporary;
        ReqLine: Record "Requisition Line";
        ReqLine2: Record "Requisition Line";
        WarehouseEntry: Record "Warehouse Entry";
        DataExist: Boolean;
        PrintBoolean: Boolean;
        PrintBoolean2: Boolean;
        Selection: Boolean;
        ShortageOnly: Boolean;
        BaseUoM: Code[10];
        LocationFilter: Code[10];
        ZoneFilter: Code[10];
        BinFilter: Code[20];
        OldItem: Code[20];
        EndDate: Date;
        StartDate: Date;
        AvailableInventory: Decimal;
        AvailableInventoryProd: Decimal;
        ItemInventory: Decimal;
        ItemInventoryProd: Decimal;
        ProjectedBalance: Decimal;
        ProjectedBalanceBin: Decimal;
        QtyInTransit: Decimal;
        BufferCounter: Integer;
        AvailableInventoryProdCaptionLbl: Label 'Available Inventory Production :';
        BaseUoMCaptionLbl: Label '" Base UoM :"';
        ProjBalanceProducCaption: Label 'Projected Balance in Production';
        SchedWHMovementCaption: Label 'Scheduled W/H Zone Movement';
        Text001: Label '"Date Filter : "';
        Text002: Label '"Location Filter : "';
        Text003: Label '"Zone Filter : "';
        Text004: Label '"Bin Filter : "';
        Text005: Label '"Status Filter : "';
        Text006: Label '"There is no component exists under this Status filter - %1. "';
        Text007: Label '"There is nothing to show within these filters. "';
        Text008: Label '"Replenishment System : "';
        Text009: Label 'Please enter Start Date.';
        Text010: Label 'Please enter End Date.';
        Text011: Label '"Detailed : "';
        Text012: Label '"Shortage Only : "';
        StatusFilter: Option All,"Firm Planned",Released;
        ReplenishmentSystem: Option Purchase,"Prod. Order",,Assembly;
        PlanningFilter: Text;
        DateFilter: Text[30];
        AvailableInventoryCaptionLbl: TextConst ENU = 'Available Inventory Site :', FRA = 'Stock disponible';
        CurrReportPageNoCaptionLbl: TextConst ENU = 'Page : ', FRA = 'Page';
        DateCaptionLbl: TextConst ENU = 'Date', FRA = 'Date';
        DocumentNoCaptionLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        DocumentTypeCaptionLbl: TextConst ENU = 'Document Type', FRA = 'Type document';
        GrossRequirementCaptionLbl: TextConst ENU = 'Gross Requirement', FRA = 'Besoin brut';
        PlannedReceiptsCaptionLbl: TextConst ENU = 'Planned Receipts', FRA = 'Réceptions prévues';
        PlanningAvailabilityCaptnLbl: TextConst ENU = 'Production Replenishment Proposal', FRA = 'Disponibilité planning';
        ProjectedBalanceCaptionLbl: TextConst ENU = 'Projected Site Balance', FRA = 'Stock prévisionnel';
        ScheduledReceiptsCaptionLbl: TextConst ENU = 'Scheduled Receipts', FRA = 'Réceptions planifiées';

    local procedure NewRecord();
    begin
        //PlanningBuffer.SETRANGE("Item No.");
        //PlanningBuffer.SETRANGE(Date);
        //HEI.01>>
        //PlanningBuffer.SETRANGE("Buffer No.");
        //PlanningBuffer.SETRANGE("Document Type");
        //PlanningBuffer.SETRANGE("Location Code");
        //PlanningBuffer.SETRANGE("Zone Code");
        //PlanningBuffer.SETRANGE("Bin Code");
        PlanningBuffer.RESET();
        //HEI.01<<

        if not PlanningBuffer.FINDLAST() then
            BufferCounter := 1
        else begin
            BufferCounter := PlanningBuffer."Buffer No." + 1;
            CLEAR(PlanningBuffer);
        end;
        //PlanningBuffer.INIT;
        PlanningBuffer."Buffer No." := BufferCounter;
    end;

    local procedure NewRecordWithDetails(NewDate: Date; NewItemNo: Code[20]; NewDescription: Text[50]);
    begin
        NewRecord();
        PlanningBuffer.Date := NewDate;
        PlanningBuffer."Item No." := NewItemNo;
        PlanningBuffer.Description := NewDescription;
    end;

    local procedure InsertNewForecast(ProdForecastEntry: Record "Production Forecast Entry");
    begin
        TempForecastPlanningBuffer.INIT();
        TempForecastPlanningBuffer."Buffer No." := BufferCounter;

        TempForecastPlanningBuffer.Date := ProdForecastEntry."Forecast Date";
        if ProdForecastEntry."Component Forecast" then
            TempForecastPlanningBuffer."Document Type" := TempForecastPlanningBuffer."Document Type"::"Production Forecast-Component"
        else
            TempForecastPlanningBuffer."Document Type" := TempForecastPlanningBuffer."Document Type"::"Production Forecast-Sales";
        TempForecastPlanningBuffer."Document No." := ProdForecastEntry."Production Forecast Name";
        TempForecastPlanningBuffer."Item No." := ProdForecastEntry."Item No.";
        TempForecastPlanningBuffer.Description := ProdForecastEntry.Description;
        TempForecastPlanningBuffer."Gross Requirement" := ProdForecastEntry."Forecast Quantity";
        //HEI.02>>
        TempForecastPlanningBuffer."Location Code FND" := ProdForecastEntry."Location Code";
        //HEI.02<<
        TempForecastPlanningBuffer.INSERT();
    end;

    local procedure ModifyForecast(ItemNo: Code[20]; Date: Date; DocumentType: Option; Quantity: Decimal);
    begin
        CLEAR(TempForecastPlanningBuffer);
        TempForecastPlanningBuffer.SETRANGE("Item No.", ItemNo);
        TempForecastPlanningBuffer.SETFILTER(Date, '..%1', Date);
        TempForecastPlanningBuffer.SETRANGE("Document Type", DocumentType);
        if TempForecastPlanningBuffer.FINDLAST() then begin
            TempForecastPlanningBuffer."Gross Requirement" -= Quantity;
            TempForecastPlanningBuffer.MODIFY();
        end;
    end;

    local procedure InsertItemBuffer(ItemNo: Code[20]);
    var
        ItemL: Record Item;
    begin
        //HEI.02>>
        ItemBuffer.RESET();
        ItemBuffer.SETRANGE("Item No.", ItemNo);
        if ItemBuffer.FINDFIRST() then begin
            ItemBuffer."Active Component" := true;
            ItemBuffer.MODIFY();
        end else begin
            ItemL.GET(ItemNo);
            ItemBuffer.INIT();
            ItemBuffer."Item No." := ItemNo;
            ItemBuffer."Active Component" := true;
            ItemBuffer.INSERT();
        end;
        //HEI.02<<
    end;
}

