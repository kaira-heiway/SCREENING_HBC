report 55035 "Close G/L Entries from Migr."
{
    // HEI.01 CHG2149205 BULIMC01 IBM 03/03/2022#new report created to close the open GL Entries based on specific filters
    // BC Upgrade BHARAD11 >>
    // 1. OLD Report ID - 50571.
    // 2. Add ApplicationArea property in Report.
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Close G/L Entries from Migration';
    Permissions = TableData "G/L Entry" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Open FND" = CONST(true));
            RequestFilterFields = "Posting Date", "Document No.", "Source Code";

            trigger OnAfterGetRecord();
            begin
                "Open FND" := false;
                Updated := true;
                MODIFY();

                Counter += 1;
                if Counter >= NoOfRecProgress
                then begin
                    NoOfProgresed := NoOfProgresed + Counter;
                    ProgressWindow.UPDATE(1, ROUND(NoOfProgresed / NoOfRecords * 10000, 1));
                    Counter := 0;
                    TimeProgress := TIME;
                end;
            end;

            trigger OnPreDataItem();
            begin
                NoOfRecords := COUNT;
                NoOfRecProgress := NoOfRecords div 100;
                Counter := 0;
                NoOfProgresed := 0;
                TimeProgress := TIME;

                if "G/L Entry".GETFILTERS = '' then
                    ERROR(Text004);
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

    trigger OnPostReport();
    begin
        ProgressWindow.CLOSE();

        if Updated then
            MESSAGE(Text002)
        else
            MESSAGE(Text003);
    end;

    trigger OnPreReport();
    begin
        ProgressWindow.OPEN(Text001);
    end;

    var
        Updated: Boolean;
        Text001: Label '"G/L Entries..       @1@@@@@@@@@@@ "';
        Text002: Label 'G/L Entries have been successfully updated.';
        Text003: Label 'There is no G/L Entry within the filters. No update done.';
        ProgressWindow: Dialog;
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        NoOfProgresed: Integer;
        Counter: Integer;
        TimeProgress: Time;
        Filters: Text;
        Text004: Label 'Please apply at least one filter on the request page!';
}

