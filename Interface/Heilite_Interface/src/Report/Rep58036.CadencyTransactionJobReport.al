report 58036 "Cadency Transaction Job Report"
{
    // HEI.01 FDD-RTRGAP073 BRD HB142- Trintech connection , IBM.NAIKH01 , 05.03.2019
    //   # Created new Report

    // BC Upgrade POENAB02: Original (HeiLite) report id 50249

    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            MaxIteration = 1;

            trigger OnAfterGetRecord();
            begin
                Report.Run(50245, false);
                Report.Run(50246, false);
                Report.Run(50247, false);
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

