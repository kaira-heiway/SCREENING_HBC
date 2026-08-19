namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Foundation.Reporting;

tableextension 50227 CustomReportSelectionExtFND extends "Custom Report Selection"
{
    // BC Upgrade SHUKLP03 >> 50000 Document Subtype code ,50001 Document Subtype filter table fields added and function FilterDocSubTypeTable() added.
    fields
    {
        field(50000; "Document Subtype Code FND"; Code[10])
        {
            CaptionML = ENU = 'Document Subtype Code', FRA = 'Code Sous-Type Document';
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = FIELD("Doc Subtype Filter Table FND"));
        }
        field(50001; "Doc Subtype Filter Table FND"; Option)
        {
            FieldClass = FlowFilter;
            TableRelation = "Document Subtype Code FND";
            CaptionML = ENU = 'Document Subtype Filter', FRA = 'Filtre Sous-Type Document';
            OptionMembers = Sales,Purchase,BankAcc,Reminder,CashFlow,Inventory,Service,"P.Service","Prod.Order",,,,,,,,,,"Fin.Contract";
            OptionCaptionML = ENU = 'Sales,Purchase,BankAcc,Reminder,CashFlow,Inventory,Service,P.Service,Prod.Order,,,,,,,,,,Fin.Contract', FRA = 'Vente,Achat,Cpte.Banc,Relance,Trésorerie,Stock,Service,Service.A,O.F,,,,,,,,,,Contrat.Fin';
        }
    }

    procedure FilterDocSubTypeTable(ReportSelectionPageType: Option Sales,Purchase,BankAcc,Reminder,CashFlow,Inventory,Service,"P.Service","Prod.Order")
    var
        DummyReportSelection: Record "Report Selections";
    begin
        // <<DITW110.00.08 DDR 16/02/2017 NRQ#20755
        DummyReportSelection.FilterDocSubType(ReportSelectionPageType);
        DummyReportSelection.COPYFILTER("Doc Subtype Filter Table FND", "Doc Subtype Filter Table FND");
    end;

}
