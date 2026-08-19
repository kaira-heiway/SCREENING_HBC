namespace DTWLocal.DTWLocal;
using Microsoft.Inventory.Tracking;
using Microsoft.Inventory.Ledger;
//PATHAA02 03.06.26-To delete Lot No Information records which have zero inventory and no related Item Ledger Entries and Reservation Entries. 
//This is to clean up the bulk uploaded Lot No Information table in Q.
//Request from Anca and Meraj.

report 54048 "Delete Lot No Information"
{
    ApplicationArea = All;
    Caption = 'Delete Lot No Information';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(LotNoInformation; "Lot No. Information")
        {
            RequestFilterFields = "Item No.", "Lot No.";

            trigger OnAfterGetRecord()
            begin
                ProcessLotNoInformation();
            end;
        }
    }
    trigger OnPostReport()
    begin
        Message('Process completed.\' + 'Deleted Records: %1', DeletedCount);
    end;

    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ReservationEntry: Record "Reservation Entry";
        DeletedCount: Integer;
        QCCheckHeader92FDW: Record QCCheckHeader92FDW;

    local procedure ProcessLotNoInformation()
    begin
        // Inventory must be zero
        LotNoInformation.CalcFields(Inventory);

        if LotNoInformation.Inventory <> 0 then
            exit;

        // Check Item Ledger Entries, if it has values then skip deletion of the Lot No. Information record
        ItemLedgerEntry.Reset();
        ItemLedgerEntry.SetRange("Item No.", LotNoInformation."Item No.");
        ItemLedgerEntry.SetRange("Variant Code", LotNoInformation."Variant Code");
        ItemLedgerEntry.SetRange("Lot No.", LotNoInformation."Lot No.");

        if not ItemLedgerEntry.IsEmpty() then
            exit;

        // Check Reservation Entries, if it has values then skip deletion of the Lot No. Information record
        ReservationEntry.Reset();
        ReservationEntry.SetRange("Item No.", LotNoInformation."Item No.");
        ReservationEntry.SetRange("Variant Code", LotNoInformation."Variant Code");
        ReservationEntry.SetRange("Lot No.", LotNoInformation."Lot No.");

        if not ReservationEntry.IsEmpty() then
            exit;

        //Quality COntrol Check Header, if it has values then skip deletion of the Lot No. Information record
        QCCheckHeader92FDW.Reset();
        QCCheckHeader92FDW.SetCurrentKey("Item No.", "Lot No.");
        QCCheckHeader92FDW.SetRange("Item No.", LotNoInformation."Item No.");
        QCCheckHeader92FDW.SetRange("Lot No.", LotNoInformation."Lot No.");

        if not QCCheckHeader92FDW.IsEmpty() then
            exit;

        // Delete Lot No. Information record
        LotNoInformation.Delete(true);
        DeletedCount += 1;
    end;
}
