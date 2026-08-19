namespace ALProject.ALProject;

using Microsoft.Inventory.Setup;

// BC Upgrade PATELP08 >> 
// # Renamed extension name from "ReportSelectionUsageInventoryExt" to "ReportSelectionUsageInvExt" to meet the 30-character limit.
// BC Upgrade PATELP08 <<

// BC Upgrade PATELP08 >> 
//enumextension 50011 ReportSelectionUsageInventoryExt extends "Report Selection Usage Inventory"
enumextension 50011 ReportSelectionUsageInvExt extends "Report Selection Usage Inventory"
// BC Upgrade PATELP08 <<
{
    value(50000; "Load List (Posted Whse. Shipment)") { Caption = 'Load List (Posted Whse. Shipment)'; }
    value(50001; "Combined Pick (Whs Shipment)") { Caption = 'Combined Pick (Whs Shipment)'; }
    value(50002; "Loading Notes (Whse. Shipment)") { Caption = 'Loading Notes (Whse. Shipment)'; }
    value(50003; "Zone (Whse Movement)") { Caption = 'Zone (Whse Movement)'; }
    value(50004; "Unloading Note(Whse. Receipt)") { Caption = 'Unloading Note(Whse. Receipt)'; }
    value(50005; "Picking List By Lot") { Caption = 'Picking List By Lot'; }
    value(50006; "Gate Entry Document") { Caption = 'Gate Entry Document'; }
}
