namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;
using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Transfer;
using Microsoft.Utilities;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Counting.Journal;
using Microsoft.Warehouse.Request;
using Microsoft.Warehouse.Document;
//using Microsoft.Inventory.Transfer;
codeunit 58016 InterfaceDtWCode
{
    var
        TransferHeaderG: Record "Transfer Header"; //PATHAA02-Global variable -CU5704

    //BC UPGRADE PATHAA02-Ext for CU5407-ProdOrderStatusMgmt 13.11.25>>
    //CU5407-Publisher->OnAfterReleasedProductionOrder(HEI.02)-->EventSubscribed on CU50109-WMS Interface Mgmt(HEI.22)
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", OnAfterChangeStatusOnProdOrder, '', false, false)]
    procedure ProdOrderStatusManagement_OnAfterChangeStatusOnProdOrder(var ProdOrder: Record "Production Order"; var ToProdOrder: Record "Production Order"; NewStatus: Enum "Production Order Status"; NewPostingDate: Date; NewUpdateUnitCost: Boolean; var SuppressCommit: Boolean)
    var
        ProcessOutboundRPOforLPL: Report "Process Outbound RPO for LP";
        WMSInterfaceSetup: Record "WMS Interface Setup INT";
    begin
        //CU5407-HEI.02>>
        IF NewStatus = NewStatus::Released THEN begin
            //CU50109-HEI.22>>
            IF ProdOrder.ISTEMPORARY THEN
                EXIT;
            // IF PreviewMode THEN EXIT; //BC UPGRADE PATHAA02-commented
            IF WMSInterfaceSetup.GET() THEN BEGIN //T50166
                IF NOT WMSInterfaceSetup."WMS Integration" THEN
                    EXIT;
                IF NOT WMSInterfaceSetup."Activate LogoPak Interface" THEN
                    EXIT;
                ProcessOutboundRPOforLPL.GetProdOrder(ProdOrder."No.");
                ProcessOutboundRPOforLPL.RUN(); //R50545
            END;
        end;
        //CU50109-HEI.22<<
    end;
    //CU5407-HEI.02<<
    //BC UPGRADE PATHAA02-Ext for CU5407-ProdOrderStatusMgmt 13.11.25<<

    //BC UPGRADE PATHAA02 CU5751-"Get Source Doc. Inbound" 18.11.25>>
    //CU5751-HEI.01>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Source Doc. Inbound", 'OnBeforeShowDialog', '', false, false)]
    local procedure OnBeforeShowDialog(var GetSourceDocuments: Report "Get Source Documents"; var WhseReceiptCreated: Boolean; var IsHandled: Boolean)
    begin
        if SkipOpeningPage then begin
            WhseReceiptCreated := false; // Prevent opening the Warehouse Receipt page          
        end;
    end;
    //CU5751-HEI.01<<

    //CU5751-HEI.01>>
    procedure SkipPageOpening(SkipPageOpening2: Boolean)
    //BC UPGRADE PATHAA02-called from CU50109-wmsmgmt,CU50144-autopostingAPI
    begin
        SkipOpeningPage := SkipPageOpening2;
    end;

    var
        SkipOpeningPage: Boolean;
    //CU5751-HEI.01<<
    //BC UPGRADE PATHAA02 CU5751-"Get Source Doc. Inbound" 18.11.25<<

    // BC Upgrade SHUKLP03 >> Page Management 700 Codeunit

    // HEI.01 CHG2219877 PRASAA03 10.10.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
    // # Subscribed Event OnConditionalCardPageIDNotFound to add code
    // # Added new procedures "GetItemJournalBatchPageID()" and "GetItemJournalLinePageID()".

    // HEI.02 CHG2219877 PRASAA03 12.10.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
    // # Subscribed Event OnConditionalCardPageIDNotFound to add code

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", OnConditionalCardPageIDNotFound, '', false, false)]
    local procedure OnConditionalCardPageIDNotFound(RecordRef: RecordRef; var CardPageID: Integer)
    begin
        case RecordRef.Number of
            //HEI.01>>
            DATABASE::"Item Journal Batch":
                CardPageID := GetItemJournalBatchPageID(RecordRef);//HEI.02
            DATABASE::"Item Journal Line":
                CardPageID := GetItemJournalLinePageID(RecordRef)//HEI.02
                                                                 //HEI.01<<
        END;
    end;

    LOCAL procedure GetItemJournalBatchPageID(RecordRef: RecordRef): Integer
    var
        ItemJournalBatch: Record "Item Journal Batch";
        ItemJournalLine: Record "Item Journal Line";
    begin
        //HEI.01>>
        RecordRef.SETTABLE(ItemJournalBatch);

        ItemJournalLine.SETRANGE("Journal Template Name", ItemJournalBatch."Journal Template Name");
        ItemJournalLine.SETRANGE("Journal Batch Name", ItemJournalBatch.Name);
        IF NOT ItemJournalLine.FINDFIRST() THEN
            EXIT(PAGE::"Item Journal");

        RecordRef.GETTABLE(ItemJournalLine);
        //HEI.01<<
        EXIT(GetItemJournalLinePageID(RecordRef));
    end;

    LOCAL procedure GetItemJournalLinePageID(RecordRef: RecordRef): Integer
    var
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalTemplate: Record "Item Journal Template";
    Begin
        //HEI.01>>
        RecordRef.SETTABLE(ItemJournalLine);
        ItemJournalTemplate.GET(ItemJournalLine."Journal Template Name");
        CASE ItemJournalTemplate.Type OF
            ItemJournalTemplate.Type::Item:
                EXIT(PAGE::"Item Journal");
            ItemJournalTemplate.Type::"Phys. Inventory":
                EXIT(PAGE::"Phys. Inventory Journal");
        END;
        //HEI.01<<
    End;

    // BC Upgrade SHUKLP03 << Page Management 700 Codeunit


    //***************************************************************************************************************************************
    //BC UPGRADE PATHAA02-30.01.26 CU5704-"TransferOrder-Post Shipment"(INTERFACESExt)
    //HEI.07-Event Subscribed-->OnBeforeInsertTransShptLine (Interface-IC TO)
    //HEI.10-Event Subscribed-->OnBeforeInsertTransShptLine (Interface-LSR)
    //*****************************************************************************************************************************************

    //Interface Ext-CU5704-Posted Transfer Shipment PATHAA02>>
    //HEI.07>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnAfterCheckInvtPostingSetup, '', false, false)]
    local procedure OnAfterCheckInvtPostingSetupExt(var TransferHeader: Record "Transfer Header"; var TempWhseShipmentHeader: Record "Warehouse Shipment Header" temporary; var SourceCode: Code[10])
    begin
        TransferHeaderG := TransferHeader; //PATHAA02-Global variable
    end;

    //Std-->Line 155(InsertTransShptLine(TransShptHeader)--> Line 568(OnBeforeInsertTransShptLine)//PATHAA02
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnBeforeInsertTransShptLine, '', false, false)]
    local procedure OnBeforeInsertTransShptLineExt(var TransShptLine: Record "Transfer Shipment Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var IsHandled: Boolean; TransShptHeader: Record "Transfer Shipment Header")
    begin

        TransShptLine."IC Shipment Adjusted FND" := TransferHeaderG."IC Document FND"; //HEI.07 //BC UPGRADE PATHAA02(Global Variable used from event-OnAfterCheckInvtPostingSetup)
    end;
    //HEI.07<<

    //HEI.10>>
    //Std--> Line 108(InsertTransShptHeader)--> Line 532(OnBeforeInsertTransShptHeader)//PATHAA02
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnBeforeInsertTransShptHeader, '', false, false)]
    local procedure OnBeforeInsertTransShptHeaderExt(var TransShptHeader: Record "Transfer Shipment Header"; TransHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    begin
        TransShptHeader."LSR Order No FND" := TransHeader."LSR Order No FND";  //HEI.10 //BC UPGRADE PATHAA02-will be moved to Interface Extension
    end;
    //HEI.10<<
    //Interface Ext-CU5704-Posted Transfer Shipment PATHAA02<<
    //***************************************************************************************************************************************

    // BC Upgrade SHUKLP03 >> Codeunit 5705 "TransferOrder-Post Receipt"
    //HEI.12 => Subscribed event OnBeforeTransRcptHeaderInsert

    [EventSubscriber(ObjectType::Codeunit, codeunit::"TransferOrder-Post Receipt", OnBeforeTransRcptHeaderInsert, '', false, false)]
    local procedure OnBeforeTransRcptHeaderInsert(TransferHeader: Record "Transfer Header"; var TransferReceiptHeader: Record "Transfer Receipt Header")
    var
    begin
        TransferReceiptHeader."LSR Order No FND" := TransferHeader."LSR Order No FND";  //HEI.12
    end;

    // BC Upgrade SHUKLP03 << Codeunit 5705 "TransferOrder-Post Receipt"

    //***************************************************************************************************************************************
    //BC UPGRADE PATHAA02-10.02.26 CU5760-"Whse.-Post Receipt"
    //Interface Ext-CU5760-Whse.-Post Receipt-PATHAA02>>
    //HEI.15>>
    //BC UPGRADE KUMARR78 >> Blocking - Whse Recipet Not Getting Commited
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnAfterCode, '', false, false)]
    // local procedure WhsePostReceiptLSR_OnAfterCode(var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WarehouseReceiptLine: Record "Warehouse Receipt Line"; CounterSourceDocTotal: Integer; CounterSourceDocOK: Integer)
    // var
    //     LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt."; //CU58021 in Interface Ext.
    //     ItemReclassErr: Label 'Item Reclassification Entries are not created successfully, please process them manually';
    // begin
    //     if CounterSourceDocOK = 0 then Exit;  //Run LSR when something was actually posted if not skip //BC UPGRADE PATHAA02 

    //     LSRInterfaceMgmt.SetWarehouseReceiptHeader(WarehouseReceiptHeader); // Pass fully posted Warehouse Receipt Header
    //     if not LSRInterfaceMgmt.RUN then
    //         Message(ItemReclassErr);
    //     LSRInterfaceMgmt.PostItemReclessJournal(WarehouseReceiptHeader);
    // end;
    //BC UPGRADE KUMARR78 << Blocking - Whse Recipet Not Getting Commited

    //BC UPGRADE KUMARR78 >> Adding
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnAfterCode, '', false, false)]
    local procedure WhsePostReceiptLSR_OnAfterCode(
            var WarehouseReceiptHeader: Record "Warehouse Receipt Header";
            WarehouseReceiptLine: Record "Warehouse Receipt Line";
            CounterSourceDocTotal: Integer;
            CounterSourceDocOK: Integer)
    var
        LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt.";
        ItemReclassErr: Label 'Item Reclassification Entries are not created successfully, please process them manually';
    begin
        if CounterSourceDocOK = 0 then
            exit;

        LSRInterfaceMgmt.SetWarehouseReceiptHeader(WarehouseReceiptHeader);

        if not TryRunLSR(LSRInterfaceMgmt) then begin
            // Prefer logging over Message in posting flows (optional)
            Message(ItemReclassErr);
            exit; // or continue based on your business rule
        end;

        // If this can also error, you may want to wrap it too:
        LSRInterfaceMgmt.PostItemReclessJournal(WarehouseReceiptHeader);
    end;

    [TryFunction]
    local procedure TryRunLSR(var LSRInterfaceMgmt: Codeunit "LSR Interface Mgmt.")
    begin
        LSRInterfaceMgmt.Run();
    end;
    //BC UPGRADE KUMARR78 << Adding

    //HEI.15<<
    //Interface Ext-CU5760-Whse.-Post Receipt-PATHAA02<<
    //**************************************************************************************


}