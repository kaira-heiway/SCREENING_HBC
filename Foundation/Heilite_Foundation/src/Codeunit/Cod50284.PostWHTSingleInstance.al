namespace STPFast.STPFast;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Intercompany.DataExchange;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Finance.ReceivablesPayables;
using Microsoft.Inventory.Posting;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Purchases.Posting;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.History;

codeunit 50284 "Post WHT Single Instance FND"
{
    SingleInstance = true;
    procedure IsWHTEnabled(): Boolean
    begin
        if not GLSetupFound then
            GLSetup.Get();
        GLSetupFound := true;
        exit(GLSetup."Enable WHT FND");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnRunOnAfterPostPurchLine, '', false, false)]
    local procedure PurchPost_OnRunOnAfterPostPurchLine(var Sender: Codeunit "Purch.-Post"; var TempPurchLineGlobal: Record "Purchase Line" temporary; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var ReturnShipmentHeader: Record "Return Shipment Header")
    begin

        if not IsWHTEnabled() then
            exit;

        TempPurchLineGlobalSI := TempPurchLineGlobal;
        if TempPurchLineGlobalSI.Insert() then;

        PurchInvHeaderSI := PurchInvHeader;
        if PurchInvHeaderSI.Insert() then;
        PurchCrMHeaderSI := PurchCrMemoHdr;
        if PurchCrMHeaderSI.Insert() then;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePostPurchaseDoc, '', false, false)]
    local procedure PurchPost_OnBeforePostPurchaseDoc(var Sender: Codeunit "Purch.-Post"; var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var HideProgressWindow: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; var IsHandled: Boolean)
    begin
        ClearSIVariables();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterPostPurchaseDoc, '', false, false)]
    local procedure PurchPost_OnAfterPostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean)
    begin
        ClearSIVariables()
    end;

    var
        GLSetup: Record "General Ledger Setup";
        PurchCrMHeaderSI: Record "Purch. Cr. Memo Hdr." temporary;
        PurchInvHeaderSI: Record "Purch. Inv. Header" temporary;
        TempPurchLineGlobalSI: Record "Purchase Line" temporary;
        TempWHTEntrySI: Record "WHT Entry FND" temporary;
        TempWHTPaymentCertificateToPrintSI: Record "WHT Entry FND" temporary;
        GLSetupFound: Boolean;
        WHTTotalAmount: Decimal;
        NextWHTEntryNo: Integer;

    local procedure ClearSIVariables()
    begin
        ClearAll();

        PurchCrMHeaderSI.Reset();
        if PurchCrMHeaderSI.IsTemporary then
            PurchCrMHeaderSI.DeleteAll();

        PurchInvHeaderSI.Reset();
        if PurchInvHeaderSI.IsTemporary then
            PurchInvHeaderSI.DeleteAll();

        TempPurchLineGlobalSI.Reset();
        if TempPurchLineGlobalSI.IsTemporary then
            TempPurchLineGlobalSI.DeleteAll();
        ClearTempWHTEntrySI();
    end;

    procedure ClearTempWHTEntrySI()
    begin
        TempWHTEntrySI.Reset();
        if TempWHTEntrySI.IsTemporary then
            TempWHTEntrySI.DeleteAll();
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnRunOnAfterPostPurchLine, '', false, false)]
    // local procedure PurchPost_OnRunOnAfterPostPurchLine(var Sender: Codeunit "Purch.-Post"; var TempPurchLineGlobal: Record "Purchase Line" temporary; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var ReturnShipmentHeader: Record "Return Shipment Header")
    // begin
    //     // TempPurchLineGlobalSI := TempPurchLineGlobal;
    //     TempPurchLineGlobalSI := TempPurchLineGlobal;
    //     if TempPurchLineGlobalSI.Insert() then;

    //     PurchInvHeaderSI := PurchInvHeader;
    //     if PurchInvHeaderSI.Insert() then;
    //     PurchCrMHeaderSI := PurchCrMemoHdr;
    //     if PurchCrMHeaderSI.Insert() then;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnPostInvoiceOnAfterPostLines, '', false, false)]
    local procedure PurchPost_OnPostInvoiceOnAfterPostLines(var PurchaseHeader: Record "Purchase Header"; SrcCode: Code[10]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line")
    var
        TotalInvAmount: Decimal;
        GLSetup: Record "General Ledger Setup";
        TempInvoicePostBuffer: Record "Invoice Posting Buffer";
        DocType: Enum "Gen. Journal Document Type";
        WHTGenJnlApplu: Codeunit "WHT Gen. Jnl.-Apply FND";
        TotalWHTAmount: Decimal;
    begin
        if not IsWHTEnabled() then
            exit;
        IF PurchaseHeader.Invoice AND (PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::"Credit Memo") THEN BEGIN  //HEI.43
            GLSetup.get();
            IF GLSetup."Enable WHT FND" THEN begin
                PurchaseHeader.CalcFields("Amount Including VAT");
                // PostGLOnFaInvoice(PurchaseHeader, TempInvoicePostBuffer);
                // TotalInvAmount := PostFAReturnPostingBuffer(PurchaseHeader, TempInvoicePostBuffer, DocType::Invoice, PurchaseHeader."No.", PurchaseHeader."Vendor Invoice No.");
                // WHTGenJnlApplu.PostWHT(PurchaseHeader, TotalInvAmount, TotalWHTAmount, PurchInvHeaderSI, SrcCode); // OLD
                WHTGenJnlApplu.PostWHT(PurchaseHeader, TempPurchLineGlobalSI, TotalPurchLineLCY, PurchaseHeader."Amount Including VAT", WHTTotalAmount, PurchInvHeaderSI, PurchCrMHeaderSI, SrcCode, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, GenJnlPostLine);
            end;
        END; //HEI.22
        IF PurchaseHeader.IsCreditDocType() AND (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo") THEN BEGIN  //HEI.43
            GLSetup.get();
            IF GLSetup."Enable WHT FND" THEN begin
                PurchaseHeader.CalcFields("Amount Including VAT");
                // PostGLOnFaCreditMemo(PurchaseHeader, TempInvoicePostBuffer);
                // WHTGenJnlApplu.PostWHT(PurchaseHeader, TotalInvAmount, TotalWHTAmount, PurchInvHeaderSI, SrcCode); // OLD
                WHTGenJnlApplu.PostWHT(PurchaseHeader, TempPurchLineGlobalSI, TotalPurchLineLCY, PurchaseHeader."Amount Including VAT", WHTTotalAmount, PurchInvHeaderSI, PurchCrMHeaderSI, SrcCode, GenJnlLineDocType, GenJnlLineDocNo, GenJnlLineExtDocNo, GenJnlPostLine); //NEW
            end;
        END; //HEI.22
    end;

    procedure InsertTempWHTEntrySI(pWHTEntry: Record "WHT Entry FND")
    begin

        TempWHTEntrySI.TransferFields(pWHTEntry);
        if TempWHTEntrySI.Insert() then;
    end;

    // procedure GetTempWHTEntrySI(var pWHTEntry: Record "WHT Entry FND")
    // begin
    //     if not pWHTEntry.IsTemporary then
    //         exit;
    //     TempWHTEntrySI.Reset();
    //     if TempWHTEntrySI.FindSet() then
    //         repeat
    //             pWHTEntry.TransferFields(TempWHTEntrySI);
    //             pWHTEntry.Insert();
    //         until TempWHTEntrySI.Next() = 0;
    // end;
    procedure GetTempWHTEntrySI(var pWHTEntry: Record "WHT Entry FND")
    begin
        if not pWHTEntry.IsTemporary then
            exit;

        TempWHTEntrySI.Reset();
        if TempWHTEntrySI.FindSet() then
            repeat
                pWHTEntry.TransferFields(TempWHTEntrySI);
                if pWHTEntry.Get(pWHTEntry."Entry No.") then
                    pWHTEntry.Modify()
                else
                    pWHTEntry.Insert();
            until TempWHTEntrySI.Next() = 0;
    end;

    procedure IncreaseWHTEntryNo()
    begin
        NextWHTEntryNo := NextWHTEntryNo + 1;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterInitGLRegister, '', false, false)]
    local procedure GenJnlPostLine_OnAfterInitGLRegister(var GLRegister: Record "G/L Register"; var GenJournalLine: Record "Gen. Journal Line")
    var
        WHTEntry: Record "WHT Entry FND";
    begin

        if not IsWHTEnabled() then begin

            NextWHTEntryNo := 0;
            exit;
        end;
        WHTEntry.LockTable();
        if WHTEntry.FindLast() then
            NextWHTEntryNo := WHTEntry."Entry No." + 1
        else
            NextWHTEntryNo := 1;

        GLRegister."From WHT Entry No. FND" := NextWHTEntryNo;
    end;

    procedure GetGLSetup(var recGLSetup: Record "General Ledger Setup")
    begin

        if not IsWHTEnabled() then
            exit;
        recGLSetup := GLSetup;
    end;

    procedure GetWHTTotalAmount(var decWHTTotalAmount: Decimal)
    begin

        if not IsWHTEnabled() then
            exit;
        decWHTTotalAmount := WHTTotalAmount;
    end;

}
