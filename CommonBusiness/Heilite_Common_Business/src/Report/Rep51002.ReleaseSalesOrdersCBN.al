report 51002 "Release Sales Orders CBN"
{
    // version HEI.01

    // HEI.01 FDD-OTCGAP016C IBM NASTAA02 29.11.2017 # Credit Control Check
    //   # New Report created to be used for scheduling the releasing of the Sales Orders
    // BC Upgrade BHARDA11 >>
    // 1.  Add ApplicationArea to Report.
    // BC Upgrade BHARDA11 <<
    Caption = 'Release Sales Orders';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending) WHERE("Document Type" = CONST(Order), Status = CONST(Open));

            trigger OnAfterGetRecord();
            begin
                if AutoReleaseSalesOrders.RUN("Sales Header") then;
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

    var
        // ReleaseSalesDoc: Codeunit "Release Sales Document";
        AutoReleaseSalesOrders: Codeunit "Auto Release Sales Orders CBN";
}

