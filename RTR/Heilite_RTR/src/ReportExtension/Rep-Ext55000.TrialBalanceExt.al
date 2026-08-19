
reportextension 55000 TrialBalanceExt extends "Trial Balance"
{


    dataset
    {
        add("G/L Account")
        {
            column(No__2; "No. 2")
            {
            }
        }
    }
    rendering
    {

        layout(Trial_Balance_RTR)
        {
            Type = RDLC;
            LayoutFile = '.\src\ReportsLayout\TrialBalance.rdl';
        }

    }

}
