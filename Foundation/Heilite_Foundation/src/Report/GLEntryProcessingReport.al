report 51491 "GL Entry Processing Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(GeneralLedgerEntry; "G/L Entry")
        {
            DataItemTableView = sorting("Entry No.") order(ascending);

            trigger OnAfterGetRecord()
            begin
                if PreviousDocumentNo <> "Document No." then begin
                    CurrentTransactionNo += 1;
                    PreviousDocumentNo := "Document No.";
                    GLTransactionUpdater.UpdateRelatedTransactionNos("Document No.", CurrentTransactionNo);
                end;
            end;
        }
    }

    trigger OnPreReport()
    begin
        GLTransactionUpdater.ResetGLEntryTransactionNos();
        Commit();
    end;

    trigger OnPostReport()
    var
        GLEntry: Record "G/L Entry";
        LastEntry_DocNo: Code[20];
        LastEntry_TransNo: Integer;
        Highest_TranNo: Integer;
    begin
        GLEntry.Reset();
        GLEntry.Ascending(false);
        if GLEntry.FindFirst() then begin
            LastEntry_TransNo := GLEntry."Transaction No.";
            LastEntry_DocNo := GLEntry."Document No.";
        end;


        GLEntry.Reset();
        GLEntry.SetCurrentKey("Transaction No.");
        GLEntry.Ascending(false);
        if GLEntry.FindFirst() then
            Highest_TranNo := GLEntry."Transaction No.";

        if LastEntry_TransNo <> Highest_TranNo then begin
            if Confirm('you are going to update Last Transaction No', true) then begin
                LastEntry_TransNo += 1;
                GLTransactionUpdater.UpdateRelatedTransactionNos(LastEntry_DocNo, LastEntry_TransNo);
            end;
        end else
            Message('Process Completed');
    end;

    var
        PreviousDocumentNo: Code[20];
        CurrentTransactionNo: Integer;
        GLTransactionUpdater: Codeunit "GL Transaction Updater";
}
