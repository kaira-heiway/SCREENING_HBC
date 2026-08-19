report 53073 "Update CLE VLE Open Entries"
{
    // version HEI.01

    // HEI.01 CHG2183957 BHANDS01 05.12.2022 #Corrective Change
    //   # Open Incorrect CLE
    //   # Open Incorrect VLE
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID- 50519
    // 2. Add ApplicationArea Property in Report and Requestpage fields.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Permissions = TableData "Cust. Ledger Entry" = rm,
                  TableData "Vendor Ledger Entry" = rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem(CLE; "Cust. Ledger Entry")
        {
            CalcFields = "Remaining Amount";
            DataItemTableView = WHERE(Open = FILTER(false), "Remaining Amount" = FILTER(<> 0), Reversed = FILTER(false));
            RequestFilterFields = "Customer No.", "Entry No.", "Posting Date";

            trigger OnAfterGetRecord();
            begin
                if GUIALLOWED then begin
                    ProgressWindow.UPDATE(3, CLE."Customer No.");
                    cntCLE := cntCLE + 1;
                end;
                if CLEUpdate.GET(CLE."Entry No.") then begin
                    CLEUpdate."Closed at Date" := 0D;
                    CLEUpdate."Closed by Entry No." := 0;
                    CLEUpdate."Closed by Amount" := 0;
                    CLEUpdate."Closed by Amount (LCY)" := 0;
                    CLEUpdate."Closed by Currency Amount" := 0;
                    CLEUpdate."Closed by Currency Code" := '';
                    CLEUpdate.Open := true;
                    CLEUpdate.MODIFY;
                end;
                if GUIALLOWED then
                    ProgressWindow.UPDATE(1, ROUND(cntCLE / TotalCLECount * 10000, 1));
            end;

            trigger OnPreDataItem();
            begin
                CLEAR(TotalCLECount);
                CLEAR(cntCLE);
                if not UpdateCLE then
                    CurrReport.BREAK;
                TotalCLECount := CLE.COUNT;
            end;
        }
        dataitem(VLE; "Vendor Ledger Entry")
        {
            CalcFields = "Remaining Amount";
            DataItemTableView = WHERE(Open = FILTER(false), "Remaining Amount" = FILTER(<> 0), Reversed = FILTER(false));
            RequestFilterFields = "Vendor No.", "Entry No.", "Posting Date";

            trigger OnAfterGetRecord();
            var
                VLEUpdate: Record "Vendor Ledger Entry";
            begin
                if GUIALLOWED then begin
                    ProgressWindow.UPDATE(4, VLE."Vendor No.");
                    cntVLE := cntVLE + 1;
                end;
                if VLEUpdate.GET(VLE."Entry No.") then begin
                    VLEUpdate."Closed at Date" := 0D;
                    VLEUpdate."Closed by Entry No." := 0;
                    VLEUpdate."Closed by Amount" := 0;
                    VLEUpdate."Closed by Amount (LCY)" := 0;
                    VLEUpdate."Closed by Currency Amount" := 0;
                    VLEUpdate."Closed by Currency Code" := '';
                    VLEUpdate.Open := true;
                    VLEUpdate."Rem. Amt FND" := 0;
                    VLEUpdate."Rem. Amt for WHT FND" := 0;
                    VLEUpdate.MODIFY;
                end;
                if GUIALLOWED then
                    ProgressWindow.UPDATE(2, ROUND(cntVLE / TotalVLECount * 10000, 1));
            end;

            trigger OnPreDataItem();
            begin
                CLEAR(TotalVLECount);
                CLEAR(cntVLE);
                if not UpdateVLE then
                    CurrReport.BREAK;
                TotalVLECount := VLE.COUNT;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control55003)
                {
                    Caption = 'Options';
                    field(UpdateCLE; UpdateCLE)
                    {
                        ApplicationArea = All;
                        Caption = 'Correct CLE';
                    }
                    field(UpdateVLE; UpdateVLE)
                    {
                        ApplicationArea = All;
                        Caption = 'Correct VLE';
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

    trigger OnInitReport();
    begin
        CLEARALL;
    end;

    trigger OnPostReport();
    begin
        if GUIALLOWED then
            ProgressWindow.CLOSE;
        CLEARALL;
    end;

    trigger OnPreReport();
    begin
        if GUIALLOWED then
            ProgressWindow.OPEN(
              Text001 +
              Text002 +
              Text003 +
              Text004 +
              Text005);
    end;

    var
        CLEUpdate: Record "Cust. Ledger Entry";
        cntCLE: Integer;
        UpdateCLE: Boolean;
        UpdateVLE: Boolean;
        ProgressWindow: Dialog;
        Text001: Label 'Information\';
        Text002: Label '"  Customer      #3#######################\"';
        Text003: Label '"  Vendor          #4#######################\"';
        Text004: Label '"  Progress CLE    @1@@@@@@@@@@@@@@@@@@@@@@@\"';
        Text005: Label '"  Progress VLE    @2@@@@@@@@@@@@@@@@@@@@@@@\"';
        TotalCLECount: Integer;
        cntVLE: Integer;
        TotalVLECount: Integer;
}

