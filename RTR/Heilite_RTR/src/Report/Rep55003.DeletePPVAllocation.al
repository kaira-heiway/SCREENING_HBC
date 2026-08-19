report 55003 "Delete PPV Allocation"
{
    // version HEI.01

    // HEI.01 CHG2193490 IBM SISUM01 27/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # new object created

    // BC Upgrade POENAB02: Original (HeiLite) report id 50140

    Caption = 'Delete PPV Allocation';
    Permissions = TableData "PPV Allocation Header RTR" = rd,
                  TableData "PPV Allocation Line RTR" = rd;
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Tasks;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            trigger OnAfterGetRecord();
            begin
                PPVAllocationHeader.SetRange(Month, Date2DMY(StartDate, 2));
                PPVAllocationHeader.SetRange(Year, Date2DMY(StartDate, 3));
                PPVAllocationHeader.DeleteAll();

                PPVAllocationLine.SetRange(Month, Date2DMY(StartDate, 2));
                PPVAllocationLine.SetRange(Year, Date2DMY(StartDate, 3));
                PPVAllocationLine.DeleteAll();
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
                    field(StartingDate; StartDate)
                    {
                        ToolTip = 'Specifies the starting date for deleting PPV allocations. The ending date is automatically set to one month after the starting date.';
                        Caption = 'Starting Date';
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            if StartDate <> 0D then
                                EndDate := CalcDate('<CM>', StartDate);
                        end;
                    }
                    field(EndingDate; EndDate)
                    {
                        ToolTip = 'Specifies the ending date for deleting PPV allocations. It is automatically set to one month after the starting date.';
                        Caption = 'Ending Date';
                        ApplicationArea = All;
                        Editable = false;
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
        Message(Text001);
    end;

    trigger OnPreReport();
    begin
        CheckDates();
    end;

    var
        PPVAllocationHeader: Record "PPV Allocation Header RTR";
        PPVAllocationLine: Record "PPV Allocation Line RTR";
        StartDate: Date;
        EndDate: Date;
        Text001: Label 'Deleted.';
        Text002: Label 'Starting Date must not be empty.';
        Text003: Label 'Ending Date must not be empty.';

    local procedure CheckDates();
    begin
        if StartDate = 0D then
            Error(Text002);
        if EndDate = 0D then
            Error(Text003);
    end;
}