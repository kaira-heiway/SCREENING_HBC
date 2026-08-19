report 54032 "Update Warehouse Entry Check"
{
    // version HEI.01

    // HEI.01 CHG2160634 SAHAL01 22.06.2022 # Created New Report: 50505 - Update Warehouse Entry Check
    //   # Update Unavailable Stock (Quality) as True for that Quality Statas as Blocked.
    // HEI.02 CHG2160634 SAHAL01 20.07.2022
    //   # Updated Unavailable Stock as True for that Quality Statas as Blocked.
    // BC Upgrade BHARDA11 >>
    // 1. OLD Report ID- 50505.
    // 2. Add ApplicationArea property in Report.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Update Warehouse Entry Check';
    Permissions = TableData "Warehouse Entry" = m;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Warehouse Entry"; "Warehouse Entry")
        {
            DataItemTableView = SORTING("Entry No.")
                                ORDER(Ascending)
                                WHERE("Inspection Status FND" = CONST('BLOCKED'), //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43
                                       "Unavail. Stock (Quality) FND" = CONST(false));

            trigger OnAfterGetRecord();
            begin
                //HEI.01>>
                "Unavail. Stock (Quality) FND" := TRUE;
                //HEI.02>>
                "Unavailable Stock FND" := TRUE;
                //HEI.02<<
                MODIFY(FALSE);
                //HEI.01<<
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

