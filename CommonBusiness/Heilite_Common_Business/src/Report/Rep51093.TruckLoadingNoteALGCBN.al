report 51093 "Truck Loading Note ALG CBN"
{
    // version HEI.01

    // HEI.01 FDD-PA-LOGGAP05 - Loading Not IBM.NAIKH01 20.11.2017
    //    # Created a new Report
    // BC Upgrade BHARAD11 >>
    // 1. Add ApplicationArea Property in Report.
    // 2. Remove Drink-IT Fields, Tables and related code("Truck Code","Driver Code",Route,"Route Planning No.","Picking Type","Truck Zone")
    // 3. Change Language To LanguageMgt and Record to codeunit and use function GetLanguageID.
    // 4. Old Report ID - 50088.
    // 5. Remove Drink-IT Fields related column in Dataset as well as from the layout.
    // 6. Inside the dataitem ("Sales Header"; "Sales Header"), the Highly Drink-IT field ("Route Planning No.") has a dependency because this field is used for the dataitem link
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Truck Loading Note ALG.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.
    Caption = 'Truck Loading Note Alg';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Warehouse Shipment Header"; "Warehouse Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = false;
            // RequestFilterFields = "No.", "Location Code", "Shipment Date", "Truck Code", "Driver Code"; // BC Upgrade BHARDA11 ----Drink-IT Field("Truck Code","Driver Code")
            RequestFilterFields = "No.", "Location Code", "Shipment Date";
            column(No_WarehouseShipmentHeader; "Warehouse Shipment Header"."No.")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
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
            // BC Upgrade BHARDA11 >> ----Drink-IT Field("Driver Code","Truck Code",Route)
            // column(Driver_Code_Whse_Shipment_Header; "Warehouse Shipment Header"."Driver Code" + '   ' + DriverName)
            // {
            // }
            // column(Truck_Code_Whse_Shipment_Header; "Warehouse Shipment Header"."Truck Code")
            // {
            // }
            // column(Route_WarehouseShipmentHeader; "Warehouse Shipment Header".Route)
            // {
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Field("Driver Code","Truck Code",Route)

            dataitem("Warehouse Shipment Line"; "Warehouse Shipment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = "Warehouse Shipment Header";
                DataItemTableView = SORTING("Item No.")
                                    WHERE(Quantity = FILTER(<> 0));
                PrintOnlyIfDetail = false;
                column(No_WarehouseShipmentLine; "Warehouse Shipment Line"."No.")
                {
                }
                column(ItemNo_WarehouseShipmentLine; "Warehouse Shipment Line"."Item No.")
                {
                }
                column(Description_WarehouseShipmentLine; "Warehouse Shipment Line".Description)
                {
                }
                column(Qty_WhseShipmentLine; "Warehouse Shipment Line".Quantity)
                {
                }
                column(Weight_WhseShipmentLine; "Warehouse Shipment Line".Weight)
                {
                }
                column(UnitofMeasureCode_WarehouseShipmentLine; "Warehouse Shipment Line"."Unit of Measure Code")
                {
                }
                column(Quantity_WarehouseShipmentLine; "Warehouse Shipment Line".Quantity)
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

                    IF "Unit of Measure Code" = 'UN' THEN
                        UnQty := Quantity
                    ELSE
                        BoxQty := Quantity;

                    TotalBulkPallet += NBBulkPallet;
                    TotalFullPallet += NbFullPallet;
                end;

                trigger OnPreDataItem()
                begin

                    TotalFullPallet := 0;
                    TotalBulkPallet := 0;

                    //CurrReport.CREATETOTALS(NbFullPallet,NBBulkPallet,Quantity,Weight);
                    CurrReport.CREATETOTALS(Quantity, Weight, NbFullPallet, NBBulkPallet, BoxQty, UnQty);
                end;
            }
            dataitem("Sales Header"; "Sales Header")
            {
                // BC Upgrade BHARAD11 >> ----Drink-IT Fields("Route Planning No.") ---Inside the dataitem ("Sales Header"; "Sales Header"), the Highly Drink-IT field ("Route Planning No.") has a dependency because this field is used for the dataitem link
                // DataItemLink = "Route Planning No." = FIELD("Route Planning No."),
                //                "Whse. Shipment No. (First)" = FIELD("No.");
                // DataItemTableView = WHERE("Document Type" = CONST(Order),
                //                           "Route Planning No." = FILTER(<> ''));
                // BC Upgrade BHARAD11 << ----Drink-IT Fields("Route Planning No.") ---Inside the dataitem ("Sales Header"; "Sales Header"), the Highly Drink-IT field ("Route Planning No.") has a dependency because this field is used for the dataitem link

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
                // BC Upgrade BHARAD11 >> ----Drink-IT Fields("Picking Type","Truck Zone") --Also removed from layout
                // column(SalesOrdersPickingType; "Sales Header"."Picking Type")
                // {
                // }
                // column(SalesOrdersTruckZone; "Sales Header"."Truck Zone")
                // {
                // }
                // BC Upgrade BHARAD11 << ----Drink-IT Fields("Picking Type","Truck Zone") --Also removed from layout


                trigger OnAfterGetRecord()
                begin

                    IF NOT Cust.GET("Sales Header"."Sell-to Customer No.") THEN
                        Cust.INIT;

                    //Cnt1 := Cnt1+1;
                end;

                trigger OnPostDataItem()
                begin
                    //MESSAGE('Count is %1',Cnt1);
                end;

                trigger OnPreDataItem()
                begin
                    Cnt1 := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // BC Upgrade BHARAD11 >> ----Drink-IT Table(WhseShippingDriver)
                // IF WhseShippingDriver.GET("Warehouse Shipment Header"."Driver Code") THEN
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
        Tex003 = 'Signature chauffeur/ Client';
        Tex008 = 'Signature sécurité';
        Tex009 = 'Outputs Paletts';
        Tex010 = 'Pallets Entries';
        Tex011 = 'Signature Contrôleur';
        Tex012 = 'Signature Chargé de magasin';
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

        // BASE FCE01-
        gCodLanguage := CompanyInfo."Language Code FND";
        // BASe FCE01+
    end;

    trigger OnPreReport()
    begin
        //FCE-
        // CurrReport.LANGUAGE := Language.GetLanguageID(gCodLanguage); // BC Upgrade BHARAD11 ::Blocked
        CurrReport.LANGUAGE := LanguageMgt.GetLanguageID(gCodLanguage); // BC Upgrade BHARAD11 ::Added

        // FCE+
    end;

    var
        CompanyInfo: Record "Company Information";
        // WhseShippingDriver: Record 2014063; // BC UPGRADE BHARDA11 ----Drink-IT Table(2014063)
        // WhseShippingDriver2: Record 2014063; // BC UPGRADE BHARDA11 ----Drink-IT Table(2014063)
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
        gCodLanguage: Code[10];
        // Language: Record Language; // BC Upgrade BHARDA11 ::Blocked
        LanguageMgt: Codeunit Language;
}

