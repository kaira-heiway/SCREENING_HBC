report 55052 "Update MR Code in GL Entry"
{
    ApplicationArea = All;
    Caption = 'Update MR Code in GL Entry';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    Permissions = TableData "G/L Entry" = RIMD;

    dataset
    {
        dataitem(GLAccount; "G/L Account")
        {
            DataItemTableView = sorting("No.") order(Ascending) where("MR Code FND" = filter(<> ''));
            RequestFilterFields = "No.";
            trigger OnAfterGetRecord()
            var
                GLEntry: Record "G/L Entry";
            begin
                GLEntry.SetCurrentKey("G/L Account No.");
                GLEntry.SetRange("G/L Account No.", GLAccount."No.");
                if GLEntry.FindSet() then
                    repeat
                        GLEntry.Validate("MR Code FND", GLAccount."MR Code FND");
                        GLEntry.Modify();
                    until GLEntry.Next() = 0;
            end;
        }
    }


    trigger OnPostReport()
    begin
        message(Text001Lbl);
    end;

    var
        Text001Lbl: Label 'MR Code updated in G/L Entry table.';
}
