report 54017 "Load List BA"
{
    // version HEI.02

    // HEI.01 FDD-PA-LOGGAP05 - Loading Not IBM.NAIKH01 20.11.2017
    //    # Created a new Report
    // HEI.02 Bugfixing Bahamas IBM NASTAA02 19.02.2019 # Load List Bahamas
    //   # Copied Report 50068 - Truck Load Panama and created new Bahamas Report
    // HEI.03 FDD- HB596 IBM BULIMC01 16.05.2019 # Quantity field changed into "Qty to Ship"
    //   # "Qty to pick" filter deleted from Warehouse Shipment Line DataItem.
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID - 50243.
    // 2. Add layout path and Change extension RDLC to RDL.
    // 3. In Sales Header DataItem DataitemLink property is comment because the Highly Drink-IT field ("Route Planning No.") has a dependency because this field is used for the dataitem link
    // 4. Remove Drink-IT Fields and related code("Driver Code","Truck Code",Route,"Route Planning No.","Picking Type","Truck Zone")
    // 5. Add ApplicationArea property in Report.
    // 6. Blank Drink-IT Fields Related columns.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Load List BA.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.

    Caption = 'Load List Bahamas';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Warehouse Shipment Header"; "Warehouse Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = false;
            // RequestFilterFields = "No.", "Location Code", "Shipment Date", "Truck Code", "Driver Code";
            RequestFilterFields = "No.", "Location Code", "Shipment Date"; // BC Upgrade BHARDA11 ----Drink-IT Field(, "Truck Code", "Driver Code")
            column(No_WarehouseShipmentHeader; "Warehouse Shipment Header"."No.")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(DateTime_Header; FORMAT(TODAY) + '  ' + FORMAT(TIME))
            {
            }
            column(Report_Header; STRSUBSTNO(Text000, "Warehouse Shipment Header"."Shipment Date"))
            {
            }
            column(No_Whse_Shipment_Header; "Warehouse Shipment Header"."No.")
            {
            }
            column(Location_Code_Whse_Shipment_Header; "Warehouse Shipment Header"."Location Code")
            {
            }
            // BC Upgrade BHARDA11 >>----Drink-IT Fields("Driver Code","Truck Code",Route)
            // column(Driver_Code_Whse_Shipment_Header; "Warehouse Shipment Header"."Driver Code" + '   ' + DriverName)
            // {
            // }
            // column(Truck_Code_Whse_Shipment_Header; "Warehouse Shipment Header"."Truck Code")
            // {
            // }
            // column(Route_WarehouseShipmentHeader; "Warehouse Shipment Header".Route)
            // {
            // }
            column(Driver_Code_Whse_Shipment_Header; '' + '   ' + DriverName) // Because of Frink-IT Field we passed blank
            {
            }
            column(Truck_Code_Whse_Shipment_Header; '') // Because of Frink-IT Field we passed blank
            {
            }
            column(Route_WarehouseShipmentHeader; '') // Because of Frink-IT Field we passed blank
            {
            }
            // BC Upgrade BHARDA11 <<----Drink-IT Fields("Driver Code","Truck Code",Route)
            dataitem("Warehouse Shipment Line"; "Warehouse Shipment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = "Warehouse Shipment Header";
                DataItemTableView = SORTING("Item No.")
                                    WHERE(Quantity = FILTER(<> 0));
                PrintOnlyIfDetail = false;
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
                column(No_WarehouseShipmentLine; "Warehouse Shipment Line"."No.")
                {
                }
                column(ItemNo_WarehouseShipmentLine; "Warehouse Shipment Line"."Item No.")
                {
                }
                column(Description_WarehouseShipmentLine; "Warehouse Shipment Line".Description)
                {
                }
                column(Qty_WhseShipmentLine; "Warehouse Shipment Line"."Qty. Picked")
                {
                }
                column(Weight_WhseShipmentLine; "Warehouse Shipment Line".Weight)
                {
                }
                column(UnitofMeasureCode_WarehouseShipmentLine; "Warehouse Shipment Line"."Unit of Measure Code")
                {
                }
                column(Quantity_WarehouseShipmentLine; "Warehouse Shipment Line"."Qty. Picked")
                {
                }
                column(QtytoShip_WarehouseShipmentLine; "Warehouse Shipment Line"."Qty. to Ship")
                {
                }
                dataitem("Transfer Header"; "Transfer Header")
                {
                    DataItemLink = "No." = FIELD("Source No.");
                    DataItemLinkReference = "Warehouse Shipment Line";
                    DataItemTableView = SORTING("No.")
                                        ORDER(Ascending);
                    column(TransferHeader_No; "Transfer Header"."No.")
                    {
                    }
                    column(TransferHeader_FromLocationCode; "Transfer Header"."Transfer-from Code")
                    {
                    }
                    column(TransferHeader_FromLocationName; "Transfer Header"."Transfer-from Name")
                    {
                    }
                    column(TransferHeader_ToLocationCode; "Transfer Header"."Transfer-to Code")
                    {
                    }
                    column(TransferHeader_ToLocationName; "Transfer Header"."Transfer-to Name")
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        WarehouseShipmentLine.RESET;
                        WarehouseShipmentLine.SETRANGE("Source Document", WarehouseShipmentLine."Source Document"::"Outbound Transfer");
                        WarehouseShipmentLine.SETRANGE("Source No.", TransferHeader."No.");
                        WarehouseShipmentLine.CALCSUMS("Qty. to Ship");

                        IF "Warehouse Shipment Line"."Qty. to Ship" = 0 THEN
                            CurrReport.SKIP;
                    end;
                }

                trigger OnAfterGetRecord();
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

                    IF "Unit of Measure Code" = 'UN' THEN
                        UnQty := Quantity
                    ELSE
                        BoxQty := Quantity;

                    TotalBulkPallet += NBBulkPallet;
                    TotalFullPallet += NbFullPallet;
                end;

                trigger OnPreDataItem();
                begin

                    TotalFullPallet := 0;
                    TotalBulkPallet := 0;

                    //CurrReport.CREATETOTALS(NbFullPallet,NBBulkPallet,Quantity,Weight);
                    CurrReport.CREATETOTALS(Quantity, Weight, NbFullPallet, NBBulkPallet, BoxQty, UnQty);
                end;
            }
            dataitem("Sales Header"; "Sales Header")
            {
                // BC Upgrade BHARDA11 >> ----Drink-IT Field("Route Planning No.")----the Highly Drink-IT field ("Route Planning No.") has a dependency because this field is used for the dataitem link
                // DataItemLink = "Route Planning No." = FIELD("Route Planning No."),
                //                "Whse. Shipment No. (First)" = FIELD("No.");
                // BC Upgrade BHARDA11 << ----Drink-IT Field("Route Planning No.")----the Highly Drink-IT field ("Route Planning No.") has a dependency because this field is used for the dataitem link
                DataItemTableView = WHERE("Document Type" = CONST(Order));
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
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Picking Type","Truck Zone") and i have removed also in layout
                // column(SalesOrdersPickingType; "Sales Header"."Picking Type")
                // {
                // }
                // column(SalesOrdersTruckZone; "Sales Header"."Truck Zone")
                // {
                // }
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Picking Type","Truck Zone") and i have removed also in layout
                column(SalesOrder_Address; "Sales Header"."Sell-to Address")
                {
                }

                trigger OnAfterGetRecord();
                begin

                    IF NOT Cust.GET("Sales Header"."Sell-to Customer No.") THEN
                        Cust.INIT;

                    //Cnt1 := Cnt1+1;
                    WarehouseShipmentLine.RESET;
                    WarehouseShipmentLine.SETRANGE("Source Document", WarehouseShipmentLine."Source Document"::"Sales Order");
                    WarehouseShipmentLine.SETRANGE("Source No.", "Sales Header"."No.");
                    WarehouseShipmentLine.CALCSUMS("Qty. to Ship");

                    IF WarehouseShipmentLine."Qty. to Ship" = 0 THEN
                        CurrReport.SKIP;
                end;

                trigger OnPostDataItem();
                begin
                    //MESSAGE('Count is %1',Cnt1);
                end;

                trigger OnPreDataItem();
                begin
                    Cnt1 := 0;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                // BC Upgrade BHARDA11 >>----Drink-IT Record (WhseShippingDriver)
                // IF WhseShippingDriver.GET("Warehouse Shipment Header"."Driver Code") THEN
                //     DriverName := WhseShippingDriver.Description
                // ELSE
                //     DriverName := '';
                // BC Upgrade BHARDA11 <<----Drink-IT Record (WhseShippingDriver)
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
        label(LblItemDesc; ENU = 'Item Designation',
                          FRA = 'DESCRIPTION ARTICLE')
        label(LblBOXES; ENU = 'BOXES',
                       FRA = 'COLIS')
        label(LblPALLET; ENU = 'PALLET',
                        FRA = 'PALETTE')
        label(LblFULLPALLET; ENU = 'FULL PALLET',
                            FRA = 'COMPLETE')
        label(LblBULKPALLET; ENU = 'BULK PALLET',
                            FRA = 'A REPARTIR')
        label(LblWEIGHTOFBOXES; ENU = 'WEIGHT OF BOXES (KG)',
                               FRA = 'POIDS DES COLIS (KG)')
        label(LblRETURN; ENU = 'RETURN',
                        FRA = 'RETOUR')
        label(LblNo; ENU = 'No.',
                    FRA = 'N° expédition')
        LblLocCode = 'Location Code:'; LblDriverCode = 'Driver Code:'; LblAssistantCode = 'Assistant Code:'; LblTruckCode = 'Truck Code:'; LblUnits = 'UNITS'; LblQty = 'QUANTITY'; label(Tex003; ENU = 'Signature Controller',
                                                                                                                                                                                           FRA = 'Signature du contrôleur')
        label(Tex008; ENU = 'Signature Delivery Man',
                     FRA = 'Signature livreur')
        label(Tex009; ENU = 'Outputs Paletts',
                     FRA = 'Palettes sorties')
        label(Tex010; ENU = 'Pallets Entries',
                     FRA = 'Palettes entrées')
        LblRoute = 'Route:'; LblSalesOrder = 'Sales Order'; LBLSelltoCustomerNo = 'Sell-to Customer No.'; LblSelltoCustomerName = 'Sell-to Customer Name'; LblSearchName = 'Search Name'; LblPickingType = 'Sell-to Address'; LblTruckZone = 'Truck Zone'; LblUnitOfMeasure = 'Unit Of Measure'; LblQuantity = 'Quantity'; LblRealQuantity = 'Real Quantity'; LblComments = 'Comments'; TransferOrderLbl = 'Transfer Order'; TransferFromCodeLbl = 'Transfer-From Code'; TransferFromNameLbl = 'Transfer-From Name'; TransferToCodeLbl = 'Transfer-To Code'; TransferToNameLbl = 'Transfer-To Name';
    }

    trigger OnInitReport();
    begin

        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";

        // WhseShippingDriver: Record 2014063;  // BC Upgrade BHARDA11 ----Drink-IT Record (2014063)
        // WhseShippingDriver2: Record 2014063; // BC Upgrade BHARDA11 ----Drink-IT Record (2014063)
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
        Text000: TextConst ENU = 'LOADING NOTE OF %1', FRA = 'BORDEREAU DE CHARGEMENT DU %1';
        Text003: TextConst ENU = 'Signature Controller', FRA = 'Signature du contrôleur';
        Text004: TextConst ENU = 'Time', FRA = 'Heure';
        Text005: TextConst ENU = 'Km', FRA = 'Km';
        Text006: TextConst ENU = 'Start', FRA = 'Départ';
        Text007: TextConst ENU = 'End', FRA = 'Arrivée';
        Text008: TextConst ENU = 'Signature DelieveryMan', FRA = 'Signature livreur';
        Text009: TextConst ENU = 'Outputs Paletts', FRA = 'Palettes sorties';
        Text010: TextConst ENU = 'Pallets Entries', FRA = 'Palettes entrées';
        Text011: Label 'Page %1';
        PrintedLine: Integer;
        ShowLine: Integer;
        BoxQty: Decimal;
        UnQty: Decimal;
        SalesOrdersCaption: Label 'Sales Orders';
        Cust: Record Customer;
        Cnt1: Integer;
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        TransferHeader: Record "Transfer Header";
}

