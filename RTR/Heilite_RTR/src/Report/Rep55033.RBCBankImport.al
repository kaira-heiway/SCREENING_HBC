report 55033 "RBC Bank Import"
{
    // HEi.01 PBA-RTRGAP03 - Bahamas Bank Statement Import - RBC V1.0 , IBM.NAIKH01 05.12.2018
    //   # Created New Report
    // version FM

    // BC Upgrade KUMARR78 >>
    // Object: Report 50231 "RBC Bank Import"
    // 1. Added ApplicationArea property at report level.
    //    Old:
    //         - ApplicationArea property was not defined.
    //    New:
    //         - ApplicationArea = All;
    // 2. Added UsageCategory property at report level.
    //    Old:
    //         - UsageCategory property was not defined.
    //    New:
    //         - UsageCategory = ReportsAndAnalysis;
    // 3. Added ApplicationArea property to request page field.
    //    Old:
    //         - Request page field "Date Format" did not have ApplicationArea.
    //    New:
    //         - ApplicationArea = All added to the field.
    // BC Upgrade KUMARR78 <<
    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding Usagecategory

    ProcessingOnly = true;

    dataset
    {
        dataitem("Bank Acc. Reconciliation"; "Bank Acc. Reconciliation")
        {
            MaxIteration = 1;

            trigger OnAfterGetRecord();
            begin
                //ImportBAHBankRBC.SetTemplate(BankAccReconciliation);
                ImportBAHBankRBC.SetDateFormat(Option);
                ImportBAHBankRBC.SetTemplate(ToBankAccReconciliation);
                ImportBAHBankRBC.RUN;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control55001)
                {
                    field(Date1; DateOption)
                    {
                        ApplicationArea = all; //BC UPGRADE KUMARR78 Adding ApplicationArea
                        Caption = 'Date Format';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        if FORMAT(DateOption) = 'MM/DD/YYYY' then
            Option := 1;

        if FORMAT(DateOption) = 'YYYY/MM/DD' then
            Option := 2;

        //MESSAGE(FORMAT(Option));
    end;

    var
        ToBankAccReconciliation: Record "Bank Acc. Reconciliation";
        ImportBAHBankRBC: XMLport "Import BAH Bank RBC";
        Option: Integer;
        DateOption: Option "MM/DD/YYYY","YYYY/MM/DD";

    procedure SetTemplate(var BankAccReconciliationSrc: Record "Bank Acc. Reconciliation");
    begin
        ToBankAccReconciliation := BankAccReconciliationSrc;
    end;
}

