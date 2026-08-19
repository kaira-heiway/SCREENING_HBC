report 53015 "Route Posted Truck LoadingNot"
{
    // version HEI.01

    // HEI.01 FDD-PA-LOGGAP05 - Loading Not IBM.NAIKH01 20.11.2017
    //    # Created a new Report
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID - 50076
    // 2. Inside the dataitem ("Sales Header"; "Sales Header"), the Highly Drink-IT field ("Route Planning No.") has a dependency because this field is used for the dataitem link.
    // 3. Inside the dataitem ("Sales Invoice Header"; "Sales Invoice Header"), the Highly Drink-IT field ("Route Planning No.") has a dependency because this field is used for the dataitem link
    // 4. Remove Drink-IT Fields and related code("Route Planning No.", "Truck Code", "Driver Code", "Route", "Weight", "Picking Type", "Truck Zone")
    // 5. Remove Drink-IT Table and related code.
    // 6. Remove Drink-IT fields from dataset columns and these fields have also been removed from the RDLC layout.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Route Posted Truck LoadingNot.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.

    Caption = 'Truck Loading Note Panama';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Posted Whse. Shipment Header"; "Posted Whse. Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = false;
            // RequestFilterFields = "No.", "Location Code", "Shipment Date", "Truck Code", "Driver Code"; // BC Upgrade BHARAD11 ----Drink-IT Fields("Truck Code", "Driver Code")
            RequestFilterFields = "No.", "Location Code", "Shipment Date";
            column(No_WarehouseShipmentHeader; "Posted Whse. Shipment Header"."No.")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(DateTime_Header; FORMAT(TODAY) + '  ' + FORMAT(TIME))
            {
            }
            column(Report_Header; STRSUBSTNO(Text000, "Posted Whse. Shipment Header"."Shipment Date"))
            {
            }
            column(No_Whse_Shipment_Header; "Posted Whse. Shipment Header"."No.")
            {
            }
            column(Location_Code_Whse_Shipment_Header; "Posted Whse. Shipment Header"."Location Code")
            {
            }
            // BC Upgrade BHARAD11 >> ----Drink-It fields("Driver Code","Truck Code",Route),these fields have also been removed from the RDL layout.
            // column(Driver_Code_Whse_Shipment_Header; "Posted Whse. Shipment Header"."Driver Code" + '   ' + DriverName)
            // {
            // }
            // column(Truck_Code_Whse_Shipment_Header; "Posted Whse. Shipment Header"."Truck Code")
            // {
            // }
            // column(Route_WarehouseShipmentHeader; "Posted Whse. Shipment Header".Route)
            // {
            // }
            // BC Upgrade BHARAD11 << ----Drink-It fields("Driver Code","Truck Code",Route),these fields have also been removed from the RDL layout.
            dataitem("Posted Whse. Shipment Line"; "Posted Whse. Shipment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = "Posted Whse. Shipment Header";
                DataItemTableView = SORTING("Item No.")
                                    WHERE(Quantity = FILTER(<> 0));
                PrintOnlyIfDetail = false;
                column(No_WarehouseShipmentLine; "Posted Whse. Shipment Line"."No.")
                {
                }
                column(ItemNo_WarehouseShipmentLine; "Posted Whse. Shipment Line"."Item No.")
                {
                }
                column(Description_WarehouseShipmentLine; "Posted Whse. Shipment Line".Description)
                {
                }
                column(Qty_WhseShipmentLine; "Posted Whse. Shipment Line".Quantity)
                {
                }
                // BC Upgrade BHARAD11 >> ----Drink-IT Field(Weight)
                // column(Weight_WhseShipmentLine; "Posted Whse. Shipment Line".Weight)
                // {
                // }
                // BC Upgrade BHARAD11 << ----Drink-IT Field(Weight)

                column(UnitofMeasureCode_WarehouseShipmentLine; "Posted Whse. Shipment Line"."Unit of Measure Code")
                {
                }
                column(Quantity_WarehouseShipmentLine; "Posted Whse. Shipment Line".Quantity)
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
                    // CurrReport.CREATETOTALS(Quantity, Weight, NbFullPallet, NBBulkPallet, BoxQty, UnQty); // BC Upgrade BHARDA11 ----Drink-IT Field(Weight)
                    CurrReport.CREATETOTALS(Quantity, NbFullPallet, NBBulkPallet, BoxQty, UnQty);

                end;
            }
            dataitem("Sales Header"; "Sales Header")
            {
                // BC Upgrade BHARDA11 >> ----Drink-IT Field("Route Planning No.")----the Highly Drink-IT field ("Route Planning No.") has a dependency because this field is used for the dataitem link
                // DataItemLink = "Route Planning No." = FIELD("Route Planning No.");
                // DataItemTableView = WHERE("Document Type" = CONST(Order),
                //                           "Route Planning No." = FILTER(<> ''));
                // BC Upgrade BHARDA11 << ----Drink-IT Field("Route Planning No.")----the Highly Drink-IT field ("Route Planning No.") has a dependency because this field is used for the dataitem link

                column(SalesOrdersNo; "Sales Header"."No.")
                {
                }
                column(SalesOrdersSelltoCustomerNo; "Sales Header"."Sell-to Customer No.")
                {
                }
                column(SalesOrdersSelltoCustomerName; "Sales Header"."Sell-to Customer Name")
                {
                }
                column(SalesOrdersSelltoCustomerSearchName; Cust."Search Name")
                {
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Picking Type","Truck Zone"),these fields have also been removed from the RDLC layout.
                // column(SalesOrdersPickingType; "Sales Header"."Picking Type")
                // {
                // }
                // column(SalesOrdersTruckZone; "Sales Header"."Truck Zone")
                // {
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Fields("Picking Type","Truck Zone"),these fields have also been removed from the RDLC layout.


                trigger OnAfterGetRecord()
                begin

                    IF NOT Cust.GET("Sales Header"."Sell-to Customer No.") THEN
                        Cust.INIT;
                end;
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                // DataItemLink = "Route Planning No." = FIELD("Route Planning No."); // BC Upgrade BHARAD11 ----Drink-IT Field("Route Planning No."),Inside the dataitem ("Sales Invoice Header"; "Sales Invoice Header"), the Highly Drink-IT field ("Route Planning No.") has a dependency because this field is used for the dataitem link
                column(OrderNo_SalesInvoiceHeader; "Sales Invoice Header"."Order No.")
                {
                }
                column(SelltoCustomerNo_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer No.")
                {
                }
                column(SelltoCustomerName_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer Name")
                {
                }
                column(SalesInvoiceSelltoCustomerSearchName; Cust."Search Name")
                {
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Field("Truck Code")
                // column(TruckCode_SalesInvoiceHeader; "Sales Invoice Header"."Truck Code")
                // {
                // }

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

            trigger OnAfterGetRecord()
            begin

                // BC Upgrade BHARAD11 >> ----Drink-IT Table(WhseShippingDriver)
                // IF WhseShippingDriver.GET("Posted Whse. Shipment Header"."Driver Code") THEN
                //     DriverName := WhseShippingDriver.Description
                // ELSE
                //     DriverName := '';
                // BC Upgrade BHARAD11 << ----Drink-IT Table(WhseShippingDriver)
                /*  //NaikH01
                IF WhseShippingDriver2.GET("Warehouse Shipment Header"."Driver Assistant") THEN
                  AssistantDriverName := WhseShippingDriver2.Description
                ELSE
                  AssistantDriverName := '';
                */

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
    }

    trigger OnInitReport()
    begin

        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        // WhseShippingDriver: Record 2014063; // BC Upgrade BHARAD11 ----Drink-IT Table(2014063)
        // WhseShippingDriver2: Record 2014063; // BC Upgrade BHARAD11 ----Drink-IT Table(2014063)
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
}

