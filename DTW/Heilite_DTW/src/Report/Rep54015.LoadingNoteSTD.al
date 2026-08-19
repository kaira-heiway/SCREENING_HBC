report 54015 "Loading Note STD"
{
    // version HEI.01

    // HEI.01 FDD-PA-LOGGAP05 - Loading Not IBM.NAIKH01 20.11.2017
    //    # Created a new Report
    // HEI.02 CHG2105841 IBM GHOSHS05 22.06.2021 LblCountedQuantity added and RDLC layout changed

    // BC Upgrade RAHUL>>
    // 1. Added ApplicationArea = All property at report level for BC visibility.
    // 2. Added UsageCategory = ReportsAndAnalysis property at report level for BC searchability.
    // 3. Blocked RequestFilterFields containing Drink-IT fields ("Truck Code","Driver Code").
    //    - Old: RequestFilterFields = "No.", "Location Code", "Shipment Date", "Truck Code", "Driver Code";
    //    - New: RequestFilterFields = "No.", "Location Code", "Shipment Date";
    // 4. Blocked dataset columns due to removed Drink-IT fields from "Warehouse Shipment Header":
    //    - Driver Code column
    //    - Truck Code column
    //    - Route column
    // 5. Replaced Sales Header DataItemLink logic because field "Whse. Shipment No. (First)" is not available in BC.
    //    - Old: CalcFields = "Whse. Shipment No. (First)";
    //           DataItemLink = "Whse. Shipment No. (First)" = FIELD("No.");
    //    - New: DataItemLink = "Whse. Shipment No." = field("No.");
    // 6. Blocked Sales Header columns due to Drink-IT fields not available in BC:
    //    - Picking Type
    //    - Truck Zone
    // 7. Blocked Driver lookup logic in OnAfterGetRecord() due to missing Drink-IT table "Whse. Shipping Driver".
    // 8. Blocked Truck lookup logic due to missing Drink-IT table "Whse. Shipping Truck".
    // 9. Commented out variable declarations for Drink-IT custom tables:
    //    - WhseShippingDriver, WhseShippingDriver2, WhseShippingTruck
    // 10. Removing DIT Colomns from Report Layout(Driver_Code_Whse_Shipment_Header,Truck_Code_Whse_Shipment_Header,Route_WarehouseShipmentHeader,SalesOrdersPickingType,SalesOrdersTruckZone)
    // 11. Old Report Id- 50263
    // BC Upgrade RAHUL<<

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Loading Note STD.rdl';
    CaptionML = ENU = 'Loading Note STD',
                ESP = 'Doc. Cargue de Camion STD';
    PreviewMode = PrintLayout;
    ApplicationArea = All; // BC Upgrade RAHUL Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade RAHUL Adding Usagecategory

    // BC Upgrade SHUKLP03 >> Replaced all DIT fields.

    dataset
    {
        dataitem("Warehouse Shipment Header"; "Warehouse Shipment Header")
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = false;
            // RequestFilterFields = "No.", "Location Code", "Shipment Date", "Truck Code", "Driver Code"; //BC Upgrade RAHUL Blocking Due to DIT Field("Truck Code","Driver Code").
            RequestFilterFields = "No.", "Location Code", "Shipment Date", "Vehicle Code 101FDW", "Log Driver 107FDW";//BC Upgrade SHUKLP03 
            column(No_WarehouseShipmentHeader; "Warehouse Shipment Header"."No.")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(DateTime_Header; Format(Today) + '  ' + Format(Time))
            {
            }
            column(Report_Header; StrSubstNo(Text000, "Warehouse Shipment Header"."Shipment Date"))
            {
            }
            column(No_Whse_Shipment_Header; "Warehouse Shipment Header"."No.")
            {
            }
            column(Location_Code_Whse_Shipment_Header; "Warehouse Shipment Header"."Location Code" + '  ' + Location.Name)
            {
            }
            // BC Upgrade SHUKLP03>> 
            column(Driver_Code_Whse_Shipment_Header; "Warehouse Shipment Header"."Log Driver 107FDW" + '   ' + DriverName)
            {
            }
            column(Truck_Code_Whse_Shipment_Header; "Warehouse Shipment Header"."Vehicle Code 101FDW" + '   ' + WhseShippingTruck.Description)
            {
            }
            column(Route_WarehouseShipmentHeader; "Warehouse Shipment Header"."Route 107FDW")
            {
            }
            // BC Upgrade SHUKLP03<<  
            column(ShowSOList; ShowSOList)
            {
            }
            dataitem("Warehouse Shipment Line"; "Warehouse Shipment Line")
            {
                DataItemLink = "No." = field("No.");
                DataItemLinkReference = "Warehouse Shipment Header";
                DataItemTableView = sorting("Item No.") where(Quantity = filter(<> 0));
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
                column(Quantity_WarehouseShipmentLine; "Warehouse Shipment Line"."Qty. to Ship")
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
                column(SourceNo_whseShipmentline; "Warehouse Shipment Line"."Source No.")
                {
                }

                trigger OnAfterGetRecord();
                begin

                    NBBulkPallet := 0;
                    NbFullPallet := 0;

                    if ItemUnitOfMeasure.Get("Item No.", 'COL') then
                        NBBulkPallet := Round(Quantity / ItemUnitOfMeasure."Qty. per Unit of Measure", 1, '<')
                    else
                        NBBulkPallet := Round(Quantity, 1, '<');

                    if not ItemUnitOfMeasure.Get("Item No.", 'PAL') then begin
                        NbFullPallet := 0;
                        NBBulkPallet := NBBulkPallet
                    end else begin
                        NbFullPallet := Round(Quantity / ItemUnitOfMeasure."Qty. per Unit of Measure", 1, '<');
                        NBBulkPallet := NBBulkPallet - (NbFullPallet * ItemUnitOfMeasure."Qty. per Unit of Measure");
                    end;

                    if "Unit of Measure Code" = 'UN' then
                        UnQty := Quantity
                    else
                        BoxQty := Quantity;

                    TotalBulkPallet += NBBulkPallet;
                    TotalFullPallet += NbFullPallet;
                end;

                trigger OnPreDataItem();
                begin

                    TotalFullPallet := 0;
                    TotalBulkPallet := 0;

                    //CurrReport.CREATETOTALS(NbFullPallet,NBBulkPallet,Quantity,Weight);
                    CurrReport.CreateTotals(Quantity, Weight, NbFullPallet, NBBulkPallet, BoxQty, UnQty);
                end;
            }
            dataitem("Sales Header"; "Sales Header")
            {

                // BC Upgrade RAHUL>>  Blocking Due to DIT Fields.
                // CalcFields = "Whse. Shipment No. (First)";
                // DataItemLink = "Whse. Shipment No. (First)" = FIELD("No.");
                // BC Upgrade RAHUL<<  Blocking Due to DIT Fields.

                DataItemLink = "No." = field("source no. FND");   // BC Upgrade SHUKLP03>>  changed link property.
                DataItemTableView = where("Document Type" = const(Order));
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
                // BC Upgrade SHUKLP03 >> Obsolete
                // column(SalesOrdersPickingType; "Sales Header"."Picking Type")
                // {
                // }
                // column(SalesOrdersTruckZone; "Sales Header"."Truck Zone")
                // {
                // }
                // BC Upgrade SHUKLP03 << Obsolete

                trigger OnAfterGetRecord();
                begin

                    if not Cust.Get("Sales Header"."Sell-to Customer No.") then
                        Cust.Init();

                    //Cnt1 := Cnt1+1;
                end;

                trigger OnPostDataItem();
                begin
                    //MESSAGE('Count is %1',Cnt1);
                end;

                trigger OnPreDataItem();
                begin
                    Cnt1 := 0;
                    // "Sales Header".CALCFIELDS("Whse. Shipment No."); // BC Upgrade RAHUL>>  Blocking Due to DIT Fields.
                end;
            }
            dataitem(TransferWhseShipment; "Warehouse Shipment Line")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.", "Source Document", "Source No.") where(Quantity = filter(<> 0), "Source Document" = const("Outbound Transfer"));
                column(TransferOrder_No; TransferWhseShipment."Source No.")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    if TransferOrderNo <> TransferWhseShipment."Source No." then
                        TransferOrderNo := TransferWhseShipment."Source No."
                    else
                        CurrReport.Skip();
                end;

                trigger OnPreDataItem();
                begin
                    Clear(TransferOrderNo);
                end;
            }

            trigger OnAfterGetRecord();
            begin

                // BC Upgrade SHUKLP03>> 
                if WhseShippingDriver.GET("Warehouse Shipment Header"."Log Driver 107FDW") then
                    DriverName := WhseShippingDriver.Description
                else
                    DriverName := '';
                // BC Upgrade SHUKLP03<< 

                /*  //NaikH01
                IF WhseShippingDriver2.GET("Warehouse Shipment Header"."Driver Assistant") THEN
                  AssistantDriverName := WhseShippingDriver2.Description
                ELSE
                  AssistantDriverName := '';
                */

                if Location.Get("Warehouse Shipment Header"."Location Code") then;
                if WhseShippingTruck.GET("Warehouse Shipment Header"."Vehicle Code 101FDW") then;  // BC Upgrade SHUKLP03>> 
                WarehouseShipmentLine.Reset();
                WarehouseShipmentLine.SetRange("No.", "Warehouse Shipment Header"."No.");
                if WarehouseShipmentLine.FindFirst() then
                    if WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Sales Order" then
                        ShowSOList := true;

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
        label(LblCountedQuantity; ENU = 'Counted Quantity',
                                 FRA = 'Quantité Comptée')
    }

    trigger OnInitReport();
    begin

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        Item: Record Item;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        ItemUnitOfMeasure1: Record "Item Unit of Measure";
        ItemUnitOfMeasure2: Record "Item Unit of Measure";
        Location: Record Location;
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        // BC Upgrade SHUKLP03>> 
        WhseShippingDriver: Record Driver107FDW;
        WhseShippingDriver2: Record Driver107FDW;
        WhseShippingTruck: Record Vehicle101FDW;
        // BC Upgrade SHUKLP03<< 
        ShowSOList: Boolean;
        TransferOrderNo: Code[20];
        BoxQty: Decimal;
        NBBulkPallet: Decimal;
        NbFullPallet: Decimal;
        Qty: Decimal;
        TotalBulkPallet: Decimal;
        TotalFullPallet: Decimal;
        TotalQty: Decimal;
        UnQty: Decimal;
        Cnt1: Integer;
        NbCol: Integer;
        PrintedLine: Integer;
        ShowLine: Integer;
        SalesOrdersCaption: Label 'Sales Orders';
        Text011: Label 'Page %1';
        DriverName: Text[250];
        Text000: TextConst ENU = 'LOADING NOTE OF %1', FRA = 'BORDEREAU DE CHARGEMENT DU %1';
        Text003: TextConst ENU = 'Signature Warehouse', FRA = 'Signature du contrôleur';
        Text004: TextConst ENU = 'Time', FRA = 'Heure';
        Text005: TextConst ENU = 'Km', FRA = 'Km';
        Text006: TextConst ENU = 'Start', FRA = 'Départ';
        Text007: TextConst ENU = 'End', FRA = 'Arrivée';
        Text008: TextConst ENU = 'Signature Driver', FRA = 'Signature livreur';
        Text009: TextConst ENU = 'Outputs Paletts', FRA = 'Palettes sorties';
        Text010: TextConst ENU = 'Pallets Entries', FRA = 'Palettes entrées';
}

