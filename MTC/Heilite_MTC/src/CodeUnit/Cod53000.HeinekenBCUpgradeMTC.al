codeunit 53000 "Heineken BC Upgrade MTC"
{
    // BC Upgrade SHUKLP03 >> 311 Codeunit
    // HEI.01 CHG2023313 IBM KUMARN15 22.08.2019
    // # New functions created ShowAndHandleAvailabilityPageUnrestr, ShowNotificationDetailsUnrestr, CreateAndSendNotificationUnrestr
    // # Code changed in functions SalesLineCheck, QtyAvailToPromise => Subscribe event "OnBeforeSalesLineCheck" added whole code after "OnBeforeSalesLineCheck" event from procedure "SalesLineCheck" 
    // made ISHandled boolean true and also added event publishers "OnSalesLineCheckOnAfterSalesLineShowWarning".
    // # Code changed in functions SalesLineShowWarning => Subscribed event "OnSalesLineShowWarningOnBeforeShowWarning".
    // # Code changed in functions QtyAvailToPromise =>  Subscribe event "OnBeforeQtyAvailToPromise" added whole code after "OnBeforeQtyAvailToPromise" event from procedure "QtyAvailToPromise" 
    // made ISHandled boolean true and also added event publishers "OnAfterConvertQty" and local procedure "ConvertQty".

    // HEI.02 CHG2023313 IBM.AB 05.11.2019
    // # Code enhancement in CreateAndSendNotificationUnrestr function

    // HEI.03 CHG2119178 IBM.AS 30.06.2021
    // # HeiLite Base Stability Changes for Posting functions at JOB NAS
    // # Adding GUIAllowed function added in Functions CreateAndSendNotificationUnrestr()

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item-Check Avail.", OnBeforeSalesLineCheck, '', false, false)]
    local procedure OnBeforeSalesLineCheck(SalesLine: Record "Sales Line"; sender: Codeunit "Item-Check Avail."; var IsHandled: Boolean; var Rollback: Boolean)
    var
        TempAsmHeader: Record "Assembly Header" temporary;
        TempAsmLine: Record "Assembly Line" temporary;
        ATOLink: Record "Assemble-to-Order Link";
        NotificationLifecycleMgt: Codeunit "Notification Lifecycle Mgt.";
        ItemCheckAva: Codeunit "Item-Check Avail.";

    begin
        NotificationLifecycleMgt.RecallNotificationsForRecordWithAdditionalContext(
         SalesLine.RecordId, ItemCheckAva.GetItemAvailabilityNotificationId(), true);
        if ItemCheckAva.SalesLineShowWarning(SalesLine) then
            // Rollback := ShowAndHandleAvailabilityPage(SalesLine.RecordId);
            Rollback := ShowAndHandleAvailabilityPageUnrestr(SalesLine.RecordId);//BC Upgrade SHUKLP03 << OnBeforeSalesLineCheck event is called for ShowAndHandleAvailabilityPageUnrestr function because no event is found to add HEI code, so called OnBeforeSalesLineCheck event and made IsHandle boolean true.

        OnSalesLineCheckOnAfterSalesLineShowWarning(SalesLine, Rollback);

        if not Rollback then
            if ATOLink.SalesLineCheckAvailShowWarning(SalesLine, TempAsmHeader, TempAsmLine) then
                Rollback := ItemCheckAva.ShowAsmWarningYesNo(TempAsmHeader, TempAsmLine);

        IsHandled := true;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnSalesLineCheckOnAfterSalesLineShowWarning(var SalesLine: Record "Sales Line"; var Rollback: Boolean);
    begin
    end;

    LOCAL procedure ShowAndHandleAvailabilityPageUnrestr(RecordId: RecordID) Rollback: Boolean
    var
        ItemNo2: Code[20];
        UnitOfMeasureCode2: Code[10];
        InventoryQty2: Decimal;
        GrossReq2: Decimal;
        ReservedReq2: Decimal;
        SchedRcpt2: Decimal;
        ReservedRcpt2: Decimal;
        CurrentQuantity2: Decimal;
        CurrentReservedQty2: Decimal;
        TotalQuantity2: Decimal;
        EarliestAvailDate2: Date;
        ItemCheckAva: Codeunit "Item-Check Avail.";
    begin
        //HEI.01<<
        IF NOT GUIALLOWED THEN
            EXIT(FALSE);

        ItemCheckAva.FetchCalculation(
        ItemNo2, UnitOfMeasureCode2, InventoryQty2,
        GrossReq2, ReservedReq2, SchedRcpt2, ReservedRcpt2,
        CurrentQuantity2, CurrentReservedQty2, TotalQuantity2, EarliestAvailDate2);
        ItemNo := ItemNo2; // BC Upgrade SHUKLP03 << Code added to assign ItemNo2 value to ItemNo because it is global variable in base object and in this codeunit also.
        Rollback := CreateAndSendNotificationUnrestr(UnitOfMeasureCode2, InventoryQty2,
            GrossReq2, ReservedReq2, SchedRcpt2, ReservedRcpt2,
            CurrentQuantity2, CurrentReservedQty2, TotalQuantity2, EarliestAvailDate2);
        //HEI.01>>
    end;

    procedure ShowNotificationDetailsUnrestr(AvailabilityCheckNotification: Notification)
    var
        ItemAvailabilityCheckSO: Page "Item Availability Check";
    begin
        //HEI.01<<
        ItemAvailabilityCheckSO.InitializeFromNotification(AvailabilityCheckNotification);
        ItemAvailabilityCheckSO.SetHeading(AvailabilityCheckNotification.MESSAGE);
        ItemAvailabilityCheckSO.RUNMODAL();
        //HEI.01>>
    end;

    LOCAL procedure CreateAndSendNotificationUnrestr(UnitOfMeasureCode: Code[20]; InventoryQty: Decimal; GrossReq: Decimal; ReservedReq: Decimal; SchedRcpt: Decimal; ReservedRcpt: Decimal; CurrentQuantity: Decimal; CurrentReservedQty: Decimal; TotalQuantity: Decimal; EarliestAvailDate: Date): Boolean
    var
        ItemAvailabilityCheckSO: Page "Item Availability Check - SO";
        AvailabilityCheckNotification: Notification;
        SalesSetup: Record "Sales & Receivables Setup";
        DetailsTxt: TextConst ENU = 'Details...', FRA = 'Détails...';
        NotificationMsg: TextConst Comment = '%1=Item No.', ENU = 'The available inventory for item %1 is lower than the entered quantity', FRA = 'Le stock disponible pour larticle %1 est inférieur à la quantité saisie';
    begin
        //HEI.01<<
        AvailabilityCheckNotification.ID(GetItemAvailabilityNotificationId());
        AvailabilityCheckNotification.MESSAGE(STRSUBSTNO(NotificationMsg, ItemNo));
        //HEI.02<<
        SalesSetup.GET();
        //>>HEI.03
        //IF SalesSetup."Item Avlblty Message Enable" THEN
        IF ((SalesSetup."Item Avlblty Msg Enable FND") AND (GUIALLOWED)) THEN
            //<<HEI.03
            MESSAGE(STRSUBSTNO(NotificationMsg, ItemNo));
        //HEI.02>> 
        AvailabilityCheckNotification.SCOPE(NOTIFICATIONSCOPE::LocalScope);
        AvailabilityCheckNotification.ADDACTION(DetailsTxt, CODEUNIT::"Item-Check Avail.", 'ShowNotificationDetailsUnrestr');
        ItemAvailabilityCheckSO.PopulateDataOnNotification(AvailabilityCheckNotification, ItemNo, UnitOfMeasureCode,
        InventoryQty, GrossReq, ReservedReq, SchedRcpt, ReservedRcpt, CurrentQuantity, CurrentReservedQty,
        TotalQuantity, EarliestAvailDate);
        AvailabilityCheckNotification.SEND();

        EXIT(FALSE);
        //HEI.01>>
    end;

    LOCAL procedure GetItemAvailabilityNotificationId(): GUID
    begin
        EXIT('2712AD06-C48B-4C20-820E-347A60C9AD00');
    end;

    [EventSubscriber(ObjectType::Codeunit, 311, OnSalesLineShowWarningOnBeforeShowWarning, '', false, false)]
    local procedure OnSalesLineShowWarningOnBeforeShowWarning(SalesLine: Record "Sales Line")
    begin
        //HEI.01<<
        // IF SalesLine."Document Type" = SalesLine."Document Type"::Order THEN
        //  UseOrderPromise := TRUE;
        IF SalesLine."Document Type" = SalesLine."Document Type"::Order THEN BEGIN
            UseOrderPromise := TRUE;
            IsInventoryCheckOnSalesOrder := TRUE;
        END;
        //HEI.01>>
    end;

    [EventSubscriber(ObjectType::Codeunit, 311, OnBeforeQtyAvailToPromise, '', false, false)]
    local procedure OnBeforeQtyAvailToPromise_311(var CompanyInfo: Record "Company Information"; var GrossReq: Decimal; var InventoryQty: Decimal; var IsHandled: Boolean; var Item: Record Item; var OldItemNetResChange: Decimal; var ReservedRcpt: Decimal; var ReservedReq: Decimal; var SchedRcpt: Decimal)
    var
        AvailableToPromise: Codeunit "Available to Promise";
    begin
        AvailableToPromise.CalcQtyAvailabletoPromise(
         Item, GrossReq, SchedRcpt, Item.GetRangeMax("Date Filter"),
         CompanyInfo."Check-Avail. Time Bucket", CompanyInfo."Check-Avail. Period Calc.");
        InventoryQty := ConvertQty(AvailableToPromise.CalcAvailableInventory(Item) - OldItemNetResChange);
        //HEI.01<<
        IF IsInventoryCheckOnSalesOrder THEN BEGIN
            Item.CALCFIELDS("Uavailable Inv. (Whse) FND");
            //IF Item."Uavailable Inv. (Whse)" > 0 THEN
            InventoryQty := InventoryQty - ConvertQty(Item."Uavailable Inv. (Whse) FND");
        END;
        //HEI.01>> //BC Upgrade SHUKLP03 << OnBeforeQtyAvailToPromise event is called for because no event is found to add HEI code, so called OnBeforeQtyAvailToPromise event added whole code of that function where this event is called and made IsHandle boolean true.

        GrossReq := ConvertQty(GrossReq);
        ReservedReq := ConvertQty(AvailableToPromise.CalcReservedRequirement(Item) + OldItemNetResChange);
        SchedRcpt := ConvertQty(SchedRcpt);
        ReservedRcpt := ConvertQty(AvailableToPromise.CalcReservedReceipt(Item));
        IsHandled := true;
    end;

    local procedure ConvertQty(Qty: Decimal) Result: Decimal
    var
        UOMMgt: Codeunit "Unit of Measure Management";
    begin
        if QtyPerUnitOfMeasure = 0 then
            QtyPerUnitOfMeasure := 1;
        Result := Round(Qty / QtyPerUnitOfMeasure, UOMMgt.QtyRndPrecision());
        OnAfterConvertQty(ItemNo, Qty, QtyPerUnitOfMeasure, Result);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterConvertQty(ItemNo: Code[20]; Qty: Decimal; var QtyPerUnitOfMeasure: Decimal; var Result: Decimal)
    begin
    end;
    // BC Upgrade SHUKLP03 << 311 Codeunit
    // BC Upgrade BHARDA11 >> --- This code was written inside the CreateConsumpJnlLine function of the “Calc. Consumption” report.
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt
    [EventSubscriber(ObjectType::Report, Report::"Calc. Consumption", OnBeforeInsertItemJnlLine, '', false, false)]
    local procedure OnBeforeInsertItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; ProdOrderComponent: Record "Prod. Order Component")
    var
        Bin: Record Bin;
    begin
        //HEI.01 PRDGAP024>>
        IF ItemJournalLine."Bin Code" <> '' THEN BEGIN
            Bin.GET(ItemJournalLine."Location Code", ItemJournalLine."Bin Code");
            ItemJournalLine."Zone Code FND" := Bin."Zone Code";
        END;
        //HEI.01 PRDGAP024<<
    end;

    // BC Upgrade BHARDA11 << ----This code was written inside the CreateConsumpJnlLine function of the “Calc. Consumption” report.

    //BC UPGRADE SIVA >> Moved procedure from 50015 General app "Heineken Global to "53000 "Heineken BC Upgrade MTC""

    //1.Activation of Procedure (InsertRPMCustomerDifferences) from Sales Return order & Sales Return Order subform under action is Customer Differences (RPM)  

    // HEI.05 RPM Breakages IBM ISYED01 03.11.2019 # Rwanda

    //     # added code for creating reco for RPM breakages.



    //BC UPGRADE SIVA >> SalesReturnOrder_PageAction_CustomerDifferences(RPM)
    procedure InsertRPMCustomerDifferences(var Rec: Record "Sales Line");
    var
        salesheader: Record "Sales Header";
        CustomerDifferencesRPM: Record "Customer Differences RPM FND";
        Item: Record Item;
        LastLineNo: Integer;
        salesline: Record "Sales Line";
        CustomerDifferencesRPMPage: Page "Customer Differences (RPM) CBN";
        //DrinkDepositGroup : Record "Drink Deposit Group";
        PostedCustomerDiffRPM: Record "Posted Customer Diff RPM FND";
        //SalesDepositItemCharge : Record "Sales Deposit Item Charge";
        SalesLine1: Record "Sales Line";
        SalesHeader1: Record "Sales Header";
        CustomerDifferencesRPM1: Record "Customer Differences RPM FND";
        LineNo: Boolean;
        SalesLine2: Record "Sales Line";
        Customer1: Record Customer;
        Text005: Label 'Cust Diff RPM has already created and Posted for the document %1.';
    begin
        //HEI.47>>
        PostedCustomerDiffRPM.SETFILTER("Sales return order no.", Rec."Document No.");
        if PostedCustomerDiffRPM.FINDFIRST() then begin
            //<<HEI.96
            if GUIALLOWED then
                //>>HEI.96
                MESSAGE(Text005, Rec."Document No.");
            exit;
        end;

        //HEI.66>>
        salesheader.SETRANGE("No.", Rec."Document No.");
        salesheader.SETFILTER("Document Type", '%1', salesheader."Document Type"::"Return Order");
        if salesheader.FINDFIRST() then
            if Rec."Document Type" = Rec."Document Type"::"Return Order" then begin
                salesline.SETFILTER("Document No.", Rec."Document No.");
                salesline.SETFILTER("Document Type", '%1', salesline."Document Type"::"Return Order");
                if salesline.findset() then
                    repeat
                        if salesline.Type = salesline.Type::Item then begin
                            if Item.GET(salesline."No.") then
                                if Item."Replenishment System" <> Item."Replenishment System"::Assembly then begin
                                    CLEAR(LineNo);
                                    CustomerDifferencesRPM.RESET();
                                    if CustomerDifferencesRPM.FINDLAST() then begin
                                        LastLineNo := CustomerDifferencesRPM."Line No.";
                                        LastLineNo := LastLineNo + 10000;
                                    end else
                                        LastLineNo := LastLineNo + 10000;

                                    CustomerDifferencesRPM.SETRANGE("Item No.", salesline."No.");
                                    CustomerDifferencesRPM.SETRANGE("Sales return order no.", salesline."Document No.");
                                    CustomerDifferencesRPM.SETRANGE("Line No.", salesline."Line No.");
                                    if not CustomerDifferencesRPM.FINDFIRST() then begin
                                        CustomerDifferencesRPM.INIT();
                                        CustomerDifferencesRPM."Sales return order no." := salesline."Document No.";
                                        CustomerDifferencesRPM."Sell-to customer no." := salesline."Sell-to Customer No.";
                                        CustomerDifferencesRPM."Sell-to Customer Name" := salesheader."Sell-to Customer Name";
                                        CustomerDifferencesRPM."Bill-to Customer No." := salesline."Bill-to Customer No.";
                                        CustomerDifferencesRPM."Bill-to Customer name" := salesheader."Bill-to Name";
                                        CustomerDifferencesRPM."Line No." := salesline."Line No.";
                                        CustomerDifferencesRPM."Item No." := salesline."No.";

                                        if Customer1.GET(Rec."Sell-to Customer No.") then
                                            CustomerDifferencesRPM."Compensation RPM Diff." := Customer1."Compensate RPM Differences FND";

                                        if Item.GET(salesline."No.") then begin
                                            CustomerDifferencesRPM."Item Description" := Item.Description;
                                            CustomerDifferencesRPM."UOM Code" := Item."Sales Unit of Measure";
                                        end;

                                        CustomerDifferencesRPM.INSERT();
                                    end;
                                end;
                        end else if (salesline.Type = salesline.Type::"Charge (Item)") then begin
                            //and (salesline."Item Charge Type" = salesline."Item Charge Type"::Deposit) then begin // Drink IT fieldItem Charge Type
                            CustomerDifferencesRPM.SETRANGE("Sales return order no.", salesline."Document No.");
                            CustomerDifferencesRPM.SETRANGE("Line No.", salesline."Attached to Line No.");
                            if CustomerDifferencesRPM.FINDFIRST() then begin
                                if LineNo = false then
                                    CustomerDifferencesRPM."Deposit Price" := salesline."Unit Price"
                                else
                                    CustomerDifferencesRPM."Deposit Price" := 0;
                                CustomerDifferencesRPM.MODIFY();
                                LineNo := true;
                            end;
                        end;
                    until salesline.NEXT() = 0;

            end;
        //HEI.66<<
        CustomerDifferencesRPM.RESET();
        CustomerDifferencesRPM.SETRANGE("Sales return order no.", salesheader."No.");
        if CustomerDifferencesRPM.FINDFIRST() then begin
            CustomerDifferencesRPMPage.SETTABLEVIEW(CustomerDifferencesRPM);
            CustomerDifferencesRPMPage.SETRECORD(CustomerDifferencesRPM);
            CustomerDifferencesRPMPage.RUN();
        end
        else begin
            CustomerDifferencesRPMPage.SETTABLEVIEW(CustomerDifferencesRPM);
            CustomerDifferencesRPMPage.RUN();
        end;
        //HEI.47<<
    end;
    //BC UPGRADE SIVA << SalesReturnOrder_PageAction_CustomerDifferences(RPM)

    //BC UPGRADE SIVA 103 >>
    // DITW15.00.00.01 DDR 19/03/2008 added function UpdateValueEntry()
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW17.00.01 DDR 22/11/2012 DIT-770 #001 Modified 'Permissions' property Codeunit
    //                                            Modified function UpdateValueEntry()
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   HEI.02 IBM PATHAA02-# To edit the comment field on page 25

    //1.Subscribed event OnBeforeCustLedgEntryModify in Codeunit _"Cust. Entry-Edit" for update comment field.

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cust. Entry-Edit", OnBeforeCustLedgEntryModify, '', false, false)]
    local procedure OnBeforeCustLedgEntryModify(var CustLedgEntry: Record "Cust. Ledger Entry"; FromCustLedgEntry: Record "Cust. Ledger Entry")
    begin
        CustLedgEntry."Comment FND" := FromCustLedgEntry."Comment FND";//HEI.02
    end;
    //BC UPGRADE SIVA 103 <<

    //BC Upgrade VAMSIU01 - Report 295 >>
    // # Added Document Subtype code
    [EventSubscriber(ObjectType::Report, Report::"Combine Shipments", OnBeforeSalesInvHeaderModify, '', false, false)]
    local procedure "Combine Shipments_OnBeforeSalesInvHeaderModify"(var SalesHeader: Record "Sales Header"; SalesOrderHeader: Record "Sales Header")
    begin
        SalesHeader.Validate("Document Subtype Code FND", SalesOrderHeader."Document Subtype Code FND");
    end;
    //BC Upgrade VAMSIU01 - Report 295 <<

    //BC Upgrade VAMSIU01 - Report 6653 >>
    // # Added Document Subtype code
    [EventSubscriber(ObjectType::Report, Report::"Combine Return Receipts", OnBeforeSalesCrMemoHeaderModify, '', false, false)]
    local procedure "Combine Return Receipts_OnBeforeSalesCrMemoHeaderModify"(var SalesHeader: Record "Sales Header"; SalesOrderHeader: Record "Sales Header")
    begin
        SalesHeader.Validate("Document Subtype Code FND", SalesOrderHeader."Document Subtype Code FND");
    end;
    //BC Upgrade VAMSIU01 - Report 6653 <<

    // BC Upgrade SHUKLP03 >> Page 132 Posted sales invoice
    // OTC008 Testscript changes
    // Added subscribed event for OnBeforeSalesInvHeaderPrintRecords event of Posted Sales Invoice page to handle the print logic.

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Invoice", OnBeforeSalesInvHeaderPrintRecords, '', false, false)]
    local procedure OnBeforeSalesInvHeaderPrintRecords(var IsHandled: Boolean; var SalesInvHeader: Record "Sales Invoice Header")
    var
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
        xPrintCountL: Integer;
        PrintCountL: Integer;
        DocumentTypeL: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";
        AutomationUtilityL: Codeunit "Automation Utility";
        SalesSetup: Record "Sales & Receivables Setup";
        CompanyInfoRec: Record "Company Information";
    begin
        //HEI.09>>
        xPrintCountL := SalesInvHeader."No. Printed";
        //HEI.09<<
        //HEI.11 >>
        //SalesSetup.RESET;
        SalesSetup.GET;
        //CompanyInfoRec.RESET;
        CompanyInfoRec.GET;
        IF SalesSetup."Export Invoice FND" = TRUE THEN BEGIN
            IF CompanyInfoRec."Country/Region Code" <> SalesInvHeader."Ship-to Country/Region Code" THEN
                REPORT.RUNMODAL(Report::"Sales Inv Export Burundi CBN", TRUE, TRUE, SalesInvHeader)
            ELSE IF CompanyInfoRec."Country/Region Code" = SalesInvHeader."Ship-to Country/Region Code" THEN
                SalesInvHeader.PrintRecords(TRUE)
            ELSE IF CompanyInfoRec."Country/Region Code" = '' THEN
                SalesInvHeader.PrintRecords(TRUE);
        END ELSE
            SalesInvHeader.PrintRecords(TRUE);
        //HEI.11 <<
        //HEI.09>>
        SalesInvoiceHeaderL.GET(SalesInvHeader."No.");
        PrintCountL := SalesInvoiceHeaderL."No. Printed";
        IF PrintCountL > xPrintCountL THEN BEGIN
            AutomationUtilityL.UpdateJQEntryAfterManualPrint(DocumentTypeL::Order, SalesInvoiceHeaderL."Order No.",
              SalesInvoiceHeaderL."No.", xPrintCountL, PrintCountL);
        END;
        //HEI.09<<
        IsHandled := TRUE;
    end;
    // BC Upgrade SHUKLP03 << Page 132 Posted sales invoice

    // BC Upgrade SHUKLP03 >> Page 143 Posted sales invoices
    // Added subscribed event for OnPrintActionOnBeforePrintRecords event of Posted Sales Invoice page to handle the print logic.

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Invoices", OnPrintActionOnBeforePrintRecords, '', false, false)]
    local procedure OnPrintActionOnBeforePrintRecords(var IsHandled: Boolean; var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        //SalesInvHeader: Record "Sales Invoice Header";
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
        xPrintCountL: Integer;
        PrintCountL: Integer;
        DocumentTypeL: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";
        AutomationUtilityL: Codeunit "Automation Utility";
        salesSetup: Record "Sales & Receivables Setup";
        CompanyInfoRec: Record "Company Information";
    begin
        //HEI.09>>
        xPrintCountL := SalesInvoiceHeader."No. Printed";
        //HEI.09<<
        //HEI.10 >>
        //HEI.10 >>
        SalesSetup.RESET;
        SalesSetup.GET;
        CompanyInfoRec.RESET;
        CompanyInfoRec.GET;
        IF SalesSetup."Export Invoice FND" = TRUE THEN BEGIN
            IF CompanyInfoRec."Country/Region Code" <> SalesInvoiceHeader."Ship-to Country/Region Code" THEN
                REPORT.RUNMODAL(Report::"Sales Inv Export Burundi CBN", TRUE, TRUE, SalesInvoiceHeader)
            ELSE IF CompanyInfoRec."Country/Region Code" = SalesInvoiceHeader."Ship-to Country/Region Code" THEN
                SalesInvoiceHeader.PrintRecords(TRUE)
            ELSE IF CompanyInfoRec."Country/Region Code" = '' THEN
                SalesInvoiceHeader.PrintRecords(TRUE);
        END ELSE
            SalesInvoiceHeader.PrintRecords(TRUE);
        //HEI.10 <<

        //SalesInvHeader.PrintRecords(TRUE);//HEi.10

        //HEI.09>>
        SalesInvoiceHeaderL.GET(SalesInvoiceHeader."No.");
        PrintCountL := SalesInvoiceHeaderL."No. Printed";
        IF PrintCountL > xPrintCountL THEN BEGIN
            AutomationUtilityL.UpdateJQEntryAfterManualPrint(DocumentTypeL::Order, SalesInvoiceHeaderL."Order No.",
              SalesInvoiceHeaderL."No.", xPrintCountL, PrintCountL);
        END;
        //HEI.09<<
        IsHandled := TRUE;
    end;

    // BC Upgrade SHUKLP03 << Page 143 Posted sales invoices

    //POENAB02, 04.08.2026, BCUP0-219>>
    //Added a condition on Document Subtype. There was an issue where the email was being sent for the wrong document subtype. 
    //This event subscriber checks if the document subtype of the posted sales invoice header matches the document subtype of the report selection before sending the email. 
    //If they do not match, it sets IsHandled to true, preventing the email from being sent. Initial error was for report 53012 "Sales Invoice - Export STD".
    [EventSubscriber(ObjectType::Table, Database::"Report Selections", OnSendEmailDirectlyOnBeforeSendSingleFile, '', false, false)]
    local procedure OnSendEmailDirectlyOnBeforeSendSingleFile(ReportUsage: Enum "Report Selection Usage"; RecordVariant: Variant; DocNo: Code[20]; var DocName: Text[150]; var DefaultEmailAddress: Text[250]; ShowDialog: Boolean; var TempAttachReportSelections: Record "Report Selections" temporary; var CustomReportSelection: Record "Custom Report Selection"; var IsHandled: Boolean; var EmailBody: Codeunit "Temp Blob")
    var
        PostedSalesInvHeader: Record "Sales Invoice Header";
    begin
        if PostedSalesInvHeader.GET(DocNo) then
            if PostedSalesInvHeader."Document Subtype Code FND" <> TempAttachReportSelections."Document Subtype Code FND" then
                IsHandled := true;
    end;
    //POENAB02, 04.08.2026, BCUP0-219<<

    var
        UseOrderPromise: Boolean;	// BC Upgrade SHUKLP03 << CodeUnit 311
        IsInventoryCheckOnSalesOrder: Boolean;	// BC Upgrade SHUKLP03 << CodeUnit 311
        QtyPerUnitOfMeasure: Decimal;// BC Upgrade SHUKLP03 << CodeUnit 311
        ItemNo: Code[20];// BC Upgrade SHUKLP03 << CodeUnit 311

}
