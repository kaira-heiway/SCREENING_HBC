codeunit 53005 BatchPostCollector
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(
        var SalesHeader: Record "Sales Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        SalesShptHdrNo: Code[20];
        SalesInvHdrNo: Code[20];
        SalesCrMemoHdrNo: Code[20];
        CommitIsSuppressed: Boolean)
    var
        PrintMgt: Codeunit BatchPostPrintMgt;
    begin
        if not PrintMgt.GetPrint() then
            exit;

        if SalesInvHdrNo <> '' then
            PrintMgt.AddInvoice(SalesInvHdrNo);

        // if SalesShptHdrNo <> '' then
        //     PrintMgt.AddInvoice(SalesShptHdrNo);
    end;

    [EventSubscriber(ObjectType::Report, Report::"Batch Post Sales Orders", 'OnAfterSalesBatchPostMgt', '', false, false)]
    local procedure OnAfterSalesBatchPostMgt(var SalesHeader: Record "Sales Header"; var SalesBatchPostMgt: Codeunit "Sales Batch Post Mgt.")
    var
        RepBatchPostsaleOrder: Report "Batch Post Sales Orders";
        cduSalesPostPrint: Codeunit "Sales-Post + Print";

    begin
        if RepBatchPostsaleOrder.GetPrint() then
            cduSalesPostPrint.GetReport(SalesHeader);
    end;

    procedure CreateGateEntryOutbound(WhseShipment: Record "Warehouse Shipment Header");
    var
        GateEntryHeader: Record "Gate Entry Header FND";
        GateEntryHeader2: Record "Gate Entry Header FND";
        GateEntryLine: Record "Gate Entry Line FND";
        WhseSetup: Record "Warehouse Setup";
        WhseShip: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        // NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade NANDIS03
        NoSeries: Codeunit "No. Series";  // BC Upgrade NANDIS03
        LineNo: Integer;
    begin
        WhseSetup.GET();
        if WhseSetup."Allow Collect Lines FND" then begin
            // WhseShipment.TESTFIELD(WhseShipment."Driver Code");//BC Upgrade SHARMP16-- Drink-IT fields used
            // WhseShipment.TESTFIELD(WhseShipment."Truck Code");//BC Upgrade SHARMP16-- Drink-IT fields used
            //BC UPGRADE KUMARR78 >> FDD-MTC-007
            WhseShipment.TESTFIELD(WhseShipment."Log Driver 107FDW");
            WhseShipment.TESTFIELD(WhseShipment."Vehicle Code 101FDW");
            //BC UPGRADE KUMARR78 << FDD-MTC-007

            GateEntryHeader.Init();
            WhseSetup.TestField("Gate Entry Nos. FND");
            GateEntryHeader."Gate Entry Document No." :=
                NoSeries.GetNextNo(WhseSetup."Gate Entry Nos. FND", WorkDate(), true);
            GateEntryHeader."No. Series" := WhseSetup."Gate Entry Nos. FND";
            GateEntryHeader.Insert(true);

            GateEntryHeader.VALIDATE("Gate Entry Type", GateEntryHeader."Gate Entry Type"::Outbound);
            GateEntryHeader.VALIDATE(GateEntryHeader."Document Type", GateEntryHeader."Document Type"::"Warehouse Shipment");
            GateEntryHeader.VALIDATE(GateEntryHeader."Document No.", WhseShipment."No.");
            //  GateEntryHeader.VALIDATE(GateEntryHeader."Vehicle No.", WhseShipment."Truck Code");//BC Upgrade SHARMP16-- Drink-IT fields used
            GateEntryHeader.VALIDATE(GateEntryHeader."Vehicle No.", WhseShipment."Vehicle Code 101FDW");//BC UPGRADE KUMARR78 FDD-MTC-007

            GateEntryHeader.VALIDATE(GateEntryHeader."Location Code", WhseShipment."Location Code");
            GateEntryHeader.VALIDATE("Zone Code", WhseShipment."Zone Code"); //HEI.02

            // GateEntryHeader.VALIDATE(GateEntryHeader."Driver Code", WhseShipment."Driver Code");//BC Upgrade SHARMP16-- Drink-IT fields used
            GateEntryHeader.VALIDATE(GateEntryHeader."Driver Code", WhseShipment."Log Driver 107FDW");//BC UPGRADE KUMARR78 FDD-MTC-007

            GateEntryHeader."Date In" := WORKDATE();
            GateEntryHeader."Time In" := TIME;

            GateEntryHeader.MODIFY(true);
            //HEI.02>>
            LineNo := 10000;
            WarehouseShipmentLine.SETRANGE("No.", WhseShipment."No.");
            if WarehouseShipmentLine.findset() then
                repeat
                    GateEntryLine.INIT();
                    GateEntryLine.VALIDATE("Gate Entry Document No.", GateEntryHeader."Gate Entry Document No.");
                    GateEntryLine.VALIDATE("Line No.", LineNo);
                    GateEntryLine.INSERT(true);

                    GateEntryLine.VALIDATE(Type, GateEntryLine.Type::Item);
                    GateEntryLine.VALIDATE("No.", WarehouseShipmentLine."Item No.");
                    GateEntryLine.VALIDATE("Unit Of Measure Code", WarehouseShipmentLine."Unit of Measure Code");
                    GateEntryLine.VALIDATE("Location Code", WhseShipment."Location Code");
                    GateEntryLine.VALIDATE("Zone Code", WhseShipment."Zone Code");
                    GateEntryLine.VALIDATE("Quantity Shipment", WarehouseShipmentLine.Quantity); //HEI.02
                    if WhseSetup."Auto Insert Qty.CollectLin FND" then
                        GateEntryLine.VALIDATE("Quantity on Departure", WarehouseShipmentLine.Quantity);
                    GateEntryLine.MODIFY();
                    LineNo += 10000;
                until WarehouseShipmentLine.NEXT() = 0;
            //HEI.02<<
            MESSAGE('The Gate Entry Outbount with no %1 was created!', GateEntryHeader."Gate Entry Document No.");
            GateEntryHeader.ReleaseGateEntry();
            COMMIT();
            PAGE.RUNMODAL(53010, GateEntryHeader);
            if WhseShip.GET(WhseShipment."No.") then begin
                WhseShip.VALIDATE("Gate Entry No. FND", GateEntryHeader."Gate Entry Document No.");
                WhseShip.MODIFY();
            end;

        end else begin
            MESSAGE('Nothing to create!Please check the warehouse setup!');
        end;
    end;

    //BC UPGRDAE KUMARR78 FDD-MTC-007

    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", 'OnBeforeWhseShptHeaderInsert', '', false, false)]
    local procedure OnBeforeWhseShptHeaderInsert(
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        TransferLine: Record "Transfer Line";
        var WarehouseRequest: Record "Warehouse Request";
        var WarehouseShipmentHeader: Record "Warehouse Shipment Header"
    )
    begin

        WarehouseShipmentHeader."Source Document Type FND" := WarehouseRequest."Source Document".AsInteger();
        WarehouseShipmentHeader."Source No. FND" := WarehouseRequest."Source No.";

    end;

    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", 'OnBeforeWhseReceiptHeaderInsert', '', false, false)]

    local procedure OnBeforeWhseReceiptHeaderInsert(var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; var WarehouseRequest: Record "Warehouse Request")
    begin

        WarehouseReceiptHeader."Source Document Type FND" := WarehouseRequest."Source Document".AsInteger();
        WarehouseReceiptHeader."Source No. FND" := WarehouseRequest."Source No.";
    end;
    //BC UPGRDAE KUMARR78 FDD-MTC-007


    //BC UPGRADE KUMARR78 >> ++26-06-2026
    procedure BlockCustomer(Variant: Variant)
    var
        RecRef: RecordRef;
        Customer: Record Customer;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        //HEI.01>>
        RecRef.GETTABLE(Variant);
        CASE RecRef.NUMBER OF
            DATABASE::Customer:
                BEGIN
                    SalesReceivablesSetup.GET;
                    SalesReceivablesSetup.TESTFIELD("Reason Code Block Customer FND");
                    Customer := Variant;
                    Customer.Blocked := Customer.Blocked::All;
                    Customer."Blocked Reason Code FND" := SalesReceivablesSetup."Reason Code Block Customer FND";
                    Customer.MODIFY;
                END;
        END;
    end;
    //HEI.01<<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling",
                     'OnExecuteWorkflowResponse', '', false, false)]
    local procedure OnExecuteWorkflowResponse(
        var ResponseExecuted: Boolean;
        var Variant: Variant;
        xVariant: Variant;
        ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    begin
        case ResponseWorkflowStepInstance."Function Name" of
            'BLOCKCUSTOMER':
                begin
                    BlockCustomer(Variant);
                    ResponseExecuted := true;
                end;
            'UNBLOCKCUSTOMER':
                begin
                    UnBlockCustomer(Variant);
                    ResponseExecuted := true;
                end;
        end;
    end;

    procedure UnBlockCustomer(Variant: Variant)
    var
        RecRef: RecordRef;
        Customer: Record Customer;
        Fldref: FieldRef;
        ApprovalEntry: Record "Approval Entry";
        RecRef2: RecordRef;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        //HEI.01>>
        RecRef.GETTABLE(Variant);
        CASE RecRef.NUMBER OF
            DATABASE::"Approval Entry":
                BEGIN
                    Fldref := RecRef.FIELD(ApprovalEntry.FIELDNO("Table ID"));
                    IF FORMAT(Fldref.VALUE) = '18' THEN BEGIN
                        ApprovalEntry := Variant;
                        RecRef2.GET(ApprovalEntry."Record ID to Approve");
                        RecRef2.SETTABLE(Customer);
                        SalesReceivablesSetup.GET;
                        SalesReceivablesSetup.TESTFIELD("Reason Code Block Customer FND");
                        IF STRPOS('Y001', Customer."Account Group FND") <> 0 THEN BEGIN
                            Customer.Blocked := Customer.Blocked::Ship;
                            Customer."Blocked Reason Code FND" := SalesReceivablesSetup."Reason Code Block Customer FND";
                            Customer.MODIFY;
                        END;
                        IF STRPOS('Y002|Y005|Y010', Customer."Account Group FND") <> 0 THEN BEGIN
                            Customer.Blocked := Customer.Blocked::Invoice;
                            Customer."Blocked Reason Code FND" := SalesReceivablesSetup."Reason Code Block Customer FND";
                            Customer.MODIFY;
                        END;
                        IF STRPOS('Y006|Y009|Y008', Customer."Account Group FND") <> 0 THEN BEGIN
                            Customer.Blocked := Customer.Blocked::" ";
                            CLEAR(Customer."Blocked Reason Code FND");
                            Customer.MODIFY;
                        END;

                        //Customer.Blocked := Customer.Blocked::" ";
                        //CLEAR(Customer."Blocked Reason Code");
                        //Customer.MODIFY;
                        //tet
                    END;
                END;
        END;
    end;
    //HEI.01<<
    //BC UPGRADE KUMARR78 >> ++24-06-2026

    //BC UPGRADE KUMARR78 >> ++26-06-2026
    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Header", 'OnBeforePrintRecords', '', false, false)]
    local procedure OnBeforePrintRecordsShipment(var SalesShipmentHeader: Record "Sales Shipment Header"; ShowDialog: Boolean; var IsHandled: Boolean)
    var
        ReportSelection: Record "Report Selections";
        SalesShptHeader: Record "Sales Shipment Header";
    begin
        ReportSelection.Reset();
        ReportSelection.SetRange(Usage, ReportSelection.Usage::"S.Shipment");
        ReportSelection.SetRange("Document Subtype Code FND", SalesShipmentHeader."Document Subtype Code FND");
        if ReportSelection.FindFirst() then begin
            SalesShptHeader.RESET();
            SalesShptHeader.SETRANGE(SalesShptHeader."No.", SalesShipmentHeader."No.");
            IF SalesShptHeader.FINDSET() THEN;
            Report.RunModal(ReportSelection."Report ID", true, false, SalesShptHeader);
        end;
        IsHandled := true;
    end;
    //BC UPGRADE KUMARR78 >> ++26-06-2026
    //BC UPGRADE KUMARR78 >> ++26-06-2026
    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Header", 'OnBeforePrintRecords', '', false, false)]
    local procedure OnBeforePrintRecordsInvoice(var ReportSelections: Record "Report Selections"; var SalesInvoiceHeader: Record "Sales Invoice Header"; ShowRequestPage: Boolean; var IsHandled: Boolean)
    var
        ReportSelection: Record "Report Selections";
        SalesInviceHeader: Record "Sales Invoice Header";
        rr: Report Reminder;
    begin
        ReportSelection.Reset();
        ReportSelection.SetRange(Usage, ReportSelection.Usage::"S.Invoice");
        ReportSelection.SetRange("Document Subtype Code FND", SalesInvoiceHeader."Document Subtype Code FND");
        if ReportSelection.FindFirst() then begin
            SalesInviceHeader.RESET();
            SalesInviceHeader.SETRANGE(SalesInviceHeader."No.", SalesInvoiceHeader."No.");
            IF SalesInviceHeader.FINDSET() THEN;
            Report.RunModal(ReportSelection."Report ID", true, false, SalesInviceHeader);
        end;
        IsHandled := true;
    end;
    //BC UPGRADE KUMARR78 >> ++26-06-2026

    //BC UPGRADE KUMARR78 >> ++15-07-2026

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeCheckBlockedCust', '', false, false)]
    local procedure OnBeforeCheckBlockedCust(Customer: Record Customer; Source: Option Journal,Document; DocType: Option; Shipment: Boolean; Transaction: Boolean; var IsHandled: Boolean)
    begin
        IsHandled := true;
        if Customer.Blocked = Customer.Blocked::Invoice then
            Customer.CheckBlockedCustOnDocs2(Customer, Source::Document, FALSE, FALSE, 0, FALSE, FALSE, FALSE)
        else
            Customer.CheckBlockedCustOnDocs2(Customer, Source::Document, FALSE, FALSE, 0, true, FALSE, FALSE);
    end;


    [EventSubscriber(ObjectType::report, Report::"Get Source Documents", 'OnSalesLineOnAfterGetRecordOnBeforeCheckCustBlocked', '', false, false)]
    local procedure OnSalesLineOnAfterGetRecordOnBeforeCheckCustBlocked(var Customer: Record Customer; var IsHandled: Boolean)
    begin

        IF Customer.CheckBlockedCustOnDocs2(Customer, 0, FALSE, FALSE, 0, FALSE, FALSE, FALSE) THEN
            IsHandled := true;
    end;

    //BC UPGRADE KUMARR78 >> ++15-07-2026

}