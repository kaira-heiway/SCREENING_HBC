report 58037 "Delete Archived Cadency Data"
{
    // version HEI.01

    // HEI.01 FDD-RTRGAP073 BRD HB142- Trintech connection , IBM.NAIKH01 , 25.02.2019
    //   # Created new Report

    // BC Upgrade POENAB02: Original (HeiLite) report id 50248

    // BC Upgrade PATELP08>>
    // Changed name of table from "Cadency Data Archive" to "Cadency Data Archive FND"
    // BC Upgrade PATELP08<<

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Cadency Data Archive FND"; "Cadency Data Archive FND")
        {
            RequestFilterFields = "Date Archived", "File Type";

            trigger OnAfterGetRecord();
            begin

                "Cadency Data Archive FND".Delete();
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

