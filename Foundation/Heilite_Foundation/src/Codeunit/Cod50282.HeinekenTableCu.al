namespace IBM_MainExt.IBM_MainExt;
using System.Automation;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Finance.ReceivablesPayables;
using Microsoft.Purchases.Document;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Bank.Ledger;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Foundation.NoSeries;
using Microsoft.Warehouse.Structure;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Tracking;
using Microsoft.Warehouse.Activity;
using Microsoft.Manufacturing.Routing;
using Microsoft.Foundation.Reporting;
// Blocked as already used above at line 9
//using Microsoft.Foundation.NoSeries;
using Microsoft.HumanResources.Payables;
using Microsoft.Sales.History;
using Microsoft.CRM.Contact;
using Microsoft.Manufacturing.Setup;
using Microsoft.Warehouse.Journal;
using Microsoft.Manufacturing.Capacity;
using Microsoft.Inventory.Item;
using Microsoft.Projects.Resources.Resource;
using Microsoft.Finance.Currency;
using Microsoft.Finance.VAT.Setup;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.Inventory.Ledger;
using Microsoft.Purchases.Setup;
using Microsoft.Finance.GeneralLedger.Account;
using System.Utilities;
using Microsoft.CRM.Opportunity;
using Microsoft.Sales.Posting;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Sales.Setup;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Sales.Document;
using Microsoft.Bank.BankAccount;
using Microsoft.Bank.Reconciliation;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Manufacturing.Document;
using Microsoft.Warehouse.Document;
using Microsoft.Finance.GeneralLedger.Reversal;
using Microsoft.Utilities;
using Microsoft.Purchases.Archive;
using Microsoft.Sales.Archive;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Payables;
using Microsoft.Sales.Receivables;
using Microsoft.Sales.Reminder;
using Microsoft.Sales.Customer;
using Microsoft.Inventory.Transfer;
using System.Security.User;

codeunit 50282 "Heineken Table Cu"
{

    // BC Upgrade POENAB02, 26.02.2026, Gap/Fit correction for "Setting Workflow for FA and General Journal"

    //BC Upgrade SHARMP16 Begin>> ---454 table Custom Code
    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", OnBeforeRecordDetails, '', false, false)]
    local procedure OnBeforeRecordDetailsHandler(var ApprovalEntry: Record "Approval Entry"; var Details: Text; var IsHandled: Boolean)
    var
        WorkflowRule: Record "Workflow Rule";
        CustBankAcc: Record "Customer Bank Account";
        ChangeRecordDetails: Text;
        RecRef: RecordRef;
    begin
        // HEI.01 >>
        if (ChangeRecordDetails = '') and (RecRef.Number = Database::"Customer Bank Account") then begin
            WorkflowRule.SetRange("Workflow Step Instance ID", ApprovalEntry."Workflow Step Instance ID");
            WorkflowRule.SetRange("Workflow Code", ApprovalEntry."Approval Code");
            if WorkflowRule.FindFirst() then begin
                WorkflowRule.CalcFields("Field Caption");
                ChangeRecordDetails := ':' + WorkflowRule."Field Caption";
            end;

            RecRef.SetTable(CustBankAcc);
            if ChangeRecordDetails <> '' then
                ChangeRecordDetails += ':' + CustBankAcc."Old Bank Account No. FND" + '->' + CustBankAcc."Bank Account No.";
        end;
        // HEI.01 <<
    end;
    //BC Upgrade SHARMP16 End<< ---454 Custom Cod


    //BC Upgrade KAPOOV01 >> //BC Upgrade KAPOOV01 13-11-2025 #HEI.01 custom code on-Entry No. - OnValidate() trigger  so for this Event subscribed-OnAfterCopyFromCustLedgEntry in Heineken Table Cu.

    [EventSubscriber(ObjectType::Table, Database::"Reminder Line", OnAfterCopyFromCustLedgEntry, '', false, false)]
    local procedure OnAfterCopyFromCustLedgEntry(var ReminderLine: Record "Reminder Line"; CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        DisputeCase: Record "Dispute Case FND";
    begin
        //HEI.01>>
        DisputeCase.SETRANGE(DisputeCase."Cust. Ledger Entry No.", ReminderLine."Entry No.");
        DisputeCase.SETRANGE(DisputeCase.Status, DisputeCase.Status::Open);
        IF DisputeCase.FINDFIRST() THEN
            ReminderLine."Disputed Reason code FND" := DisputeCase."Reason Code";
        //HEI.01>>
    end;
    //BC Upgrade KAPOOV01 << //BC Upgrade KAPOOV01 13-11-2025 #HEI.01 custom code on-Entry No. - OnValidate() trigger  so for this Event subscribed-OnAfterCopyFromCustLedgEntry in Heineken Table Cu.


    //BC Upgrade POENAB02 >>
    //Custome code/condition from table 179 "Reversal Entry"
    [EventSubscriber(ObjectType::Table, 179, 'OnBeforeCheckBankAcc', '', false, false)]
    local procedure OnBeforeCheckBankAcc(var BankAccLedgEntry: Record "Bank Account Ledger Entry"; var IsHandled: Boolean);
    var
        SourceCodeSetup: Record "Source Code Setup";
        IsExchRateAdjmt: Boolean;
        Text006Lbl: Label 'You cannot reverse %1 No. %2 because the entry is closed.', Comment = 'Entry cannot be reversed beucase the entry is closed.';
    begin
        SourceCodeSetup.Get();
        IsExchRateAdjmt := SourceCodeSetup."Exchange Rate Adjmt." = BankAccLedgEntry."Source Code";
        if not BankAccLedgEntry.Open and (not IsExchRateAdjmt) THEN
            Error(
                Text006Lbl, BankAccLedgEntry.TableCaption, BankAccLedgEntry."Entry No.");
    end;

    //Modified logic for "CheckDtldVendLedgEntry" from table 179 "Reversal Entry"
    //In HeiLite part of the code is commented
    [EventSubscriber(ObjectType::Table, 179, OnBeforeCCheckDtldVendLedgEntry, '', false, false)]
    local procedure OnBeforeCCheckDtldVendLedgEntry(VendLedgEntry: Record "Vendor Ledger Entry"; var IsHandled: Boolean)
    var
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        ReversalEntry: Record "Reversal Entry";
    begin
        IsHandled := true;
        DetailedVendorLedgEntry.SetCurrentKey("Vendor Ledger Entry No.", "Entry Type");
        DetailedVendorLedgEntry.SetRange("Vendor Ledger Entry No.", VendLedgEntry."Entry No.");
        DetailedVendorLedgEntry.SetFilter("Entry Type", '<>%1', DetailedVendorLedgEntry."Entry Type"::"Initial Entry");
        DetailedVendorLedgEntry.SetRange(Unapplied, false);
        if not DetailedVendorLedgEntry.IsEmpty() then
            Error(ReversalEntry.ReversalErrorForChangedEntry(VendLedgEntry.TableCaption(), VendLedgEntry."Entry No."));
    end;
    //BC Upgrade POENAB02 <<

    //BC Upgrade POENAB02 >>
    //Custom code from table 271 "Bank Account Ledger Entry"
    [EventSubscriber(ObjectType::Table, 271, 'OnAfterCopyFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyFromGenJnlLine(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
    begin
        BankAccountLedgerEntry."Transaction Code FND" := GenJournalLine."Transaction Code FND";
    end;
    //BC Upgrade POENAB02 <<



    //Logic migrated from HeiLite, from table 49 "Invoice Post. Buffer", function PreparePurchase
    [EventSubscriber(ObjectType::Codeunit, 826, OnAfterPrepareInvoicePostingBuffer, '', false, false)]
    local procedure OnAfterPrepareInvoicePostingBuffer(var PurchaseLine: Record "Purchase Line"; var InvoicePostingBuffer: Record "Invoice Posting Buffer")
    begin
        //HEI.03>>
        InvoicePostingBuffer."Additional Description FND" := PurchaseLine."Additional Description FND";
        //HEI.03<<
        //Bc Upgrade YADAVM09 code added in Levy custom codeunit>>
        // //HEI.06
        // InvoicePostingBuffer."H&S Levy Tax Amount FND" := PurchaseLine."H&S Levy Tax Amount FND";
        // InvoicePostingBuffer."H&S Levy Tax % FND" := PurchaseLine."H&S Levy Tax % FND";
        // InvoicePostingBuffer."HS Posting Group FND" := PurchaseLine."HS Posting Group FND";
        // //HEI.06
        //Bc Upgrade YADAVM09 code added in Levy custom codeunit<<
    end;

    //Logic migrated from HeiLite, from table 49 "Invoice Post. Buffer", function Update
    // [EventSubscriber(ObjectType::Table, Database::"Invoice Posting Buffer", 'OnUpdateOnBeforeModify', '', false, false)]
    // local procedure OnUpdateOnBeforeModifyInvoicePostingBuffer(var InvoicePostingBuffer: Record "Invoice Posting Buffer"; FromInvoicePostingBuffer: Record "Invoice Posting Buffer")
    // begin
    //     InvoicePostingBuffer."H&S Levy Tax Amount FND" += FromInvoicePostingBuffer."H&S Levy Tax Amount FND";
    // end;//Bc Upgrade YADAVM09 event added in Levy custom codeunit<<
    //BC Upgrade POENAB02 <<

    //BC Upgrade SHARMP16 Begin>> ---5746(Transfer Receipt Header) table Custom Code
    [EventSubscriber(ObjectType::Table, Database::"Transfer Receipt Header", OnAfterCopyFromTransferHeader, '', false, false)]
    local procedure OnAfterCopyFromTransferHeader(TransferHeader: Record "Transfer Header"; var TransferReceiptHeader: Record "Transfer Receipt Header")
    begin
        TransferReceiptHeader."IC Document FND" := TransferHeader."IC Document FND"; //HEI.04
    end;
    //BC Upgrade SHARMP16 End<< ---5746(Transfer Receipt Header) table Custom Code

    //BC Upgrade SHARMP16 Begin>> ---5744(Transfer Shipment Header) table Custom Code
    [EventSubscriber(ObjectType::Table, Database::"Transfer Shipment Header", OnAfterCopyFromTransferHeader, '', false, false)]
    local procedure OnAfterCopyFromTransferHeaderShipment(TransferHeader: Record "Transfer Header"; var TransferShipmentHeader: Record "Transfer Shipment Header")
    begin
        TransferShipmentHeader."IC Document FND" := TransferHeader."IC Document FND"; //HEI.03
    end;
    //BC Upgrade SHARMP16 End<< ---5744(Transfer Shipment Header) table Custom Code

    //BC Upgrade SHARMP16 Begin>> ---7320(Warehouse Shipment Header) table Custom Code
    [EventSubscriber(ObjectType::Table, Database::"Warehouse Shipment Header", 'OnAfterOnInsert', '', false, false)]
    local procedure WhseShptHeaderOnBeforeInsert(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var xWarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        Location: Record Location;
        Bin: Record Bin;
    begin
        //HEI.01>>
        if Location.Get(WarehouseShipmentHeader."Location Code") then begin
            if Bin.Get(Location.Code, Location."Shipment Bin Code") then
                WarehouseShipmentHeader.Validate("Zone Code", Bin."Zone Code");
        end;
        //HEI.01<<
    end;
    //BC Upgrade SHARMP16 End<< ---7320(Warehouse Shipment Header) table Custom Code -- must be on after so that the base logic run first then this logic

    //BC Upgrade SHARMP16 Begin>> --0(Warehouse Receipt Header) table Custom Code
    [EventSubscriber(ObjectType::Table, Database::"Warehouse Receipt Header", 'OnAfterOnInsert', '', false, false)]
    local procedure WhseRcptHeaderOnBeforeInsert(var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; Location: Record Location; var xWarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        Bin: Record Bin;
    begin
        //HEI.01>>
        if Location.Get(WarehouseReceiptHeader."Location Code") then begin
            if Bin.Get(Location.Code, Location."Shipment Bin Code") then
                WarehouseReceiptHeader.Validate("Zone Code", Bin."Zone Code");
        end;
        //HEI.01<<
    end;
    //BC Upgrade SHARMP16 End>> ---(Warehouse Receipt Header) table Custom Code -- must be on after so that the base logic run first then this logic

    //BC Upgrade SHARMP16 BEGIN<< ---Warehouse Receipt Header DeleteRelatedLines fn
    [EventSubscriber(ObjectType::Table, Database::"Warehouse Receipt Header", OnBeforeDeleteWhseRcptRelatedLines, '', false, false)]
    local procedure OnBeforeDeleteWhseRcptRelatedLines(var SkipConfirm: Boolean; var WhseRcptLine: Record "Warehouse Receipt Line")
    begin
        // >>> HEI.13 Custom Logic
        if g_SuppressWindow then
            SkipConfirm := true;
        // <<< HEI.13
    end;

    procedure SuppressConfirmBox(SuppressWindow: Boolean)
    begin
        //>>HEI.13
        g_SuppressWindow := SuppressWindow;
        //<<HEI.13
    end;
    //BC Upgrade SHARMP16 END>> ---Warehouse Receipt Header DeleteRelatedLines fn

    //HEI YADAVM09 Prod. Order Componenet>>
    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Component", OnBeforeBinCodeOnLookup, '', false, false)]
    local procedure OnBeforeBinCodeOnLookup(var ProdOrderComponent: Record "Prod. Order Component"; var IsHandled: Boolean)
    var
        WMSManagement: Codeunit "WMS Management";
        BinCode: Code[20];
        Item: Record Item;
    begin
        if Item.Get(ProdOrderComponent."Item No.") then
            if BinCode <> '' then
                Item.TestField(Type, Item.Type::Inventory);
        IF ProdOrderComponent.Quantity > 0 THEN
            //HEI.01 PRDGAP024 delete BinCode := WMSManagement.BinContentLookUp("Location Code","Item No.","Variant Code",'',"Bin Code")
            BinCode := WMSManagement.BinContentLookUp(ProdOrderComponent."Location Code", ProdOrderComponent."Item No.", ProdOrderComponent."Variant Code", ProdOrderComponent."Zone Code FND", ProdOrderComponent."Bin Code")//HEI.01 PRDGAP024 SINGLE
        ELSE
            //HEI.01 PRDGAP024 delete BinCode := WMSManagement.BinLookUp("Location Code","Item No.","Variant Code",'');
            BinCode := WMSManagement.BinLookUp(ProdOrderComponent."Location Code", ProdOrderComponent."Item No.", ProdOrderComponent."Variant Code", ProdOrderComponent."Zone Code FND");//HEI.01 PRDGAP024 SINGLE

        IF BinCode <> '' THEN
            ProdOrderComponent.VALIDATE("Bin Code", BinCode);
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Component", OnBeforeUpdateBin, '', false, false)]
    local procedure OnBeforeUpdateBin(var ProdOrderComponent: Record "Prod. Order Component"; FieldNo: Integer; FieldCaption: Text[30])
    var
        ProdOrderComp2: Record "Prod. Order Component";
        OverwriteBinCode, IsHandled : Boolean;
        Text001: Label 'The changed %1 now points to bin %2. Do you want to update the bin on this line?';
        CurrFieldNo: Integer;
    begin
        ProdOrderComponent.GetCurrentFieldno(CurrFieldNo);//Bc Upgrade YADAVM09 function created to handle Currfield
        ProdOrderComp2 := ProdOrderComponent;
        ProdOrderComp2.GetDefaultBin();
        IF ProdOrderComponent."Bin Code" <> ProdOrderComp2."Bin Code" THEN
            IF CurrFieldNo = FieldNo THEN BEGIN
                IF CONFIRM(Text001, FALSE, FieldCaption, ProdOrderComp2."Bin Code") THEN
                    OverwriteBinCode := TRUE;
            END ELSE
                //HEI.08>>
                //OverwriteBinCode := TRUE;//old code
                OverwriteBinCode := FALSE;

        //HEI.08>>
        IF OverwriteBinCode THEN
            ProdOrderComponent."Bin Code" := ProdOrderComp2."Bin Code";
        IsHandled := true;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Component", OnBeforeGetDefaultBin, '', false, false)]
    local procedure OnBeforeGetDefaultBin(var ProdOrderComponent: Record "Prod. Order Component"; var xProdOrderComponent: Record "Prod. Order Component"; var IsHandled: Boolean)
    var
        DefaultBin: Code[20];
        Bin2: Record Bin;
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        Item: Record Item;
    begin
        if (ProdOrderComponent.Quantity * xProdOrderComponent.Quantity > 0) and
    (ProdOrderComponent."Item No." = xProdOrderComponent."Item No.") and
    (ProdOrderComponent."Location Code" = xProdOrderComponent."Location Code") and
    (ProdOrderComponent."Variant Code" = xProdOrderComponent."Variant Code") and
    (ProdOrderComponent."Routing Link Code" = xProdOrderComponent."Routing Link Code") then
            exit;
        ProdOrderComponent."Bin Code" := '';

        //HEI.01 PRDGAP024+
        ProdOrderComponent."Zone Code FND" := '';
        DefaultBin := ProdOrderComponent.GetDefaultConsumptionBin(ProdOrderRtngLine);
        IF DefaultBin <> '' THEN BEGIN
            Bin2.GET(ProdOrderComponent."Location Code", DefaultBin);
            ProdOrderComponent."Zone Code FND" := Bin2."Zone Code";
        END;
        //HEI.01 PRDGAP024+
        if (ProdOrderComponent."Location Code" <> '') and (ProdOrderComponent."Item No." <> '') then begin
            if Item."No." <> ProdOrderComponent."Item No." then
                Item.Get(ProdOrderComponent."Item No.");
            if Item.IsInventoriableType() then
                ProdOrderComponent.Validate("Bin Code", ProdOrderComponent.GetDefaultConsumptionBin(ProdOrderRtngLine));
        end;
        IsHandled := true;
    end;
    //HEI YADAVM09 Prod. Order Componenet<<

    //Yadavm09-5406 Prod. Order Line>>
    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Line", OnBeforeValidateRoutingNo, '', false, false)]
    local procedure OnBeforeValidateRoutingNo(var ProdOrderLine: Record "Prod. Order Line"; var xProdOrderLine: Record "Prod. Order Line"; FieldNumber: Integer; var IsHandled: Boolean)
    var
        CapLedgEntry: Record "Capacity Ledger Entry";
        PurchLine: Record "Purchase Line";
        Text99000004Err: Label 'You cannot modify %1 %2 because there is at least one %3 associated with it.', Comment = '%1 = Field Caption; %2 = Field Value; %3 = Table Caption';
        RoutingHeader: Record "Routing Header";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        RoutingVersion: Code[20];
        VersionManagement: Codeunit VersionManagement;
        ModifyRecord: Boolean;
    begin
        //"Routing Version Code" := '';//HEI.02>>

        if ProdOrderLine."Routing No." <> xProdOrderLine."Routing No." then begin
            //HEI.02>>
            //VALIDATE("Routing Version Code",VersionMgt.GetRtngVersion("Routing No.","Due Date",TRUE));
            //HEI.02<<
            if ProdOrderLine.Status = ProdOrderLine.Status::Released then begin
                if CheckCapLedgEntry(ProdOrderLine, CapLedgEntry) then
                    Error(
                      Text99000004Err,
                      ProdOrderLine.FieldCaption("Routing No."), xProdOrderLine."Routing No.", CapLedgEntry.TableCaption());

                if CheckSubcontractPurchOrder(ProdOrderLine, PurchLine) then
                    Error(
                      Text99000004Err,
                      ProdOrderLine.FieldCaption("Routing No."), xProdOrderLine."Routing No.", PurchLine.TableCaption());
            end;

            ModifyRecord := false;
            OnBeforeDeleteProdOrderRtngLines(ProdOrderLine, ModifyRecord);
            if ModifyRecord then
                ProdOrderLine.Modify();

            ProdOrderRoutingLine.SetRange(Status, ProdOrderLine.Status);
            ProdOrderRoutingLine.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");
            ProdOrderRoutingLine.SetRange("Routing No.", xProdOrderLine."Routing No.");
            ProdOrderRoutingLine.SetRange("Routing Reference No.", ProdOrderLine."Line No.");
            ProdOrderRoutingLine.DeleteAll(true);
            // OnAfterDeleteProdOrderRtngLines(Rec);
        end;

        if ProdOrderLine."Routing No." = '' then
            //exit;//Bc Upgrade YADAVM09
            IsHandled := true;
        if IsHandled then
            exit;//Bc Upgrade YADAVM09

        IF ProdOrderLine."Routing Version Code" = '' THEN BEGIN
            //HEI.08>>
            RoutingVersion := VersionManagement.GetRtngVersion(ProdOrderline."Routing No.", WORKDATE(), TRUE);
            ProdOrderLine.VALIDATE("Routing Version Code", RoutingVersion);
            //VALIDATE("Routing Version Code",DefProdBOMVersion);//HEI.06
            //HEI.08<<
            RoutingHeader.GET(ProdOrderLine."Routing No.");
            RoutingHeader.TESTFIELD(Status, RoutingHeader.Status::Certified);
            ProdOrderLine."Routing Type" := RoutingHeader.Type;
        END;
        //HEI.07>>
        IF ProdOrderLine."Bin Code" = '' THEN
            GetDefaultBin(ProdOrderLine, xProdOrderLine);
        //HEI.07<<
        //HEI.10>>
        // IF (xRec."Routing No." <> "Routing No.") AND (CurrFieldNo <> 0) THEN BEGIN
        //    ValidateAstroProdOrderLineModification;
        //END;//BCUpgrade YadavM09 Blocked as Astro is out of scope
        //HEI.10<<
        IsHandled := true;
    end;

    local procedure GetDefaultBin(var ProdOrderline: Record "Prod. Order Line"; var xProdOrderLine: Record "Prod. Order Line")
    var
        WMSManagement: Codeunit "WMS Management";
        ProdOrderWarehouseMgt: Codeunit "Prod. Order Warehouse Mgt.";
        Bin: Record Bin;
        WHSUTILS: Codeunit "WHS-UTILS";
    begin
        /* //HEI.07
        IF (Quantity * xRec.Quantity > 0) AND
           ("Item No." = xRec."Item No.") AND
           ("Location Code" = xRec."Location Code") AND
           ("Variant Code" = xRec."Variant Code")
        THEN
          EXIT;
        *///HEI.07<<

        ProdOrderline."Bin Code" := '';
        if (ProdOrderline."Location Code" <> '') and (ProdOrderline."Item No." <> '') then begin
            ProdOrderline."Bin Code" :=
                ProdOrderWarehouseMgt.GetLastOperationFromBinCode(
                    ProdOrderline."Routing No.", ProdOrderline."Routing Version Code", ProdOrderline."Location Code", false, Enum::"Flushing Method"::Manual);
            GetLocation(ProdOrderline."Location Code");
            if ProdOrderline."Bin Code" = '' then
                ProdOrderline."Bin Code" := Location."From-Production Bin Code";
            //HEI.07>>
            IF Bin.GET(ProdOrderline."Location Code", ProdOrderline."Bin Code") THEN
                ProdOrderline."Zone Code FND" := Bin."Zone Code";
            IF ProdOrderline."Zone Code FND" <> '' THEN
                WHSUTILS.CheckUserAuthorizedinZone(ProdOrderline."Location Code", ProdOrderline."Zone Code FND");
            //HEI.07<<

            //if (ProdOrderline."Bin Code" = '') and Location."Bin Mandatory" and not Location."Directed Put-away and Pick" then
            //    WMSManagement.GetDefaultBin(ProdOrderline."Item No.", ProdOrderline."Variant Code", ProdOrderline."Location Code", ProdOrderline."Bin Code");
        end;
        ProdOrderline.Validate("Bin Code");
    end;

    local procedure CheckCapLedgEntry(var ProdOrderLine: Record "Prod. Order Line"; var CapLedgEntry: Record "Capacity Ledger Entry"): Boolean
    var
    //CapLedgEntry: Record "Capacity Ledger Entry";
    begin
        CapLedgEntry.SetCurrentKey("Order Type", "Order No.", "Order Line No.");
        CapLedgEntry.SetRange("Order Type", CapLedgEntry."Order Type"::Production);
        CapLedgEntry.SetRange("Order No.", ProdOrderLine."Prod. Order No.");
        CapLedgEntry.SetRange("Order Line No.", ProdOrderLine."Line No.");
        exit(not CapLedgEntry.IsEmpty);
    end;

    local procedure CheckSubcontractPurchOrder(var ProdOrderLine: Record "Prod. Order Line"; var PurchLine: Record "Purchase Line"): Boolean
    var
    //PurchLine: Record "Purchase Line";
    begin
        PurchLine.SetCurrentKey(
          "Document Type", Type, "Prod. Order No.", "Prod. Order Line No.", "Routing No.", "Operation No.");
        PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SetRange(Type, PurchLine.Type::Item);
        PurchLine.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");
        PurchLine.SetRange("Prod. Order Line No.", ProdOrderLine."Line No.");
        exit(not PurchLine.IsEmpty);
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Clear(Location)
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;

    local procedure ValidateUnitofMeasureCodeFromItem(ProdOrderLine: Record "Prod. Order Line"; Item: Record Item)
    var
        IsHandled: Boolean;
    begin
        // IsHandled := false;
        // OnBeforeValidateUnitofMeasureCodeFromItem(Rec, xRec, Item, ProdOrder, IsHandled);
        // if IsHandled then
        //     exit;
        ProdOrderLine.Validate("Unit of Measure Code", Item."Base Unit of Measure");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Line", OnValidateProductionBOMNoOnBeforeTestStatus, '', false, false)]
    local procedure OnValidateProductionBOMNoOnBeforeTestStatus(var ProdOrderLine: Record "Prod. Order Line"; var IsHandled: Boolean)
    var
        ProdBOMVersion: Code[20];
        VersionManagement: Codeunit VersionManagement;
    begin
        //HEI.06>>
        //HEI.08>>
        IF ProdOrderLine."Production BOM Version Code" = '' THEN BEGIN
            ProdBOMVersion := VersionManagement.GetBOMVersion(ProdOrderLine."Production BOM No.", WORKDATE(), TRUE);
            ProdOrderLine.VALIDATE("Production BOM Version Code", ProdBOMVersion);
        END;
        //VALIDATE("Production BOM Version Code",DefProdBOMVersion);
        //HEI.08<<
        //HEI.06<<
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDeleteProdOrderRtngLines(var ProdOrderLine: Record "Prod. Order Line"; var ModifyRecord: Boolean)
    begin
    end;

    //Yadavm09-5406 Prod. Order Line<<


    //BC UPGRADE PATHAA02 01.12.25 Subscribed to this event to handle code- HEI.01 of T5767 on Function-AutofillQtyToHandle>>

    [EventSubscriber(ObjectType::Table, Database::"Warehouse Activity Line", OnBeforeAutofillQtyToHandle, '', false, false)]
    local procedure WarehouseActivityLine_OnBeforeAutofillQtyToHandle(var WarehouseActivityLine: Record "Warehouse Activity Line"; var IsHandled: Boolean)
    var
        NotEnough: Boolean;
        Hooks: Codeunit "WHS-UTILS";
        QtyTransit: Decimal;
        QtyTransitBase: Decimal;
        Text50000: Label 'Quantity available to pick is not enough to fill in all the lines.';

    begin
        NotEnough := FALSE;
        IF WarehouseActivityLine.FIND('-') THEN
            REPEAT
                //HEI.01 PRDGAP024 begin delete
                //VALIDATE("Qty. to Handle","Qty. Outstanding");
                //HEI.01 PRDGAP024 end delete
                //HEI.01 PRDGAP024>>
                IF NOT WarehouseActivityLine."Zone-Transfer FND" THEN BEGIN
                    WarehouseActivityLine.VALIDATE("Qty. to Handle", WarehouseActivityLine."Qty. Outstanding");
                    IF WarehouseActivityLine."Qty. to Handle (Base)" <> WarehouseActivityLine."Qty. Outstanding (Base)" THEN
                        WarehouseActivityLine.VALIDATE("Qty. to Handle (Base)", WarehouseActivityLine."Qty. Outstanding (Base)");
                END ELSE BEGIN
                    IF WarehouseActivityLine."Action Type" = WarehouseActivityLine."Action Type"::Take THEN BEGIN
                        WarehouseActivityLine.VALIDATE("Qty. to Handle", WarehouseActivityLine."Qty. Outstanding");
                        IF WarehouseActivityLine."Qty. to Handle (Base)" <> WarehouseActivityLine."Qty. Outstanding (Base)" THEN
                            WarehouseActivityLine.VALIDATE("Qty. to Handle (Base)", WarehouseActivityLine."Qty. Outstanding (Base)");
                    END ELSE BEGIN
                        Hooks.CalcQtyTransitRef(WarehouseActivityLine, QtyTransit, QtyTransitBase);
                        //temp VALIDATE("Qty. to Handle",QtyTransit);
                        WarehouseActivityLine.VALIDATE("Qty. to Handle (Base)", QtyTransitBase);
                    END;
                END;
                //HEI.01 PRDGAP024>>
                //HEI.01 PRDGAP024 begin delete
                //IF "Qty. to Handle (Base)" <> "Qty. Outstanding (Base)" THEN
                //  VALIDATE("Qty. to Handle (Base)","Qty. Outstanding (Base)");
                //HEI.01 PRDGAP024<< end delete
                WarehouseActivityLine.MODIFY();

                IF NOT NotEnough THEN
                    IF WarehouseActivityLine."Qty. to Handle" < WarehouseActivityLine."Qty. Outstanding" THEN
                        NotEnough := TRUE;
            UNTIL WarehouseActivityLine.NEXT() = 0;
        IF NOT WarehouseActivityLine."Zone-Transfer FND" THEN//HEI.01 PRDGAP024 SINGLE
            IF NotEnough THEN
                MESSAGE(Text50000);
        IsHandled := true;//Skip Standard code
    end;
    //BC UPGRADE PATHAA02 01.12.25 Subscribed to this events to handle code- HEI.01 of T5767 on Function-AutofillQtyToHandle<<

    //BC UPGRADE PATHAA02 02.12.25 procedure of CU7307(HEI.11) is added in common CU. It is called from T5767(HEI.06) on Function-CallItemTracking>>

    procedure CallItemTracking(VAR WarehouseActivityLine: Record "Warehouse Activity Line")
    var
        ItemTrackingLines: Page "Item Tracking Lines";
        TrackingSpecification: Record "Tracking Specification";
    begin
        //HEI.11>>
        WarehouseActivityLine.TESTFIELD("Item No.");
        TrackingSpecification.InitFromWhseActivityLine(WarehouseActivityLine);
        ItemTrackingLines.ApplyFilters();
        ItemTrackingLines.SetSourceSpec(TrackingSpecification, WarehouseActivityLine."Due Date");
        ItemTrackingLines.SetInbound(WarehouseActivityLine.IsInbound());
        ItemTrackingLines.RUNMODAL();
        //HEI.11<<
    end;
    //BC UPGRADE PATHAA02 02.12.25 procedure of CU7307(HEI.11) is added in common CU. It is called from T5767(HEI.06) on Function-CallItemTracking>>



    //Start here table-1294-Applied Payment Entry--->>
    //For this table created 3 subscriber functions below

    //BC Upgrade KAPOOV01 02.12.25  #Subsribed to this event for Function-UpdateParentBankAccReconLine() of Table-1294-Applied Payment Entry>>
    [EventSubscriber(ObjectType::Table, Database::"Applied Payment Entry", OnUpdateParentBankAccReconLineOnBeforeBankAccReconLineModify, '', false, false)]
    local procedure OnUpdateParentBankAccReconLineOnBeforeBankAccReconLineModify(var AppliedPaymentEntry: Record "Applied Payment Entry"; var BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line"; IsDelete: Boolean)
    var

    begin
        // BankAccReconciliationLine."IBAN Matched" := FALSE;//soicad
    end;
    //BC Upgrade KAPOOV01 02.12.25  #Subsribed to this event for Function-UpdateParentBankAccReconLine() of Table-1294-Applied Payment Entry<<

    //BC Upgrade KAPOOV01 02.12.25  #Subsribed to this event for Function-GetCustLedgEntryRemAmt() of Table-1294-Applied Payment Entry>>
    [EventSubscriber(ObjectType::Table, Database::"Applied Payment Entry", OnGetCustLedgEntryRemAmtOnBeforeCalcFields, '', false, false)]
    local procedure OnGetCustLedgEntryRemAmtOnBeforeCalcFields(AppliedPaymentEntry: Record "Applied Payment Entry"; var IsHandled: Boolean; var Result: Decimal)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        IsBankLCY: Boolean;
        BankAcc: Record "Bank Account";
    begin
        IsHandled := true;
        //BC Upgrade KAPOOV01 updated Boolean-IsBankLCY that was done by separate local function-IsBankLCY() in standard codeunit>>
        BankAcc.GET(AppliedPaymentEntry."Bank Account No.");
        IsBankLCY := BankAcc.IsInLocalCurrency();
        //BC Upgrade KAPOOV01 updated Boolean-IsBankLCY that was done by separate local function-IsBankLCY() in standard codeunit<<
        CustLedgEntry.GET(AppliedPaymentEntry."Applies-to Entry No.");
        //soicad01>>
        CustLedgEntry.CALCFIELDS("Original Amount");
        IF (CustLedgEntry."Original Amount" < 0) AND (CustLedgEntry."Document Type" = CustLedgEntry."Document Type"::"Credit Memo") THEN BEGIN
            IF IsBankLCY AND (CustLedgEntry."Currency Code" <> '') THEN BEGIN
                CustLedgEntry.CALCFIELDS("Original Amt. (LCY)");
                //BC Upgrade KAPOOV01>>
                //EXIT(CustLedgEntry."Original Amt. (LCY)");
                Result := CustLedgEntry."Original Amt. (LCY)";
                //BC Upgrade KAPOOV01<<
            END;
            CustLedgEntry.CALCFIELDS("Original Amount");
            //BC Upgrade KAPOOV01>>
            //EXIT(CustLedgEntry."Original Amount");
            Result := CustLedgEntry."Original Amount";
            //BC Upgrade KAPOOV01<<

        END;
        //soicad01<<
        IF IsBankLCY AND (CustLedgEntry."Currency Code" <> '') THEN BEGIN
            CustLedgEntry.CALCFIELDS("Remaining Amt. (LCY)");
            //BC Upgrade KAPOOV01>>
            //EXIT(CustLedgEntry."Remaining Amt. (LCY)");
            Result := CustLedgEntry."Remaining Amt. (LCY)";
            //BC Upgrade KAPOOV01<<
        END;
        CustLedgEntry.CALCFIELDS("Remaining Amount");
        //soicad01>>

        IF IsBankLCY AND (CustLedgEntry."Currency Code" <> '') THEN BEGIN
            CustLedgEntry.CALCFIELDS("Remaining Amt. (LCY)");
            //BC Upgrade KAPOOV01>>
            //EXIT(CustLedgEntry."Remaining Amt. (LCY)" + CustLedgEntry."Pmt. Tolerance (LCY)");
            Result := CustLedgEntry."Remaining Amt. (LCY)" + CustLedgEntry."Pmt. Tolerance (LCY)";
            //BC Upgrade KAPOOV01<<
        END;
        CustLedgEntry.CALCFIELDS("Remaining Amount");
        //BC Upgrade KAPOOV01>>
        //EXIT(CustLedgEntry."Remaining Amount" + CustLedgEntry."Max. Payment Tolerance");
        Result := CustLedgEntry."Remaining Amount" + CustLedgEntry."Max. Payment Tolerance";
        //BC Upgrade KAPOOV01<<
        //soicad01<<
        //BC Upgrade KAPOOV01>>
        //EXIT(CustLedgEntry."Remaining Amount");
        Result := CustLedgEntry."Remaining Amount";
        //BC Upgrade KAPOOV01<<
    end;
    //BC Upgrade KAPOOV01 02.12.25  #Subsribed to this event for Function-GetCustLedgEntryRemAmt() of Table-1294-Applied Payment Entry<<

    //BC Upgrade KAPOOV01 02.12.25  #Subsribed to this event for Function-GetVendLedgEntryRemAmt() of Table-1294-Applied Payment Entry<<
    [EventSubscriber(ObjectType::Table, Database::"Applied Payment Entry", OnGetVendLedgEntryRemAmtOnBeforeCalcFields, '', false, false)]
    local procedure OnGetVendLedgEntryRemAmtOnBeforeCalcFields(AppliedPaymentEntry: Record "Applied Payment Entry"; var IsHandled: Boolean; var Result: Decimal)
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        IsBankLCY: Boolean;
        BankAcc: Record "Bank Account";
    begin
        IsHandled := true;
        //BC Upgrade KAPOOV01 updated Boolean-IsBankLCY that was done by separate local function-IsBankLCY() in standard codeunit>>
        BankAcc.GET(AppliedPaymentEntry."Bank Account No.");
        IsBankLCY := BankAcc.IsInLocalCurrency();
        //BC Upgrade KAPOOV01 updated Boolean-IsBankLCY that was done by separate local function-IsBankLCY() in standard codeunit<<

        VendLedgEntry.GET(AppliedPaymentEntry."Applies-to Entry No.");
        IF IsBankLCY AND (VendLedgEntry."Currency Code" <> '') THEN BEGIN

            VendLedgEntry.CALCFIELDS("Remaining Amt. (LCY)");
            VendLedgEntry.CALCFIELDS("Original Amt. (LCY)");//SOICAD01 single
                                                            //soicad delete EXIT(VendLedgEntry."Remaining Amt. (LCY)");
            IF (VendLedgEntry."Original Amt. (LCY)" > 0) AND (VendLedgEntry."Document Type" = VendLedgEntry."Document Type"::Payment) THEN//soica
                                                                                                                                          //BC Upgrade KAPOOV01>>
                                                                                                                                          //EXIT(-VendLedgEntry."Original Amt. (LCY)")//SOICAD01
                Result := -VendLedgEntry."Original Amt. (LCY)"
            //BC Upgrade KAPOOV01<<
            ELSE
                //BC Upgrade KAPOOV01>>
                //EXIT(VendLedgEntry."Remaining Amt. (LCY)");//soicad
                Result := VendLedgEntry."Remaining Amt. (LCY)";
            //BC Upgrade KAPOOV01<<
        END;
        //soicad begin delete
        // VendLedgEntry.CALCFIELDS("Remaining Amount");
        // EXIT(VendLedgEntry."Remaining Amount");
        //end delete
        //SOICAD>>
        VendLedgEntry.CALCFIELDS("Original Amount", "Remaining Amount");
        IF (VendLedgEntry."Original Amount" > 0) AND (VendLedgEntry."Document Type" = VendLedgEntry."Document Type"::Payment) THEN
            //BC Upgrade KAPOOV01>>
            //EXIT(-VendLedgEntry."Original Amount")
            Result := -VendLedgEntry."Original Amount"
        //BC Upgrade KAPOOV01<<
        ELSE
            //BC Upgrade KAPOOV01>>
            //EXIT(VendLedgEntry."Remaining Amount");
            Result := VendLedgEntry."Remaining Amount";
        //BC Upgrade KAPOOV01<<
        //soicad<<

    end;

    //BC Upgrade KAPOOV01 02.12.25  #Subsribed to this event for Function-GetVendLedgEntryRemAmt() of Table-1294-Applied Payment Entry<<
    //END here table-1294-Applied Payment Entry---<<



    // -----------------------BC Upgrade BHARDA11 - Sales Header Sales Line Subscriber-----------------------  >>
    // BC Upgrade BHARDA11 >>
    // 1. For Sell-to Customer No. - OnValidate() Customize code (//HEI.11>>), we suscribe this event  OnValidateSellToCustomerNoOnBeforeCheckBlockedCustOnDocs
    // 2. For Sell-to Customer No. - OnValidate() Customize code (// >>HEI.09 IBM>CHAUHB01 03/02/2018) , we suscribe this event OnCopySelltoCustomerAddressFieldsFromCustomerOnBeforeAssignRespCenter
    // 3. For Sell-to Customer No. - OnValidate() Customize code //WHT ,We Suscribe this event OnAfterCheckSellToCust
    // 4. For Bill-to Customer No. - OnValidate() Customize code (//HEI.11>>), We suscribe this event OnValidateBillToCustomerNoOnBeforeCheckBlockedCustOnDocs
    // 5. For Prices Including VAT - OnValidate() Customize code (//<<HEI.59), We suscribe this event OnAfterConfirmSalesPrice
    // 6. For OnDelete() Customize code ( //<<HEI.59) , We suscribe this event OnBeforeShowPostedDocsToPrintCreatedMsg
    // 7. For Posting Date -  OnValidate() Customize code (//<<HEI.38 ) , We suscribe this event for block the base code  OnValidatePostingDateOnBeforeCheckNeedUpdateCurrencyFactor
    // 8. For Payment Terms Code - OnValidate() Customize code (// >>HEI.48) , We suscribe this event OnBeforeValidatePaymentTermsCode
    // 9. For Function CreateSalesLine Customize code (//HEI.54>>,//HEI.60>>), Wesuscribe this event OnCreateSalesLineOnBeforeAssignType
    // 10. For Function OnBeforeUpdateOpportunity Customize code (//<<HEI.59), We Suscribe this event OnBeforeUpdateOpportunity and create this function GetOpportunityEntryEstimatedValue because we block base unction and add customize code after use base code so this function is in base code
    // BC Upgrade BHARDA11 <<

    // BC Upgrade BHARDA11 >> ---- "Sales Header" Table Events
    // BC Upgrade BHARDA11 >> ----For Sell-to Customer No. - OnValidate() Customize code (//HEI.11>>), we suscribe this event  OnValidateSellToCustomerNoOnBeforeCheckBlockedCustOnDocs
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnValidateSellToCustomerNoOnBeforeCheckBlockedCustOnDocs, '', false, false)]
    local procedure OnValidateSellToCustomerNoOnBeforeCheckBlockedCustOnDocs(var SalesHeader: Record "Sales Header"; var Cust: Record Customer; var IsHandled: Boolean)
    begin
        //HEI.11>>
        //Cust.CheckBlockedCustOnDocs(Cust,"Document Type",FALSE,FALSE);
        IsHandled := true;
        if SalesHeader."No." <> '' then //BC Upgrade ATHUKS01
            Cust.CheckBlockedCustOnDocs2(Cust, SalesHeader."Document Type", FALSE, FALSE, 0, FALSE, FALSE, FALSE);
        //HEI.11<<
    end;
    // BC Upgrade BHARDA11 << ----For Sell-to Customer No. - OnValidate() Customize code (//HEI.11>>), we suscribe this event  OnValidateSellToCustomerNoOnBeforeCheckBlockedCustOnDocs
    // BC Upgrade BHARDA11 >> ----For Sell-to Customer No. - OnValidate() Customize code (// >>HEI.09 IBM>CHAUHB01 03/02/2018) , we suscribe this event OnCopySelltoCustomerAddressFieldsFromCustomerOnBeforeAssignRespCenter
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnCopySelltoCustomerAddressFieldsFromCustomerOnBeforeAssignRespCenter, '', false, false)]
    local procedure OnCopySelltoCustomerAddressFieldsFromCustomerOnBeforeAssignRespCenter(var SalesHeader: Record "Sales Header"; var SellToCustomer: Record Customer; var IsHandled: Boolean)
    begin
        SalesHeader."WHT Business Posting Group FND" := SellToCustomer."WHT Business Posting Group FND";//WHT
                                                                                                        // <<HEI.09 IBM>CHAUHB01 03/02/2018
        SalesHeader."Sales Routes FND" := SellToCustomer."Sales Routes FND";
        // >>HEI.09 IBM>CHAUHB01 03/02/2018
    end;
    // BC Upgrade BHARDA11 << ----For Sell-to Customer No. - OnValidate() Customize code (// >>HEI.09 IBM>CHAUHB01 03/02/2018) , we suscribe this event OnCopySelltoCustomerAddressFieldsFromCustomerOnBeforeAssignRespCenter
    // BC Upgrade BHARDA11 >> ----For Sell-to Customer No. - OnValidate() Customize code //WHT ,We Suscribe this event OnAfterCheckSellToCust
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterCheckSellToCust, '', false, false)]

    local procedure OnAfterCheckSellToCust(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; Customer: Record Customer; CurrentFieldNo: Integer)
    begin
        //WHT
        if SalesHeader."Sell-to Customer No." = xSalesHeader."Sell-to Customer No." then
            IF SalesHeader.ShippedSalesLinesExist() OR SalesHeader.ReturnReceiptExist() THEN BEGIN
                SalesHeader.TESTFIELD("WHT Business Posting Group FND", xSalesHeader."WHT Business Posting Group FND");//WHT

            end;
        //WHT

    end;
    // BC Upgrade BHARDA11 << ----For Sell-to Customer No. - OnValidate() Customize code //WHT ,We Suscribe this event OnAfterCheckSellToCust
    // BC Upgrade BHARDA11 >> ----For Bill-to Customer No. - OnValidate() Customize code (//HEI.11>>), We suscribe this event OnValidateBillToCustomerNoOnBeforeCheckBlockedCustOnDocs
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnValidateBillToCustomerNoOnBeforeCheckBlockedCustOnDocs, '', false, false)]
    local procedure OnValidateBillToCustomerNoOnBeforeCheckBlockedCustOnDocs(var SalesHeader: Record "Sales Header"; var Cust: Record Customer; var IsHandled: Boolean)
    var
        GLSetup: Record "General Ledger Setup";
    begin
        IsHandled := true;
        //HEI.11>>
        //Cust.CheckBlockedCustOnDocs(Cust,"Document Type",FALSE,FALSE);
        IF SalesHeader."Bill-to Customer No." <> SalesHeader."Sell-to Customer No." THEN
            Cust.CheckBlockedCustOnDocs2(Cust, SalesHeader."Document Type", FALSE, FALSE, 1, FALSE, FALSE, FALSE);
        GLSetup.Get();
        IF GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." THEN
            SalesHeader."WHT Business Posting Group FND" := Cust."WHT Business Posting Group FND";//WHT
                                                                                                  //HEI.11<<
        SalesHeader."Prices Including VAT" := Cust."Prices Including VAT";
    end;
    // BC Upgrade BHARDA11 << ----For Bill-to Customer No. - OnValidate() Customize code (//HEI.11>>), We suscribe this event OnValidateBillToCustomerNoOnBeforeCheckBlockedCustOnDocs

    // Prices Including VAT - OnValidate()
    // BC Upgrade BHARDA11 >> ----For Prices Including VAT - OnValidate() Customize code (//<<HEI.59), We suscribe this event OnAfterConfirmSalesPrice
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterConfirmSalesPrice, '', false, false)]
    local procedure OnAfterConfirmSalesPrice(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var RecalculateLines: Boolean)
    begin
        //<<HEI.59
        IF GUIALLOWED THEN BEGIN
            // RecalculateLines := SalesHeader.ConfirmRecalculatePrice(SalesLine);
            //>>HEI.59
        end else
            RecalculateLines := TRUE;
        //>>HEI.59
    end;
    // BC Upgrade BHARDA11 << ----For Prices Including VAT - OnValidate() Customize code (//<<HEI.59), We suscribe this event OnAfterConfirmSalesPrice



    // OnDelete()
    // BC Upgrade BHARDA11 >> ----For OnDelete() Customize code ( //<<HEI.59) , We suscribe this event OnBeforeShowPostedDocsToPrintCreatedMsg
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeShowPostedDocsToPrintCreatedMsg, '', false, false)]

    local procedure OnBeforeShowPostedDocsToPrintCreatedMsg(var ShowPostedDocsToPrint: Boolean)
    begin
        //<<HEI.59
        if ShowPostedDocsToPrint AND GuiAllowed then
            ShowPostedDocsToPrint := true;
        //<<HEI.59
    end;
    // BC Upgrade BHARDA11 >> ----For OnDelete() Customize code ( //<<HEI.59) , We suscribe this event OnBeforeShowPostedDocsToPrintCreatedMsg
    // Posting Date On Validate
    // BC Upgrade BHARDA11 >> ----For Posting Date -  OnValidate() Customize code (//<<HEI.38 ) , We suscribe this event for block the base code  OnValidatePostingDateOnBeforeCheckNeedUpdateCurrencyFactor

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnValidatePostingDateOnBeforeCheckNeedUpdateCurrencyFactor, '', false, false)]
    local procedure OnValidatePostingDateOnBeforeCheckNeedUpdateCurrencyFactor(var SalesHeader: Record "Sales Header"; var IsConfirmed: Boolean; var NeedUpdateCurrencyFactor: Boolean; xSalesHeader: Record "Sales Header")
    begin
        // Posting Date On validate Base  code Comment
        //<<HEI.38 - Below Code is commented to calculate Currency Factor when changing the Document Date instead of changing the Posting Date
        // BC Upgrade BHARDA11 >>
        NeedUpdateCurrencyFactor := false;
        // BC Upgrade BHARDA11 <<
        //>>HEI.38
    end;
    // BC Upgrade BHARDA11 << ----For Posting Date -  OnValidate() Customize code (//<<HEI.38 ) , We suscribe this event for block the base code  OnValidatePostingDateOnBeforeCheckNeedUpdateCurrencyFactor
    // BC Upgrade BHARDA11 >> ----For Payment Terms Code - OnValidate() Customize code (// >>HEI.48) , We suscribe this event OnBeforeValidatePaymentTermsCode
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeValidatePaymentTermsCode, '', false, false)]

    local procedure OnBeforeValidatePaymentTermsCode(var SalesHeader: Record "Sales Header"; var xSalesHeader: Record "Sales Header"; CallingFieldNo: Integer; UpdateDocumentDate: Boolean; var IsHandled: Boolean)
    var
        PaymentTerms: Record "Payment Terms";
    begin
        IsHandled := true; // BC Upgrade BHARDA11
                           // >>HEI.48
                           // if (SalesHeader."Payment Terms Code" <> '') and (SalesHeader."Document Date" <> 0D) then begin
        if (SalesHeader."Payment Terms Code" <> '') and (SalesHeader."Document Date" <> 0D) and (SalesHeader."Posting Date" <> 0D) then begin
            PaymentTerms.Get(SalesHeader."Payment Terms Code");
            if SalesHeader.IsCreditDocType() and not PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then begin
                IsHandled := false;
                // OnValidatePaymentTermsCodeOnBeforeValidateDueDate(Rec, xRec, CurrFieldNo, IsHandled);
                if not IsHandled then
                    // >>HEI.48
                    // SalesHeader.Validate("Due Date", SalesHeader."Document Date");
                    SalesHeader.Validate("Due Date", SalesHeader."Posting Date");
                // <<HEI.48
                SalesHeader.Validate("Pmt. Discount Date", 0D);
                SalesHeader.Validate("Payment Discount %", 0);
            end else begin
                IsHandled := false;
                // OnValidatePaymentTermsCodeOnBeforeCalcDueDate(Rec, xRec, FieldNo("Payment Terms Code"), CurrFieldNo, IsHandled);
                if not IsHandled then
                    // >>HEI.48
                    // SalesHeader."Due Date" := CalcDate(PaymentTerms."Due Date Calculation", SalesHeader."Document Date");
                    SalesHeader."Due Date" := CalcDate(PaymentTerms."Due Date Calculation", SalesHeader."Posting Date");
                // <<HEI.48
                IsHandled := false;
                // OnValidatePaymentTermsCodeOnBeforeCalcPmtDiscDate(Rec, xRec, FieldNo("Payment Terms Code"), CurrFieldNo, IsHandled);
                if not IsHandled then
                    SalesHeader."Pmt. Discount Date" := CalcDate(PaymentTerms."Discount Date Calculation", SalesHeader."Document Date");
                if not UpdateDocumentDate then
                    SalesHeader.Validate("Payment Discount %", PaymentTerms."Discount %")
            end;
        end else begin
            IsHandled := false;
            // OnValidatePaymentTermsCodeOnBeforeValidateDueDateWhenBlank(Rec, xRec, CurrFieldNo, IsHandled);
            if not IsHandled then
                // >>HEI.48
                // SalesHeader.Validate("Due Date", SalesHeader."Document Date");
                SalesHeader.Validate("Due Date", SalesHeader."Posting Date");
            // <<HEI.48
            if not UpdateDocumentDate then begin
                SalesHeader.Validate("Pmt. Discount Date", 0D);
                SalesHeader.Validate("Payment Discount %", 0);
            end;
            // OnValidatePaymentTermsCodeOnAfterValidatePaymentDiscountWhenBlank(Rec, xRec, CurrFieldNo);
        end;
        if xSalesHeader."Payment Terms Code" = SalesHeader."Prepmt. Payment Terms Code" then begin
            if xSalesHeader."Prepayment Due Date" = 0D then begin
                IsHandled := false;
                // OnValidatePaymentTermsCodeOnBeforeCalculatePrepaymentDueDate(Rec, xRec, CurrFieldNo, IsHandled);
                if not IsHandled then begin
                    SalesHeader.TestField("Document Date");
                    SalesHeader."Prepayment Due Date" := CalcDate(PaymentTerms."Due Date Calculation", SalesHeader."Document Date");
                end;
            end;
            SalesHeader.Validate("Prepmt. Payment Terms Code", SalesHeader."Payment Terms Code");
        end;
    end;
    // BC Upgrade BHARDA11 << ----For Payment Terms Code - OnValidate() Customize code (// >>HEI.48) , We suscribe this event OnBeforeValidatePaymentTermsCode

    // Function Createsalesline
    // BC Upgrade BHARDA11 >> ----For Function CreateSalesLine Customize code (//HEI.54>>,//HEI.60>>), Wesuscribe this event OnCreateSalesLineOnBeforeAssignType
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnCreateSalesLineOnBeforeAssignType, '', false, false)]

    local procedure OnCreateSalesLineOnBeforeAssignType(var SalesLine: Record "Sales Line"; TempSalesLine: Record "Sales Line" temporary; var SalesHeader: Record "Sales Header")
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        //HEI.54>>
        IF (TempSalesLine."Attached to Line No." <> 0) AND (TempSalesLine.Type = TempSalesLine.Type::Resource) THEN BEGIN
            SalesLine := TempSalesLine;
            SalesLine.INSERT();
            EXIT;
        END;
        //HEI.54<<
        //HEI.60<<
        IF (TempSalesLine.Type = TempSalesLine.Type::Resource) AND (TempSalesLine."No." = SalesSetup."Timbre Resource Code FND") THEN BEGIN
            SalesLine := TempSalesLine;
            SalesLine.INSERT();
            EXIT;
        END;
        //HEI.60>>
    end;
    // BC Upgrade BHARDA11 << ----For Function CreateSalesLine Customize code (//HEI.54>>,//HEI.60>>), Wesuscribe this event OnCreateSalesLineOnBeforeAssignType

    // Function  UpdateOpportunity
    // BC Upgrade BHARDA11 >> ----For Function OnBeforeUpdateOpportunity Customize code (//<<HEI.59), We Suscribe this event OnBeforeUpdateOpportunity and create this function GetOpportunityEntryEstimatedValue because we block base unction and add customize code after use base code so this function is in base code
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeUpdateOpportunity, '', false, false)]

    local procedure OnBeforeUpdateOpportunity(var IsHandled: Boolean; var SalesHeader: Record "Sales Header")

    var
        Opp: Record Opportunity;
        OpportunityEntry: Record "Opportunity Entry";
        ConfirmManagement: Codeunit "Confirm Management";
        // IsHandled: Boolean;
        Text040: Label 'A won opportunity is linked to this order.\It has to be changed to status Lost before the Order can be deleted.\Do you want to change the status for this opportunity now?';
        Text044: Label 'The status of the opportunity has not been changed. The program has aborted deleting the order.';
    begin
        IsHandled := true; // BC Upgrade BHARDA11
        if not (SalesHeader."Opportunity No." <> '') or not (SalesHeader."Document Type" in [SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Order]) then
            exit;

        if not Opp.Get(SalesHeader."Opportunity No.") then
            exit;

        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            //<<HEI.59
            IF GUIALLOWED THEN BEGIN
                //>>HEI.59
                if not ConfirmManagement.GetResponseOrDefault(Text040, true) then
                    Error(Text044);

                OpportunityEntry.SetRange("Opportunity No.", SalesHeader."Opportunity No.");
                OpportunityEntry.ModifyAll(Active, false);

                OpportunityEntry.Init();
                OpportunityEntry.Validate("Opportunity No.", Opp."No.");

                OpportunityEntry.LockTable();
                OpportunityEntry."Entry No." := OpportunityEntry.GetLastEntryNo() + 1;
                OpportunityEntry."Sales Cycle Code" := Opp."Sales Cycle Code";
                OpportunityEntry."Contact No." := Opp."Contact No.";
                OpportunityEntry."Contact Company No." := Opp."Contact Company No.";
                OpportunityEntry."Salesperson Code" := Opp."Salesperson Code";
                OpportunityEntry."Campaign No." := Opp."Campaign No.";
                OpportunityEntry."Action Taken" := OpportunityEntry."Action Taken"::Lost;
                OpportunityEntry.Active := true;
                OpportunityEntry."Completed %" := 100;
                OpportunityEntry."Estimated Value (LCY)" := GetOpportunityEntryEstimatedValue(SalesHeader);
                OpportunityEntry."Estimated Close Date" := Opp."Date Closed";
                OpportunityEntry.Insert(true);
            end;
        end;
        Opp.Find();
        Opp."Sales Document Type" := Opp."Sales Document Type"::" ";
        Opp."Sales Document No." := '';
        // OnUpdateOpportunityOnBeforeModify(Opp, Rec);
        Opp.Modify();
        SalesHeader."Opportunity No." := '';
    end;

    local procedure GetOpportunityEntryEstimatedValue(SalesHeader: Record "Sales Header"): Decimal
    var
        OpportunityEntry: Record "Opportunity Entry";
    begin
        OpportunityEntry.SetRange("Opportunity No.", SalesHeader."Opportunity No.");
        if OpportunityEntry.FindLast() then
            exit(OpportunityEntry."Estimated Value (LCY)");
    end;
    // BC Upgrade BHARDA11 << ----For Function OnBeforeUpdateOpportunity Customize code (//<<HEI.59), We Suscribe this event OnBeforeUpdateOpportunity and create this function GetOpportunityEntryEstimatedValue because we block base unction and add customize code after use base code so this function is in base code
    // BC Upgrade BHARDA11 << ---- "Sales Header" Table Events

    // BC Upgrade BHARDA11 >>
    // 1. Block Code  //HEI.35>> //HEI.32>> Because VAT Line Amount table habe some comment As per discussion with Saikat and Sakshi, For now putting this object on hold because CAD functionality is running only in CONGO opco.
    // 2. All events are from sales line table and all are local procedures .
    // 3. For No. - OnValidate() (//WHT) , We suscribe this event OnAfterAssignGLAccountValues
    // 4. For No. - OnValidate() Type - Item Customize Code ( //HEI.07>>,//WHT) , we suscribe this event OnBeforeCopyFromItem.
    // 5. For No. - OnValidate() Type - Resource Customize Code  (//WHT) , we suscribe this event OnCopyFromResourceOnBeforeApplyResUnitCost.
    // 6. For No. - OnValidate() Type - "Charge (Item)"  Customize Code (//WHT), We suscribe this event OnAfterAssignItemChargeValues
    // 7. For No. - OnValidate() Customize Code (//WHT), We suscribe this event OnAfterAssignFieldsForNo
    // 8. For Quantity - OnValidate() Customize Code (//HEI.14>>), We suscribe this event OnValidateQuantityOnBeforeCheckAssocPurchOrder.
    // 9. For "Appl.-to Item Entry" - OnValidate() Customize Code (//>>HEI.34), we suscribe this event OnApplToItemEntryValidateOnBeforeMessage.
    // 10. For "VAT Prod. Posting Group" - OnValidate() Customize Code (//HEI.14) , We Suscribe this event OnValidateVATProdPostingGroupOnBeforeVATPostingSetupGet
    // 11. For "Depreciation Book Code" - OnValidate() Customize Code (//HEI.11>>) , We Suscribe this event OnAfterGetFAPostingGroup
    // 12. For Function UpdateItemChargeAssgnt() Customize Code (//HEI.30>>) , We Suscribe this event OnBeforeUpdateItemChargeAssgnt
    // 13. For Function UpdateVATOnLines Customize Code (//HEI.32>>) , We Suscribe this event OnUpdateVATOnLinesOnBeforeModifySalesLine
    // 14. For Function LOCAL CheckWarehouse() Customize Code (//>>HEI.34), , We Suscribe this event OnCheckWarehouseOnBeforeShowDialog
    // BC Upgrade BHARDA11 <<
    // BC Upgrade BHARDA11 >> ----- "Sales Line" Table Events
    // BC Upgrade BHARDA11 >>----For No. - OnValidate() (//WHT) , We suscribe this event OnAfterAssignGLAccountValues
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterAssignGLAccountValues, '', false, false)]

    local procedure OnAfterAssignGLAccountValues(var SalesLine: Record "Sales Line"; GLAccount: Record "G/L Account"; SalesHeader: Record "Sales Header"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        SalesLine."WHT Product Posting Group FND" := GLAccount."WHT Product Posting Group FND";//WHT
    end;
    // BC Upgrade BHARDA11 <<----For No. - OnValidate() (//WHT) , We suscribe this event OnAfterAssignGLAccountValues

    // BC Upgrade BHARDA11 >>----For No. - OnValidate() Type - Item Customize Code ( //HEI.07>>,//WHT) , we suscribe this event OnBeforeCopyFromItem.
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnBeforeCopyFromItem, '', false, false)]
    local procedure OnBeforeCopyFromItem(var SalesLine: Record "Sales Line"; Item: Record Item; var IsHandled: Boolean)
    var
        SKU: Record "Stockkeeping Unit";
        SalesHeader: Record "Sales Header";
    begin
        if SalesLine.GetSKU(SKU) then begin

            //HEI.07>>
            SalesLine."RPM Solution FND" := SKU."RPM Solution FND".AsInteger();
            SalesLine."RPM Type FND" := SKU."RPM Type FND";
            SalesLine."Item Type FND" := SKU."Item Type FND".AsInteger();
            //HEI.07<<
        end else begin
            //HEI.07>>
            SalesLine."RPM Solution FND" := Item."RPM Solution FND".AsInteger();
            SalesLine."RPM Type FND" := Item."RPM Type FND";
            SalesLine."Item Type FND" := Item."Item Type FND".AsInteger();
            //HEI.07<<
        end;
        //HEI.02>>
        // BC Upgrade BHARDA11 >> ----Drink-IT Field ---- SalesHeader."Document Subtype Code"
        // if SalesHeader.get(SalesLine."Document Type", SalesLine."Document No.") then
        //     SalesLine."Document Subtype Code" := SalesHeader."Document Subtype Code";
        // BC Upgrade BHARDA11 << ----Drink-IT Field ---- SalesHeader."Document Subtype Code"

        //HEI.02<<
        SalesLine."WHT Product Posting Group FND" := Item."WHT Product Posting Group FND";//WHT
    end;
    // BC Upgrade BHARDA11 <<----For No. - OnValidate() Type - Item Customize Code ( //HEI.07>>,//WHT) , we suscribe this event OnBeforeCopyFromItem.

    // BC Upgrade BHARDA11 >>--- For No. - OnValidate() Type - Resource Customize Code  (//WHT) , we suscribe this event OnCopyFromResourceOnBeforeApplyResUnitCost.
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnCopyFromResourceOnBeforeApplyResUnitCost, '', false, false)]

    local procedure OnCopyFromResourceOnBeforeApplyResUnitCost(var SalesLine: Record "Sales Line"; Resource: Record Resource; SalesHeader: Record "Sales Header")
    begin
        SalesLine."WHT Product Posting Group FND" := Resource."WHT Product Posting Group FND";//WHT
    end;
    // BC Upgrade BHARDA11 <<--- For No. - OnValidate() Type - Resource Customize Code  (//WHT) , we suscribe this event OnCopyFromResourceOnBeforeApplyResUnitCost.

    // BC Upgrade BHARDA11 >>--- For No. - OnValidate() Type - "Charge (Item)"  Customize Code (//WHT), We suscribe this event OnAfterAssignItemChargeValues

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterAssignItemChargeValues, '', false, false)]
    local procedure OnAfterAssignItemChargeValues(var SalesLine: Record "Sales Line"; ItemCharge: Record "Item Charge"; SalesHeader: Record "Sales Header")
    begin
        SalesLine."WHT Product Posting Group FND" := ItemCharge."WHT Product Posting Group FND";//WHT
    end;
    // BC Upgrade BHARDA11 <<--- For No. - OnValidate() Type - "Charge (Item)"  Customize Code (//WHT), We suscribe this event OnAfterAssignItemChargeValues

    // BC Upgrade BHARDA11 >>--- For No. - OnValidate() Customize Code (//WHT), We suscribe this event OnAfterAssignFieldsForNo

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterAssignFieldsForNo, '', false, false)]

    local procedure OnAfterAssignFieldsForNo(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    begin
        IF NOT (SalesLine.Type IN [SalesLine.Type::" ", SalesLine.Type::"Fixed Asset"]) THEN BEGIN
            SalesLine.VALIDATE("WHT Product Posting Group FND");//WHT
        END;
    end;
    // BC Upgrade BHARDA11 <<--- For No. - OnValidate() Customize Code (//WHT), We suscribe this event OnAfterAssignFieldsForNo

    // BC Upgrade BHARDA11 >>--- For Quantity - OnValidate() Customize Code (//HEI.14>>), We suscribe this event OnValidateQuantityOnBeforeCheckAssocPurchOrder.

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnValidateQuantityOnBeforeCheckAssocPurchOrder, '', false, false)]

    local procedure OnValidateQuantityOnBeforeCheckAssocPurchOrder(var SalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    begin
        //HEI.14>>
        IF SalesLine."TIN No. FND" = '' THEN
            SalesLine.UpdateTINBAndVATProdPostGrByLocation();
        //HEI.14<<
    end;
    // BC Upgrade BHARDA11 <<--- For Quantity - OnValidate() Customize Code (//HEI.14>>), We suscribe this event OnValidateQuantityOnBeforeCheckAssocPurchOrder.

    // BC Upgrade BHARDA11 >>--- For "Appl.-to Item Entry" - OnValidate() Customize Code (//>>HEI.34), we suscribe this event OnApplToItemEntryValidateOnBeforeMessage.

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnApplToItemEntryValidateOnBeforeMessage, '', false, false)]
    local procedure OnApplToItemEntryValidateOnBeforeMessage(var SalesLine: Record "Sales Line"; CurrFieldNo: Integer; var IsHandled: Boolean)
    var
        Text042: Label 'When posting the Applied to Ledger Entry %1 will be opened first';
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        IsHandled := true;
        ItemLedgEntry.Get(SalesLine."Appl.-to Item Entry");
        //>>HEI.34
        //IF NOT ItemLedgEntry.Open THEN
        IF ((NOT ItemLedgEntry.Open) AND (GUIALLOWED)) THEN
            //<<HEI.34
            MESSAGE(Text042, SalesLine."Appl.-to Item Entry");
    end;
    // BC Upgrade BHARDA11 <<--- For "Appl.-to Item Entry" - OnValidate() Customize Code (//>>HEI.34), we suscribe this event OnApplToItemEntryValidateOnBeforeMessage.

    // BC Upgrade BHARDA11 >>--- For "VAT Prod. Posting Group" - OnValidate() Customize Code (//HEI.14) , We Suscribe this event OnValidateVATProdPostingGroupOnBeforeVATPostingSetupGet

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnValidateVATProdPostingGroupOnBeforeVATPostingSetupGet, '', false, false)]

    local procedure OnValidateVATProdPostingGroupOnBeforeVATPostingSetupGet(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var IsHandled: Boolean; var VATPostingSetup: Record "VAT Posting Setup")
    begin
        SalesLine.UpdateTINBAndVATProdPostGrByLocation(); //HEI.14
    end;
    // BC Upgrade BHARDA11 <<--- For "VAT Prod. Posting Group" - OnValidate() Customize Code (//HEI.14) , We Suscribe this event OnValidateVATProdPostingGroupOnBeforeVATPostingSetupGet
    // BC Upgrade BHARDA11 >>--- For "Depreciation Book Code" - OnValidate() Customize Code (//HEI.11>>) , We Suscribe this event OnAfterGetFAPostingGroup

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterGetFAPostingGroup, '', false, false)]
    local procedure OnAfterGetFAPostingGroup(var SalesLine: Record "Sales Line"; GLAccount: Record "G/L Account")
    var
        DepreciationBook: Record "Depreciation Book";
    begin
        //HEI.11>>
        DepreciationBook.RESET();
        DepreciationBook.SETFILTER(Code, '<>%1', SalesLine."Depreciation Book Code");
        DepreciationBook.SETRANGE("Part of Duplication List", TRUE);
        IF DepreciationBook.FINDFIRST() THEN
            SalesLine.VALIDATE("Use Duplication List", DepreciationBook."Part of Duplication List")
        ELSE
            SalesLine.VALIDATE("Use Duplication List", FALSE);
        IF DepreciationBook.GET(SalesLine."Depreciation Book Code") THEN;
        //HEI.11<<
    end;
    // BC Upgrade BHARDA11 <<--- For "Depreciation Book Code" - OnValidate() Customize Code (//HEI.11>>) , We Suscribe this event OnAfterGetFAPostingGroup

    // BC Upgrade BHARDA11 >>--- For Function UpdateItemChargeAssgnt() Customize Code (//HEI.30>>) , We Suscribe this event OnBeforeUpdateItemChargeAssgnt

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnBeforeUpdateItemChargeAssgnt, '', false, false)]

    local procedure OnBeforeUpdateItemChargeAssgnt(var SalesLine: Record "Sales Line"; var InHandled: Boolean);
    var
        SalesHeader2: Record "Sales Header";
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        // var
        ItemChargeAssgntSales: Record "Item Charge Assignment (Sales)";
        ShareOfVAT: Decimal;
        TotalQtyToAssign: Decimal;
        TotalAmtToAssign: Decimal;
        TotalQtyToHandle: Decimal;
        TotalAmtToHandle: Decimal;
        IsHandled: Boolean;
    begin
        // InHandled := true;
        //HEI.30>>
        IF SalesHeader2.GET(SalesLine."Document Type", SalesLine."Document No.") THEN
            IF SourceSystemIdentifierAPI.GET(SalesHeader2."Source System Identifier FND") THEN
                IF SourceSystemIdentifierAPI."Apply Sales Condit Interface" THEN
                    EXIT;
        //HEI.30<<
    end;
    // BC Upgrade BHARDA11 <<--- For Function UpdateItemChargeAssgnt() Customize Code (//HEI.30>>) , We Suscribe this event OnBeforeUpdateItemChargeAssgnt

    // BC Upgrade BHARDA11 >>--- For Function UpdateVATOnLines Customize Code (//HEI.32>>) , We Suscribe this event OnUpdateVATOnLinesOnBeforeModifySalesLine
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnUpdateVATOnLinesOnBeforeModifySalesLine, '', false, false)]
    local procedure OnUpdateVATOnLinesOnBeforeModifySalesLine(var SalesLine: Record "Sales Line"; VATAmount: Decimal)
    var
        VATPostingSetup: Record "VAT Posting Setup";
        SalesHeader: Record "Sales Header";
        Currency: Record Currency;
        CADAmount: Decimal;
    begin
        //HEI.32>>
        // HEI.32 - Add CAD Amount to Sales Line
        if VATPostingSetup.Get(SalesLine."VAT Bus. Posting Group", SalesLine."VAT Prod. Posting Group") then begin
            if VATPostingSetup."CAD % FND" <> 0 then begin
                SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
                Currency.Initialize(SalesHeader."Currency Code");

                // Use the VATAmount parameter directly - yeh already calculated hai
                CADAmount := Round((VATPostingSetup."CAD % FND" / 100) * VATAmount, Currency."Amount Rounding Precision");

                // Update Sales Line fields
                SalesLine."CAD Amount FND" := CADAmount;
                SalesLine."Amount Including VAT" := SalesLine."Amount Including VAT" + CADAmount;
            end;
        end;
        //HEI.32<<
    end;
    // BC Upgrade BHARDA11 <<--- For Function UpdateVATOnLines Customize Code (//HEI.32>>) , We Suscribe this event OnUpdateVATOnLinesOnBeforeModifySalesLine
    // BC Upgrade BHARDA11 >>--- For Function LOCAL CheckWarehouse() Customize Code (//>>HEI.34), , We Suscribe this event OnCheckWarehouseOnBeforeShowDialog
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnCheckWarehouseOnBeforeShowDialog, '', false, false)]

    local procedure OnCheckWarehouseOnBeforeShowDialog(var SalesLine: Record "Sales Line"; Location: Record Location; var ShowDialog: Option " ",Message,Error; var DialogText: Text[50])
    var
        WhseRequirementMsg: Label '%1 is required for this line. The entered information may be disregarded by warehouse activities.', Comment = '%1=Document';
        Text016: Label '%1 is required for %2 = %3.';
    begin
        //>>HEI.34
        case ShowDialog of
            ShowDialog::Message:
                IF GUIALLOWED THEN
                    Message(WhseRequirementMsg, DialogText);
            ShowDialog::Error:
                Error(Text016, DialogText, SalesLine.FieldCaption("Line No."), SalesLine."Line No.");
        end;
        ShowDialog := ShowDialog::" "; // This code exit the real code
        //<<HEI.34
    end;
    // BC Upgrade BHARDA11 <<--- For Function LOCAL CheckWarehouse() Customize Code (//>>HEI.34), , We Suscribe this event OnCheckWarehouseOnBeforeShowDialog

    // BC Upgrade BHARDA11 << ----- "Sales Line" Table Events



    // BC Upgrade BHARDA11 >> ----This code //<<HEI.59 is used in CheckCustomerCreated this function in sales header table , For this we use this event OnCheckCustomerCreatedOnBeforeConfirmProcess
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnCheckCustomerCreatedOnBeforeConfirmProcess, '', false, false)]

    local procedure OnCheckCustomerCreatedOnBeforeConfirmProcess(SalesHeader: Record "Sales Header"; var Prompt: Boolean; var Result: Boolean; var IsHandled: Boolean)
    var
        Cont, Contact : Record Contact;
    begin
        //<<HEI.59
        //IF Prompt THEN
        if Prompt And GuiAllowed then
            Prompt := true else
            Prompt := false;
        //>>HEI.59
    end;
    // BC Upgrade BHARDA11 << ----This code //<<HEI.59 is used in CheckCustomerCreated this function in sales header table , For this we use this event OnCheckCustomerCreatedOnBeforeConfirmProcess

    // BC Upgrade BHARDA11 >> ----This code  //HEI.54>> is in RecreateSalesLines this function in sales header table . we use this event OnBeforeRecreateSalesLinesHandleSupplementTypes
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeRecreateSalesLinesHandleSupplementTypes, '', false, false)]

    local procedure OnBeforeRecreateSalesLinesHandleSupplementTypes(var TempSalesLine: Record "Sales Line" temporary; var IsHandled: Boolean)
    begin
        //HEI.54>>
        if (TempSalesLine."Attached to Line No." = 0) or ((TempSalesLine."Attached to Line No." <> 0) AND (TempSalesLine.Type = TempSalesLine.Type::Resource)) then
            IsHandled := false else
            IsHandled := true;
        //HEI.54<<
    end;
    // BC Upgrade BHARDA11 << ----This code  //HEI.54>> is in RecreateSalesLines this function in sales header table . we use this event OnBeforeRecreateSalesLinesHandleSupplementTypes

    // BC Upgrade BHARDA11 >> --- There is a code //<<HEI.59 on fuction in navision ConfirmResvDateConflict but the function name change in BC (ConfirmReservationDateConflict) this function is use only in sales header table and we have a custom code //<<HEI.59 in this function
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnUpdateSalesLinesByFieldNoOnAfterCalcShouldConfirmReservationDateConflict, '', false, false)]
    local procedure OnUpdateSalesLinesByFieldNoOnAfterCalcShouldConfirmReservationDateConflict(var SalesHeader: Record "Sales Header"; ChangedFieldNo: Integer; var ShouldConfirmReservationDateConflict: Boolean)
    var
        ReservationEngineMgt: Codeunit "Reservation Engine Mgt.";
    begin
        // BC Upgrade SHUKLP03 >> DIT field "Document Subtype Code" is added.
        //HEI.01>>
        ShouldConfirmReservationDateConflict := ChangedFieldNo in [
          SalesHeader.FieldNo("Document Subtype Code FND")
        ];
        //HEI.01<<
        // BC Upgrade SHUKLP03 << DIT field "Document Subtype Code" is added.

        //<<HEI.59
        //IF ResvEngMgt.ResvExistsForSalesHeader(Rec) THEN
        if ReservationEngineMgt.ResvExistsForSalesHeader(SalesHeader) And GuiAllowed then
            //>>HEI.59
            ShouldConfirmReservationDateConflict := true else
            ShouldConfirmReservationDateConflict := false;
    end;
    // BC Upgrade BHARDA11 << --- There is a code //<<HEI.59 on fuction in navision ConfirmResvDateConflict but the function name change in BC (ConfirmReservationDateConflict) this function is use only in sales header table and we have a custom code //<<HEI.59 in this function

    // BC Upgrade BHARDA11 >> --- This Code  //<<HEI.59 is use in the function ConfirmDeletion in sales header table for that we use this event OnBeforeCheckNoAndShowConfirm
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeCheckNoAndShowConfirm, '', false, false)]

    local procedure OnBeforeCheckNoAndShowConfirm(SalesHeader: Record "Sales Header"; var SalesShptHeader: Record "Sales Shipment Header"; var SalesInvHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnRcptHeader: Record "Return Receipt Header"; var SalesInvHeaderPrePmt: Record "Sales Invoice Header"; var SalesCrMemoHeaderPrePmt: Record "Sales Cr.Memo Header"; SourceCode: Record "Source Code"; var Result: Boolean; var IsHandled: Boolean)
    begin
        //<<HEI.59
        if not GuiAllowed then begin
            IsHandled := true;
            Result := true;
            //>>HEI.59
        end;
    end;
    // BC Upgrade BHARDA11 >> --- This Code  //<<HEI.59 is use in the function ConfirmDeletion in sales header table for that we use this event OnBeforeCheckNoAndShowConfirm
    // -----------------------BC Upgrade BHARDA11 - Sales Header Sales Line Subscriber-----------------------  <<


    // -----------------------BC Upgrade KUMARS145 - Workflow Step Buffer Subscriber-----------------------  >>
    // tableextension 50213 WorkflowStepBufferExt extends "Workflow Step Buffer"
    // table 1507 "Workflow Step Buffer"
    //   BC Upgrade KUMARS145 alternative for HEI.01 CHG2231326 HB3599 YADAVM09 IBM 07.02.2024>>
    //   HEI.01 CHG2231326 HB3599 YADAVM09 IBM 07.02.2024 # Restrict users to connect or disconnect RTR journal templates from the Workflow approval on Opco level.
    // # New function Added #OnBeforeOpenEventConditions

    // POENAB02, 26.02.2026 <<
    /* 
    [EventSubscriber(ObjectType::Table, Database::"Workflow Step Buffer", OnBeforeModifyEvent, '', false, false)]
    local procedure OnBeforeModifyEvent()
    var
        UserSetupRec: Record "User Setup";
    begin
        if UserSetupRec.Get(UserId) then begin
            if UserSetupRec."Restrict RtR Workflow Users" then
                Error('User is not authorized to modify Workflow Step Buffer. Please contact your administrator.');
        end else
            Error('User is not authorized to modify Workflow Step Buffer. Please contact your administrator.');
    end;
    */
    // POENAB02, 26.02.2026 <<

    //   BC Upgrade KUMARS145 alternative for HEI.01 CHG2231326 HB3599 YADAVM09 IBM 07.02.2024<<
    // -----------------------BC Upgrade KUMARS145 - Workflow Step Buffer Subscriber-----------------------  <<

    // -----------------------BC Upgrade KUMARS145 - CV Ledger Entry Buffer Subscriber-----------------------  >>
    // Event Subscriber for CV Ledger Entry Buffer table
    // Triggered after copying data from Vendor Ledger Entry to CV Ledger Entry Buffer
    //   BC Upgrade KUMARS145 alternative for HEI.02 for table 382 "CV Ledger Entry Buffer" OnAfterCopyFromVendLedgerEntry>>
    [EventSubscriber(ObjectType::Table, Database::"CV Ledger Entry Buffer", OnAfterCopyFromVendLedgerEntry, '', false, false)]
    local procedure OnAfterCopyFromVendLedgerEntry(var CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        CVLedgerEntryBuffer."Fixed Asset Acquisition FND" := VendorLedgerEntry."Fixed Asset Acquisition FND"; //HEI.02 - Customization reference
    end;
    //   BC Upgrade KUMARS145 alternative for HEI.02 for table 382 "CV Ledger Entry Buffer"<<

    // Event Subscriber for CV Ledger Entry Buffer table
    // Triggered after RecalculateAmounts CV Ledger Entry Buffer
    //   BC Upgrade KUMARS145 alternative for HEI.03 for table 382 "CV Ledger Entry Buffer" OnAfterRecalculateAmounts>>
    [EventSubscriber(ObjectType::Table, Database::"CV Ledger Entry Buffer", OnAfterRecalculateAmounts, '', false, false)]

    local procedure OnAfterRecalculateAmounts(var CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; FromCurrencyCode: Code[10]; ToCurrencyCode: Code[10]; PostingDate: Date)
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        //HEI.03>>
        // missing standard used in CalcApplication() with payment currency <> invoice
        CVLedgerEntryBuffer."Original Amount" := CurrExchRate.ExchangeAmount(CVLedgerEntryBuffer."Original Amount", FromCurrencyCode, ToCurrencyCode, PostingDate);
        //HEI.03<<
    end;
    //   BC Upgrade KUMARS145 alternative for HEI.03 for table 382 "CV Ledger Entry Buffer" OnAfterRecalculateAmounts<<
    // -----------------------BC Upgrade KUMARS145 - CV Ledger Entry Buffer Subscriber----------------------- <<

    // BC Upgrade SHUKLP03 >> Table 21 Cust. Ledger Entry

    // HEI.06 => to add ShowDoc function code for RPM Damage or Loss, subscribed event OnAfterShowDoc.
    // HEI.15,HEI.13,HEI.08 => to add CopyFromGenJnlLine function code, subscribed event OnAfterCopyCustLedgerEntryFromGenJnlLine

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", OnAfterShowDoc, '', false, false)]
    local procedure OnAfterShowDoc(var CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        SalesInvoiceHdr: Record "Sales Invoice Header";
    begin
        case CustLedgerEntry."Document Type" of
            //>>HEI.06
            CustLedgerEntry."Document Type"::"RPM Damage or Loss":
                IF SalesInvoiceHdr.GET(CustLedgerEntry."External Document No.") THEN BEGIN
                    PAGE.RUN(PAGE::"Posted Sales Invoice", SalesInvoiceHdr);
                END;
        //<<HEI.06
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", OnAfterCopyCustLedgerEntryFromGenJnlLine, '', false, false)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(GenJournalLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        //HEI.08>>
        CustLedgerEntry."Empties Item No. FND" := GenJournalLine."Empties Item No. FND";
        CustLedgerEntry."Deposit Quantity FND" := GenJournalLine."Deposit Quantity FND";
        //HEI.08<<
        CustLedgerEntry."Source System Identifier FND" := GenJournalLine."Source System Identifier FND";  // HEI.13
        CustLedgerEntry."Related Sales Order No. FND" := GenJournalLine."Related Sales Order FND"; //HEI.15
        CustLedgerEntry."Document Subtype Code FND" := GenJournalLine."Document Subtype Code FND";  // BC Upgrade SHUKLP03 << Added code for document subtype code.

    end;
    // BC Upgrade SHUKLP03 << Table 21 Cust. Ledger Entry 


    // BC Upgrade SHUKLP03 >> Table 36 Sales Header => Added DIT field "Document Subtype Code" code.
    // Subscribed event OnBeforeInitRecord to add HEI.22 code of procedure InitRecord().
    // Subscribed event OnAfterInitRecord to add code of procedure InitRecord().
    // BC Upgrade SHUKLP03 << Document Subtype code added.
    // Added event OnAfterInitPostingNoSeries.

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeInitRecord, '', false, false)]
    local procedure OnBeforeInitRecord(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        GenJournalTemplate: Record "Gen. Journal Template";
        NoSeries: Codeunit "No. Series";
        PostingNoSeries: Code[20];
        DocumentSubtypeCodeSetup: Record "Doc Subtype Code Setup FND";
        DocumentSubtypeCode: Record "Document Subtype Code FND";
        PostedInvoiceNo: Code[20];
    begin
        SalesSetup.Get();
        GLSetup.GetRecordOnce();
        if GLSetup."Journal Templ. Name Mandatory" then begin
            if SalesHeader."Journal Templ. Name" = '' then begin
                if not SalesHeader.IsCreditDocType() then
                    GenJournalTemplate.Get(SalesSetup."S. Invoice Template Name")
                else
                    GenJournalTemplate.Get(SalesSetup."S. Cr. Memo Template Name");
                SalesHeader."Journal Templ. Name" := GenJournalTemplate.Name;
            end else
                GenJournalTemplate.Get(SalesHeader."Journal Templ. Name");
            PostingNoSeries := GenJournalTemplate."Posting No. Series";
        end else
            if SalesHeader.IsCreditDocType() then
                PostingNoSeries := SalesSetup."Posted Credit Memo Nos."
            else
                PostingNoSeries := SalesSetup."Posted Invoice Nos.";

        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Order:
                begin
                    //HEI.22>>
                    DocumentSubtypeCodeSetup.GET();
                    IF DocumentSubtypeCode.GET(DocumentSubtypeCodeSetup."CTS Order") AND
                       (SalesHeader."Document Subtype Code FND" = DocumentSubtypeCodeSetup."CTS Order") AND
                       (SalesHeader."Document Type" = SalesHeader."Document Type"::Order)
                    THEN
                        PostedInvoiceNo := DocumentSubtypeCode."Posted Invoice Nos."
                    ELSE
                        PostedInvoiceNo := SalesSetup."Posted Invoice Nos.";

                    //NoSeriesMgt.SetDefaultSeries("Posting No. Series",SalesSetup."Posted Invoice Nos.");
                    if NoSeries.IsAutomatic(PostedInvoiceNo) then
                        SalesHeader."Posting No. Series" := PostedInvoiceNo;
                    //HEI.22<<
                    if NoSeries.IsAutomatic(SalesSetup."Posted Shipment Nos.") then
                        SalesHeader."Shipping No. Series" := SalesSetup."Posted Shipment Nos.";
                    if NoSeries.IsAutomatic(SalesSetup."Posted Prepmt. Inv. Nos.") then
                        SalesHeader."Prepayment No. Series" := SalesSetup."Posted Prepmt. Inv. Nos.";
                    if NoSeries.IsAutomatic(SalesSetup."Posted Prepmt. Cr. Memo Nos.") then
                        SalesHeader."Prepmt. Cr. Memo No. Series" := SalesSetup."Posted Prepmt. Cr. Memo Nos.";
                end;
            SalesHeader."Document Type"::Invoice:
                begin
                    if (SalesHeader."No. Series" <> '') and (SalesSetup."Invoice Nos." = PostingNoSeries) then
                        SalesHeader."Posting No. Series" := SalesHeader."No. Series"
                    else
                        if NoSeries.IsAutomatic(PostingNoSeries) then
                            SalesHeader."Posting No. Series" := PostingNoSeries;

                    if SalesSetup."Shipment on Invoice" then
                        if NoSeries.IsAutomatic(SalesSetup."Posted Shipment Nos.") then
                            SalesHeader."Shipping No. Series" := SalesSetup."Posted Shipment Nos.";
                end;
            SalesHeader."Document Type"::"Return Order":
                begin
                    if NoSeries.IsAutomatic(PostingNoSeries) then
                        SalesHeader."Posting No. Series" := PostingNoSeries;
                    if NoSeries.IsAutomatic(SalesSetup."Posted Return Receipt Nos.") then
                        SalesHeader."Return Receipt No. Series" := SalesSetup."Posted Return Receipt Nos.";
                end;
            SalesHeader."Document Type"::"Credit Memo":
                begin
                    if (SalesHeader."No. Series" <> '') and (SalesSetup."Credit Memo Nos." = PostingNoSeries) then
                        SalesHeader."Posting No. Series" := SalesHeader."No. Series"
                    else
                        if NoSeries.IsAutomatic(PostingNoSeries) then
                            SalesHeader."Posting No. Series" := PostingNoSeries;
                    if SalesSetup."Return Receipt on Credit Memo" then
                        if NoSeries.IsAutomatic(SalesSetup."Posted Return Receipt Nos.") then
                            SalesHeader."Return Receipt No. Series" := SalesSetup."Posted Return Receipt Nos."
                end;
        end;

        OnAfterInitPostingNoSeries(SalesHeader, xSalesHeader);

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterInitRecord, '', false, false)]
    local procedure OnAfterInitRecord(var SalesHeader: Record "Sales Header")
    var
        DocSubtypeCodeSetup: Record "Doc Subtype Code Setup FND";
    begin
        IF DocSubtypeCodeSetup.GET() THEN
            IF (DocSubtypeCodeSetup."Sales - General" <> '') THEN
                IF SalesHeader."Document Subtype Code FND" = '' THEN //PATHAA02 29.09.17
                    SalesHeader.VALIDATE("Document Subtype Code FND", DocSubtypeCodeSetup."Sales - General");

    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInitPostingNoSeries(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    begin
    end;

    // BC Upgrade SHUKLP03 << Table 36 Sales Header => Added DIT field "Document Subtype Code" code.

    // BC Upgrade SHUKLP03 >> Table 37 Sales Line => Added DIT field "Document Subtype Code" code.

    // BC Upgrade SHUKLP03 >> Table 37 Sales Line => Added DIT field "Document Subtype Code" code.
    // HEI.02 => Subscribed event OnAfterCopyFromItem to add code of No. onvalidate.

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterCopyFromItem, '', false, false)]
    local procedure OnAfterCopyFromItem(var SalesLine: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
    begin
        If SalesHeader.get(SalesLine."Document Type", SalesLine."Document No.") then
            //HEI.02>>
            SalesLine."Document Subtype Code FND" := SalesHeader."Document Subtype Code FND";
        //HEI.02<<
    end;

    // BC Upgrade SHUKLP03 << Table 37 Sales Line => Added DIT field "Document Subtype Code" code.

    // BC Upgrade SHUKLP03 >> Table Transfer Header => Added DIT field "Document Subtype Code" code.

    [EventSubscriber(ObjectType::Table, Database::"Transfer Header", OnAfterInitRecord, '', false, false)]
    local procedure OnAfterInitRecordTH(var TransferHeader: Record "Transfer Header")
    var
        DocSubtypeCodeSetup: Record "Doc Subtype Code Setup FND";
    begin
        IF DocSubtypeCodeSetup.GET() THEN
            IF (DocSubtypeCodeSetup."Transfer - General" <> '') THEN
                TransferHeader.VALIDATE("Document Subtype Code FND", DocSubtypeCodeSetup."Transfer - General");

    end;
    // BC Upgrade SHUKLP03 << Table Transfer Header => Added DIT field "Document Subtype Code" code.

    // BC Upgrade VAMSIU01 - Table 38 Purchase Header - Added DIT field "Document Subtype Code" code>>
    // # InitRecord Custom code is added in OnBeforeInitRecord.
    // # GetNoSeriescode Custom code is added in OnBeforeGetNoSeriesCode.
    // # TestNoSeries Custom code is added in OnBeforeTestNoSeries.

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnBeforeInitRecord, '', false, false)]
    local procedure OnBeforeInitRecordPurch(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        GLSetup: Record "General Ledger Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        GenJournalTemplate: Record "Gen. Journal Template";
        NoSeries: Codeunit "No. Series";
        PostingNoSeries: Code[20];
        DocumentSubtypeCodeSetup: Record "Doc Subtype Code Setup FND";
        DocumentSubtypeCode: Record "Document Subtype Code FND";
        PostedInvoiceNo: Code[20];
    begin
        PurchSetup.Get();
        GLSetup.GetRecordOnce();

        if GLSetup."Journal Templ. Name Mandatory" then begin
            if PurchaseHeader."Journal Templ. Name" = '' then begin
                if not PurchaseHeader.IsCreditDocType() then
                    GenJournalTemplate.Get(PurchSetup."P. Invoice Template Name")
                else
                    GenJournalTemplate.Get(PurchSetup."P. Cr. Memo Template Name");

                PurchaseHeader."Journal Templ. Name" := GenJournalTemplate.Name;
            end else
                GenJournalTemplate.Get(PurchaseHeader."Journal Templ. Name");

            PostingNoSeries := GenJournalTemplate."Posting No. Series";
        end else
            if PurchaseHeader.IsCreditDocType() then
                PostingNoSeries := PurchSetup."Posted Credit Memo Nos."
            else
                PostingNoSeries := PurchSetup."Posted Invoice Nos.";

        case PurchaseHeader."Document Type" of

            PurchaseHeader."Document Type"::Quote,
            PurchaseHeader."Document Type"::Order:
                begin
                    DocumentSubtypeCodeSetup.Get();
                    if DocumentSubtypeCode.Get(DocumentSubtypeCodeSetup."CTS Order") and
                       (PurchaseHeader."Document Subtype Code FND" = DocumentSubtypeCodeSetup."CTS Order") and
                       (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order)
                    then
                        PostedInvoiceNo := DocumentSubtypeCode."Posted Invoice Nos."
                    else
                        PostedInvoiceNo := PurchSetup."Posted Invoice Nos.";

                    if NoSeries.IsAutomatic(PostedInvoiceNo) then
                        PurchaseHeader."Posting No. Series" := PostedInvoiceNo;

                    if NoSeries.IsAutomatic(PurchSetup."Posted Receipt Nos.") then
                        PurchaseHeader."Receiving No. Series" := PurchSetup."Posted Receipt Nos.";

                    if NoSeries.IsAutomatic(PurchSetup."Posted Prepmt. Inv. Nos.") then
                        PurchaseHeader."Prepayment No. Series" := PurchSetup."Posted Prepmt. Inv. Nos.";

                    if NoSeries.IsAutomatic(PurchSetup."Posted Prepmt. Cr. Memo Nos.") then
                        PurchaseHeader."Prepmt. Cr. Memo No. Series" := PurchSetup."Posted Prepmt. Cr. Memo Nos.";
                end;

            PurchaseHeader."Document Type"::Invoice:
                begin
                    //hei.19>>
                    PurchSetup.TestField("Expense Claim Subdoc. Type FND");
                    if PurchaseHeader."Document Subtype Code FND" = PurchSetup."Expense Claim Subdoc. Type FND" then begin
                        if NoSeries.IsAutomatic(PurchSetup."Expense Claim Invoices Nos FND") then
                            PurchaseHeader."Posting No. Series" := PurchSetup."Expense Claim Invoices Nos FND";
                    end else begin
                        //hei.19<<
                        if (PurchaseHeader."No. Series" <> '') and
                           (PurchSetup."Invoice Nos." = PurchSetup."Posted Invoice Nos.")
                        then
                            PurchaseHeader."Posting No. Series" := PurchaseHeader."No. Series"
                        //HEI.47>>
                        else begin
                            if (PurchSetup."GR IR Invoice Writeoff No. FND" <> '') and
                               (PurchSetup."Posted GRIR Inv. Wrtoff No FND" <> '') then begin
                                if (PurchaseHeader."No. Series" <> '') and
                                   (PurchaseHeader."No. Series" = PurchSetup."GR IR Invoice Writeoff No. FND") then begin
                                    if NoSeries.IsAutomatic(PurchSetup."Posted GRIR Inv. Wrtoff No FND") then
                                        PurchaseHeader."Posting No. Series" := PurchSetup."Posted GRIR Inv. Wrtoff No FND";
                                end else begin
                                    if NoSeries.IsAutomatic(PurchSetup."Posted Invoice Nos.") then
                                        PurchaseHeader."Posting No. Series" := PurchSetup."Posted Invoice Nos.";
                                end;
                            end else begin
                                if NoSeries.IsAutomatic(PurchSetup."Posted Invoice Nos.") then
                                    PurchaseHeader."Posting No. Series" := PurchSetup."Posted Invoice Nos.";
                            end;
                        end;
                        //HEI.47<<
                    end;
                    if PurchSetup."Receipt on Invoice" then
                        if NoSeries.IsAutomatic(PurchSetup."Posted Receipt Nos.") then
                            PurchaseHeader."Receiving No. Series" := PurchSetup."Posted Receipt Nos.";
                end;

            PurchaseHeader."Document Type"::"Return Order":
                begin
                    if NoSeries.IsAutomatic(PostingNoSeries) then
                        PurchaseHeader."Posting No. Series" := PostingNoSeries;

                    if NoSeries.IsAutomatic(PurchSetup."Posted Return Shpt. Nos.") then
                        PurchaseHeader."Return Shipment No. Series" := PurchSetup."Posted Return Shpt. Nos.";
                end;

            PurchaseHeader."Document Type"::"Credit Memo":
                begin
                    PurchSetup.TestField("Expense ClaimCMSubdoc Type FND");
                    if PurchaseHeader."Document Subtype Code FND" = PurchSetup."Expense ClaimCMSubdoc Type FND" then begin
                        if NoSeries.IsAutomatic(PurchSetup."Expense claim crd memos No FND") then
                            PurchaseHeader."Posting No. Series" := PurchSetup."Expense claim crd memos No FND";
                    end else begin
                        if (PurchaseHeader."No. Series" <> '') and (PurchSetup."Credit Memo Nos." = PostingNoSeries) then
                            PurchaseHeader."Posting No. Series" := PurchaseHeader."No. Series"
                        else
                            if NoSeries.IsAutomatic(PostingNoSeries) then
                                PurchaseHeader."Posting No. Series" := PostingNoSeries;

                        if PurchSetup."Return Shipment on Credit Memo" then
                            if NoSeries.IsAutomatic(PurchSetup."Posted Return Shpt. Nos.") then
                                PurchaseHeader."Return Shipment No. Series" := PurchSetup."Posted Return Shpt. Nos.";
                    end;
                end;
        end;
        OnAfterInitPostingNoSeriesPurch(PurchaseHeader, xPurchaseHeader);

        IsHandled := true;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInitPostingNoSeriesPurch(var PurchHeader: Record "Purchase Header"; xPurchHeader: Record "Purchase Header")
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeGetNoSeriesCode', '', false, false)]
    local procedure PurchHeader_OnBeforeGetNoSeriesCode(
    PurchSetup: Record "Purchases & Payables Setup";
    var NoSeriesCode: Code[20];
    var IsHandled: Boolean;
    PurchaseHeader: Record "Purchase Header")
    var
        NoSeries: Codeunit "No. Series";
    begin

        IsHandled := true;

        case PurchaseHeader."Document Type" of

            PurchaseHeader."Document Type"::Quote:
                NoSeriesCode := PurchSetup."Quote Nos.";

            PurchaseHeader."Document Type"::Order:
                begin
                    // HEI.13 >>
                    if PurchaseHeader."Document Subtype Code FND" in
                       [PurchSetup."NPO Prepayment req.subtype FND",
                        PurchSetup."PO Prepayment req. Subtype FND"] then
                        NoSeriesCode := PurchSetup."Prepayment Request Nos. FND"
                    else
                        NoSeriesCode := PurchSetup."Order Nos.";
                    // HEI.13 <<
                end;

            PurchaseHeader."Document Type"::Invoice:
                begin
                    NoSeriesCode := PurchSetup."Invoice Nos.";

                    // hei.19 >>
                    if PurchaseHeader."Document Subtype Code FND" = PurchSetup."Expense Claim Subdoc. Type FND" then begin
                        PurchSetup.TestField("Expense Claim Invoices Nos FND");
                        NoSeriesCode := PurchSetup."Expense Claim Invoices Nos FND";
                    end;
                    // hei.19 <<
                end;

            PurchaseHeader."Document Type"::"Return Order":
                NoSeriesCode := PurchSetup."Return Order Nos.";

            PurchaseHeader."Document Type"::"Credit Memo":
                begin
                    NoSeriesCode := PurchSetup."Credit Memo Nos.";

                    // hei.19 >>
                    if PurchaseHeader."Document Subtype Code FND" = PurchSetup."Expense ClaimCMSubdoc Type FND" then begin
                        PurchSetup.TestField("Expense claim crd memos No FND");
                        NoSeriesCode := PurchSetup."Expense claim crd memos No FND";
                    end;
                    // hei.19 <<
                end;

            PurchaseHeader."Document Type"::"Blanket Order":
                NoSeriesCode := PurchSetup."Blanket Order Nos.";
        end;

        if NoSeries.IsAutomatic(NoSeriesCode) then
            exit;

        if NoSeries.HasRelatedSeries(NoSeriesCode) then
            if NoSeries.LookupRelatedNoSeries(NoSeriesCode, PurchaseHeader."No. Series") then
                NoSeriesCode := PurchaseHeader."No. Series";

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeTestNoSeries', '', false, false)]
    local procedure OnBeforeTestNoSeries(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        PurchSetup: Record "Purchases & Payables Setup";
        GLSetup: Record "General Ledger Setup";
        GenJournalTemplate: Record "Gen. Journal Template";
        GlobalNoSeries: Record "No. Series";
    begin
        PurchSetup.Get();
        IsHandled := true;

        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::Quote:
                PurchSetup.TestField("Quote Nos.");

            PurchaseHeader."Document Type"::Order:
                begin
                    //HEI.13
                    if PurchaseHeader."Document Subtype Code FND" in
                       [PurchSetup."NPO Prepayment req.subtype FND",
                        PurchSetup."PO Prepayment req. Subtype FND"]
                    then
                        PurchSetup.TestField("Prepayment Request Nos. FND")
                    else
                        PurchSetup.TestField("Order Nos.");
                    //HEI.13
                end;

            PurchaseHeader."Document Type"::Invoice:
                PurchSetup.TestField("Invoice Nos.");

            PurchaseHeader."Document Type"::"Return Order":
                PurchSetup.TestField("Return Order Nos.");

            PurchaseHeader."Document Type"::"Credit Memo":
                PurchSetup.TestField("Credit Memo Nos.");

            PurchaseHeader."Document Type"::"Blanket Order":
                PurchSetup.TestField("Blanket Order Nos.");
        end;

        GLSetup.GetRecordOnce();

        if not GLSetup."Journal Templ. Name Mandatory" then begin
            case PurchaseHeader."Document Type" of
                PurchaseHeader."Document Type"::Invoice:
                    PurchSetup.TestField("Posted Invoice Nos.");
                PurchaseHeader."Document Type"::"Credit Memo":
                    PurchSetup.TestField("Posted Credit Memo Nos.");
            end;
        end else begin
            PurchSetup.GetRecordOnce();

            if not PurchaseHeader.IsCreditDocType() then begin
                PurchSetup.TestField("P. Invoice Template Name");

                if PurchaseHeader."Journal Templ. Name" = '' then
                    GenJournalTemplate.Get(PurchSetup."P. Invoice Template Name")
                else
                    GenJournalTemplate.Get(PurchaseHeader."Journal Templ. Name");
            end else begin
                PurchSetup.TestField("P. Cr. Memo Template Name");

                if PurchaseHeader."Journal Templ. Name" = '' then
                    GenJournalTemplate.Get(PurchSetup."P. Cr. Memo Template Name")
                else
                    GenJournalTemplate.Get(PurchaseHeader."Journal Templ. Name");
            end;

            GenJournalTemplate.TestField("Posting No. Series");
            GlobalNoSeries.Get(GenJournalTemplate."Posting No. Series");
            GlobalNoSeries.TestField("Default Nos.", true);
        end;
    end;
    //BC Upgrade VAMSIU01 - Table 38 Purchase Header - Added DIT field "Document Subtype Code" code <<

    // BC Upgrade SHUKLP03 >> Table 81 Gen. Journal Line => Added DIT field "Document Subtype Code" code.
    //BC Upgrade ATHUKS01 >> Update Payment Status FND to GenjournalLine table. 
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnLookUpAppliesToDocCustOnAfterUpdateDocumentTypeAndAppliesTo, '', false, false)]
    local procedure OnLookUpAppliesToDocCustOnAfterUpdateDocumentTypeAndAppliesTo(var GenJournalLine: Record "Gen. Journal Line"; CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        GenJournalLine."Document Subtype Code FND" := CustLedgerEntry."Document Subtype Code FND";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnLookUpAppliesToDocVendOnAfterUpdateDocumentTypeAndAppliesTo, '', false, false)]
    local procedure OnLookUpAppliesToDocVendOnAfterUpdateDocumentTypeAndAppliesTo(var GenJournalLine: Record "Gen. Journal Line"; VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        GenJournalLine."Document Subtype Code FND" := VendorLedgerEntry."Document Subtype Code FND";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterCopyGenJnlLineFromPurchHeader, '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromPurchHeader(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Document Subtype Code FND" := PurchaseHeader."Document Subtype Code FND";
        GenJournalLine."Payment Status FND" := PurchaseHeader."Payment Status FND"; //BC ATHUKS01
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterCopyGenJnlLineFromSalesHeader, '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Document Subtype Code FND" := SalesHeader."Document Subtype Code FND";
        GenJournalLine."Vehicle Code HNK FND" := SalesHeader."Vehicle Code 101FDW"; //BC UPGRADE KUMARR78 Adding Vehicle Code Flow(FDD OTC 091)
        GenJournalLine."Driver Code HNK FND" := SalesHeader."Log Driver 107FDW"; //BC UPGRADE KUMARR78 Adding Driver Code Flow (FDD OTC 091)

    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterCopyGenJnlLineFromSalesHeaderPayment, '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeaderPayment(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Document Subtype Code FND" := SalesHeader."Document Subtype Code FND";
    end;

    // BC Upgrade SHUKLP03 >> Table 81 Gen. Journal Line => Added DIT field "Document Subtype Code" code.

    // BC Upgrade VAMSIU01 - Table 77 Report Selections >>

    // # Adding Aptean Procedures(FilterPrintDocSubType and FindFieldRefDocSubType) that are used in below base Procedures:
    // # PrintWithGUIYesNo
    // # PrintWithGUIYesNoVendor
    // # GetEmailbody
    // # GetEmailbodyVendor
    // # SendtoDisk
    // # SendtoDiskVendor
    // # DIT(Aptean) code Written in the two procedures PrintWithGUIYesNo and PrintWithGUIYesNoVendor in Navision but these procedures are replaced with PrintWithDialogForCust & PrintWithDialogForVend in Business Central.
    // # DIT(Aptean) code written in the two procedures GetEmailbody and GetEmailbodyVendor in Navision but these procedures are replaced with GetEmailBodyTextForCust & GetEmailBodyForVend in Business Central.
    // # DIT(Aptean) code written in the two procedures SendtoDisk and SendtoDiskVendor in Navision but these procedures are replaced with SendToDiskForCust & SendToDiskForVend in Business Central.
    // # The logic from PrintWithGUIYesNo and PrintWithGUIYesNoVendor in Navision has been implemented in Business Central using the OnPrintDocumentsOnAfterSelectTempReportSelectionsToPrint event.
    // # Code in GetHtml function in Navison is not upgrading to BC due gethtml is not used effectively.
    // # The logic from GetEmailbody in Navision has been implemented in Business Central using the OnGetEmailBodyCustomerTextOnAfterNotFindEmailBodyUsage event.
    // # The logic from GetEmailbodyVendor in Navision has been implemented in Business Central using the OnGetEmailBodyVendorTextOnAfterNotFindEmailBodyUsage event.
    // # The logic from SendtoDisk in Navision has been implemented in Business Central using the OnSendToDiskForCustOnBeforeFindReportUsage event. 
    // # The logic from SendtoDiskVendor in Navision has been implemented in Business Central using the OnSendToDiskForVendOnBeforeSendFileLoop event. 
    // # The logic from SendToZip in Navision has been implemented in Business Central using the OnSendToZipForCustOnBeforeFindReportUsageForCust event. 
    // # The logic from SendToZipVendor in Navision has been implemented in Business Central using the OnSendToZipForVendOnBeforeSendFileLoop event. 
    // # The logic from CopyToReportSelection in Navision has been implemented in Business Central using the OnCopyToReportSelectionOnBeforInsertToReportSelections event. 
    // # The logic from GetCustomReportSelection in Navision has been implemented in Business Central using the OnAfterGetCustomReportSelection event. 
    // # The logic from SendemailtocustDirectly , Sendemailtovendordirectly and Sendemaildirectly in navison has been implemented in Business central using the OnBeforeSendEmailDirectly Event.

    //BC UPGRADE KUMARR78 >> Adding Event for Data from gen Jnl Line to Cust. Ledger Entry (FDD OTC 091)
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCustLedgEntryInsert', '', true, true)]
    local procedure OnBeforeCustLedgEntryInsert(
        GLRegister: Record "G/L Register";
        sender: Codeunit "Gen. Jnl.-Post Line";
        var CustLedgerEntry: Record "Cust. Ledger Entry";
        var GenJournalLine: Record "Gen. Journal Line";
        var NextEntryNo: Integer;
        var TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"
    )
    var
    begin
        CustLedgerEntry."Vehicle Code HNK FND" := GenJournalLine."Vehicle Code HNK FND";
        CustLedgerEntry."Driver Code HNK FND" := GenJournalLine."Driver Code HNK FND";
    end;
    //BC UPGRADE KUMARR78 << Adding Event for Data from gen Jnl Line to Cust. Ledger Entry(FDD OTC 091)

    //BC UPGRADE KUMARR78 >> Adding Event for Data flow from Sales Header to Sales Invoice.(FDD OTC 091)
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesInvHeaderInsert(
       CommitIsSuppressed: Boolean;
       InvtPickPutaway: Boolean;
       var IsHandled: Boolean;
       var SalesHeader: Record "Sales Header";
       var SalesInvHeader: Record "Sales Invoice Header";
       WhseShip: Boolean;
       WhseShptHeader: Record "Warehouse Shipment Header"
        )
    begin
        SalesInvHeader."Vehicle Code HNK FND" := SalesHeader."Vehicle Code 101FDW";
        SalesInvHeader."Log Driver 107FDW" := SalesHeader."Log Driver 107FDW";
    end;
    //BC UPGRADE KUMARR78 << Adding Event for Data flow from Sales Header to Sales Invoice.(FDD OTC 091)


    [EventSubscriber(ObjectType::Table, Database::"Report Selections", OnPrintDocumentsOnAfterSelectTempReportSelectionsToPrint, '', false, false)]
    local procedure "ReportSelections_OnPrintDocumentsOnAfterSelectTempReportSelectionsToPrint"(RecordVariant: Variant; var TempReportSelections: Record "Report Selections" temporary; var TempNameValueBuffer: Record "Name/Value Buffer" temporary; var WithCheck: Boolean; ReportUsage: Integer; TableNo: Integer)
    var
    //ReportSelections: Record "Report Selections"; // BC Upgrade SHUKLP03 << Created global variable.
    begin
        //POENAB02, BCUP0-241, 07.08.2026>>
        //commented below code, as it was impacting the already set filter for the report that was being triggered
        //depending on Report Selection setup, the "Document Subtype Code FND" impacted and in some conditions the report was not triggered.
        /*
        FilterPrintDocSubType(ReportUsage, RecordVariant);
        TempReportSelections.SetFilter("Document Subtype Code FND", ReportSelections.GETFILTER("Document Subtype Code FND"));
        //TempReportSelections.FindSet(); // BC Upgrade SHUKLP03 << Commented out as FindSet is already called in the event publisher after this event is raised.
        */
        //POENAB02, BCUP0-241, 07.08.2026<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", OnGetEmailBodyCustomerTextOnAfterNotFindEmailBodyUsage, '', false, false)]
    local procedure "ReportSelections_OnGetEmailBodyCustomerTextOnAfterNotFindEmailBodyUsage"(ReportUsage: Integer; RecordVariant: Variant; CustNo: Code[20]; var TempBodyReportSelections: Record "Report Selections" temporary; var IsHandled: Boolean; var EmailBodyUsageFound: Boolean)
    var
    // ReportSelections: Record "Report Selections"; // BC Upgrade SHUKLP03 << Created global variable.
    begin
        FilterPrintDocSubType(ReportUsage, RecordVariant);
        TempBodyReportSelections.SetFilter("Document Subtype Code FND", ReportSelections.GETFILTER("Document Subtype Code FND"));
        if not TempBodyReportSelections.FindSet() then
            exit;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", OnGetEmailBodyVendorTextOnAfterNotFindEmailBodyUsage, '', false, false)]
    local procedure "Report Selections_OnGetEmailBodyVendorTextOnAfterNotFindEmailBodyUsage"(ReportUsage: Integer; RecordVariant: Variant; CustNo: Code[20]; var TempBodyReportSelections: Record "Report Selections" temporary; var IsHandled: Boolean; var EmailBodyUsageFound: Boolean)
    var
    //ReportSelections: Record "Report Selections"; // BC Upgrade SHUKLP03 << Created global variable.
    begin
        FilterPrintDocSubType(ReportUsage, RecordVariant);
        TempBodyReportSelections.SetFilter("Document Subtype Code FND", ReportSelections.GETFILTER("Document Subtype Code FND"));
        if not TempBodyReportSelections.FindSet() then
            exit;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", OnSendToDiskForCustOnBeforeFindReportUsage, '', false, false)]
    local procedure "ReportSelections_OnSendToDiskForCustOnBeforeFindReportUsage"(var ReportSelectionsOrg: Record "Report Selections"; ReportUsage: Enum "Report Selection Usage"; RecordVariant: Variant; CustNo: Code[20]; var ReportSelectionsPart: Record "Report Selections"; var IsHandled: Boolean)
    begin
        FilterPrintDocSubType(ReportUsage.AsInteger(), RecordVariant);
        ReportSelectionsPart.SETFILTER("Document Subtype Code FND", ReportSelectionsOrg.GETFILTER("Document Subtype Code FND"));
        ReportSelectionsPart.FINDSET();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", OnSendToDiskForVendOnBeforeSendFileLoop, '', false, false)]
    local procedure "ReportSelections_OnSendToDiskForVendOnBeforeSendFileLoop"(var ReportSelections: Record "Report Selections" temporary; var RecordVariant: Variant)
    var
        TempReportSelections: Record "Report Selections";
        ReportUsage: Integer;
    begin
        FilterPrintDocSubType(ReportUsage, RecordVariant);
        TempReportSelections.SETFILTER("Document Subtype Code FND", ReportSelections.GETFILTER("Document Subtype Code FND"));
        TempReportSelections.FINDSET();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", OnSendToZipForCustOnBeforeFindReportUsageForCust, '', false, false)]
    local procedure "Report Selections_OnSendToZipForCustOnBeforeFindReportUsageForCust"(var ReportSelectionsOrg: Record "Report Selections"; ReportUsage: Enum "Report Selection Usage"; RecordVariant: Variant; CustNo: Code[20]; var ReportSelectionsPart: Record "Report Selections"; var IsHandled: Boolean)
    begin
        FilterPrintDocSubType(ReportUsage.AsInteger(), RecordVariant);
        ReportSelectionsPart.SETFILTER("Document Subtype Code FND", ReportSelectionsOrg.GETFILTER("Document Subtype Code FND"));
        ReportSelectionsPart.FINDSET();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", OnSendToZipForVendOnBeforeSendFileLoop, '', false, false)]
    local procedure "ReportSelections_OnSendToZipForVendOnBeforeSendFileLoop"(var ReportSelections: Record "Report Selections" temporary; var RecordVariant: Variant)
    var
        TempReportSelections: Record "Report Selections";
        ReportUsage: Integer;
    begin
        FilterPrintDocSubType(ReportUsage, RecordVariant);
        TempReportSelections.SETFILTER("Document Subtype Code FND", ReportSelections.GETFILTER("Document Subtype Code FND"));
        TempReportSelections.FINDSET();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", OnCopyToReportSelectionOnBeforInsertToReportSelections, '', false, false)]
    local procedure "ReportSelections_OnCopyToReportSelectionOnBeforInsertToReportSelections"(var ReportSelections: Record "Report Selections"; CustomReportSelection: Record "Custom Report Selection")
    begin
        ReportSelections."Document Subtype Code FND" := CustomReportSelection."Document Subtype Code FND";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", OnAfterGetCustomReportSelection, '', false, false)]
    local procedure "ReportSelections_OnAfterGetCustomReportSelection"(var CustomReportSelection: Record "Custom Report Selection"; AccountNo: Code[20]; TableNo: Integer)
    var
    //ReportSelections: Record "Report Selections"; // BC Upgrade SHUKLP03 << Created global variable.
    begin
        CustomReportSelection.SetFilter("Document Subtype Code FND", ReportSelections.GETFILTER("Document Subtype Code FND"));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", OnBeforeSendEmailDirectly, '', false, false)]
    local procedure "Report Selections_OnBeforeSendEmailDirectly"(var ReportSelections: Record "Report Selections"; ReportUsage: Enum "Report Selection Usage"; RecordVariant: Variant; var DocNo: Code[20]; var DocName: Text[150]; FoundBody: Boolean; FoundAttachment: Boolean; ServerEmailBodyFilePath: Text[250]; var DefaultEmailAddress: Text[250]; ShowDialog: Boolean; var TempAttachReportSelections: Record "Report Selections" temporary; var CustomReportSelection: Record "Custom Report Selection"; var AllEmailsWereSuccessful: Boolean; var IsHandled: Boolean; var SourceTableIDs: List of [Integer]; var SourceIDs: List of [Guid]; var SourceRelationTypes: List of [Integer])
    begin
        FilterPrintDocSubType(ReportUsage.AsInteger(), RecordVariant);
        TempAttachReportSelections.SETFILTER("Document Subtype Code FND", ReportSelections.GETFILTER("Document Subtype Code FND"));
        FoundAttachment := TempAttachReportSelections.FindSet();

        CustomReportSelection.SetFilter("Document Subtype Code FND", ReportSelections.GETFILTER("Document Subtype Code FND"));
    end;

    procedure FilterPrintDocSubType(ReportUsage: Integer; RecordVariant: Variant)
    var
        DocRecRef: RecordRef;
        DocFieldRef: FieldRef;
    // ReportSelections: Record "Report Selections"; // BC Upgrade SHUKLP03 << Created global variable.
    begin
        // <<DITW110.00.08 DDR 16/02/2017 NRQ#20755
        ReportSelections.SetRange("Document Subtype Code FND");

        DocRecRef.GetTable(RecordVariant);

        if FindFieldRefDocSubType(DocRecRef, DocFieldRef) then
            ReportSelections.SetRange("Document Subtype Code FND", Format(DocFieldRef.Value));
        IF ReportSelections.FINDFIRST() THEN; // BC Upgrade SHUKLP03 << Added to set the filter on Document Subtype Code field in Report Selections table based on the value from the document which is being processed.
    end;

    procedure FindFieldRefDocSubType(DocRecRef: RecordRef; var DocFieldRef: FieldRef): Boolean
    var
        SalesHeader: Record "Sales Header";
        PurchaseHeader: Record "Purchase Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        SalesHeaderArchive: Record "Sales Header Archive";
        PurchaseHeaderArchive: Record "Purchase Header Archive";
        TransferHeader: Record "Transfer Header";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        TransferReceiptHeader: Record "Transfer Receipt Header";
        ReturnShipmentHeader: Record "Return Shipment Header";
        ReturnReceiptHeader: Record "Return Receipt Header";
    begin
        case DocRecRef.Number of
            Database::"Sales Header":
                DocFieldRef := DocRecRef.Field(SalesHeader.FieldNo("Document Subtype Code FND"));

            Database::"Purchase Header":
                DocFieldRef := DocRecRef.Field(PurchaseHeader.FieldNo("Document Subtype Code FND"));

            Database::"Sales Shipment Header":
                DocFieldRef := DocRecRef.Field(SalesShipmentHeader.FieldNo("Document Subtype Code FND"));

            Database::"Sales Invoice Header":
                DocFieldRef := DocRecRef.Field(SalesInvoiceHeader.FieldNo("Document Subtype Code FND"));

            Database::"Sales Cr.Memo Header":
                DocFieldRef := DocRecRef.Field(SalesCrMemoHeader.FieldNo("Document Subtype Code FND"));

            Database::"Purch. Rcpt. Header":
                DocFieldRef := DocRecRef.Field(PurchRcptHeader.FieldNo("Document Subtype Code FND"));

            Database::"Purch. Inv. Header":
                DocFieldRef := DocRecRef.Field(PurchInvHeader.FieldNo("Document Subtype Code FND"));

            Database::"Purch. Cr. Memo Hdr.":
                DocFieldRef := DocRecRef.Field(PurchCrMemoHdr.FieldNo("Document Subtype Code FND"));

            Database::"Sales Header Archive":
                DocFieldRef := DocRecRef.Field(SalesHeaderArchive.FieldNo("Document Subtype Code FND"));

            Database::"Purchase Header Archive":
                DocFieldRef := DocRecRef.Field(PurchaseHeaderArchive.FieldNo("Document Subtype Code FND"));

            Database::"Transfer Header":
                DocFieldRef := DocRecRef.Field(TransferHeader.FieldNo("Document Subtype Code FND"));

            Database::"Transfer Shipment Header":
                DocFieldRef := DocRecRef.Field(TransferShipmentHeader.FieldNo("Document Subtype Code FND"));

            Database::"Transfer Receipt Header":
                DocFieldRef := DocRecRef.Field(TransferReceiptHeader.FieldNo("Document Subtype Code FND"));

            Database::"Return Shipment Header":
                DocFieldRef := DocRecRef.Field(ReturnShipmentHeader.FieldNo("Document Subtype Code FND"));

            Database::"Return Receipt Header":
                DocFieldRef := DocRecRef.Field(ReturnReceiptHeader.FieldNo("Document Subtype Code FND"));

            else
                exit(false);
        end;

        exit(true);
    end;

    //BC Upgrade VAMSIU01 - Table 77 Report Selections <<

    var
        g_SuppressWindow: Boolean;//BC Upgrade SHARMP16 -Declared global variable
        myInt: Integer;
        Location: Record Location;
        ReportSelections: Record "Report Selections";    // BC Upgrade SHUKLP03 << 
}
