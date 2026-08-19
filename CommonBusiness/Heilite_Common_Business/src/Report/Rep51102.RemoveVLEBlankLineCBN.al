report 51102 "Remove VLE Blank Line CBN"
{

    // HEI.01 CHG2314200 SAHAL01 07.08.2025 Heilite Esker Interface fix DRC
    //   # Created New Report: 50620 - Remove VLE Blank Line
    //   # Added Code

    // BC Upgrade PATES08 >>
    // # Object Created
    // # NAV ID : 50620
    // BC Upgrade PATES08 <<

    ApplicationArea = All;
    Caption = 'Remove VLE Blank Line';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    Permissions = TableData "Vendor Ledger Entry"=rd;

    dataset
    {
        dataitem(VendorLedgerEntry; "Vendor Ledger Entry")
        {
            RequestFilterFields = "Entry No.";
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Entry No."=CONST(0),Amount=CONST(0),"Amount (LCY)"=CONST(0),"Document Type"=CONST(" "));
            
            
            trigger OnPreDataItem()
            begin
                //HEI.01>>
                LineCount := COUNT;
                IF LineCount > 1 THEN
                ERROR(Text000);
                //HEI.01<<
            end;

            trigger OnAfterGetRecord()
            begin
                //HEI.01>>
                IF (LineCount = 1) AND ("Entry No." = 0) THEN BEGIN
                DELETE(FALSE);
                LineFound := TRUE;
                END;
                //HEI.01<<
            end;
        }
    }

    trigger OnPreReport()
    begin
        //HEI.01>>
        CLEAR(LineCount);
        CLEAR(LineFound);
        //HEI.01<<
    end;

    trigger OnPostReport()
    begin
        //HEI.01>>
        IF GUIALLOWED THEN BEGIN
        IF (LineCount = 1) AND LineFound THEN
            MESSAGE(Text001)
        ELSE
            MESSAGE(Text002);
        END;
        //HEI.01<<
    end;

    var
        LineCount : Integer;
        LineFound : Boolean;
        Text000 : Label 'The system cannot execute the process, because the number count should not be more then 1.';
        Text001 : Label 'Process completed.';
        Text002 : Label 'Nothing to process.';


}
