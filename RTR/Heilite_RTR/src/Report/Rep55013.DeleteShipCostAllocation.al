report 55013 "Delete Ship. Cost Allocation"
{
    // version HEI.02

    // HEI.01 CHG2095415 IBM BULIMC01 11.04.2021# new report to delete the shipping allocations
    // HEI.02 CHG2162842 IBM SAMANR01 20/06/202022 #C2S optimazation
    //   # Modify the code for optimized the execution time.

    // BC Upgrade POENAB02: Original (HeiLite) report id 50523

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Tasks;

    dataset
    {
        dataitem("Shipping Cost Allocation FND"; "Shipping Cost Allocation FND")
        {
            DataItemTableView = sorting("Posting Date", "Destination Type", "Only RPM Transportation") ORDER(Ascending);

            trigger OnPreDataItem();
            begin
                SetRange("Posting Date", StartingDate, EndingDate);
                DeleteAll();//HEI.02>>
            end;
        }
        dataitem("RPM - SKU Relationship FND"; "RPM - SKU Relationship FND")
        {
            DataItemTableView = sorting("Period Start Date", "Period End Date", "RPM Item No.", "Linked Item No.", "Customer No.") ORDER(Ascending);

            trigger OnPreDataItem();
            begin
                SetRange("Period Start Date", StartingDate, EndingDate);
                SetRange("Period End Date", StartingDate, EndingDate);
                DeleteAll();//HEI.02>>
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartingDate; StartingDate)
                    {
                        Caption = 'Starting Date';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the starting date for deleting shipping cost allocations.';
                    }
                    field(EndingDate; EndingDate)
                    {
                        Caption = 'Ending Date';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the ending date for deleting shipping cost allocations.';
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

    trigger OnPostReport();
    begin
        Message('Deleted.');
    end;

    trigger OnPreReport();
    begin
        CheckDates();
    end;

    var
        StartingDate: Date;
        EndingDate: Date;
        Text001Lbl: Label '%1 must not be blank.';
        Text002Lbl: Label 'Starting Date';
        Text003Lbl: Label 'Ending Date';

    local procedure CheckDates();
    begin
        if StartingDate = 0D then
            Error(Text001Lbl, Text002Lbl);
        if EndingDate = 0D then
            Error(Text001Lbl, Text003Lbl);
    end;
}

