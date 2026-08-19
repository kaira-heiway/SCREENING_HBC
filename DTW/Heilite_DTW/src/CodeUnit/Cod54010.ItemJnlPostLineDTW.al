namespace DTWMain_Ext.DTWMain_Ext;
using Microsoft.Inventory.Posting;
using Microsoft.Inventory.Tracking;
using BC_DTWLocal.BC_DTWLocal;
using Microsoft.Inventory.Setup;
using Microsoft.Finance.GeneralLedger.Setup;
using ALProject.ALProject;
using Microsoft.Finance.VAT.Setup;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Costing;
using Microsoft.Inventory.Counting.Journal;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Journal;
using Microsoft.Manufacturing.Capacity;

codeunit 54010 "Item Jnl.-Post Line_DTW"
{
    //BC Upgrade Kamnay01 Created this new Cu for Revaluation Journal error log. FDD- FDD-DTW-031
    //BC Upgrade Kamnay01  Capacity Ledger Entry FDD 018 subscribe event 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforePostItemJnlLine, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnBeforePostItemJnlLine"(var ItemJournalLine: Record "Item Journal Line"; CalledFromAdjustment: Boolean; CalledFromInvtPutawayPick: Boolean; var ItemRegister: Record "Item Register"; var ItemLedgEntryNo: Integer; var ValueEntryNo: Integer; var ItemApplnEntryNo: Integer)
    begin


        //HEI.20>>
        GetItemJnlLineCU22(ItemJournalLine);
        IF CreateLog THEN BEGIN
            IF ItemJournalLine."Post To FND" = ItemJournalLine."Post To FND"::Skip THEN
                EXIT;
        END;
        //HEI.20<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeRunWithCheck, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnBeforeRunWithCheck"(var Sender: Codeunit "Item Jnl.-Post Line"; var ItemJournalLine: Record "Item Journal Line"; CalledFromAdjustment: Boolean; CalledFromInvtPutawayPick: Boolean; CalledFromApplicationWorksheet: Boolean; PostponeReservationHandling: Boolean; var IsHandled: Boolean)
    begin
        GetItemJnlLineCU22(ItemJournalLine);

        IF CreateLog THEN BEGIN
            IF ItemJournalLine."Post To FND" = ItemJournalLine."Post To FND"::Skip THEN begin
                IsHandled := true;
                EXIT;
            end;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeCheckItemTracking, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnBeforeCheckItemTracking"(var ItemJournalLine: Record "Item Journal Line"; ItemTrackingSetup: Record "Item Tracking Setup" temporary; var IsHandled: Boolean; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    begin
        GetItemJnlLineCU22(ItemJournalLine);

        IF CreateLog THEN BEGIN
            IF ItemJournalLine."Post To FND" = ItemJournalLine."Post To FND"::Skip THEN begin
                IsHandled := true;
                EXIT;
            end;
        END;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnBeforePostJnlLine, '', false, false)]
    local procedure "Item Jnl.-Post Batch_OnBeforePostJnlLine"(var ItemJournalLine: Record "Item Journal Line"; SuppressCommit: Boolean; var IsHandled: Boolean)
    begin
        GetItemJnlLineCU22(ItemJournalLine);
        IF CreateLog THEN BEGIN
            IF ItemJournalLine."Post To FND" = ItemJournalLine."Post To FND"::Skip THEN begin
                IsHandled := true;
                EXIT;
            end;
        END;
    end;









    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeInsertValueEntry, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnBeforeInsertValueEntry"(var ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry"; var ValueEntryNo: Integer; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; CalledFromAdjustment: Boolean; var OldItemLedgEntry: Record "Item Ledger Entry"; var Item: Record "Item"; TransferItem: Boolean; var GlobalValueEntry: Record "Value Entry")
    var

        InventorySetupL: Record "Inventory Setup";
    begin
        GetItemJnlLineCU22(ItemJournalLine);
        //HEI.20>>
        IF Test1 THEN BEGIN
            GlobalValueEntry."Rev. Jnl. Error Log FND" := TRUE;
            GlobalValueEntry."Journal Template Name FND" := ItemJournalLine."Journal Template Name";
            IF GlobalValueEntry."Journal Batch Name" = '' THEN
                GlobalValueEntry."Journal Batch Name" := ItemJournalLine."Journal Batch Name";
            GlobalValueEntry."Line No. FND" := ItemJournalLine."Line No.";
        END;
        //HEI.20<<
    end;

    //  GetItemJnlLine(VAR ItemJournalLine : Record "Item Journal Line") //BC Upgrade GUNREM01 - Moved to procedure below
    procedure GetItemJnlLineCU22(VAR ItemJournalLine: Record "Item Journal Line") //BC Upgrade GUNREM01 - Renamed to avoid conflict
    var
        InventorySetupL: Record "Inventory Setup";
        ItemJnlTemplateL: Record "Item Journal Template";
    begin
        //HEI.20>>
        CLEAR(ItemJnlLineError);
        CLEAR(CreateLog);

        IF InventorySetupL.GET THEN BEGIN
            IF InventorySetupL."Activate Rev.Jnl.Error Log FND" THEN BEGIN
                IF ItemJnlTemplateL.GET(ItemJournalLine."Journal Template Name") THEN BEGIN
                    IF ItemJnlTemplateL.Type = ItemJnlTemplateL.Type::Revaluation THEN BEGIN
                        ItemJnlLineError.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
                        ItemJnlLineError.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
                        ItemJnlLineError.SETRANGE("Line No.", ItemJournalLine."Line No.");
                        IF ItemJnlLineError.FINDFIRST THEN;
                        CreateLog := TRUE;
                        Test1 := true
                        //Test2 := true;
                    END;
                END;
            END;
        END;
    end;
    //HEI.20<<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnCodeOnAfterRunCheck, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnCodeOnAfterRunCheck"(var ItemJournalLine: Record "Item Journal Line")
    var

        ErrorTextL: Text[250];

    begin

        //HEI.20>>
        GetItemJnlLineCU22(ItemJournalLine);
        IF CreateLog AND (GETLASTERRORTEXT <> '') THEN BEGIN
            ErrorTextL := COPYSTR(GETLASTERRORTEXT, 1, 250);
            // ItemJnlPostBatchL.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
            Cu23.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
            IF ItemJournalLine."Post To FND" = ItemJournalLine."Post To FND"::Skip THEN
                EXIT;
        END;
        CLEAR(ErrorTextL);
        //HEI.20<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeGetGeneralPostingSetup, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnBeforeGetGeneralPostingSetup"(ItemJournalLine: Record "Item Journal Line"; var GeneralPostingSetup: Record "General Posting Setup"; PostToGl: Boolean; var IsHandled: Boolean)
    var
        ErrorTextL: Text[250];
        Text041: Label 'The %1 does not exist. Identification fields and values: %2 - %3 and %4 - %5.';
    begin
        GetItemJnlLineCU22(ItemJournalLine);
        IsHandled := true;
        if (ItemJournalLine."Gen. Bus. Posting Group" <> GeneralPostingSetup."Gen. Bus. Posting Group") or
           (ItemJournalLine."Gen. Prod. Posting Group" <> GeneralPostingSetup."Gen. Prod. Posting Group")
       then
            //HEI.20>>

            IF CreateLog AND (NOT GeneralPostingSetup.GET(ItemJournalLine."Gen. Bus. Posting Group", ItemJournalLine."Gen. Prod. Posting Group")) THEN BEGIN
                ErrorTextL := COPYSTR(STRSUBSTNO(Text041, GeneralPostingSetup.TABLECAPTION,
                 ItemJournalLine.FIELDCAPTION("Gen. Bus. Posting Group"), ItemJournalLine."Gen. Bus. Posting Group",
                    ItemJournalLine.FIELDCAPTION("Gen. Prod. Posting Group"), ItemJournalLine."Gen. Prod. Posting Group"), 1, 250);
                // ItemJnlPostBatchL.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
                Cu23.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
                CLEAR(ErrorTextL);
                IsHandled := true;
                IF ItemJournalLine."Post To FND" = ItemJournalLine."Post To FND"::Skip THEN
                    EXIT;
            END ELSE
                //HEI.20<<
                if GenPostingSetup.Get(ItemJournalLine."Gen. Bus. Posting Group", ItemJournalLine."Gen. Prod. Posting Group") then
                    GenPostingSetup.TestField(Blocked, false);

    end;
    //BC Upgrade GUNREM01 - Codeunit 22 Item Jnl.-Post Line 22.02.26<<
    //BC Upgrade GUNREM01 - Codeunit 22 Item Jnl.-Post Line var >>


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnInsertCapValueEntryOnAfterUpdateCostAmounts, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnInsertCapValueEntryOnAfterUpdateCostAmounts"(var ValueEntry: Record "Value Entry"; var ItemJournalLine: Record "Item Journal Line")
    begin
        ValueEntry."Journal Template Name FND" := ItemJournalLine."Journal Template Name";
        ValueEntry."Line No. FND" := ItemJournalLine."Line No.";
    end;


    //BC Upgrade Kamnay01 >> Capacity Ledger Entry FDD 018
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeInsertCapLedgEntry, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnBeforeInsertCapLedgEntry1"(var CapLedgEntry: Record "Capacity Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; LastOperation: Boolean)
    var
        Item: Record Item;
        IUOM: Record "Item Unit of Measure";
    begin
        Item.Get(ItemJournalLine."Item No.");
        CapLedgEntry."Output quantity (HL) FND" := ItemJournalLine."Output Quantity (Base)" * Item."Unit Volume";
        CapLedgEntry."Quantity (HL) FND" := ItemJournalLine."Quantity (Base)" * Item."Unit Volume";
        CapLedgEntry."Unit Volume HL FND" := Item."Unit Volume";
    end;
    //BC Upgrade Kamnay01 <<Capacity Ledger Entry FDD 018





    var

        ItemJnlLineError: Record "Item Journal Line";
        CreateLog: Boolean;

        Test1: Boolean;
        Test2: Boolean;
        Cu23: Codeunit "Item Jnl.-Post Batch _DTW";
        GenPostingSetup: Record "General Posting Setup";

    //
}
