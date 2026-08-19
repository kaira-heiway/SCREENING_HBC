report 54013 "Loading Note - Posted WS STD"
{
    // version HEI.01

    // HEI.01 FDD-PA-LOGGAP05 - Loading Not IBM.NAIKH01 20.11.2017
    //    # Created a new Report
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID is 50292
    // 2. Add ApplicationArea ,UsageCategory property in Report.
    // 3. Add layout path and Change extension RDLC to RDL.
    // 4. Remove Drink-IT Fields from report and layout("Truck Code", "Driver Code",weight,"Picking Type","Truck Zone")
    // 5. Remove Drink-IT Tables and related code(WhseShippingDriver,WhseShippingTruck,2014063,2014068)
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Loading Note - Posted WS STD.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.

    CaptionML = ENU = 'Loading Note - Posted WS STD',
                ESP = 'Doc. Cargue de Camion STD';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Posted Whse. Shipment Header"; "Posted Whse. Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = false;
            // RequestFilterFields = "No.", "Location Code", "Shipment Date", "Truck Code", "Driver Code"; // BC Upgrade BHARDA11 ----drink-IT Fields("Truck Code", "Driver Code")
            RequestFilterFields = "No.", "Location Code", "Shipment Date";
            column(No_WarehouseShipmentHeader; "Posted Whse. Shipment Header"."No.")
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
            column(Report_Header; STRSUBSTNO(Text000, "Posted Whse. Shipment Header"."Shipment Date"))
            {
            }
            column(No_Whse_Shipment_Header; "Posted Whse. Shipment Header"."No.")
            {
            }
            column(Location_Code_Whse_Shipment_Header; "Posted Whse. Shipment Header"."Location Code" + '  ' + Location.Name)
            {
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Driver Code","Truck Code") and It has been removed from the layout as well.
            // column(Driver_Code_Whse_Shipment_Header; "Posted Whse. Shipment Header"."Driver Code" + '   ' + DriverName)
            // {
            // }
            // column(Truck_Code_Whse_Shipment_Header; "Posted Whse. Shipment Header"."Truck Code" + '   ' + WhseShippingTruck.Description)
            // {
            // }
            // column(Route_WarehouseShipmentHeader; "Posted Whse. Shipment Header".Route)
            // {
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Driver Code","Truck Code") and It has been removed from the layout as well.

            column(ShowSOList; ShowSOList)
            {
            }
            dataitem("Posted Whse. Shipment Line"; "Posted Whse. Shipment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = "Posted Whse. Shipment Header";
                DataItemTableView = SORTING("Item No.")
                                    WHERE(Quantity = FILTER(<> 0));
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
                // BC Upgrade BHARDA11 >> ----Drink-IT Field(Weight) It was not being used anywhere in the layout.
                // column(Weight_WhseShipmentLine; "Posted Whse. Shipment Line".Weight)
                // {
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Field(Weight) It was not being used anywhere in the layout.

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
                column(SourceNo_whseShipmentline; "Posted Whse. Shipment Line"."Source No.")
                {
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
                    // CurrReport.CREATETOTALS(Quantity, Weight, NbFullPallet, NBBulkPallet, BoxQty, UnQty); // BC Upgrade BHARDA11 ----Drink-IT Field(Weight) 
                end;
            }
            dataitem("Sales Shipment Header"; "Sales Shipment Header")
            {
                DataItemLink = "Whse. Shipment No. FND" = FIELD("Whse. Shipment No.");
                DataItemTableView = SORTING("No.");
                column(SalesOrdersNo; "Sales Shipment Header"."Order No.")
                {
                }
                column(SalesOrdersSelltoCustomerNo; "Sales Shipment Header"."Sell-to Customer No.")
                {
                }
                column(SalesOrdersSelltoCustomerName; "Sales Shipment Header"."Sell-to Customer Name")
                {
                }
                column(SalesOrdersSelltoCustomerSearchName; Cust."Search Name")
                {
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Field("Picking Type","Truck Zone") It was not being used anywhere in the layout.

                // column(SalesOrdersPickingType; "Sales Shipment Header"."Picking Type")
                // {
                // }
                // column(SalesOrdersTruckZone; "Sales Shipment Header"."Truck Zone")
                // {
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Field("Picking Type","Truck Zone") It was not being used anywhere in the layout.

                trigger OnAfterGetRecord();
                begin

                    IF NOT Cust.GET("Sales Shipment Header"."Sell-to Customer No.") THEN
                        Cust.INIT;

                    //Cnt1 := Cnt1+1;
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
            dataitem(TransferWhseShipment; "Posted Whse. Shipment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Source Document", "Source No.")
                                    WHERE(Quantity = FILTER(<> 0),
                                          "Source Document" = CONST("Outbound Transfer"));
                column(TransferOrder_No; TransferWhseShipment."Source No.")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    IF TransferOrderNo <> TransferWhseShipment."Source No." THEN
                        TransferOrderNo := TransferWhseShipment."Source No."
                    ELSE
                        CurrReport.SKIP;
                end;

                trigger OnPreDataItem();
                begin
                    CLEAR(TransferOrderNo);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                // BC Upgrade BHARDA11 >> ----Drink-IT Table(WhseShippingDriver)
                // IF WhseShippingDriver.GET("Driver Code") THEN
                //     DriverName := WhseShippingDriver.Description
                // ELSE
                //     DriverName := '';
                // BC Upgrade BHARDA11 << ----Drink-IT Table(WhseShippingDriver)
                /*  //NaikH01
                IF WhseShippingDriver2.GET("Warehouse Shipment Header"."Driver Assistant") THEN
                  AssistantDriverName := WhseShippingDriver2.Description
                ELSE
                  AssistantDriverName := '';
                */

                IF Location.GET("Location Code") THEN;
                // IF WhseShippingTruck.GET("Truck Code") THEN; // BC Upgrade BHARDA11 >> ----Drink-IT Table(WhseShippingTruck)
                WarehouseShipmentLine.RESET;
                WarehouseShipmentLine.SETRANGE("No.", "No.");
                IF WarehouseShipmentLine.FINDFIRST THEN
                    IF WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Sales Order" THEN
                        ShowSOList := TRUE;

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
        label(LblItemDesc; ENU = 'Item Description',
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
        label(LblLocCode; ENU = 'Location Code and Description:',
                         FRA = 'Code et description du magasin:')
        label(LblDriverCode; ENU = 'Driver Code and Description:',
                            FRA = 'Code et description du chauffeur:')
        LblAssistantCode = 'Assistant Code:'; label(LblTruckCode; ENU = 'Truck Code and Description:',
                                                                FRA = 'Code et description du camion:')
        LblUnits = 'UNITS'; LblQty = 'QUANTITY'; label(Tex003; ENU = 'Signature Warehouse',
                                                            FRA = 'Signature du contrôleur')
        label(Tex008; ENU = 'Signature Driver',
                     FRA = 'Signature livreur')
        label(Tex009; ENU = 'Outputs Paletts',
                     FRA = 'Palettes sorties')
        label(Tex010; ENU = 'Pallets Entries',
                     FRA = 'Palettes entrées')
        LblRoute = 'Route:'; label(LblSalesOrder; ENU = 'Sales Order',
                                                FRA = 'Commande vente')
        label(LBLSelltoCustomerNo; ENU = 'Sell-to Customer No.',
                                  FRA = 'N° donneur d'' ordre')
        label(LblSelltoCustomerName; ENU = 'Sell-to Customer Name',
                                    FRA = 'Nom du donneur d'' ordre')
        label(LblSearchName; ENU = 'Search Name',
                            FRA = 'Nom de recherche')
        LblPickingType = 'Picking Type'; LblTruckZone = 'Truck Zone'; label(LblUnitOfMeasure; ENU = 'Unit Of Measure',
                                                                                           FRA = 'Code unite')
        label(LblQuantity; ENU = 'Quantity',
                          FRA = 'Quantité')
        label(LblRealQuantity; ENU = 'Real Quantity',
                              FRA = 'Quantité réelle')
        label(LblComments; ENU = 'Comments',
                          FRA = 'Commentaires')
        label(LblDocNo; ENU = 'Document No.:',
                       FRA = 'Numéro de document:')
        label(LblTransferOrders; ENU = 'Transfer Order',
                                FRA = 'Ordre de transfert')
        label(LblPage; ENU = 'Page',
                      FRA = 'Numéro de page')
        label(LblTotal; ENU = 'Total quantity per unit of measure',
                       FRA = 'Quantité totale par unité de mesure ')
    }

    trigger OnInitReport();
    begin

        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        // WhseShippingDriver: Record 2014063; // BC Upgrade BHARDA11 ----Drink-IT Table(2014063)
        // WhseShippingDriver2: Record 2014063; // BC Upgrade BHARDA11 ----Drink-IT Table(2014063)
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
        Text003: TextConst ENU = 'Signature Warehouse', FRA = 'Signature du contrôleur';
        Text004: TextConst ENU = 'Time', FRA = 'Heure';
        Text005: TextConst ENU = 'Km', FRA = 'Km';
        Text006: TextConst ENU = 'Start', FRA = 'Départ';
        Text007: TextConst ENU = 'End', FRA = 'Arrivée';
        Text008: TextConst ENU = 'Signature Driver', FRA = 'Signature livreur';
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
        Location: Record Location;
        // WhseShippingTruck: Record 2014068; // BC Upgrade BHARDA11 ----Drink-IT Table(2014068)
        ShowSOList: Boolean;
        WarehouseShipmentLine: Record "Posted Whse. Shipment Line";
        TransferOrderNo: Code[20];
}

