codeunit 51006 "Gen. Jnl. Post via Job Q CBN"
{
    // version HEI.01

    TableNo = "Job Queue Entry";

    trigger OnRun();
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        SalesPostPrint: Codeunit "Sales-Post + Print";
        RecRef: RecordRef;
    begin
        Rec.TESTFIELD(Rec."Record ID to Process");
        RecRef.GET(Rec."Record ID to Process");
        RecRef.SETTABLE(GenJournalBatch);
        GenJournalBatch.FIND();

        GenJournalLine.RESET();
        GenJournalLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJournalLine.SETRANGE("Journal Template Name", GenJournalBatch."Journal Template Name");
        if GenJournalLine.findset() then
            if not CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine) then begin
                ERROR(GETLASTERRORTEXT);
            end;
    end;

    var
        Confirmation: TextConst Comment = '%1=document type, %2=number, e.g. Order 123  or Invoice 234.', ENU = '%1 %2 has been scheduled for posting.';
        PostAndPrintDescription: TextConst Comment = '%1 = document type, %2 = document number. Example: Post Sales Order 1234.', ENU = 'Post and Print Sales %1 %2.';
        PostDescription: TextConst Comment = '%1 = document type, %2 = document number. Example: Post Sales Order 1234.', ENU = 'Post Sales %1 %2.';
        WrongJobQueueStatus: TextConst Comment = '%1 = document type, %2 = document number. Example: Sales Order 1234 or Invoice 1234.', ENU = '%1 %2 cannot be posted because it has already been scheduled for posting. Choose the Remove from Job Queue action to reset the job queue status and then post again.';
}

