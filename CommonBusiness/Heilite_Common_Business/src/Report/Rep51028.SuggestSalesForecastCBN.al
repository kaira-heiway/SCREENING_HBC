report 51028 "Suggest Sales Forecast CBN"
{
    // version HEI.01
    // BC Upgrade BHARDA11 >>
    // 1. ApplicationManagement is removed we are using codeunit 41 TextManagement for this fnction
    // BC Upgrade BHARDA11 <<
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(SalesOption; SalesOption)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Suggest';

                    trigger OnValidate();
                    begin
                        if (SalesOption = SalesOption::"Custom Period") then
                            ShowPeriod := true
                        else
                            ShowPeriod := false;
                    end;
                }
                field(Period; Period)
                {
                    ApplicationArea = All;
                    Caption = 'Period';

                    trigger OnValidate();
                    begin
                        ApplicationManagement.MakeDateFilter(Period)
                    end;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            ShowPeriod := false;
        end;
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        case SalesOption of
            SalesOption::"Current Month":
                HeinekenGlobal.SuggestSales(DateFilter::CM, Period);
            SalesOption::"Current Quarter":
                HeinekenGlobal.SuggestSales(DateFilter::CQ, Period);
            SalesOption::"Custom Period":
                begin
                    if Period = '' then
                        ERROR(Text001);
                    HeinekenGlobal.SuggestSales(DateFilter::CP, Period);
                end;

        end;
    end;

    var
        SalesOption: Option "Current Month","Current Quarter","Custom Period";
        Period: Text;
        // ApplicationManagement: Codeunit ApplicationManagement; // BC Upgrade BHARDA11 ---ApplicationManagement is removed we are using codeunit 41 TextManagement for this fnction
        ApplicationManagement: Codeunit "Filter Tokens";
        ShowPeriod: Boolean;
        HeinekenGlobal: Codeunit "Heineken Global";
        DateFilter: Option CM,CQ,CP;
        Text001: Label 'Please select the period!';
}

