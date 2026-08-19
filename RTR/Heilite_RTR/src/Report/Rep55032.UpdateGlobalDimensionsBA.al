report 55032 "Update Global Dimensions BA"
{
    // BUGFIX NASTAA02 Update G/L Entry Global Dimensions
    // BC Upgrade BHARAD11 >>
    // 1. Old Report ID - 50093.
    // 2. Add ApplicationArea property in report.
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Permissions = TableData "G/L Entry" = rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Entry No.";

            trigger OnAfterGetRecord();
            var
                DimensionSetEntry: Record "Dimension Set Entry";
            begin
                if "Global Dimension 2 Code" = '' then
                    if DimensionSetEntry.GET("Dimension Set ID", GLSetup."Global Dimension 2 Code") then begin
                        "Global Dimension 2 Code" := DimensionSetEntry."Dimension Value Code";
                        MODIFY;
                    end;
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
        MESSAGE('Done');
    end;

    trigger OnPreReport();
    begin
        GLSetup.GET();
    end;

    var
        GLSetup: Record "General Ledger Setup";
}

