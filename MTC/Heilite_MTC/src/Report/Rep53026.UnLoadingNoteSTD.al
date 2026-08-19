report 53026 "UnLoading Note STD"
{
    // version HEI.01

    // HEI.01 FDD-PA-LOGGAP05 - Loading Not IBM.NAIKH01 20.11.2017
    //    # Created a new Report
    // HEI.02 CHG2105841 IBM GHOSHS05 22.06.2021 RDLC layout changed
    //    # LblCountedQuantityCounted Quantity
    //    # LblMissingCratesMissing Crates
    //    # LblMissingBTLMissing (BTL)
    //    # LblForeignBTLForeign (BTL)
    //    # LblBreakageBTLBreakage (BTL) Labels added
    // HEI.02 CHG2105841 IBM GHOSHS05 05.08.2021 Added Company logo in Layout

    // BC Upgrade KUMARR78>>
    // 1. Added ApplicationArea = All property at report level for BC visibility.
    // 2. Added UsageCategory = ReportsAndAnalysis property at report level for BC searchability.
    // 3. Blocked RequestFilterFields containing Drink-IT fields ("Truck Code","Driver Code").
    //    - Old: RequestFilterFields = "No.", "Location Code", "Truck Code", "Driver Code";
    //    - New: RequestFilterFields = "No.", "Location Code";
    // 4. Blocked dataset columns due to removed Drink-IT fields from "Warehouse Receipt Header":
    //    - Driver Code column
    //    - Truck Code column
    //    - Route column
    // 5. Blocked Driver lookup logic in OnAfterGetRecord() due to missing Drink-IT table "Whse. Shipping Driver".
    // 6. Blocked Truck lookup logic due to missing Drink-IT table "Whse. Shipping Truck".
    // 7. Commented out variable declarations for Drink-IT custom tables:
    //    - WhseShippingDriver
    //    - WhseShippingDriver2
    //    - WhseShippingTruck
    // 8. No functional logic changes in core pallet/unit calculations, only DIT dependency removal.
    // 9. Layout change remains as per HEI.02 (CHG2105841): Added Company logo + labels for unloading report.
    // 10. Removing DIT Colomns from Report Layout(Driver_Code_Whse_Shipment_Header,Truck_Code_Whse_Shipment_Header,Route_WarehouseShipmentHeader)
    // 11. Old Report ID - 50264
    // BC Upgrade KUMARR78<<


    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\UnLoading Note STD.rdl';

    CaptionML = ENU = 'UnLoading Note STD',
                ESP = 'Doc. Cargue de Camion STD';
    PreviewMode = PrintLayout;
    ApplicationArea = All; // BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade KUMARR78 Adding Usagecategory

    // BC Upgrade SHUKLP03 >> LOG021 Testscript changes.

    dataset
    {
        dataitem("Warehouse Receipt Header"; "Warehouse Receipt Header")
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", "Location Code", "Vehicle Code 101FDW", "Log Driver 107FDW"; //BC Upgrade SHUKLP03 - DIT Field("Truck Code","Driver Code").
            // RequestFilterFields = "No.", "Location Code"; //BC Upgrade KUMARR78 Adding As Blocked Older Condition Due to DIT Field("Truck Code","Driver Code")
            column(No_WarehouseShipmentHeader; "No.")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
                Description = 'CHG2105841';
            }
            column(DateTime_Header; Format(Today) + '  ' + Format(Time))
            {
            }
            column(Report_Header; StrSubstNo(Text000, "Posting Date"))
            {
            }
            column(No_Whse_Shipment_Header; "No.")
            {
            }
            column(Location_Code_Whse_Shipment_Header; "Location Code" + '  ' + Location.Name)
            {
            }
            // BC Upgrade SHUKLP03>> DIT Fields.
            column(Driver_Code_Whse_Shipment_Header; "Log Driver 107FDW" + '   ' + DriverName)
            {
            }
            column(Truck_Code_Whse_Shipment_Header; "Vehicle Code 101FDW" + '   ' + WhseShippingTruck.Description)
            {
            }
            column(Route_WarehouseShipmentHeader; "Route 107FDW")
            {
            }
            // BC Upgrade SHUKLP03<< DIT Fields.
            column(ShowSOList; ShowSOList)
            {
            }
            dataitem("Warehouse Receipt Line"; "Warehouse Receipt Line")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("Item No.") where(Quantity = filter(<> 0));
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
                column(Weight_WhseShipmentLine; Weight)
                {
                }
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
                column(SourceNo_whseShipmentline; "Source No.")
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
            dataitem(TransferWhseShipment; "Warehouse Receipt Line")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("Item No.") where(Quantity = filter(<> 0), "Source Document" = const("Inbound Transfer"));
                column(TransferOrder_No; TransferWhseShipment."Source No.")
                {
                }
            }
            dataitem(SalesReturOrderLine; "Warehouse Receipt Line")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("Item No.") where(Quantity = filter(<> 0), "Source Document" = const("Sales Return Order"));
                column(SalesOrdersNo; SalesReturOrderLine."Source No.")
                {
                }
                column(SalesHeader_selltocust; SalesHeader."Sell-to Customer No.")
                {
                }
                column(CustName; Cust.Name)
                {
                }
                column(CustSearchName; Cust."Search Name")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    if SalesHeader.Get(SalesHeader."Document Type"::"Return Order", SalesReturOrderLine."Source No.") then;
                    if Cust.Get(SalesHeader."Sell-to Customer No.") then;
                end;
            }

            trigger OnAfterGetRecord();
            begin

                // BC Upgrade SHUKLP03>> Blocking Due to DIT Fields.
                if WhseShippingDriver.GET("Log Driver 107FDW") then
                    DriverName := WhseShippingDriver.Description
                else
                    DriverName := '';
                // BC Upgrade SHUKLP03<< Blocking Due to DIT Fields.
                /*  //NaikH01
                IF WhseShippingDriver2.GET("Warehouse Shipment Header"."Driver Assistant") THEN
                  AssistantDriverName := WhseShippingDriver2.Description
                ELSE
                  AssistantDriverName := '';
                */

                if Location.Get("Location Code") then;
                if WhseShippingTruck.GET("Vehicle Code 101FDW") then;  // BC Upgrade SHUKLP03>> DIT Fields.
                WarehouseShipmentLine.Reset();
                WarehouseShipmentLine.SetRange("No.", "No.");
                if WarehouseShipmentLine.FindFirst() then
                    if WarehouseShipmentLine."Source Document" = WarehouseShipmentLine."Source Document"::"Sales Return Order" then
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
        LblRoute = 'Route:'; label(LblSalesOrder; ENU = 'Sales Return Order',
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
        label(LblMissingCrates; ENU = 'Missing Crates',
                               FRA = 'Crates Manquante')
        label(LblMissingBTL; ENU = 'Missing (BTL)',
                            FRA = 'Bouteille Manquante')
        label(LblForeignBTL; ENU = 'Foreign (BTL)',
                            FRA = 'Bouteille Etrangère')
        label(LblBreakageBTL; ENU = 'Breakage (BTL)',
                             FRA = 'Casse')
    }

    trigger OnInitReport();
    begin

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        // BC Upgrade SHUKLP03>> DIT Variables.
        WhseShippingDriver: Record Driver107FDW;//"Whse. Shipping Driver";
        WhseShippingDriver2: Record Driver107FDW;//"Whse. Shipping Driver";
        // BC Upgrade SHUKLP03<< DIT Variables
        Item: Record Item;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        ItemUnitOfMeasure1: Record "Item Unit of Measure";
        ItemUnitOfMeasure2: Record "Item Unit of Measure";
        Location: Record Location;
        SalesHeader: Record "Sales Header";
        WarehouseShipmentLine: Record "Warehouse Receipt Line";
        WhseShippingTruck: Record Vehicle101FDW;//"Whse. Shipping Truck"; // BC Upgrade SHUKLP03>> DIT Variables
        ShowSOList: Boolean;
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
        Text000: TextConst ENU = 'UNLOADING NOTE OF %1', FRA = 'BORDEREAU DE CHARGEMENT DU %1';
        Text003: TextConst ENU = 'Signature Warehouse', FRA = 'Signature du contrôleur';
        Text004: TextConst ENU = 'Time', FRA = 'Heure';
        Text005: TextConst ENU = 'Km', FRA = 'Km';
        Text006: TextConst ENU = 'Start', FRA = 'Départ';
        Text007: TextConst ENU = 'End', FRA = 'Arrivée';
        Text008: TextConst ENU = 'Signature Driver', FRA = 'Signature livreur';
        Text009: TextConst ENU = 'Outputs Paletts', FRA = 'Palettes sorties';
        Text010: TextConst ENU = 'Pallets Entries', FRA = 'Palettes entrées';
}

