namespace Heiniken.Heiniken;

using System.Threading;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Posting;

codeunit 51020 "Item Jnl. Post via Job Que CBN"
{
    // BC Upgrade Kapoov01 50164 Codeunit >>
    // HEI.01 CHG2049056 IBM.LS      01.04.2021
    //   # Created New Codeunit and Added Code.
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        ItemJournalBatch: Record "Item Journal Batch";
        ItemJournalLine: Record "Item Journal Line";
        RecRef: RecordRef;

    begin
        //HEI.01>>
        Rec.TESTFIELD(Rec."Record ID to Process");
        RecRef.GET(Rec."Record ID to Process");
        RecRef.SETTABLE(ItemJournalBatch);
        ItemJournalBatch.FIND();

        ItemJournalLine.RESET();
        ItemJournalLine.SETRANGE(ItemJournalLine."Journal Template Name", ItemJournalBatch."Journal Template Name");
        ItemJournalLine.SETRANGE(ItemJournalLine."Journal Batch Name", ItemJournalBatch.Name);
        IF ItemJournalLine.findset() THEN
            IF NOT CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJournalLine) THEN BEGIN
                ERROR(GETLASTERRORTEXT);
            end;
        //HEI.01<<
    end;

}
