namespace ALProject.ALProject;

using Microsoft.Sales.Setup;

enumextension 50008 ReportSelectionUsgSalesEnumExt extends "Report Selection Usage Sales"
{

    value(50000; "Delivery Note(Sales Invoice)") { Caption = 'Delivery Note(Sales Invoice)'; }
    value(50001; "Debit Note") { Caption = 'Debit Note'; }
    value(50002; "Delivery Note(Whse Ship)") { Caption = 'Delivery Note(Whse Ship)'; }//BC UPGRADE KUMARR78 ++03-07-2026
}
