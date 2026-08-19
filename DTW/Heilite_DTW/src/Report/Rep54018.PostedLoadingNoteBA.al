report 54018 "Posted Loading Note BA"
{
    // version HEI.02

    // HEI.01 FDD-PA-LOGGAP05 - Loading Not IBM.NAIKH01 20.11.2017
    //    # Created a new Report
    // HEI.02 FDD-BA-LOGAGP09 IBM NASTAA02 11.03.2019 # Loading Note Bahamas
    //   # Copied Report 50070 - Posted Truck LoadingNote PAN and created new Bahamas Report
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID- 50244.
    // 2. Remove Drink-IT Fields and related code("Truck Code", "Driver Code", "Route", "Route Planning No.", "Weight", "Picking Type", "Truck Zone")
    // 3. Comment Drink-IT Fields Columns and also remove the Drik-IT fields expression in RDL layout.
    // 4. Add layout path and Change extension RDLC to RDL.
    // 5. Comment DataItemLink Property in Sales Header Dataitem After commenting this property, the report will not open. Currently, this report has a high dependency on the Drink-IT field.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Posted Loading Note BA.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.

    Caption = 'Posted Loading Note Bahamas';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Posted Whse. Shipment Header"; "Posted Whse. Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = false;
            // RequestFilterFields = "No.", "Location Code", "Shipment Date", "Truck Code", "Driver Code", "Route Planning No.";
            RequestFilterFields = "No.", "Location Code", "Shipment Date"; // BC Upgrade BHARDA11 ----Drink-IT Fields("Truck Code", "Driver Code", "Route Planning No.")
            column(No_WarehouseShipmentHeader; "No.")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(DateTime_Header; FORMAT(TODAY) + '  ' + FORMAT(TIME))
            {
            }
            column(Report_Header; STRSUBSTNO(Text000, "Shipment Date"))
            {
            }
            column(No_Whse_Shipment_Header; "No.")
            {
            }
            column(Location_Code_Whse_Shipment_Header; "Location Code")
            {
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Driver Code","Truck Code",Route) Also removed in the rdl layout
            // column(Driver_Code_Whse_Shipment_Header; "Driver Code" + '   ' + DriverName)
            // {
            // }
            // column(Truck_Code_Whse_Shipment_Header; "Truck Code")
            // {
            // }
            // column(Route_WarehouseShipmentHeader; Route)
            // {
            // }
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Driver Code","Truck Code",Route) Also removed in the rdl layout

            dataitem("Posted Whse. Shipment Line"; "Posted Whse. Shipment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = "Posted Whse. Shipment Header";
                DataItemTableView = SORTING("Item No.")
                                    WHERE(Quantity = FILTER(<> 0));
                PrintOnlyIfDetail = false;
                column(No_WarehouseShipmentLine; "No.")
                {
                }
                column(ItemNo_WarehouseShipmentLine; "Item No.")
                {
                }
                column(Description_WarehouseShipmentLine; Description)
                {
                }
                column(Qty_WhseShipmentLine; Quantity)
                {
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Field(Weight)
                // column(Weight_WhseShipmentLine; Weight)
                // {
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Field(Weight)
                column(UnitofMeasureCode_WarehouseShipmentLine; "Unit of Measure Code")
                {
                }
                column(Quantity_WarehouseShipmentLine; Quantity)
                {
                }
                column(Header1; Text004)
                {
                }
                column(Header2; Text005)
                {
                }
                column(Header3; Text006)
                {
                }
                column(Header4; Text007)
                {
                }

                trigger OnAfterGetRecord()
                begin


                    NBBulkPallet := 0;
                    NbFullPallet := 0;

                    IF ItemUnitOfMeasure.GET("Item No.", 'COL') THEN
                        NBBulkPallet := ROUND(Quantity / ItemUnitOfMeasure."Qty. per Unit of Measure", 1, '<')
                    ELSE
                        NBBulkPallet := ROUND(Quantity, 1, '<');

                    IF NOT ItemUnitOfMeasure.GET("Item No.", 'PAL') THEN BEGIN
                        NbFullPallet := 0;
                        NBBulkPallet := NBBulkPallet
                    END ELSE BEGIN
                        NbFullPallet := ROUND(Quantity / ItemUnitOfMeasure."Qty. per Unit of Measure", 1, '<');
                        NBBulkPallet := NBBulkPallet - (NbFullPallet * ItemUnitOfMeasure."Qty. per Unit of Measure");
                    END;


                    IF "Unit of Measure Code" = 'CJ' THEN
                        BoxQty := Quantity;
                    IF "Unit of Measure Code" = 'UN' THEN
                        UnQty := Quantity;




                    TotalBulkPallet += NBBulkPallet;
                    TotalFullPallet += NbFullPallet;
                end;

                trigger OnPreDataItem()
                begin


                    TotalFullPallet := 0;
                    TotalBulkPallet := 0;

                    //CurrReport.CREATETOTALS(NbFullPallet,NBBulkPallet,Quantity,Weight);
                    // CurrReport.CREATETOTALS(Quantity, Weight, NbFullPallet, NBBulkPallet, BoxQty, UnQty);
                    CurrReport.CREATETOTALS(Quantity, NbFullPallet, NBBulkPallet, BoxQty, UnQty); // BC Upgrade BHARDA11 ----Drink-IT Field(Weight)
                end;
            }
            dataitem("Transfer Header"; "Transfer Header")
            {
                DataItemLink = "No." = FIELD("Source No.");
                DataItemLinkReference = "Posted Whse. Shipment Line";
                DataItemTableView = SORTING("No.")
                                    ORDER(Ascending);
                column(TransferHeader_No; "No.")
                {
                }
                column(TransferHeader_FromLocationCode; "Transfer-from Code")
                {
                }
                column(TransferHeader_FromLocationName; "Transfer-from Name")
                {
                }
                column(TransferHeader_ToLocationCode; "Transfer-to Code")
                {
                }
                column(TransferHeader_ToLocationName; "Transfer-to Name")
                {
                }
            }
            dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
            {
                DataItemLink = "Transfer Order No." = FIELD("Source No.");
                DataItemLinkReference = "Posted Whse. Shipment Line";
                DataItemTableView = SORTING("No.")
                                    ORDER(Ascending);
                column(TransferShHeader_No; "No.")
                {
                }
                column(TransferShHeader_FromLocationCode; "Transfer-from Code")
                {
                }
                column(TransferShHeader_FromLocationName; "Transfer-from Name")
                {
                }
                column(TransferShHeader_ToLocationCode; "Transfer-to Code")
                {
                }
                column(TransferShHeader_ToLocationName; "Transfer-to Name")
                {
                }
            }
            dataitem("Sales Header"; "Sales Header")
            {
                // BC Upgrade BHARDA11 >> ----Drink-IT Field("Route Planning No.") -After commenting this property, the report will not open. Currently, this report has a high dependency on the Drink-IT field.
                // DataItemLink = "Route Planning No." = FIELD("Route Planning No."),
                //                "Whse. Shipment No." = FIELD("Whse. Shipment No."),
                //                "Posted Warehouse Shipment No." = FIELD("No.");
                // DataItemTableView = WHERE("Document Type" = CONST(Order),
                //                           "Route Planning No." = FILTER(<> ''));
                // BC Upgrade BHARDA11 << ----Drink-IT Field("Route Planning No.")- After commenting this property, the report will not open. Currently, this report has a high dependency on the Drink-IT field.
                column(SalesOrdersNo; "No.")
                {
                }
                column(SalesOrdersSelltoCustomerNo; "Sell-to Customer No.")
                {
                }
                column(SalesOrdersSelltoCustomerName; "Sell-to Customer Name")
                {
                }
                column(SalesOrdersSelltoCustomerSearchName; Cust."Search Name")
                {
                }
                // BC Upgrade BHARDA11 >> ---Drink-IT Fields("Picking Type","Truck Zone") --This has also been removed from the layout.
                // column(SalesOrdersPickingType; "Picking Type")
                // {
                // }
                // column(SalesOrdersTruckZone; "Truck Zone")
                // {
                // }
                // BC Upgrade BHARDA11 << ---Drink-IT Fields("Picking Type","Truck Zone") --This has also been removed from the layout.


                trigger OnAfterGetRecord()
                begin

                    IF NOT Cust.GET("Sales Header"."Sell-to Customer No.") THEN
                        Cust.INIT;
                end;
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLink = "Posted Whse. Shpmt No. FND" = FIELD("No.");
                column(OrderNo_SalesInvoiceHeader; "Order No.")
                {
                }
                column(SelltoCustomerNo_SalesInvoiceHeader; "Sell-to Customer No.")
                {
                }
                column(SelltoCustomerName_SalesInvoiceHeader; "Sell-to Customer Name")
                {
                }
                column(SalesInvoiceSelltoCustomerSearchName; Cust."Search Name")
                {
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Field("Truck Code")
                // column(TruckCode_SalesInvoiceHeader; "Truck Code")
                // {
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Field("Truck Code")

                trigger OnAfterGetRecord()
                begin
                    IF NOT Cust.GET("Sales Invoice Header"."Sell-to Customer No.") THEN
                        Cust.INIT;

                    //MESSAGE('Posted whse shipment No.',"Sales Invoice Header"."Posted Warehouse Shipment No.");
                end;

                trigger OnPreDataItem()
                begin
                    //MESSAGE('Posted whse shipment No.',"Sales Invoice Header"."Posted Warehouse Shipment No.");
                end;
            }
            dataitem(Visibility; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    ORDER(Ascending)
                                    WHERE(Number = CONST(1));
                column(PostedWhseShipmentNo; PostedWhseShipmentNo)
                {
                }
                column(SalesOrder_Visible; SalesOrderExist)
                {
                }
                column(Transfer_Visible; ("Transfer Header"."No." <> '') OR ("Transfer Shipment Header"."No." <> ''))
                {
                }

                trigger OnAfterGetRecord()
                var
                    SalesHeader: Record "Sales Header";
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    SalesHeaderExist: Boolean;
                    SalesInvoiceHeaderExist: Boolean;
                begin
                    //HEI.02>>
                    SalesOrderExist := FALSE;
                    SalesHeaderExist := FALSE;
                    SalesHeader.RESET;
                    SalesHeader.SETRANGE("Whse. Shipment No. FND", "Posted Whse. Shipment Header"."Whse. Shipment No.");
                    SalesHeader.SETRANGE("Posted Warehouse Ship. No. FND", "Posted Whse. Shipment Header"."No.");
                    // BC Upgrade BHARDA11 >> ----Drink-IT Field (Route,"Route Planning No.")
                    // SalesHeader.SETRANGE(Route, "Posted Whse. Shipment Header".Route);   
                    // SalesHeader.SETRANGE("Route Planning No.", "Posted Whse. Shipment Header"."Route Planning No.");
                    // BC Upgrade BHARDA11 << ----Drink-IT Field (Route,"Route Planning No.")
                    SalesHeaderExist := SalesHeader.FINDFIRST;

                    SalesInvoiceHeaderExist := FALSE;
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETRANGE("Whse. Shipment No. FND", "Posted Whse. Shipment Header"."Whse. Shipment No.");
                    SalesInvoiceHeader.SETRANGE("Posted Whse. Shpmt No. FND", "Posted Whse. Shipment Header"."No.");
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields(Route,"Route Planning No.")
                    // SalesInvoiceHeader.SETRANGE(Route, "Posted Whse. Shipment Header".Route);
                    // SalesInvoiceHeader.SETRANGE("Route Planning No.", "Posted Whse. Shipment Header"."Route Planning No.");
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields(Route,"Route Planning No.")

                    SalesInvoiceHeaderExist := SalesInvoiceHeader.FINDFIRST;

                    SalesOrderExist := SalesHeaderExist OR SalesInvoiceHeaderExist;

                    IF DELSTR(PostedWhseShipmentNo, 1, 3) = "Posted Whse. Shipment Header"."No." THEN
                        PostedWhseShipmentNo := DELSTR(PostedWhseShipmentNo, 1, 3);
                    //HEI.02<<
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // BC Upgrade BHARDA11 >> ----Drink-IT Table (WhseShippingDriver)
                // IF WhseShippingDriver.GET("Posted Whse. Shipment Header"."Driver Code") THEN
                //     DriverName := WhseShippingDriver.Description
                // ELSE
                //     DriverName := '';
                // BC Upgrade BHARDA11 << ----Drink-IT Table (WhseShippingDriver)
                /*  //NaikH01
                IF WhseShippingDriver2.GET("Warehouse Shipment Header"."Driver Assistant") THEN
                  AssistantDriverName := WhseShippingDriver2.Description
                ELSE
                  AssistantDriverName := '';
                */

                PostedWhseShipmentNo += ' & ' + "No."; //HEI.02

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        LblItemDesc = 'Item Designation';
        LblBOXES = 'BOXES';
        LblPALLET = 'PALLET';
        LblFULLPALLET = 'FULL PALLET';
        LblBULKPALLET = 'BULK PALLET';
        LblWEIGHTOFBOXES = 'WEIGHT OF BOXES (KG)';
        LblRETURN = 'RETURN';
        LblNo = 'No.';
        LblLocCode = 'Location Code:';
        LblDriverCode = 'Driver Code:';
        LblAssistantCode = 'Assistant Code:';
        LblTruckCode = 'Truck Code:';
        LblUnits = 'UNITS';
        LblQty = 'QUANTITY';
        Tex003 = 'Signature Controller';
        Tex008 = 'Signature Delivery Man';
        Tex009 = 'Outputs Paletts';
        Tex010 = 'Pallets Entries';
        LblRoute = 'Route:';
        LblSalesOrder = 'Sales Order';
        LBLSelltoCustomerNo = 'Sell-to Customer No.';
        LblSelltoCustomerName = 'Sell-to Customer Name';
        LblSearchName = 'Search Name';
        LblPickingType = 'Picking Type';
        LblTruckZone = 'Truck Zone';
        LblUnitOfMeasure = 'Unit Of Measure';
        LblQuantity = 'Quantity';
        LblRealQuantity = 'Real Quantity';
        LblComments = 'Comments';
        TransferOrderLbl = 'Transfer Order';
        TransferFromCodeLbl = 'Transfer-From Code';
        TransferFromNameLbl = 'Transfer-From Name';
        TransferToCodeLbl = 'Transfer-To Code';
        TransferToNameLbl = 'Transfer-To Name';
    }

    trigger OnInitReport()
    begin

        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        // WhseShippingDriver: Record 2014063; // BC Upgrade BHARDA11 ----Drink-IT Record(2014063)
        // WhseShippingDriver2: Record 2014063; // BC Upgrade BHARDA11 ----Drink-IT Record(2014063)
        Item: Record Item;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        ItemUnitOfMeasure1: Record "Item Unit of Measure";
        ItemUnitOfMeasure2: Record "Item Unit of Measure";
        DriverName: Text[250];
        TotalFullPallet: Decimal;
        TotalBulkPallet: Decimal;
        NBBulkPallet: Decimal;
        NbFullPallet: Decimal;
        TotalQty: Decimal;
        Qty: Decimal;
        NbCol: Integer;
        Text000: Label 'LOADING NOTE OF %1';
        Text003: Label 'Signature Controller';
        Text004: Label 'Time';
        Text005: Label 'Km';
        Text006: Label 'Start';
        Text007: Label 'End';
        Text008: Label 'Signature DelieveryMan';
        Text009: Label 'Outputs Paletts';
        Text010: Label 'Pallets Entries';
        Text011: Label 'Page %1';
        PrintedLine: Integer;
        ShowLine: Integer;
        BoxQty: Decimal;
        UnQty: Decimal;
        SalesOrdersCaption: Label 'Sales Orders';
        Cust: Record Customer;
        Cnt1: Integer;
        SalesOrderExist: Boolean;
        PostedWhseShipmentNo: Text[1024];
}

