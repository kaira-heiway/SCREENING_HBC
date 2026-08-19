report 55047 "GL Acc. Appl. - Zero Clearing"

// HEI.01 CHG2313007 IBM POENAB02 01.08.2025 Report creation aimed to clear Entries with Amount 0, Remaining amount 0 and marked as Open from General Ledger Entries table for SCOA 14282001
//   # Object created

// BC Upgrade POENAB02: Original (HeiLite) report id 50618

{
    ApplicationArea = All;
    Caption = 'GL Acc. Appl. - Zero Clearing';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Permissions = TableData "G/L Entry" = rm;
    dataset
    {
        dataitem(GLEntry; "G/L Entry")
        {
            DataItemTableView = sorting("G/L Account No.", "Posting Date") order(Ascending) WHERE(Amount = FILTER(0), "Remaining Amount FND" = FILTER(0), "Open FND" = FILTER(true));
            RequestFilterFields = "G/L Account No.", "Posting Date";
            trigger OnPreDataItem()
            begin
                NoOfEntries := GLEntry.Count();
                GLEntry.ModifyAll("Open FND", false);
            end;
        }
    }

    trigger OnPreReport()
    begin
        if GLEntry.GetFilter("G/L Account No.") = '' then
            Error(Text50001);
        if not GLAccount.Get(GLEntry.GetFilter("G/L Account No.")) then
            Error(Text50002);
    end;

    trigger OnPostReport()
    begin
        if NoOfEntries = 0 then
            Message(Text50003)
        else
            Message(Text50000);
    end;

    var
        GLAccount: Record "G/L Account";
        NoOfEntries: Integer;
        Text50000: Label 'Update finished!';
        Text50001: Label 'GL Account filter must have a value!';
        Text50002: Label 'Please provide a valid GL Account!';
        Text50003: Label 'Nothing to update!';
}
