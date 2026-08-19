report 58056 "Update FA Ind"
{

    //Bc Upgrade YADAVM09 old id is-50149.

    ProcessingOnly = true;
    ApplicationArea = all;//Bc Upgrade YADAVM09<<
    UsageCategory = ReportsAndAnalysis;//Bc Upgrade YADAVM09<<

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {

            trigger OnAfterGetRecord();
            var
                FinancialUtils: Codeunit "Financial-Utils";
            begin
                FinancialUtils.ChangeFaIndicator("Fixed Asset");
                MODIFY;
            end;

            trigger OnPreDataItem();
            var
                FinancialUtils: Codeunit "Financial-Utils";
            begin
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
    }
}

