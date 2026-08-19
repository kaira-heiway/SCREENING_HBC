codeunit 58067 "FM Shipments KPI"
{
    // version HEI.01
    //BC Upgrade GUNREM01 old ID-50095
    // HEI.01 CHG2161264 DEBUSD01 10.11.2022 Shipment KPI Interface

    Permissions = TableData "Interface Setup INT" = rimd;

    trigger OnRun();
    begin
        JobQueueExportData();
    end;

    local procedure JobQueueExportData();
    var
        FMInterfaceMgt: Codeunit "FM Interface Management";
        ShipmentKpi: Report "FM Shipments KPI";
        SalesShptLineFilters: Record "Sales Shipment Line";
        TransfShptLineFilters: Record "Transfer Shipment Line";
    begin
        ShipmentKpi.SetDefaultSalesShptLineFilter(SalesShptLineFilters);
        ShipmentKpi.SetDefaultTransferShptLineFilter(TransfShptLineFilters);
        FMInterfaceMgt.CreateShipmentsKpi(SalesShptLineFilters, TransfShptLineFilters, TODAY, true);
    end;
}

