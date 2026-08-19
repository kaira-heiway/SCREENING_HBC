namespace ALProject.ALProject;
using Microsoft.Sales.Customer;
using Microsoft.Projects.Project.Journal;
using Microsoft.Sales.Setup;
using Microsoft.Foundation.Company;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Posting;
using System.Threading;
using Microsoft.FixedAssets.Journal;
using Microsoft.Foundation.Enums;
using Microsoft.FixedAssets.Posting;
using Microsoft.Finance.Analysis;
using Microsoft.CRM.Contact;
using Microsoft.Foundation.Period;
using Microsoft.Foundation.Reporting;
using Microsoft.Foundation.NoSeries;
using Microsoft.Finance.FinancialReports;
using Microsoft.Inventory.Transfer;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Analysis;
using Microsoft.HumanResources.Payables;
using Microsoft.Bank.Payment;
using Microsoft.Bank.DirectDebit;
using Microsoft.Inventory.Posting;
using Microsoft.Sales.Document;
using System.Text;
using Microsoft.Manufacturing.WorkCenter;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Finance.VAT.Setup;
using Microsoft.Inventory.Journal;
using Microsoft.Warehouse.Request;
using Microsoft.Warehouse.Structure;
using System.IO;
using Microsoft.Manufacturing.Document;
using Microsoft.Purchases.Payables;
using Microsoft.Finance.GeneralLedger.Setup;
using System.Environment;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Ledger;
using Microsoft.Purchases.Vendor;
using Microsoft.Assembly.Posting;
using Microsoft.EServices.EDocument;
using System.Environment.Configuration;
using Heineken_BC_Upgrade.Heineken_BC_Upgrade;
using Microsoft.Bank.Check;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.Inventory.Requisition;
using System.Telemetry;
using System.Automation;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Warehouse.Ledger;
using Microsoft.Manufacturing.Journal;
using Microsoft.Foundation.Navigate;
using Microsoft.Finance.GeneralLedger.Preview;
using Microsoft.Manufacturing.Capacity;
using Microsoft.Finance.Deferral;
using Microsoft.Finance.GeneralLedger.Reversal;
using Microsoft.Sales.Reminder;
using Microsoft.Warehouse.Setup;
using Microsoft.Warehouse.Journal;
using Microsoft.Projects.Project.Job;
using Microsoft.Inventory.Item.Attribute;
using Microsoft.Purchases.Comment;
using System.Security.User;
using Microsoft.Purchases.Archive;
using Microsoft.Foundation.Address;
using Microsoft.Utilities;
using Microsoft.Assembly.Document;
using Microsoft.Inventory.Availability;
using System.Utilities;
using Microsoft.Inventory.Setup;
using Microsoft.Finance.VAT.Ledger;
using Microsoft.Manufacturing.Routing;
using System.Reflection;
using Microsoft.HumanResources.Employee;
using Microsoft.CRM.Campaign;
using Microsoft.CRM.Team;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Intercompany.BankAccount;
using Microsoft.Intercompany.GLAccount;
using Microsoft.Intercompany.Partner;
using Microsoft.Finance.ReceivablesPayables;
using Microsoft.Purchases.Posting;
using Microsoft.Finance.GeneralLedger.Budget;
using Microsoft.Bank.Ledger;
using Microsoft.Sales.Receivables;
using Microsoft.Inventory.Counting.Journal;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.CostAccounting.Setup;
using Microsoft.CostAccounting.Account;
using Microsoft.Bank.BankAccount;
using Microsoft.Bank.Reconciliation;
using Microsoft.Purchases.History;
using Microsoft.Warehouse.Document;
using Microsoft.Sales.History;
using Microsoft.Warehouse.History;
using Microsoft.Warehouse.Reports;
using Microsoft.Inventory.BOM.Tree;
using Microsoft.Inventory.Costing;
using Microsoft.Inventory.BOM;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Foundation.UOM;
using Microsoft.Finance.Currency;
using Microsoft.Inventory;
using Microsoft.Finance.Dimension;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Warehouse.Activity;
using Microsoft.Inventory.Tracking;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.FixedAssets.Ledger;
using System.Xml;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Purchases.Setup;
using Microsoft.Finance.VAT.Calculation;
using Microsoft.Manufacturing.Setup;
//Bc Upgrade YADAVM09 Drink it dependency event Blocked OnAfterSetBookValueFiltersOnFALedgerEntry,OnAfterCreateTypes for table (FA Matrix Posting Type),OnMATRIX_OnDrillDownOnCaseElse.
//Bc Upgrade YADAVM09 Code blocked in event OnAfterCreateTypes and Function SuggestAssgnt3.
//BC Upgrade SHARMP16 event blocked OnAfterUpdateAmounts and restructured the code using the event OnBeforeUpdateLineAmount
//BC UPGRADE KUMARR78 Adding Check Managment Events and Functions.
// BC UPGRADE SHIKHD02 >>
// 1. Migrated HEI.01 from NAV CU 240 "ItemJnlManagement" to BC by subscribing to OnOpenJnlBatchOnBeforeCaseSelectItemJnlTemplate.
// 2. Migrated HEI.02 from NAV CU 240 "ItemJnlManagement" to BC by subscribing to OnBeforeOnOpenPage.
// BC UPGRADE SHIKHD02 <<
//BC Upgrade RD03 an additional standard parameter has been introduced in Business Central 'InsertNotificationArgument'. 
//BC UPGRADE ATHUKS01 Added new code for update payment staus FND in VLE
// BC Upgrade RD03 - the below EventSubscriber moved to DTW extension

// BC Upgrade SHUKLP03 >> Added OTC008 testscript changes.
// BC Upgrade RD03 - Assigning value to VersionCode variable
//Bc Upgrade YADAVM09 Bug Fix BCUP0-167.
// BC UPGRADE GUPTAK03 WHT Reversal Entry
// BC UPGRADE GUPTAK03 WHT Related -->>
// RD03 - added setrange


codeunit 50280 "Heineken BC Upgrade"
{
    Permissions = tabledata "Approval Entry" = RIMD,//BC Upgrade SHARMP16 PurchProcesschanges
    tabledata "Bank Account Ledger Entry" = rimd,
    tabledata "Check Ledger Entry" = rimd,
    tabledata "Cust. Ledger Entry" = rimd,
    tabledata "Vendor Ledger Entry" = rimd,
    tabledata "Employee Ledger Entry" = rimd,
    tabledata "Dimension Set Entry" = RIM;//BC Upgrade SHARMP16 GAPFitchanges

    trigger OnRun()
    begin
        //BC Upgrade Kamnay01 >> Code commented
        //BC Upgrade Gunrem01 >> Item availability by BOM level
        // Enable lightweight BOM re-entry tracing for diagnosis
        // EnableHeinekenBOMTrace := TRUE;
        // IF MaxBOMDepth = 0 THEN
        //     MaxBOMDepth := 100;
        //BC Upgrade Gunrem01 << Item availability by BOM level
        //BC Upgrade Kamnay01 << Code commented
    end;

    // BC Upgrade NANDIS03 >>
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterUpdateDocumentTypeAndAppliesToFields, '', false, false)]
    local procedure OnAfterUpdateDocumentTypeAndAppliesToFields(var GenJournalLine: Record "Gen. Journal Line")
    var
        GenLedgerSetup: Record "General Ledger Setup";
        WHTEntry: Record "WHT Entry FND";
        VendLedgEntry: Record "Vendor Ledger Entry";
        WHTPostingSetup: Record "WHT Posting Setup FND";
    begin
        //HEI.34>>
        GenJournalLine."WHT Business Posting Group FND" := '';
        GenJournalLine."WHT Product Posting Group FND" := '';
        GenLedgerSetup.GET();
        IF GenLedgerSetup."Enable WHT FND" THEN
            IF GenJournalLine."Document Type" = GenJournalLine."Document Type"::Payment THEN BEGIN
                WHTEntry.RESET();
                WHTEntry.SETCURRENTKEY("Document Type", "Document No.");
                WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Invoice);
                WHTEntry.SETRANGE("Document No.", VendLedgEntry."Document No.");
                IF WHTEntry.FINDFIRST() THEN BEGIN
                    IF WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group") THEN
                        //HEI.35 IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
                        GenJournalLine.VALIDATE("WHT Business Posting Group FND", WHTEntry."WHT Bus. Posting Group");
                    GenJournalLine.VALIDATE("WHT Product Posting Group FND", WHTEntry."WHT Prod. Posting Group");
                    //HEI.35 END;
                END;
            END;
        //HEI.34<<
    end;
    // BC Upgrade NANDIS03 <<

    // Bc Upgrade SHARMP16 >>
    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", OnAfterCopyVendLedgerEntryFromGenJnlLine, '', false, false)]
    local procedure CopyFromGenJnlLineVLE(GenJournalLine: Record "Gen. Journal Line"; var VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        //HEI.10 >>
        GenJournalLine."Payment Status FND" := GenJournalLine."Payment Status FND";
        //HEI.10<<
        GenJournalLine."Fixed Asset Acquisition FND" := GenJournalLine."Fixed Asset Acquisition FND"; //HEI.16
        // FinancialUtils.OnAfterCopyVendLedgerEntryFromGenJnlLine(VendorLedgerEntry, GenJournalLine);//HEI.01 PTPGAP066 new line //BC Upgrade SHARMP16 Commented Code because this CU will handled differently.
        VendorLedgerEntry."Payment Status FND" := GenJournalLine."Payment Status FND";//BC ATHUKS01  
        VendorLedgerEntry."Document Subtype Code FND" := GenJournalLine."Document Subtype Code FND"; // BC Upgrade SHUKLP03 << Added document subtype code.

    end;
    //BC Upgrade SHARMP16 <<

    // BC Upgrade NANDIS03 >>
    [EventSubscriber(ObjectType::Table, Database::"Job Queue Entry", OnBeforeInsertLogEntry, '', false, false)]

    local procedure OnBeforeInsertLogEntry(var JobQueueLogEntry: Record "Job Queue Log Entry"; var JobQueueEntry: Record "Job Queue Entry")
    var
        SalesReceivablesSetupL: Record "Sales & Receivables Setup";
    begin
        //HEI.02>>
        SalesReceivablesSetupL.GET();
        IF SalesReceivablesSetupL."Enable OTC Billing Auto. FND" THEN BEGIN
            IF (JobQueueLogEntry."Object Type to Run" = JobQueueLogEntry."Object Type to Run"::Codeunit) AND
              (JobQueueLogEntry."Object ID to Run" = CODEUNIT::"Sales Post via Job Queue") THEN BEGIN
                SalesReceivablesSetupL.TESTFIELD("Post with Job Queue", FALSE);
                JobQueueLogEntry."Send Document FND" := JobQueueEntry."Send Document FND";
                JobQueueLogEntry."Document Type FND" := JobQueueEntry."Document Type FND";
                JobQueueLogEntry."Document No. FND" := JobQueueEntry."Document No. FND";
                JobQueueLogEntry."JQ Posted FND" := JobQueueEntry."JQ Posted FND";
                JobQueueLogEntry."JQ Mail Sent FND" := JobQueueEntry."JQ Mail Sent FND";
                JobQueueLogEntry."JQ Printed FND" := JobQueueEntry."JQ Printed FND";
                JobQueueLogEntry."Posted Document No. FND" := JobQueueEntry."Posted Document No. FND";
                JobQueueLogEntry."JQ Logistics Mail Sent FND" := JobQueueEntry."JQ Logistics Mail Sent FND";
            END;
        END;
        //HEI.02<<
        //HEI.05 //HEI.06
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Queue Entry", OnBeforeModifyLogEntry, '', false, false)]
    procedure OnBeforeModifyLogEntry(var JobQueueLogEntry: Record "Job Queue Log Entry"; var JobQueueEntry: Record "Job Queue Entry")
    var
        SalesReceivablesSetupL: Record "Sales & Receivables Setup";
        AutomationUtilityL: Codeunit "Automation Utility";
    begin
        SalesReceivablesSetupL.GET();
        IF SalesReceivablesSetupL."Enable OTC Billing Auto. FND" THEN BEGIN
            IF (JobQueueLogEntry."Object Type to Run" = JobQueueLogEntry."Object Type to Run"::Codeunit) AND
              (JobQueueLogEntry."Object ID to Run" = CODEUNIT::"Sales Post via Job Queue") THEN BEGIN
                SalesReceivablesSetupL.TESTFIELD("Post with Job Queue", FALSE);
                CLEAR(AutomationUtilityL);
                IF JobQueueEntry."JQ Posted FND" THEN
                    JobQueueLogEntry."JQ Posted FND" := JobQueueEntry."JQ Posted FND";
                JobQueueLogEntry."JQ Logistics Mail Sent FND" := JobQueueEntry."JQ Logistics Mail Sent FND"; //BC Upgrade SHUKLP03 << OTC008
                IF (JobQueueLogEntry."Posted Document No. FND" = '') AND JobQueueEntry."JQ Posted FND" THEN
                    JobQueueLogEntry."Posted Document No. FND" :=
                      AutomationUtilityL.GetPostedDocumentNoForUpdate(JobQueueEntry."Document Type FND", JobQueueEntry."Document No. FND");
            END;
        END;
    END;
    //HEI.02<<
    [EventSubscriber(ObjectType::Table, Database::"Job Queue Entry", OnBeforeClearServiceValues, '', false, false)]
    procedure OnBeforeClearServiceValues(var JobQueueEntry: Record "Job Queue Entry")
    var
        TempSessionID: Integer;
        TempTenantID: Text;
        TempServerInstanceName: Text;
        TempServerName: Text;
        recActiveSessions: Record "Active Session";
    begin
        //HEI.07>>
        CLEAR(TempSessionID);
        TempSessionID := JobQueueEntry."User Session ID";
        //HEI.08>>
        TempServerInstanceName := JobQueueEntry."JOB ServiceInstanceName FND";
        TempServerName := JobQueueEntry."JOB Server Name FND";
        TempTenantID := JobQueueEntry."JOB TenantID FND";
        //HEI.08<<
        IF (JobQueueEntry.Status = JobQueueEntry.Status::"In Process") THEN BEGIN
            recActiveSessions.SETRANGE("Session ID", TempSessionID);
            recActiveSessions.SETRANGE("Client Type", recActiveSessions."Client Type"::Background);
            IF recActiveSessions.FINDFIRST() THEN BEGIN
                IF TASKSCHEDULER.TASKEXISTS(JobQueueEntry."System Task ID") THEN BEGIN
                    TASKSCHEDULER.CANCELTASK(JobQueueEntry."System Task ID");
                END;
                //STOPSESSION(TempSessionID);//HEI.08>>
                //JobQueueEntry.StopSessionPS(TempTenantID, FORMAT(TempSessionID), TempServerInstanceName, TempServerName);//HEI.08  // BC Upgrade NANDIS03 - Blocked due to dotnet variables
            END;
        END;
        //HEI.07<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", OnAfterSummEntryNo, '', false, false)]
    procedure OnAfterSummEntryNo(ReservationEntry: Record "Reservation Entry"; var ReturnValue: Integer)
    begin
        // case ReservationEntry."Source Type" of
        //     DATABASE::"Warehouse Activity Line":
    end;
    // BC Upgrade NANDIS03 <<

    //BC Upgrade KAPOOV01 >>
    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnAfterCopyGLEntryFromGenJnlLine, '', false, false)]
    local procedure OnAfterCopyGLEntryFromGenJnlLineSubscriber(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    begin
        GLEntry."Journal Template Name FND" := GenJournalLine."Journal Template Name";//HEI.26"Journal Template Name":= GenJnlLine."Journal Template Name";//HEI.26
        //HEI.01>>
        GLEntry."CV Detailed Entry No. FND" := GenJournalLine."CV Detailed Entry No. FND";
        GLEntry."Adj. Exchange Rate Type FND" := GenJournalLine."Adj. Exchange Rate Type FND";
        GLEntry."Related Sales Order No. FND" := GenJournalLine."Related Sales Order FND"; //HEI.17
        //HEI.01<<
        //HEI.18>>
        GLEntry."Additional Description FND" := GenJournalLine."Additional Description FND";
        //HEI.18<< 
        GLEntry."Maison des Vins Value Code FND" := GenJournalLine."Maison des Vins Value Code FND"; //HEI.19
                                                                                                     // GLEntry."H&S Levy Tax Amount FND" := GenJournalLine."H&S Levy Tax Amount FND";//HEI.25//Bc Upgrade YADAVM09 code added in Levy custom codeunit<<
    end;
    //BC Upgrade KAPOOV01 <<

    /* //Bc Upgrade YADAVM09 Drink it field dependency commented>>
   //BC Upgrade KAPOOV01 >>
   [EventSubscriber(ObjectType::Table, Database::"FA Depreciation Book", OnAfterSetBookValueFiltersOnFALedgerEntry, '', false, false)]
   local procedure OnAfterSetBookValueFiltersOnFALedgerEntrySubscriber(var FALedgerEntry: Record "FA Ledger Entry")
   var
       CompanyInfo: Record "Company Information";
   begin
       //HEI.02>>
       CompanyInfo.GET;
       IF CompanyInfo."Enable French Localization" THEN
           FALedgerEntry.SETRANGE("Exclude Derogatory", FALSE);
       //HEI.02<<
   end;
   //BC Upgrade KAPOOV01 <<
    */ //Bc Upgrade YADAVM09 Drink it field dependency commented<<

    //BC Upgrade PATHAA02>>--->Tab-Ext52528.ProductionOrder/T5405->Func.GetDefaultBin-HEI.01

    [EventSubscriber(ObjectType::Table, Database::"Production Order", OnGetDefaultBinOnBeforeThirdPrioritySetBinCode, '', false, false)]
    local procedure "Production Order_OnGetDefaultBinOnBeforeThirdPrioritySetBinCode"(var ProductionOrder: Record "Production Order"; xProductionOrder: Record "Production Order"; var IsHandled: Boolean)
    var
        Bin: Record Bin;
    begin
        IsHandled := true;// HEI.05 -to miss the code below the event in Standard
        //HEI.01 PRDGAP024>>
        IF ProductionOrder."Bin Code" <> '' THEN BEGIN
            IF Bin.GET(ProductionOrder."Location Code", ProductionOrder."Bin Code") THEN
                ProductionOrder."Zone Code FND" := Bin."Zone Code";
        END;
        //HEI.01 PRDGAP024<<
    end;
    //BC Upgrade PATHAA02<<

    //BC Upgrade PATHAA02>>--->Tab-Ext52528.ProductionOrder/T5405->HEI.08
    [EventSubscriber(ObjectType::Table, Database::"Production Order", OnAfterInitRecord, '', false, false)]
    local procedure "Production Order_OnAfterInitRecord"(var ProductionOrder: Record "Production Order")
    begin
        ProductionOrder."Created By FND" := UserId; //HEI.08
    end;
    //BC Upgrade PATHAA02<<


    //BC Upgrade PATHAA02>>--->Tab-Ext52528.ProductionOrder/T5405->HEI.12
    [EventSubscriber(ObjectType::Table, Database::"Production Order", OnBeforeAssignItemNo, '', false, false)]
    local procedure "Production Order_OnBeforeAssignItemNo"(var ProdOrder: Record "Production Order"; xProdOrder: Record "Production Order"; var Item: Record Item; CallingFieldNo: Integer)
    var
        ProdOrderLineL: Record "Prod. Order Line";

        UOMMgt: Codeunit "Unit of Measure Management";
        Text000L: Label 'Item No. - %1 already exists in the Line. Would you like to delete the Line to change the Source No. - %2?';
    begin
        //  DITW110.00.11 SFI BL#30569
        Item.BlockedSKU(ProdOrder."Location Code", '', TRUE);
        //  DITW110.00.11 SFI BL#30569

        IF (ProdOrder.Status IN [ProdOrder.Status::Planned, ProdOrder.Status::"Firm Planned", ProdOrder.Status::Released]) AND (CallingFieldNo <> 0) THEN BEGIN
            IF (ProdOrder."Source No." <> xProdOrder."Source No.") AND (ProdOrder."Source No." <> '') THEN BEGIN
                ProdOrderLineL.SETCURRENTKEY(Status, "Prod. Order No.", "Item No.");
                ProdOrderLineL.SETRANGE(Status, ProdOrder.Status);
                ProdOrderLineL.SETRANGE("Prod. Order No.", ProdOrder."No.");
                ProdOrderLineL.SETRANGE("Item No.", xProdOrder."Source No.");
                IF ProdOrderLineL.FINDFIRST() THEN BEGIN
                    IF NOT CONFIRM(Text000L, FALSE, ProdOrderLineL."Item No.", ProdOrder."Source No.") THEN
                        ERROR('')
                    ELSE
                        ProdOrderLineL.DELETE(TRUE);
                END;
            END;
        end;
        //BC Upgrade Kamnay01>> DITW code 
        ProdOrder."Unit of Measure Code FND" := Item."Production Unit of Measure FND";
        ProdOrder."Qty. per Unit of Measure FND" := UOMMgt.GetQtyPerUnitOfMeasure(Item, ProdOrder."Unit of Measure Code FND");
        //ProdOrder."Unit Volume HL" := Item."Unit Volume HL" * "Qty. per Unit of Measure";
        //BC Upgrade Kamnay01<< DITW code
        Item.BlockedSKU(ProdOrder."Location Code", '', TRUE); //BC Upgrade GUNREM01 Blocked SKU GAP12_DTW
    end;
    //BC Upgrade PATHAA02<<

    //BC Upgrade KAMNAY01>>---Item Journal Line
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterCopyFromProdOrderLine, '', false, false)]
    local procedure "Item Journal Line_OnAfterCopyFromProdOrderLine"(var ItemJournalLine: Record "Item Journal Line"; ProdOrderLine: Record "Prod. Order Line")
    var
        Bin: Record Bin;
    begin
        //HEI.01 PRDGAP024>>
        IF ProdOrderLine."Bin Code" <> '' THEN BEGIN
            Bin.GET(ItemJournalLine."Location Code", ProdOrderLine."Bin Code");
            ItemJournalLine."Zone Code FND" := Bin."Zone Code";
        END;
        //HEI.01 PRDGAP024<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterCopyFromProdOrderComp, '', false, false)]
    local procedure "Item Journal Line_OnAfterCopyFromProdOrderComp"(var ItemJournalLine: Record "Item Journal Line"; ProdOrderComponent: Record "Prod. Order Component")
    var
        Bin: Record Bin;
    begin
        //HEI.01 PRDGAP024>>
        IF ProdOrderComponent."Bin Code" <> '' THEN BEGIN
            Bin.GET(ItemJournalLine."Location Code", ProdOrderComponent."Bin Code");
            ItemJournalLine."Zone Code FND" := Bin."Zone Code";
        END;
        //HEI.01 PRDGAP024<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnOrderLineNoOnValidateOnAfterAssignProdOrderLineValues, '', false, false)]
    local procedure "Item Journal Line_OnOrderLineNoOnValidateOnAfterAssignProdOrderLineValues"(var ItemJournalLine: Record "Item Journal Line"; ProdOrderLine: Record "Prod. Order Line")
    var
        Bin: Record Bin;
    begin
        if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Output then begin
            //HEI.01 PRDGAP024>>
            IF ProdOrderLine."Bin Code" <> '' THEN BEGIN
                Bin.GET(ItemJournalLine."Location Code", ProdOrderLine."Bin Code");
                ItemJournalLine."Zone Code FND" := Bin."Zone Code";
            END;
            //HEI.01 PRDGAP024<<
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterCopyItemJnlLineFromSalesLine, '', false, false)]
    local procedure "Item Journal Line_OnAfterCopyItemJnlLineFromSalesLine"(var ItemJnlLine: Record "Item Journal Line"; SalesLine: Record "Sales Line")
    var
        Bin: Record Bin;
    begin
        //HEI.01 PRDGAP024>>
        IF SalesLine."Bin Code" <> '' THEN BEGIN
            Bin.GET(ItemJnlLine."Location Code", SalesLine."Bin Code");
            ItemJnlLine."Zone Code FND" := Bin."Zone Code";
        END;
        //HEI.01 PRDGAP024<<
        //HEI.10>>
        ItemJnlLine."RPM Solution FND" := SalesLine."RPM Solution FND";
        ItemJnlLine."RPM Type FND" := SalesLine."RPM Type FND";
        ItemJnlLine."Item Type FND" := SalesLine."Item Type FND";
        //HEI.10<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterCopyItemJnlLineFromPurchLine, '', false, false)]
    local procedure "Item Journal Line_OnAfterCopyItemJnlLineFromPurchLine"(var ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line")
    var
        Bin: Record Bin;
    begin
        //HEI.01 PRDGAP024>>
        IF PurchLine."Bin Code" <> '' THEN BEGIN
            Bin.GET(ItemJnlLine."Location Code", PurchLine."Bin Code");
            ItemJnlLine."Zone Code FND" := Bin."Zone Code";
        END;
        //HEI.01 PRDGAP024<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterCopyItemJnlLineFromSalesHeader, '', false, false)]
    local procedure "Item Journal Line_OnAfterCopyItemJnlLineFromSalesHeader"(var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header")
    begin
        ItemJnlLine."Source System Identifier FND" := SalesHeader."Source System Identifier FND"; // HEI.25
    end;
    //     [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnValidateAppliesToEntryOnAferCalcShowTrackingExistsError, '', false, false)]
    //     local procedure "Item Journal Line_OnValidateAppliesToEntryOnAferCalcShowTrackingExistsError"(var ItemJournalLine: Record "Item Journal Line"; xItemJournalLine: Record "Item Journal Line"; var ShowTrackingExistsError: Boolean)
    //     var
    //         ItemLedgEntry: Record "Item Ledger Entry";
    //     begin
    //         IF ((NOT ItemLedgEntry.Open) AND (GUIALLOWED)) THEN
    // end;
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnBeforeCheckProdOrderCompBinCode, '', false, false)]
    local procedure "Item Journal Line_OnBeforeCheckProdOrderCompBinCode"(var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    var
        ProdOrderComp: Record "Prod. Order Component";
        UpdateInterruptedErr: Label 'The update has been interrupted to respect the warning.';
        Text021: Label 'The entered bin code %1 is different from the bin code %2 in production order component %3.\\Are you sure that you want to post the consumption from bin code %1?';
    begin
        //>>HEI.29
        IsHandled := true;
        ProdOrderComp.Get(ProdOrderComp.Status::Released, ItemJournalLine."Order No.", ItemJournalLine."Order Line No.", ItemJournalLine."Prod. Order Comp. Line No.");
        if (ProdOrderComp."Bin Code" <> '') and (ProdOrderComp."Bin Code" <> ItemJournalLine."Bin Code") and (GUIALLOWED) then
            if not Confirm(
                 Text021,
                 false,
                 ItemJournalLine."Bin Code",
                 ProdOrderComp."Bin Code",
                 ItemJournalLine."Order No.")
            then
                Error(UpdateInterruptedErr);
        //>>HEI.29
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnBeforePostingItemJnlFromProduction, '', false, false)]
    local procedure "Item Journal Line_OnBeforePostingItemJnlFromProduction"(var ItemJournalLine: Record "Item Journal Line"; Print: Boolean; var IsHandled: Boolean)
    var
        ProductionOrder: Record "Production Order";
        ProductionOrderNo: Code[20];
        //ImportProductionOrdersMgmt: Codeunit "Import Production Orders Mgmt";  // BC Upgrade KAMNAY01 - Blocked as this codeunit is uncompiled
        HeinekenGlobal: Codeunit "Heineken Global";
    begin
        IsHandled := true;
        IF (ItemJournalLine."Order Type" = ItemJournalLine."Order Type"::Production) AND (ItemJournalLine."Order No." <> '') THEN BEGIN //HEI.38
            ProductionOrder.GET(ProductionOrder.Status::Released, ItemJournalLine."Order No.");
            //HEI.38>>
            ProductionOrderNo := ProductionOrder."No.";
        END;
        //HEI.38<<
        IF HeinekenGlobal.CheckConsumptionLines(ItemJournalLine) THEN BEGIN //HEI.17
                                                                            //HEI.42>>
            CLEAR(HeinekenGlobal);
            HeinekenGlobal.NegativeConsumptionCatgryCodeNew(ItemJournalLine);
            //HEI.42<<
            IF Print THEN
                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post+Print", ItemJournalLine)
            ELSE
                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", ItemJournalLine);
            //ImportProductionOrdersMgmt.ArchiveImportedProdOrders(ProductionOrderNo); //HEI.38  // BC Upgrade KAMNAY01 - Blocked as this codeunit is uncompiled
        END; //HEI.17
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnValidateItemNoOnAfterCreateDimInitial, '', false, false)]
    local procedure "Item Journal Line_OnValidateItemNoOnAfterCreateDimInitial"(var ItemJournalLine: Record "Item Journal Line")
    begin
        ItemJournalLine.UpdateCCCfromBinCode(); //HEI.24
    end;
    //BC Upgrade KAMNAY01<<---Item Journal Line
    //---BC Upgrade KAMNAY01>> --- SKU HEI.06
    [EventSubscriber(ObjectType::Table, Database::"Stockkeeping Unit", OnAfterCopyFromItem, '', false, false)]
    local procedure "Stockkeeping Unit_OnAfterCopyFromItem"(var StockkeepingUnit: Record "Stockkeeping Unit"; Item: Record Item)
    begin
        //HEI.06>>
        StockkeepingUnit."Item Type FND" := Item."Item Type FND";
        StockkeepingUnit."RPM Solution FND" := Item."RPM Solution FND";
        StockkeepingUnit."RPM Type FND" := Item."RPM Type FND";
        //HEI.06<<
    end;
    //---BC Upgrade KAMNAY01<< --- SKU HEI.06
    //---BC Upgrade KAMNAY01>> --- BIN HEI.01
    [EventSubscriber(ObjectType::Table, Database::Bin, OnBeforeOnInsert, '', false, false)]
    local procedure Bin_OnBeforeOnInsert(var Bin: Record Bin; var IsHandled: Boolean)

    begin
        Bin.TestField("Location Code");
        Bin.TestField(Code);
        GetLocation(Bin."Location Code");
        if Location."Directed Put-away and Pick" then begin
            Bin.TestField("Zone Code");
            Bin.TestField("Bin Type Code");
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Bin, OnBeforeOnModify, '', false, false)]
    local procedure Bin_OnBeforeOnModify(var Bin: Record Bin; var xBin: Record Bin; var IsHandled: Boolean)

    begin
        Bin.TestField("Location Code");
        Bin.TestField(Code);
        GetLocation(Bin."Location Code");
        if Location."Directed Put-away and Pick" then begin
            Bin.TestField("Zone Code");
            Bin.TestField("Bin Type Code");
        end;
    end;

    local procedure GetLocation(LocationCode: Code[10])

    begin
        if Location.Code <> LocationCode then
            Location.Get(LocationCode);
    end;
    //---BC Upgrade KAMNAY01<< --- BIN HEI.01
    //---BC Upgrade KAMNAY01>>---Request Order Line HEI.03
    // procedure CalcAvailabilityByFromCodeForRequestOrder(VAR RequestLine: Record "Request Order Line"): Decimal
    // var
    //     RequestHeader: Record "Request Order Header";
    //     GrossRequirement: Decimal;
    //     ScheduledReceipt: Decimal;
    //     PeriodType: Option Day,Week,Month,Quarter,Year;
    //     Item: record Item;
    //     LookaheadDateformula: DateFormula;
    // begin
    //     //HEI.03>>
    //     IF Item.GET(RequestLine."Item No.") THEN BEGIN
    //         RequestHeader.GET(RequestLine."Document No.");
    //         Item.RESET;
    //         Item.SETRANGE("Date Filter", 0D, RequestHeader."Request Date");
    //         Item.SETRANGE("Location Filter", RequestLine."From-Code");
    //         Item.SETRANGE("Drop Shipment Filter", FALSE);
    //         EXIT(ConvertQty(
    //           AvailableToPromise.QtyAvailabletoPromise(
    //             Item,
    //             GrossRequirement,
    //             ScheduledReceipt,
    //             RequestHeader."Request Date",
    //             PeriodType,
    //             LookaheadDateformula),
    //             RequestLine."Qty. per Unit of Measure"));
    //     END;
    //     //HEI.03<<
    // end;
    //---BC Upgrade KAMNAY01<<---Request Order Line HEI.03
    //---BC Upgrade KAMNAY01 --- Transfer header HEI.09
    [EventSubscriber(ObjectType::Table, Database::"Transfer Header", OnAfterInitRecord, '', false, false)]
    local procedure "Transfer Header_OnAfterInitRecord"(var TransferHeader: Record "Transfer Header")
    begin
        //>>HEI.09
        TransferHeader."Created By FND" := USERID;
        //<<HEI.09
    end;
    //---BC Upgrade KAMNAY01 --- Transfer header HEI.09

    var
        Location: Record Location;






    /* //Bc Upgrade YADAVM09 Drink it field dependency commented>>
       [EventSubscriber(ObjectType::Table, Database::"FA Posting Type", OnAfterCreateTypes, '', false, false)]
       local procedure OnAfterCreateTypesSubscriber(var FAPostingType: Record "FA Posting Type")
       var
           FADeprBook: Record "FA Depreciation Book";
       begin
           IF NOT FAPostingType.FIND('-') THEN BEGIN
               //HEI.01>>
               IF FAPostingType."Entry No." = 13 THEN
                   IF (FAPostingType."FA Posting Type No." <> FADeprBook.FIELDNO(Derogatory)) OR
                      (FAPostingType."FA Posting Type Name" <> FADeprBook.FIELDCAPTION(Derogatory))
                   THEN BEGIN
                       FAPostingType.DELETE;
                       FAPostingType."FA Posting Type No." := FADeprBook.FIELDNO(Derogatory);
                       FAPostingType."FA Posting Type Name" := FADeprBook.FIELDCAPTION(Derogatory);
                       FAPostingType.INSERT;
                   END
                   //HEI.01<<

                   ELSE BEGIN
                       FAPostingType.SETCURRENTKEY("Entry No.");
                       FAPostingType.FIND('-');
                       REPEAT
                           //HEI.01>>
                           IF FAPostingType."Entry No." = 13 THEN
                               IF (FAPostingType."FA Posting Type No." <> FADeprBook.FIELDNO(Derogatory)) OR
                                  (FAPostingType."FA Posting Type Name" <> FADeprBook.FIELDCAPTION(Derogatory))
                               THEN BEGIN
                                   FAPostingType.DELETE;
                                   FAPostingType."FA Posting Type No." := FADeprBook.FIELDNO(Derogatory);
                                   FAPostingType."FA Posting Type Name" := FADeprBook.FIELDCAPTION(Derogatory);
                                   FAPostingType.INSERT;
                               END;
                       //HEI.01<<
                       UNTIL FAPostingType.NEXT = 0;
                   END;
           END;
       END;
    */ //Bc Upgrade YADAVM09 Drink it field dependency commented<<

    [EventSubscriber(ObjectType::Table, Database::"FA Date Type", OnAfterCreateTypes, '', false, false)]
    local procedure OnAfterCreateTypesSubscriber1(var FADateType: Record "FA Date Type")
    var
        FADeprBook: Record "FA Depreciation Book";
        CompanyInfo: Record "Company Information";
    Begin
        IF NOT FADateType.FIND('-') THEN BEGIN
            //HEI.02>>
            CompanyInfo.GET();
            IF CompanyInfo."Enable French Localization FND" THEN BEGIN
                FADateType."FA Entry" := TRUE;
                //HEI.02<<
                //HEI.01>>
                //FADateType.InsertRec(11, FADeprBook.FIELDNO("Last Derogatory Date"), FADeprBook.FIELDCAPTION("Last Derogatory Date"));  //Bc Upgrade YADAVM09 Drink it field dependency>>
            END;
            //HEI.01<<
            //END ELSE BEGIN //Bc Upgrade YADAVM09 Blocked to handle Begin end condition
        end;//Bc Upgrade YADAVM09
        /* //Bc Upgrade YADAVM09 Drink it field dependency>>
            FADateType.SETCURRENTKEY("Entry No.");
            FADateType.FIND('-');
            REPEAT
                //HEI.01>>
                CompanyInfo.GET;
                IF CompanyInfo."Enable French Localization" THEN
                    IF FADateType."Entry No." = 11 THEN
                        IF (FADateType."FA Date Type No." <> FADeprBook.FIELDNO("Last Derogatory Date")) OR
                           (FADateType."FA Date Type Name" <> FADeprBook.FIELDCAPTION("Last Derogatory Date"))
                        THEN BEGIN
                            FADateType.DELETE;
                            FADateType.InsertRec(11, FADeprBook.FIELDNO("Last Derogatory Date"), FADeprBook.FIELDCAPTION("Last Derogatory Date"));
                        END;
            //HEI.01<<
            UNTIL FADateType.NEXT = 0;
        END;
        */ //Bc Upgrade YADAVM09 Drink it field dependency<<

    END;
    /* //Bc Upgrade YADAVM09 Drink it field dependency>>
        [EventSubscriber(ObjectType::Table, Database::"FA Matrix Posting Type", OnAfterCreateTypes, '', false, false)]
        local procedure OnAfterCreateTypesSubscriber2(var FAMatrixPostingType: Record "FA Matrix Posting Type")
        var
            FADeprBook: Record "FA Depreciation Book";

        Begin
            if not FAMatrixPostingType.FindSet() then BEGIN
                FAMatrixPostingType.InsertRec(12, FADeprBook.FIELDCAPTION(Derogatory)); //HEI.01
            end else
                repeat
                    //HEI.01>>
                    IF FAMatrixPostingType."Entry No." = 12 THEN
                        IF FAMatrixPostingType."FA Posting Type Name" <> FADeprBook.FIELDCAPTION(Derogatory) THEN BEGIN
                            FAMatrixPostingType.DELETE;
                            FAMatrixPostingType.InsertRec(12, FADeprBook.FIELDCAPTION(Derogatory));
                        END;
                //HEI.01<<
                until FAMatrixPostingType.Next() = 0;
        END;
    */ //Bc Upgrade YADAVM09 Drink it field dependency<<
    /* //Bc Upgrade YADAVM09 Drink it field dependency>>
    [EventSubscriber(ObjectType::Page, page::"FA Posting Types Overv. Matrix", OnMATRIX_OnDrillDownOnCaseElse, '', false, false)]
    local procedure OnMATRIX_OnDrillDownOnCaseElseSubscriber(MATRIX_ColumnOrdinal: Integer; var FALedgerEntry: Record "FA Ledger Entry")
    var
        CompanyInfo: Record "Company Information";
        MatrixRecords: array[32] of Record "FA Matrix Posting Type";
        MATRIX_CellData: array[32] of Decimal;
        FADeprBook: Record "FA Depreciation Book";
    //MatrixMgt: Codeunit "Matrix Management";  //BC Upgrade KAPOOV01 Codeunit

    Begin
        //HEI.02>>
        if MatrixRecords[MATRIX_ColumnOrdinal]."Entry No." = 12 then // 'Derogatory'
     BEGIN
            CompanyInfo.GET;
            IF CompanyInfo."Enable French Localization" THEN BEGIN
                IF FADeprBook.FINDFIRST THEN
                    FADeprBook.CALCFIELDS(Derogatory);
                //MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue(Derogatory, RoundingFactor); //BC Upgrade KAPOOV01 Codeunit
            END;
        END;
        //HEI.02<<
    END;
    
        [EventSubscriber(ObjectType::Page, page::"FA Posting Types Overv. Matrix", OnAfterMATRIX_OnAfterGetRecord, '', false, false)]
        local procedure OnAfterMATRIX_OnAfterGetRecordSubscriber(MATRIX_ColumnOrdinal: Integer; MatrixRecords: array[32] of Record "FA Matrix Posting Type"; RoundingFactor: Enum "Analysis Rounding Factor"; var FADepreciationBook: Record "FA Depreciation Book"; var MATRIX_CellData: array[32] of Decimal)
        var
            CompanyInfo: Record "Company Information";
        //MatrixMgt: Codeunit "Matrix Management";  //BC Upgrade KAPOOV01 Codeunit
        Begin
            //HEI.01>>
            if MatrixRecords[MATRIX_ColumnOrdinal]."Entry No." = 12 then// 'Derogatory'
              BEGIN
                CompanyInfo.GET;
                IF CompanyInfo."Enable French Localization" THEN BEGIN
                    IF FADepreciationBook.FINDFIRST THEN
                        FADepreciationBook.CALCFIELDS(Derogatory);
                    //MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue(Derogatory, RoundingFactor); ////BC Upgrade KAPOOV01 Codeunit
                END;
            END;
            //HEI.01<<
        END;
        //BC Upgrade KAPOOV01<<
    */ //Bc Upgrade YADAVM09 Drink it field dependency<<




    // BC Upgrade NANDIS03 >>
    //     HEI.01 HeiliteBase FDD-GAPLOG012 IBM.NAIKH01 14/06/2017
    //   # Added code in the "TemplateSelection" and "TemplateSelectionFromBatch" trigger to restrict the user to use the Journal batch
    // HEI.02 Defect #4888 IBM SURYAS01 11-12-2019 (CU 25 Patch)
    //   #Added Code in -"OpenJnl" Function

    [EventSubscriber(ObjectType::Codeunit, Codeunit::GenJnlManagement, 'OnBeforeRunTemplateJournalPage', '', false, false)]

    local procedure OnBeforeRunTemplateJournalPage(var GenJnlTemplate: Record "Gen. Journal Template"; var GenJnlLine: Record "Gen. Journal Line"; OpenFromBatch: Boolean; var IsHandled: Boolean)
    var
        UserJournalTemplate: Record "User Gen. Journal Setup FND";
    begin
        UserJournalTemplate.CheckUserTemplateSetup(UserJournalTemplate."Journal Type"::General, GenJnlTemplate.Name);
    end;
    // BC Upgrade NANDIS03 <<

    // //BC Upgrade SHARMP16 begin>>
    // [EventSubscriber(ObjectType::Page, Page::"Vendor Bank Account Card", OnOpenPageEvent, '', false, false)]
    // local procedure OnOpenPageVendorBankAccCard(var Rec: Record "Vendor Bank Account")
    // var
    //     FRLocAction: Boolean;
    //     CompanyInfo: Record "Company Information";
    // begin
    //     //HEI.03>>
    //     FRLocAction := FALSE;
    //     CompanyInfo.GET;
    //     IF CompanyInfo."Enable French Localization" THEN
    //         FRLocAction := TRUE;
    //     //HEI.03<<
    // end;
    // //BC Upgrade SHARMP16 end>>

    //BC Upgrade KAPOOV01 >> 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl. Line-Reserve", 'OnAfterInitFromItemJnlLine', '', false, false)]
    local procedure OnAfterInitFromItemJnlLine(var TrackingSpecification: Record "Tracking Specification"; ItemJournalLine: Record "Item Journal Line")
    begin
        //HEI.07>>
        IF (ItemJournalLine."Entry Type" IN [ItemJournalLine."Entry Type"::Consumption, ItemJournalLine."Entry Type"::Output]) AND
          (ItemJournalLine."Order Type" = ItemJournalLine."Order Type"::Production) THEN
            TrackingSpecification."Reference No. FND" := ItemJournalLine."Order No.";
        //HEI.07<<

    end;

    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnValidateExpirationDateOnBeforeResetExpirationDate', '', false, false)]
    local procedure OnValidateExpirationDateOnBeforeResetExpirationDate(var TrackingSpecification: Record "Tracking Specification"; xTrackingSpecification: Record "Tracking Specification"; var IsHandled: Boolean)
    var
        Text004: Label 'Expiration date has been established by existing entries and cannot be changed.';
    begin
        IsHandled := TRUE;
        if TrackingSpecification."Buffer Status2" = TrackingSpecification."Buffer Status2"::"ExpDate blocked" then begin
            TrackingSpecification."Expiration Date" := xTrackingSpecification."Expiration Date";
            //>>HEI.04
            IF GUIALLOWED THEN
                //<<HEI.04
                Message(Text004);
        end;
    end;

    //BC Upgrade KAPOOV01 <<


    // BC Upgrade PriyaShukla 12/09/25>> 
    procedure CalcCellFRLoc(var AccSchedLine: Record "Acc. Schedule Line"; var ColumnLayout: Record "Column Layout"; CalcAddCurr: Boolean; IncludeSim: Boolean): Decimal
    var
        Result: Decimal;
        AccountScheduleLine: Record "Acc. Schedule Line";
        AnalysisViewRead: Boolean;
        StartDate: Date;
        EndDate: Date;
        FiscalStartDate: Date;
        AccountingPeriodMgt: Codeunit "Accounting Period Mgt.";
        DivisionError: Boolean;
        PeriodError: Boolean;
        CallLevel: Integer;
        IncludeSimulation: Boolean;
        CallingAccSchedLineID: Integer;
        CallingColumnLayoutID: Integer;
        OldAccSchedLineFilters: Text;
        OldColumnLayoutFilters: Text;
        OldAccSchedLineName: Code[10];
        OldColumnLayoutName: Code[10];
        OldCalcAddCurr: Boolean;
        Recalculate: Boolean;
        OldIncludeSimulation: Boolean;
        AccSchedCellValue: Record "Acc. Sched. Cell Value" temporary;
        BasePercentLine: array[50] of Integer;
        AccSchdMng: Codeunit AccSchedManagement;
    begin
        //HEI.01>>
        IncludeSimulation := IncludeSim;
        AccountScheduleLine.COPYFILTERS(AccSchedLine);
        StartDate := AccountScheduleLine.GETRANGEMIN("Date Filter");
        IF EndDate <> AccountScheduleLine.GETRANGEMAX("Date Filter") THEN BEGIN
            EndDate := AccountScheduleLine.GETRANGEMAX("Date Filter");
            FiscalStartDate := AccountingPeriodMgt.FindFiscalYear(EndDate);
        END;
        DivisionError := FALSE;
        PeriodError := FALSE;
        CallLevel := 0;
        CallingAccSchedLineID := AccSchedLine."Line No.";
        CallingColumnLayoutID := ColumnLayout."Line No.";

        IF (OldAccSchedLineFilters <> AccSchedLine.GETFILTERS) OR
           (OldColumnLayoutFilters <> ColumnLayout.GETFILTERS) OR
           (OldAccSchedLineName <> AccSchedLine."Schedule Name") OR
           (OldColumnLayoutName <> ColumnLayout."Column Layout Name") OR
           (OldCalcAddCurr <> CalcAddCurr) OR
           Recalculate OR
           (OldIncludeSimulation <> IncludeSim)
        THEN BEGIN
            AccSchedCellValue.RESET();
            AccSchedCellValue.DELETEALL();
            CLEAR(BasePercentLine);
            OldAccSchedLineFilters := AccSchedLine.GETFILTERS;
            OldColumnLayoutFilters := ColumnLayout.GETFILTERS;
            OldAccSchedLineName := AccSchedLine."Schedule Name";
            OldColumnLayoutName := ColumnLayout."Column Layout Name";
            OldCalcAddCurr := CalcAddCurr;
            OldIncludeSimulation := IncludeSim;
        END;

        Result := AccSchdMng.CalcCellValue(AccSchedLine, ColumnLayout, CalcAddCurr);
        CASE ColumnLayout.Show OF
            ColumnLayout.Show::"When Positive":
                IF Result < 0 THEN
                    Result := 0;
            ColumnLayout.Show::"When Negative":
                IF Result > 0 THEN
                    Result := 0;
        END;
        IF ColumnLayout."Show Opposite Sign" THEN
            Result := -Result;
        CASE ColumnLayout."Show Indented Lines" OF
            ColumnLayout."Show Indented Lines"::"Indented Only":
                IF AccSchedLine.Indentation = 0 THEN
                    Result := 0;
            ColumnLayout."Show Indented Lines"::"Non-Indented Only":
                IF AccSchedLine.Indentation > 0 THEN
                    Result := 0;
        END;
        IF AccSchedLine."Show Opposite Sign" THEN
            Result := -Result;
        EXIT(Result);
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::AccSchedManagement, OnAfterSetGLAccGLEntryFilters, '', false, false)]
    local procedure OnAfterSetGLAccGLEntryFilters_CalcGLAcc(var AccSchedLine: Record "Acc. Schedule Line"; var GLAccount: Record "G/L Account"; var GLEntry: Record "G/L Entry"; var ColumnLayout: Record "Column Layout"; UseBusUnitFilter: Boolean; UseDimFilter: Boolean)

    var
        IncludeSimulation: Boolean;
        FinancialStFilter: Text;
        lGLEntryTMP: Record "G/L Entry" temporary;
        lGLAcc: Record "G/L Account";
        lPos: Integer;
        GLSetup: Record "General Ledger Setup";
    begin
        //HEI.03>>
        // BC Upgrade PriyaShukla 12/09/25>>
        // GetGLSetup;
        GLSetup.Get();
        // BC Upgrade PriyaShukla 12/09/25<<
        //HEI.03<<

        //BC Upgrade KAPOOV01 >>French Localization fields 
        //HEI.01>>
        // IF NOT IncludeSimulation THEN
        //     GLEntry.SETRANGE("Entry Type", GLEntry."Entry Type"::Definitive);
        //SETRANGE("Entry Type", "Entry Type"::Definitive);
        //HEI.01<<
        // end;
        //BC Upgrade KAPOOV01 <<French Localization fields 

        //HEI.02>>
        //HEI.03>>
        IF ((GLSetup."P&L by Nature code FND" <> '') AND (AccSchedLine."Schedule Name" = GLSetup."P&L by Nature code FND")) THEN BEGIN
            //HEI.03<<
            FinancialStFilter := AccSchedLine.GETFILTER("Finan. St. Ver. to Exclude FND");
            IF (FinancialStFilter <> '') THEN //HEI.03
            BEGIN //HEI.03
                lGLEntryTMP.DELETEALL();
                IF GLEntry.FINDSET(FALSE) THEN
                    REPEAT
                        lGLAcc.RESET();
                        IF lGLAcc.GET(GLEntry."G/L Account No.") THEN BEGIN
                            CASE lGLAcc."Financial Stmt version FND" OF
                                lGLAcc."Financial Stmt version FND"::" ":
                                    BEGIN
                                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'BLANK');
                                        IF lPos <> 0 THEN
                                            lGLEntryTMP."Entry No." := GLEntry."Entry No.";
                                        IF lGLEntryTMP.INSERT() THEN;
                                    END;
                                lGLAcc."Financial Stmt version FND"::Common:
                                    BEGIN
                                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'COMMON');
                                        IF lPos <> 0 THEN
                                            lGLEntryTMP."Entry No." := GLEntry."Entry No.";
                                        IF lGLEntryTMP.INSERT() THEN;
                                    END;
                                lGLAcc."Financial Stmt version FND"::Heineken:
                                    BEGIN
                                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'HEINEKEN');
                                        IF lPos <> 0 THEN
                                            lGLEntryTMP."Entry No." := GLEntry."Entry No.";
                                        IF lGLEntryTMP.INSERT() THEN;
                                    END;
                                lGLAcc."Financial Stmt version FND"::"Local":
                                    BEGIN
                                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'LOCAL');
                                        IF lPos <> 0 THEN
                                            lGLEntryTMP."Entry No." := GLEntry."Entry No.";
                                        IF lGLEntryTMP.INSERT() THEN;
                                    END;
                            END;
                        END;
                    UNTIL GLEntry.NEXT() = 0;
                IF GLEntry.FINDSET(FALSE) THEN
                    REPEAT
                        IF NOT lGLEntryTMP.GET(GLEntry."Entry No.") THEN
                            GLEntry.MARK(TRUE);
                    UNTIL GLEntry.NEXT() = 0;
                GLEntry.MARKEDONLY(TRUE);
                lGLEntryTMP.DELETEALL();
            end;    //HEI.03>>
        END; //HEI.03<<   //HEI.02<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::AccSchedManagement, OnAfterSetGLAccAnalysisViewEntryFilters, '', false, false)]
    local procedure OnAfterSetGLAccAnalysisViewEntryFilters_CalcGLAcc(var AccSchedLine: Record "Acc. Schedule Line"; var AnalysisViewEntry: Record "Analysis View Entry"; var ColumnLayout: Record "Column Layout"; var GLAcc: Record "G/L Account")

    var
        FinancialStFilter: Text;
        lGLEntryTMP: Record "G/L Entry" temporary;
        lGLAcc: Record "G/L Account";
        lPos: Integer;
        GLEntry: Record "G/L Entry";
        GLSetup: Record "General Ledger Setup";
    begin
        //HEI.03>>
        // BC Upgrade PriyaShukla 12/09/25>>
        // GetGLSetup;
        GLSetup.Get();
        // BC Upgrade PriyaShukla 12/09/25<<
        //HEI.03<<

        //HEI.02>>
        //HEI.03>>
        IF ((GLSetup."P&L by Nature code FND" <> '') AND (AccSchedLine."Schedule Name" = GLSetup."P&L by Nature code FND")) THEN BEGIN
            //HEI.03<<
            FinancialStFilter := AccSchedLine.GETFILTER("Finan. St. Ver. to Exclude FND");
            IF (FinancialStFilter <> '') THEN //HEI.03
                BEGIN //HEI.03
                lGLEntryTMP.DELETEALL();
                IF GLEntry.FINDSET(FALSE) THEN
                    REPEAT
                        lGLAcc.RESET();
                        IF lGLAcc.GET(GLEntry."G/L Account No.") THEN BEGIN
                            CASE lGLAcc."Financial Stmt version FND" OF
                                lGLAcc."Financial Stmt version FND"::" ":
                                    BEGIN
                                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'BLANK');
                                        IF lPos <> 0 THEN
                                            lGLEntryTMP."Entry No." := GLEntry."Entry No.";
                                        IF lGLEntryTMP.INSERT() THEN;
                                    END;
                                lGLAcc."Financial Stmt version FND"::Common:
                                    BEGIN
                                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'COMMON');
                                        IF lPos <> 0 THEN
                                            lGLEntryTMP."Entry No." := GLEntry."Entry No.";
                                        IF lGLEntryTMP.INSERT() THEN;
                                    END;
                                lGLAcc."Financial Stmt version FND"::Heineken:
                                    BEGIN
                                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'HEINEKEN');
                                        IF lPos <> 0 THEN
                                            lGLEntryTMP."Entry No." := GLEntry."Entry No.";
                                        IF lGLEntryTMP.INSERT() THEN;
                                    END;
                                lGLAcc."Financial Stmt version FND"::"Local":
                                    BEGIN
                                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'LOCAL');
                                        IF lPos <> 0 THEN
                                            lGLEntryTMP."Entry No." := GLEntry."Entry No.";
                                        IF lGLEntryTMP.INSERT() THEN;
                                    END;
                            END;
                        END;
                    UNTIL GLEntry.NEXT() = 0;
                IF GLEntry.FINDSET(FALSE) THEN
                    REPEAT
                        IF NOT lGLEntryTMP.GET(GLEntry."Entry No.") THEN
                            GLEntry.MARK(TRUE);
                    UNTIL GLEntry.NEXT() = 0;
                GLEntry.MARKEDONLY(TRUE);
                lGLEntryTMP.DELETEALL();
                //HEI.03>>
            END;
        END;
        //HEI.03<<
    End; //HEI.02<< 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::AccSchedManagement, OnAfterSetGLAccGLBudgetEntryFilters, '', false, false)]
    local procedure OnAfterSetGLAccGLBudgetEntryFilters_CalcGLAcc(var AccSchedLine: Record "Acc. Schedule Line"; var ColumnLayout: Record "Column Layout"; var GLAcc: Record "G/L Account"; var GLBudgetEntry: Record "G/L Budget Entry"; UseBusUnitFilter: Boolean; UseDimFilter: Boolean)

    var

        FinancialStFilter: Text;
        lGLEntryTMP: Record "G/L Entry" temporary;
        lGLAcc: Record "G/L Account";
        lPos: Integer;
        GLEntry: Record "G/L Entry";
        GLSetup: Record "General Ledger Setup";
    begin
        //HEI.03>>
        // BC Upgrade PriyaShukla 12/09/25>>
        // GetGLSetup;
        GLSetup.Get();
        // BC Upgrade PriyaShukla 12/09/25<<
        //HEI.03<<

        //HEI.02>>
        //HEI.03>>
        IF ((GLSetup."P&L by Nature code FND" <> '') AND (AccSchedLine."Schedule Name" = GLSetup."P&L by Nature code FND")) THEN BEGIN
            //HEI.03<<
            FinancialStFilter := AccSchedLine.GETFILTER("Finan. St. Ver. to Exclude FND");
            IF (FinancialStFilter <> '') THEN //HEI.03
                BEGIN //HEI.03
                lGLEntryTMP.DELETEALL();
                IF GLEntry.FINDSET(FALSE) THEN
                    REPEAT
                        lGLAcc.RESET();
                        IF lGLAcc.GET(GLEntry."G/L Account No.") THEN BEGIN
                            CASE lGLAcc."Financial Stmt version FND" OF
                                lGLAcc."Financial Stmt version FND"::" ":
                                    BEGIN
                                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'BLANK');
                                        IF lPos <> 0 THEN
                                            lGLEntryTMP."Entry No." := GLEntry."Entry No.";
                                        IF lGLEntryTMP.INSERT() THEN;
                                    END;
                                lGLAcc."Financial Stmt version FND"::Common:
                                    BEGIN
                                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'COMMON');
                                        IF lPos <> 0 THEN
                                            lGLEntryTMP."Entry No." := GLEntry."Entry No.";
                                        IF lGLEntryTMP.INSERT() THEN;
                                    END;
                                lGLAcc."Financial Stmt version FND"::Heineken:
                                    BEGIN
                                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'HEINEKEN');
                                        IF lPos <> 0 THEN
                                            lGLEntryTMP."Entry No." := GLEntry."Entry No.";
                                        IF lGLEntryTMP.INSERT() THEN;
                                    END;
                                lGLAcc."Financial Stmt version FND"::"Local":
                                    BEGIN
                                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'LOCAL');
                                        IF lPos <> 0 THEN
                                            lGLEntryTMP."Entry No." := GLEntry."Entry No.";
                                        IF lGLEntryTMP.INSERT() THEN;
                                    END;
                            END;
                        END;
                    UNTIL GLEntry.NEXT() = 0;
                IF GLEntry.FINDSET(FALSE) THEN
                    REPEAT
                        IF NOT lGLEntryTMP.GET(GLEntry."Entry No.") THEN
                            GLEntry.MARK(TRUE);
                    UNTIL GLEntry.NEXT() = 0;
                GLEntry.MARKEDONLY(TRUE);
                lGLEntryTMP.DELETEALL();
                //HEI.03>>
            END;
        END
        //HEI.03<<
        //HEI.02<<
    END;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::AccSchedManagement, OnAfterSetGLAccAnalysisViewBudgetEntries, '', false, false)]
    local procedure OnAfterSetGLAccAnalysisViewBudgetEntries_CalcGLAcc(var AccSchedLine: Record "Acc. Schedule Line"; var AnalysisViewBudgetEntry: Record "Analysis View Budget Entry"; var ColumnLayout: Record "Column Layout"; var GLAcc: Record "G/L Account")

    var
        FinancialStFilter: Text;
        lGLEntryTMP: Record "G/L Entry" temporary;
        lGLAcc: Record "G/L Account";
        lPos: Integer;
        GLEntry: Record "G/L Entry";
        GLSetup: Record "General Ledger Setup";
    begin
        //HEI.03>>
        // BC Upgrade PriyaShukla 12/09/25>>
        // GetGLSetup;
        GLSetup.Get();
        // BC Upgrade PriyaShukla 12/09/25<<
        //HEI.03<<

        //HEI.02>>
        //HEI.03>>
        IF ((GLSetup."P&L by Nature code FND" <> '') AND (AccSchedLine."Schedule Name" = GLSetup."P&L by Nature code FND")) THEN BEGIN
            //HEI.03<<
            FinancialStFilter := AccSchedLine.GETFILTER("Finan. St. Ver. to Exclude FND");
            IF (FinancialStFilter <> '') THEN //HEI.03
                BEGIN //HEI.03
                lGLEntryTMP.DELETEALL();
                IF GLEntry.FINDSET(FALSE) THEN
                    REPEAT
                        lGLAcc.RESET();
                        IF lGLAcc.GET(GLEntry."G/L Account No.") THEN BEGIN
                            CASE lGLAcc."Financial Stmt version FND" OF
                                lGLAcc."Financial Stmt version FND"::" ":
                                    BEGIN
                                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'BLANK');
                                        IF lPos <> 0 THEN
                                            lGLEntryTMP."Entry No." := GLEntry."Entry No.";
                                        IF lGLEntryTMP.INSERT() THEN;
                                    END;
                                lGLAcc."Financial Stmt version FND"::Common:
                                    BEGIN
                                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'COMMON');
                                        IF lPos <> 0 THEN
                                            lGLEntryTMP."Entry No." := GLEntry."Entry No.";
                                        IF lGLEntryTMP.INSERT() THEN;
                                    END;
                                lGLAcc."Financial Stmt version FND"::Heineken:
                                    BEGIN
                                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'HEINEKEN');
                                        IF lPos <> 0 THEN
                                            lGLEntryTMP."Entry No." := GLEntry."Entry No.";
                                        IF lGLEntryTMP.INSERT() THEN;
                                    END;
                                lGLAcc."Financial Stmt version FND"::"Local":
                                    BEGIN
                                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'LOCAL');
                                        IF lPos <> 0 THEN
                                            lGLEntryTMP."Entry No." := GLEntry."Entry No.";
                                        IF lGLEntryTMP.INSERT() THEN;
                                    END;
                            END;
                        END;
                    UNTIL GLEntry.NEXT() = 0;
                IF GLEntry.FINDSET(FALSE) THEN
                    REPEAT
                        IF NOT lGLEntryTMP.GET(GLEntry."Entry No.") THEN
                            GLEntry.MARK(TRUE);
                    UNTIL GLEntry.NEXT() = 0;
                GLEntry.MARKEDONLY(TRUE);
                lGLEntryTMP.DELETEALL();
                //HEI.03>>
            END;
        END;
        //HEI.03<<
        //HEI.02<<
    END;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::AccSchedManagement, OnDrillDownOnGLAccCatFilterOnAfterGLAccSetFilterGroup2, '', false, false)]
    local procedure OnDrillDownOnGLAccCatFilterOnAfterGLAccSetFilterGroup2_DrillDownOnGLAccount(var AccScheduleLine: Record "Acc. Schedule Line"; var GLAccount: Record "G/L Account")
    var
        FinancialStFilter: Text;
        lBlankIsUsed: Boolean;
        lCommonIsUsed: Boolean;
        lLocalIsUsed: Boolean;
        lHeinekenIsUsed: Boolean;
        lNoOfUsedFilters: Integer;
        lPos: Integer;
        lTextFilter: Text;
        GLsetup: Record "General Ledger Setup";

    begin
        //HEI.03>>
        // BC Upgrade PriyaShukla 12/09/25>>
        //GetGLSetup;
        GLsetup.Get();
        // BC Upgrade PriyaShukla 12/09/25<<
        //HEI.03<<

        IF ((GLSetup."P&L by Nature code FND" <> '') AND (AccScheduleLine."Schedule Name" = GLSetup."P&L by Nature code FND")) THEN BEGIN
            //HEI.03<<
            lBlankIsUsed := FALSE;
            lCommonIsUsed := FALSE;
            lLocalIsUsed := FALSE;
            lHeinekenIsUsed := FALSE;
            lNoOfUsedFilters := 0;
            lTextFilter := '';

            FinancialStFilter := AccScheduleLine.GETFILTER("Finan. St. Ver. to Exclude FND");
            IF FinancialStFilter <> '' THEN BEGIN
                lPos := STRPOS(UPPERCASE(FinancialStFilter), 'BLANK');
                IF lPos <> 0 THEN BEGIN
                    lBlankIsUsed := TRUE;
                    lTextFilter += '"Financial Statement version"::" "' + ',';
                    lNoOfUsedFilters += 1;
                END;
                lPos := STRPOS(UPPERCASE(FinancialStFilter), 'LOCAL');
                IF lPos <> 0 THEN BEGIN
                    lLocalIsUsed := TRUE;
                    lNoOfUsedFilters += 1;
                    lTextFilter += '"Financial Statement version"::"Local"' + ',';
                END;
                lPos := STRPOS(UPPERCASE(FinancialStFilter), 'HEINEKEN');
                IF lPos <> 0 THEN BEGIN
                    lHeinekenIsUsed := TRUE;
                    lNoOfUsedFilters += 1;
                    lTextFilter += '"Financial Statement version"::"Heineken"' + ',';
                END;
                lPos := STRPOS(UPPERCASE(FinancialStFilter), 'COMMON');
                IF lPos <> 0 THEN BEGIN
                    lCommonIsUsed := TRUE;
                    lNoOfUsedFilters += 1;
                    lTextFilter += '"Financial Statement version"::"Common"' + ',';
                END;
                IF (lTextFilter <> '') THEN BEGIN
                    lTextFilter := COPYSTR(lTextFilter, 1, STRLEN(lTextFilter) - 1);
                    CASE lNoOfUsedFilters OF
                        1:
                            BEGIN
                                IF lBlankIsUsed THEN
                                    GLAccount.SETFILTER("Financial Stmt version FND", '<>%1', GLAccount."Financial Stmt version FND"::" ");
                                IF lCommonIsUsed THEN
                                    GLAccount.SETFILTER("Financial Stmt version FND", '<>%1', GLAccount."Financial Stmt version FND"::Common);
                                IF lHeinekenIsUsed THEN
                                    GLAccount.SETFILTER("Financial Stmt version FND", '<>%1', GLAccount."Financial Stmt version FND"::Heineken);
                                IF lLocalIsUsed THEN
                                    GLAccount.SETFILTER("Financial Stmt version FND", '<>%1', GLAccount."Financial Stmt version FND"::"Local");
                            END;
                        2:
                            BEGIN
                                IF (lBlankIsUsed AND lLocalIsUsed) THEN
                                    GLAccount.SETFILTER("Financial Stmt version FND", '<>%1&<>%2', GLAccount."Financial Stmt version FND"::" ", GLAccount."Financial Stmt version FND"::"Local");
                                IF (lBlankIsUsed AND lHeinekenIsUsed) THEN
                                    GLAccount.SETFILTER("Financial Stmt version FND", '<>%1&<>%2', GLAccount."Financial Stmt version FND"::" ", GLAccount."Financial Stmt version FND"::Heineken);
                                IF (lBlankIsUsed AND lCommonIsUsed) THEN
                                    GLAccount.SETFILTER("Financial Stmt version FND", '<>%1&<>%2', GLAccount."Financial Stmt version FND"::" ", GLAccount."Financial Stmt version FND"::Common);
                                IF (lCommonIsUsed AND lHeinekenIsUsed) THEN
                                    GLAccount.SETFILTER("Financial Stmt version FND", '<>%1&<>%2', GLAccount."Financial Stmt version FND"::Common, GLAccount."Financial Stmt version FND"::Heineken);
                                IF (lCommonIsUsed AND lLocalIsUsed) THEN
                                    GLAccount.SETFILTER("Financial Stmt version FND", '<>%1&<>%2', GLAccount."Financial Stmt version FND"::Common, GLAccount."Financial Stmt version FND"::"Local");
                                IF (lHeinekenIsUsed AND lLocalIsUsed) THEN
                                    GLAccount.SETFILTER("Financial Stmt version FND", '<>%1&<>%2', GLAccount."Financial Stmt version FND"::Heineken, GLAccount."Financial Stmt version FND"::"Local");
                            END;
                        3:
                            BEGIN
                                IF (lBlankIsUsed AND lCommonIsUsed AND lHeinekenIsUsed) THEN
                                    GLAccount.SETFILTER("Financial Stmt version FND", '<>%1&<>%2&<>%3', GLAccount."Financial Stmt version FND"::" ", GLAccount."Financial Stmt version FND"::Common, GLAccount."Financial Stmt version FND"::Heineken);
                                IF (lBlankIsUsed AND lCommonIsUsed AND lLocalIsUsed) THEN
                                    GLAccount.SETFILTER("Financial Stmt version FND", '<>%1&<>%2&<>%3', GLAccount."Financial Stmt version FND"::" ", GLAccount."Financial Stmt version FND"::Common, GLAccount."Financial Stmt version FND"::"Local");
                                IF (lHeinekenIsUsed AND lCommonIsUsed AND lLocalIsUsed) THEN
                                    GLAccount.SETFILTER("Financial Stmt version FND", '<>%1&<>%2&<>%3', GLAccount."Financial Stmt version FND"::Heineken, GLAccount."Financial Stmt version FND"::Common, GLAccount."Financial Stmt version FND"::"Local");
                                IF (lHeinekenIsUsed AND lBlankIsUsed AND lLocalIsUsed) THEN
                                    GLAccount.SETFILTER("Financial Stmt version FND", '<>%1&<>%2&<>%3', GLAccount."Financial Stmt version FND"::Heineken, GLAccount."Financial Stmt version FND"::" ", GLAccount."Financial Stmt version FND"::"Local");
                            END;
                        4:
                            BEGIN
                                IF (lHeinekenIsUsed AND lBlankIsUsed AND lLocalIsUsed AND lCommonIsUsed) THEN
                                    GLAccount.SETFILTER("Financial Stmt version FND", '<>%1&<>%2&<>%3&<>%4', GLAccount."Financial Stmt version FND"::Heineken, GLAccount."Financial Stmt version FND"::" ", GLAccount."Financial Stmt version FND"::"Local", GLAccount."Financial Stmt version FND"::Common);
                            END;
                    END;
                END;
            END;
            //HEI.03>>
        END;
        //HEI.03<<
        //HEI.02<<
    end;
    // BC Upgrade PriyaShukla 12/09/25<< 




    // BC Upgrade PriyaShukla >>
    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Sales", OnSetUsageFilterOnAfterSetFiltersByReportUsage, '', false, false)]
    local procedure SetUsageFilter_OnSetUsageFilterOnAfterSetFiltersByReportUsage(ReportUsage2: Option; var Rec: Record "Report Selections");
    begin
        case ReportUsage2 of
            //HEI.04<<
            Enum::"Report Selection Usage Sales"::"Delivery Note(Sales Invoice)".AsInteger():
                Rec.SetRange(Usage, Enum::"Report Selection Usage"::"Delivery Note(Sales Invoice)");
            //HEI.04>>
            //<<HEI.06
            Enum::"Report Selection Usage Sales"::"Debit Note".AsInteger():
                Rec.SetRange(Usage, Enum::"Report Selection Usage"::"Debit Note");
            //>>HEI.06
            //BC UPGRADE KUMARR78 >> ++ 03-07-2026
            Enum::"Report Selection Usage Sales"::"Delivery Note(Whse Ship)":
                Rec.SETRANGE(Usage, Enum::"Report Selection Usage"::"Delivery Note(Whse Ship)");
        //BC UPGRADE KUMARR78 >> ++ 03-07-2026
        END;
    end;

    //BC Upgrade Priya <<
    [EventSubscriber(ObjectType::Page, Page::"Contact Card", OnAfterEnableFields, '', false, false)]
    local procedure EnableField_OnAfterEnableFields()
    var
        CompanyInfo: Record "Company Information";
        ContactC: Record Contact;
        "Stock CapitalEnable": Boolean;
        "APE CodeEnable": Boolean;
        "Legal FormEnable": Boolean;
        "Trade RegisterEnable": Boolean;
    begin
        //HEI.01>>
        CompanyInfo.Get();
        if CompanyInfo."Enable French Localization FND" then begin
            "Trade RegisterEnable" := ContactC.Type = ContactC.Type::Company;
            "APE CodeEnable" := ContactC.Type = ContactC.Type::Company;
            "Legal FormEnable" := ContactC.Type = ContactC.Type::Company;
            "Stock CapitalEnable" := ContactC.Type = ContactC.Type::Company;
        end;
        //HEI.01<<
    end;
    //BC Upgrade Priya <<
    // BC Upgrade PriyaShukla<< 
    //BC UPGRADE ATHUKS01 >>
    //1.Event OnBeforeAutoArchivePurchDocument PurchCommmentLine commneted due to if condtion is used drink it fields
    // BC UPGRADE ATHUKS01<<    
    //BC Upgrade Manisha CU #5063ArchiveManagement and Calculate BOM Tree>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnBeforeAutoArchivePurchDocument', '', false, false)]
    local procedure OnBeforeAutoArchivePurchDocument(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        PurchCommmentLine: Record "Purch. Comment Line";
        Text010: label 'Comment must have a value in Document Type %1, No. %2';
        ArchiveMgt: Codeunit ArchiveManagement;
    begin
        // /BC UPGRADE ATHUKUS01 FDDSTP_007>> 
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) AND not PurchaseHeader."Call From OnDelete FND" then begin
            IsHandled := true;
            exit;
        end;
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo") AND not PurchaseHeader."Call From OnDelete FND" then begin
            IsHandled := true;
            exit;
        end;
        // /BC UPGRADE ATHUKUS01 FDDSTP_007 <<
        PurchasesPayablesSetup.GET();
        //>>HEI.02
        //BC UPGRADE SHUKLP03 >> Document subtype code
        IF PurchasesPayablesSetup."Auto.Arch.Del. Inv&CrMemos FND" AND (PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Credit Memo"]) AND
            ((PurchasesPayablesSetup."PO Subtype Code FND" = PurchaseHeader."Document Subtype Code FND") OR (PurchasesPayablesSetup."NPO Subtype Code FND" = PurchaseHeader."Document Subtype Code FND") OR
            (PurchasesPayablesSetup."Expense Claim Subdoc. Type FND" = PurchaseHeader."Document Subtype Code FND") OR (PurchasesPayablesSetup."Expense ClaimCMSubdoc Type FND" = PurchaseHeader."Document Subtype Code FND")) THEN BEGIN
            PurchCommmentLine.RESET();
            PurchCommmentLine.SETFILTER("Document Type", '=%1|%2', PurchCommmentLine."Document Type"::Invoice, PurchCommmentLine."Document Type"::"Credit Memo");
            PurchCommmentLine.SETFILTER("No.", PurchaseHeader."No.");
            IF (NOT PurchCommmentLine.FINDFIRST()) OR (PurchCommmentLine.Comment = '') THEN
                ERROR(Text010, PurchaseHeader."Document Type", PurchaseHeader."No.");

        END;
        //BC UPGRADE SHUKLP03 << Document subtype code
        //<<HEI.02
        //IF NOT (PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::Order,PurchaseHeader."Document Type"::Quote]) THEN
        IF NOT (PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Quote,
                PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Credit Memo"]) THEN //HEI.01 - NEW
            IsHandled := true; // /BC UPGRADE ATHUKUS01 FDDSTP_007>> 
                               // EXIT;
                               //BC UPGRADE ATHUKUS01 FDDSTP_007 >>   
        if PurchaseHeader."Document Type" In [PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Credit Memo"] then begin
            ArchiveMgt.ArchPurchDocumentNoConfirm(PurchaseHeader);
            PurchaseHeader."Call From OnDelete FND" := false;
            IsHandled := true;
        end
        //BC UPGRADE ATHUKUS01 FDDSTP_007 <<
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnBeforeArchivePurchDocument', '', false, false)]
    // local procedure OnBeforeArchivePurchDocument(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    // var
    //     //ConfirmManagement: Codeunit "Confirm Management";
    //     gRecUserSetUp: Record "User Setup";
    //     UnAuthorisedArchive: Label 'You are not allowed to Archive this Document';
    //     Text007: Label 'Archive %1 no.: %2?';
    //     Text001: Label 'Document %1 has been archived.';
    //     ArchiveManagement: Codeunit ArchiveManagement;
    // begin
    //     //>>HEI.05
    //     IF NOT PurchaseHeader.ISTEMPORARY THEN BEGIN
    //         IF PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Quote THEN BEGIN//HEi.06
    //             IF gRecUserSetUp.GET(USERID) THEN BEGIN
    //                 IF NOT gRecUserSetUp."Allow Delete/Archive PO/Return" THEN
    //                     ERROR(UnAuthorisedArchive);
    //             END;
    //         END;//HEI.06
    //     END;
    //     //<<HEI.05

    //     IF NOT DontShowMsg THEN BEGIN //HEI.07
    //         IF CONFIRM(
    //              Text007, TRUE, PurchaseHeader."Document Type",
    //              PurchaseHeader."No.")
    //         THEN BEGIN
    //             ArchiveManagement.StorePurchDocument(PurchaseHeader, FALSE);
    //             MESSAGE(Text001, PurchaseHeader."No.");
    //             //  END; //HEI.07
    //             //>>HEI.07
    //         END;
    //     END ELSE BEGIN
    //         ArchiveManagement.StorePurchDocument(PurchaseHeader, FALSE);
    //     END;
    //     //<<HEI.07
    //     IsHandled := true;
    // end;//BC Upgrade SHARMP16--Testscriptchanges140326 -- shifted to HNK_ReverseEntryCU

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnAfterPurchHeaderArchiveInsert', '', false, false)]
    local procedure OnAfterPurchHeaderArchiveInsert(var PurchaseHeaderArchive: Record "Purchase Header Archive"; PurchaseHeader: Record "Purchase Header")
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchaseHeaderArchiveAddit: Record "Purchase Header Arch Addit FND";
    begin
        //HEI.04>>
        IF PurchaseHeaderAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") THEN
            IF NOT PurchaseHeaderArchiveAddit.GET(PurchaseHeader."Document Type", PurchaseHeader."No.", PurchaseHeaderArchive."Doc. No. Occurrence", PurchaseHeaderArchive."Version No.") THEN BEGIN
                PurchaseHeaderArchiveAddit.INIT();
                PurchaseHeaderArchiveAddit.TRANSFERFIELDS(PurchaseHeaderAdditional);
                PurchaseHeaderArchiveAddit.INSERT();
            END ELSE
                IF (PurchaseHeaderArchiveAddit."PQ Approver" = '') AND (PurchaseHeaderAdditional."PQ Approver" <> '') THEN BEGIN
                    PurchaseHeaderArchiveAddit."PQ Approver" := PurchaseHeaderAdditional."PQ Approver";
                    PurchaseHeaderArchiveAddit.MODIFY();
                END;
        //HEI.04<<
    end;

    procedure ArchivingViaDeletionPOPro(LPDontShowMsg: Boolean)
    begin
        //>>HEI.07
        DontShowMsg := LPDontShowMsg;
        //<<HEI.07
    end;
    // BC UPgrade MAnisha Archive Management END
    //BC Upgrade Manisha Calculate BOM Tree start>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate BOM Tree", 'OnGenerateBOMCompSubTreeOnBeforeLoopBOMComponents', '', false, false)]
    local procedure OnGenerateBOMCompSubTreeOnBeforeLoopBOMComponents(ParentItem: Record Item; var IsHandled: Boolean)
    var
        BOMComp: Record "BOM Component";
        ParentBOMBuffer: Record "BOM Buffer";
        UOMMgt: Codeunit "Unit of Measure Management";
        CalculateBOMTree: Codeunit "Calculate BOM Tree";
        //ParentItem2: Record Item;
        BOMBuffer: Record "BOM Buffer";
        DemandDate: Date;
        TreeType: Option " ",Availability,Cost;
        ItemFilter: Record Item;
        EntryNo: Integer;
        HeinkinBCCustomFunction: Codeunit "Heineken BC Custom Functions";
    begin
        //BC Upgrade Kamnay01 commented the code >>
        //BC Upgrade Gunrem01 >> Item availability by BOM level

        // IF InHeinekenBOMProcessing THEN BEGIN
        //     IF EnableHeinekenBOMTrace THEN
        //         MESSAGE('Heineken BOM re-entry blocked at %1 for Item %2', 'OnGenerateBOMCompSubTreeOnBeforeLoopBOMComponents', ParentItem."No.");
        //     IsHandled := true;
        //     EXIT;
        // END;
        // InHeinekenBOMProcessing := TRUE;
        // CurrentBOMDepth += 1;
        // IF MaxBOMDepth = 0 THEN
        //     MaxBOMDepth := 50;
        // IF CurrentBOMDepth > MaxBOMDepth THEN BEGIN
        //     InHeinekenBOMProcessing := FALSE;
        //     ERROR('Heineken BOM depth exceeded %1', MaxBOMDepth);
        // END;
        //BC Upgrade Gunrem01 <<Item availability by BOM level

        //CalculateBOMTree.GenerateTreeForItem(ParentItem, BOMBuffer, DemandDate, TreeType);// BC Upgrade Manisha used this function to get variable value because we don't have variables in the base event 
        //BC Upgrade Kamnay01 commented the code <<
        ItemFilter := ParentItem;
        ParentBOMBuffer := BOMBuffer;
        repeat
            if (BOMComp."No." <> '') and ((BOMComp.Type = BOMComp.Type::Item) or (TreeType in [TreeType::" ", TreeType::Cost])) then begin
                BOMBuffer.SetLocationVariantFiltersFrom(ItemFilter);
                //HEI.03>>
                BOMBuffer.ActivateBlankVersionCode(ForBlankVersionCode);
                //HEI.03<<
                BOMBuffer.TransferFromBOMComp(
                  EntryNo, BOMComp, ParentBOMBuffer.Indentation + 1,
                  Round(
                    ParentBOMBuffer."Qty. per Top Item" *
                    UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code"), UOMMgt.QtyRndPrecision()),
                  Round(
                    ParentBOMBuffer."Scrap Qty. per Top Item" *
                    UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code"), UOMMgt.QtyRndPrecision()),
                  HeinkinBCCustomFunction.CalcCompDueDate(ParentBOMBuffer."Needed by Date", ParentItem, BOMComp."Lead-Time Offset"),
                  ParentBOMBuffer."Location Code");
                if BOMComp.Type = BOMComp.Type::Item then
                    HeinkinBCCustomFunction.GenerateItemSubTree(BOMComp."No.", BOMBuffer);
            end;
        until BOMComp.Next() = 0;
        BOMBuffer := ParentBOMBuffer;
        //BC upgrade Kamnay01 // Code commented>>
        //BC Upgrade Gunrem01 >> Item availability by BOM level

        // InHeinekenBOMProcessing := FALSE;
        // IF CurrentBOMDepth > 0 THEN
        //     CurrentBOMDepth -= 1;
        //BC Upgrade Gunrem01 << Item availability by BOM level
        //BC upgrade Kamnay01 // Code commented<<
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate BOM Tree", 'OnBeforeFilterByQuantityPer', '', false, false)]
    local procedure OnBeforeFilterByQuantityPer(var ProductionBOMLine: Record "Production BOM Line"; var IsHandled: Boolean; BOMBuffer: Record "BOM Buffer")
    var
        VersionMgt: Codeunit VersionManagement;
        StockkeepingUnit: Record "Stockkeeping Unit";
        // BOMBuffer2: Record "BOM Buffer";
        DemandDate: Date;
        TreeType: Option " ",Availability,Cost;
        ParentItem: Record Item;
        CalculateBOMTree: Codeunit "Calculate BOM Tree";
        HeinekenBcUpgrade: Codeunit "Heineken BC Upgrade";
        ManufacturingSetup: record "Manufacturing Setup";// BC Upgrade Kamnay01 Bug Fix -- Item Availability by Bom level
    begin
        // BC Upgrade Kamnay01 Bug Fix -- Item Availability by Bom level>>
        ManufacturingSetup.GET();
        ParentItem.Get(ManufacturingSetup."BOM Item FND"); //Bomitem field is created to store the Bom item value 
        // BC Upgrade Kamnay01 Bug Fix -- Item Availability by Bom level<<
        // CalculateBOMTree.generateTreeForItem(ParentItem, BOMBuffer, DemandDate, TreeType);// BC Upgrade Manisha used this function to get variable value because we don't have variables in the base event
        IF NOT RunFromStockKeepingUnit THEN BEGIN
            // BC Upgrade Kamnay01 >>  
            //ProductionBOMLine.SetRange("Production BOM No.", ParentItem."Production BOM No.");
            //ProductionBOMLine.SetRange("Version Code", VersionMgt.GetBOMVersion(ParentItem."Production BOM No.", WorkDate(), true));              
            ProductionBOMLine.SetRange("Production BOM No.", BOMBuffer."Production BOM No.");
            ProductionBOMLine.SetRange("Version Code", GetBOMVersion_DTW(BOMBuffer."Production BOM No.", WorkDate(), true));
            // BC Upgrade Kamnay01 <<
            ProductionBOMLine.SetFilter("Starting Date", '%1|..%2', 0D, BOMBuffer."Needed by Date");
            ProductionBOMLine.SetFilter("Ending Date", '%1|%2..', 0D, BOMBuffer."Needed by Date");
        end else begin
            //HEI.01>>
            IF StockkeepingUnit.GET(StockkeepingUnit2."Location Code", ParentItem."No.", StockkeepingUnit."Variant Code") THEN BEGIN
                ParentItem."Replenishment System" := StockkeepingUnit."Replenishment System";
                IF ParentItem."Replenishment System" = ParentItem."Replenishment System"::"Prod. Order" THEN BEGIN
                    ParentItem."Production BOM No." := StockkeepingUnit."Production BOM No.";
                    ParentItem."Routing No." := StockkeepingUnit."Routing No.";//13.09
                END;

                ProductionBOMLine.SETRANGE("Production BOM No.", ParentItem."Production BOM No.");
                //HEI.03>>
                //VersionMgt.ActivateBlankVersionCode(ForBlankVersionCode);//BC Upgrade Manisha object referance changed
                HeinekenBcUpgrade.ActivateBlankVersionCode(ForBlankVersionCode);
                //HEI.03<<
                //HEI.02>>
                ProductionBOMLine.SETRANGE("Version Code", VersionMgt.GetBOMVersion(ParentItem."Production BOM No.", WORKDATE(), TRUE));
                //SETRANGE("Version Code",'DEFAULT');
                //HEI.02<<
                //ParentItem."Replenishment System" := ParentItem."Replenishment System"::"Prod. Order";

                //HEI.01<<
            END;
        end;
        IsHandled := true;
        Clear(ManufacturingSetup."BOM Item FND");  // BC Upgrade Kamnay01 Bug Fix -- Item Availability by Bom level
    end;

    // BC Upgrade Kamnay01 Bug Fix -- Item Availability by Bom level>> subscribe this event to store the value of item no
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate BOM Tree", OnGenerateItemSubTreeOnAfterParentItemGet, '', false, false)]
    local procedure "Calculate BOM Tree_OnGenerateItemSubTreeOnAfterParentItemGet"(var ParentItem: Record Item)
    var
        ManufacturingSetup: Record "Manufacturing Setup";
    begin
        IF ParentItem."No." <> '' THEN BEGIN
            ManufacturingSetup.GET();
            ManufacturingSetup."BOM Item FND" := ParentItem."No.";
            ManufacturingSetup.MODIFY(false);
        END;
    end;
    // BC Upgrade Kamnay01 Bug Fix -- Item Availability by Bom level<<
    //BC Upgrade Kamnay01  Commented the event becuase to consider running the std code >>
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate BOM Tree", 'OnBeforeTransferProdBOMLine', '', false, false)]
    // local procedure OnBeforeTransferProdBOMLine(var BOMBuffer: Record "BOM Buffer"; var ProdBOMLine: Record "Production BOM Line"; var ParentItem: Record Item; var ParentBOMBuffer: Record "BOM Buffer"; var EntryNo: Integer; TreeType: Option " ",Availability,Cost; var IsHandled: Boolean)
    // var
    //     CalculateBOMTree: Codeunit "Calculate BOM Tree";
    //     //ParentItem2: Record Item;
    //     DemandDate: Date;
    //     ItemFilter: Record Item;
    //     BomQtyPerUom: Decimal;
    //     HeinkinCustomFunctionCU: Codeunit "Heineken BC Custom Functions";
    //     VersionMgt: Codeunit VersionManagement;
    //     UOMMgt: Codeunit "Unit of Measure Management";
    //     MfgCostCalcMgt: Codeunit "Mfg. Cost Calculation Mgt.";
    //     RoutingLine: Record "Routing Line";
    //     CopyOfParentItem: Record Item;
    //     //BOMBuffer2: Record "BOM Buffer";
    //     HeinekenBcUpgrade: Codeunit "Heineken BC Upgrade";
    // begin
    //     // CalculateBOMTree.GenerateTreeForItem(ParentItem, BOMBuffer, DemandDate, TreeType);        //BC Upgrade Gunrem01  Item availability by BOM level
    //     if ProdBOMLine."No." <> '' then
    //         case ProdBOMLine.Type of
    //             ProdBOMLine.Type::Item:
    //                 begin
    //                     BOMBuffer.SetLocationVariantFiltersFrom(ItemFilter);
    //                     //HEI.03>>
    //                     BOMBuffer.ActivateBlankVersionCode(ForBlankVersionCode);
    //                     //HEI.03<<
    //                     IF NOT RunFromStockKeepingUnit THEN
    //                         BomQtyPerUom :=
    //                         GetQtyPerBOMHeaderUnitOfMeasure(
    //                         ParentItem, ParentBOMBuffer."Production BOM No.",
    //                         VersionMgt.GetBOMVersion(ParentBOMBuffer."Production BOM No.", WorkDate(), true))
    //                     else begin
    //                         //HEI.01>>
    //                         // {
    //                         // BomQtyPerUom :=
    //                         //     GetQtyPerBOMHeaderUnitOfMeasure(
    //                         //       ParentItem,ParentBOMBuffer."Production BOM No.",VersionMgt.GetBOMVersion(ParentBOMBuffer."Production BOM No.",WORKDATE,TRUE));//'DEFAULT');
    //                         // BOMBuffer.SetRunParam(StockkeepingUnit2,TRUE);
    //                         // }
    //                         //HEI.01<<
    //                         //HEI.03>>
    //                         //VersionMgt.ActivateBlankVersionCode(ForBlankVersionCode);//Bc Upgrade Manisha Object referance changed
    //                         HeinekenBcUpgrade.ActivateBlankVersionCode(ForBlankVersionCode);//Bc Upgrade Manisha Object referance changed
    //                         //HEI.03<<
    //                         //HEI.02>>
    //                         BomQtyPerUom :=
    //                             GetQtyPerBOMHeaderUnitOfMeasure(
    //                               ParentItem, ParentBOMBuffer."Production BOM No.",
    //                               VersionMgt.GetBOMVersion(ParentBOMBuffer."Production BOM No.", WORKDATE(), TRUE));
    //                         BOMBuffer.SetRunParam(StockkeepingUnit2, TRUE);
    //                         //HEI.02<<
    //                     end;
    //                     BOMBuffer.TransferFromProdComp(
    //                     EntryNo, ProdBOMLine, ParentBOMBuffer.Indentation + 1,
    //                     Round(
    //                         ParentBOMBuffer."Qty. per Top Item" *
    //                         UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code"), UOMMgt.QtyRndPrecision()),
    //                     Round(
    //                         ParentBOMBuffer."Scrap Qty. per Top Item" *
    //                         UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code"), UOMMgt.QtyRndPrecision()),
    //                     ParentBOMBuffer."Scrap %",
    //                     HeinkinCustomFunctionCU.CalcCompDueDate(ParentBOMBuffer."Needed by Date", ParentItem, ProdBOMLine."Lead-Time Offset"),
    //                     ParentBOMBuffer."Location Code",
    //                     ParentItem, BomQtyPerUom);

    //                     if ParentItem."Production BOM No." <> ParentBOMBuffer."Production BOM No." then begin
    //                         BOMBuffer."Qty. per Parent" := BOMBuffer."Qty. per Parent" * ParentBOMBuffer."Qty. per Parent";
    //                         BOMBuffer."Scrap Qty. per Parent" := BOMBuffer."Scrap Qty. per Parent" * ParentBOMBuffer."Qty. per Parent";
    //                         BOMBuffer."Qty. per BOM Line" := BOMBuffer."Qty. per BOM Line" * ParentBOMBuffer."Qty. per Parent";
    //                     end;
    //                     // OnAfterTransferFromProdItem(BOMBuffer, ProdBOMLine, EntryNo);
    //                     //BC Upgrade Gunrem01 >> Item availability by BOM level Removed to prevent duplicate BOM Buffer entries
    //                     // HeinkinCustomFunctionCU.GenerateItemSubTree(ProdBOMLine."No.", BOMBuffer);
    //                     //BC Upgrade Gunrem01 << Item availability by BOM level Removed to prevent duplicate BOM Buffer entries
    //                     // OnGenerateProdCompSubTreeOnAfterGenerateItemSubTree(ParentBOMBuffer, BOMBuffer);
    //                 end;
    //             ProdBOMLine.Type::"Production BOM":
    //                 begin
    //                     //OnBeforeTransferFromProdBOM(BOMBuffer, ProdBOMLine, ParentItem, ParentBOMBuffer, EntryNo, TreeType);

    //                     BOMBuffer := ParentBOMBuffer;
    //                     BOMBuffer."Qty. per Top Item" := Round(BOMBuffer."Qty. per Top Item" * ProdBOMLine."Quantity per", UOMMgt.QtyRndPrecision());
    //                     if ParentItem."Production BOM No." <> ParentBOMBuffer."Production BOM No." then
    //                         BOMBuffer."Qty. per Parent" := ParentBOMBuffer."Qty. per Parent" * ProdBOMLine."Quantity per"
    //                     else
    //                         BOMBuffer."Qty. per Parent" := ProdBOMLine."Quantity per";

    //                     BOMBuffer."Scrap %" := HeinkinCustomFunctionCU.CombineScrapFactors(BOMBuffer."Scrap %", ProdBOMLine."Scrap %");
    //                     if MfgCostCalcMgt.FindRoutingLine(RoutingLine, ProdBOMLine, WorkDate(), ParentItem."Routing No.") then
    //                         BOMBuffer."Scrap %" := HeinkinCustomFunctionCU.CombineScrapFactors(BOMBuffer."Scrap %", RoutingLine."Scrap Factor % (Accumulated)" * 100);
    //                     BOMBuffer."Scrap %" := Round(BOMBuffer."Scrap %", 0.00001);

    //                     //OnAfterTransferFromProdBOM(BOMBuffer, ProdBOMLine);

    //                     CopyOfParentItem := ParentItem;
    //                     ParentItem."Routing No." := '';
    //                     ParentItem."Production BOM No." := ProdBOMLine."No.";
    //                     //BC Upgrade Gunrem01 >> Item availability by BOM level Removed to prevent duplicate BOM Buffer entries
    //                     // HeinkinCustomFunctionCU.GenerateProdCompSubTree(ParentItem, BOMBuffer);//Yashraj 24-06-2026
    //                     //BC Upgrade Gunrem01 << Item availability by BOM level Removed to prevent duplicate BOM Buffer entries
    //                     ParentItem := CopyOfParentItem;

    //                     //OnAfterGenerateProdCompSubTree(ParentItem, BOMBuffer, ParentBOMBuffer);
    //                 end;
    //         end;
    //     IsHandled := true;
    // end;
    //BC Upgrade Kamnay01  Commented the event becuase to consider running the std code <<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate BOM Tree", 'OnAfterTransferFromProdRouting', '', false, false)]
    local procedure OnAfterTransferFromProdRouting(var BOMBuffer: Record "BOM Buffer"; var RoutingLine: Record "Routing Line")
    var
    begin
        //HEI.03>>
        BOMBuffer.ActivateBlankVersionCode(ForBlankVersionCode);
        //HEI.03<<
    end;
    //
    procedure SetRunParam(RunFromSKU: Boolean)
    begin
        RunFromStockKeepingUnit := RunFromSKU;
    end;

    procedure ActivateBlankVersionCode(IsBlankVersionCode: Boolean): Boolean
    begin
        //HEI.03>>
        ForBlankVersionCode := IsBlankVersionCode;
        //HEI.03<<
    end;

    procedure GetQtyPerBOMHeaderUnitOfMeasure(Item: Record Item; ProdBOMNo: Code[20]; ProdBOMVersionNo: Code[20]): Decimal
    var
        UOMMgt: Codeunit "Unit of Measure Management";
        VersionMgtL: Codeunit VersionManagement;
        HeinkinBCcustomFunctionCU: Codeunit "Heineken BC Custom Functions";
    begin
        if ProdBOMNo = '' then
            exit(1);
        //HEI.03>>
        IF ForBlankVersionCode THEN
            EXIT(UOMMgt.GetQtyPerUnitOfMeasure(Item, VersionMgtL.GetBOMUnitOfMeasure(ProdBOMNo, '')))
        ELSE
            //HEI.03<<
            exit(UOMMgt.GetQtyPerUnitOfMeasure(Item, HeinkinBCcustomFunctionCU.GetBOMUnitOfMeasure(ProdBOMNo, ProdBOMVersionNo)));
    end;

    procedure GenerateItemSubTreeSKU(ItemNo: Code[20]; VAR BOMBuffer: Record "BOM Buffer"; StockkeepingUnit: Record "Stockkeeping Unit"): Boolean
    var
        ParentItem: Record Item;
        TempItem: Record Item temporary;
        HeinkinBCFunctionCU: Codeunit "Heineken BC Custom Functions";
    begin
        //HEI.01>>
        StockkeepingUnit2 := StockkeepingUnit;
        ParentItem.GET(ItemNo);
        //ParentItem."Replenishment System" := ParentItem."Replenishment System"::"Prod. Order";
        ParentItem."Replenishment System" := StockkeepingUnit2."Replenishment System";
        ;
        IF ParentItem."Replenishment System" = ParentItem."Replenishment System"::"Prod. Order" THEN BEGIN
            ParentItem."Production BOM No." := StockkeepingUnit."Production BOM No.";
            ParentItem."Routing No." := StockkeepingUnit."Routing No.";
        END;
        IF TempItem.GET(ItemNo) THEN BEGIN
            BOMBuffer."Is Leaf" := FALSE;
            BOMBuffer.MODIFY(TRUE);
            EXIT(FALSE);
        END;
        TempItem := ParentItem;
        TempItem.INSERT();

        IF ParentItem."Replenishment System" = ParentItem."Replenishment System"::"Prod. Order" THEN BEGIN
            BOMBuffer."Is Leaf" := NOT HeinkinBCFunctionCU.GenerateProdCompSubTree(ParentItem, BOMBuffer);
            IF BOMBuffer."Is Leaf" THEN
                BOMBuffer."Is Leaf" := NOT HeinkinBCFunctionCU.GenerateBOMCompSubTree(ParentItem, BOMBuffer);
        END ELSE BEGIN
            BOMBuffer."Is Leaf" := NOT HeinkinBCFunctionCU.GenerateBOMCompSubTree(ParentItem, BOMBuffer);
            IF BOMBuffer."Is Leaf" THEN
                BOMBuffer."Is Leaf" := NOT HeinkinBCFunctionCU.GenerateProdCompSubTree(ParentItem, BOMBuffer);
        END;
        BOMBuffer.MODIFY(TRUE);

        TempItem.GET(ItemNo);
        TempItem.DELETE();
        EXIT(NOT BOMBuffer."Is Leaf");
    end;

    procedure GenerateTreeForItemSKULocal(VAR ParentItem: Record Item; VAR BOMBuffer: Record "BOM Buffer"; DemandDate: Date; TreeType: Option; StockkeepingUnit: Record "Stockkeeping Unit")
    var
        BOMComp: Record "BOM Component";
        ProdBOMLine: Record "Production BOM Line";
        ItemFilter: Record Item;
        EntryNo: Integer;
        ShowTotalAvailability: Boolean;
        HeinkinBCUpgrade: Codeunit "Heineken BC Custom Functions";
    begin
        //InitVars;
        BOMComp.SETRANGE(Type, BOMComp.Type::Item);
        BOMComp.SETRANGE("No.", ParentItem."No.");

        ProdBOMLine.SETRANGE(Type, ProdBOMLine.Type::Item);
        ProdBOMLine.SETRANGE("No.", ParentItem."No.");

        IF StockkeepingUnit.HasBOM() OR (StockkeepingUnit."Routing No." <> '') THEN BEGIN
            BOMBuffer.SetLocationVariantFiltersFrom(ItemFilter);
            BOMBuffer.SetRunParam(StockkeepingUnit, TRUE);
            //HEI.03>>
            BOMBuffer.ActivateBlankVersionCode(ForBlankVersionCode);
            //HEI.03<<
            BOMBuffer.TransferFromItem(EntryNo, ParentItem, DemandDate);
            GenerateItemSubTreeSKU(ParentItem."No.", BOMBuffer, StockkeepingUnit);
            HeinkinBCUpgrade.CalculateTreeType(BOMBuffer, ShowTotalAvailability, TreeType);
        END;
    end;

    //BC Upgrade Manisha CU Archive Management<<
    //BC Upgrade Manisha Table BOM Buffer Start>>
    [EventSubscriber(ObjectType::Table, Database::"BOM Buffer", OnBeforeInitFromItem, '', false, false)]
    LOCAL procedure OnBeforeInitFromItem(var BOMBuffer: Record "BOM Buffer"; Item: Record Item; var IsHandled: Boolean)
    var
        StockkeepingUnit3: Record "Stockkeeping Unit";
        BOMVersion: Record "Production BOM Version";
        VersionMgt: Codeunit VersionManagement;
        SKU: Record "Stockkeeping Unit";
        VersionCode: Code[20];
        ProductionBOMCheck: Codeunit "Production BOM-Check";
        HeinekenBcUpgrade: Codeunit "Heineken BC Upgrade";
        HeinekenBCCustomFunction: Codeunit "Heineken BC Custom Functions";
    begin
        //BC Upgrade Kamnay01 >> code commented 
        //BC Upgrade Gunrem01 >> Item availability by BOM level

        // IF InHeinekenBOMProcessing THEN BEGIN
        //     IF EnableHeinekenBOMTrace THEN
        //         MESSAGE('Heineken BOM re-entry blocked at %1 for Item %2', 'OnBeforeInitFromItem', Item."No.");
        //     IsHandled := true;
        //     EXIT;
        // END;
        // InHeinekenBOMProcessing := TRUE;
        // CurrentBOMDepth += 1;
        // IF MaxBOMDepth = 0 THEN
        //     MaxBOMDepth := 50;
        // IF CurrentBOMDepth > MaxBOMDepth THEN BEGIN
        //     InHeinekenBOMProcessing := FALSE;
        //     ERROR('Heineken BOM depth exceeded %1', MaxBOMDepth);
        // END;
        //BC Upgrade Gunrem01 <<Item availability by BOM level
        //BC Upgrade Kamnay01 << code commented 
        //MY
        BOMBuffer.Type := BOMBuffer.Type::Item;
        BOMBuffer."No." := Item."No.";
        BOMBuffer.Description := Item.Description;
        BOMBuffer."Unit of Measure Code" := Item."Base Unit of Measure";

        //HEI.01>>
        IF RunFromStockKeepingUnit THEN BEGIN
            IF StockkeepingUnit3.GET(StockkeepingUnit2."Location Code", BOMBuffer."No.", StockkeepingUnit2."Variant Code") THEN BEGIN
                BOMBuffer."Production BOM No." := StockkeepingUnit3."Production BOM No.";
                BOMBuffer."Routing No." := StockkeepingUnit3."Routing No.";
                BOMBuffer."Replenishment System" := StockkeepingUnit3."Replenishment System";
                IF BOMBuffer."Replenishment System" = "Replenishment System"::"Prod. Order" THEN BEGIN
                    //HEI.03>>
                    BOMVersion.RESET();
                    BOMVersion.SETRANGE(BOMVersion."Production BOM No.", StockkeepingUnit3."Production BOM No.");
                    //HEI.04>>
                    IF ForBlankVersionCode THEN
                        BOMVersion.SETRANGE("Version Code", '')
                    ELSE
                        //HEI.04<<
                        BOMVersion.SETRANGE(BOMVersion."Active FND", TRUE);
                    IF BOMVersion.FINDFIRST() THEN
                        // VersionCode := BOMVersion."Version Code";//BC upgrade Kamnay01 std cost 07-5-2026
                       VersionCode := '';//BC upgrade Kamnay01 std cost 07-5-2026
                    //VersionCode := 'DEFAULT';
                    //HEI.03<<
                    //HEI.04>>
                    //VersionMgt.ActivateBlankVersionCode(ForBlankVersionCode);//Bc Upgrade Manisha Object Referance Changed
                    HeinekenBcUpgrade.ActivateBlankVersionCode(ForBlankVersionCode);//Bc Upgrade Manisha Object Referance Changed
                    //HEI.04<<
                    BOMBuffer."BOM Unit of Measure Code" := VersionMgt.GetBOMUnitOfMeasure(BOMBuffer."Production BOM No.", VersionCode);
                END;
            END;
        END ELSE BEGIN//HEI.01<<

            BOMBuffer."Production BOM No." := Item."Production BOM No.";
            BOMBuffer."Routing No." := Item."Routing No.";
            //if GetSKUFromFilter(SKU, BOMBuffer."No.") then //BC Upgrade Manisha
            //BC Upgrade Kamnay01 code commented >>
            // if HeinekenBCCustomFunction.GetSKUFromFilter(SKU, BOMBuffer."No.") then //BC Upgrade Manisha
            //     BOMBuffer."Replenishment System" := SKU."Replenishment System"
            //BC Upgrade Kamnay01 code commented <<
            //else
            BOMBuffer."Replenishment System" := Item."Replenishment System";
            // BC Upgrade Kamnay01 >>
            if BOMBuffer.GetFilter("Location Code") <> '' then
                if SKU.Get(CopyStr(DelChr(BOMBuffer.GetFilter("Location Code"), '=', ''''), 1, MaxStrLen(SKU."Location Code")), BOMBuffer."No.", CopyStr(DelChr(BOMBuffer.GetFilter("Variant Code"), '=', ''''), 1, MaxStrLen(SKU."Variant Code"))) then begin
                    BOMBuffer."Replenishment System" := SKU."Replenishment System";
                    BOMBuffer."Production BOM No." := SKU."Production BOM No.";
                end;
            // BC Upgrade Kamnay01 <<
            if BOMBuffer."Replenishment System" = "Replenishment System"::"Prod. Order" then begin
                // VersionCode := VersionMgt.GetBOMVersion(BOMBuffer."Production BOM No.", WorkDate(), true); // BC Upgrade Kamnay01 Bug fix std cost 23-06-2026

                VersionCode := GetBOMVersion_DTW(BOMBuffer."Production BOM No.", WorkDate(), true);// BC Upgrade Kamnay01 Bug fix std cost 23-06-2026
                BOMBuffer."BOM Unit of Measure Code" := VersionMgt.GetBOMUnitOfMeasure(BOMBuffer."Production BOM No.", VersionCode);
                // BC Upgrade Kamnay01 >>
                // VersionCode := '';
                // CheckBOM_DTW(BOMBuffer."Production BOM No.", VersionCode);
                // BC Upgrade Kamnay01 <<
            end;
        end;
        BOMBuffer."Lot Size" := Item."Lot Size";
        BOMBuffer."Scrap %" := Item."Scrap %";
        BOMBuffer."Indirect Cost %" := Item."Indirect Cost %";
        BOMBuffer."Overhead Rate" := Item."Overhead Rate";
        BOMBuffer."Low-Level Code" := Item."Low-Level Code";
        BOMBuffer."Rounding Precision" := Item."Rounding Precision";
        BOMBuffer."Lead Time Calculation" := Item."Lead Time Calculation";
        BOMBuffer."Safety Lead Time" := Item."Safety Lead Time";
        BOMBuffer."Inventoriable" := Item.IsInventoriableType();

        BOMBuffer.SetRange("Location Code");
        BOMBuffer.SetRange("Variant Code");
        //BC Upgrade Kamnay01 // Code commented >>
        //BC Upgrade Gunrem01 >> Item availability by BOM level
        // InHeinekenBOMProcessing := FALSE;
        // IF CurrentBOMDepth > 0 THEN
        //     CurrentBOMDepth -= 1;
        //BC Upgrade Gunrem01 << Item availability by BOM level
        //BC Upgrade Kamnay01 // Code commented <<
        IsHandled := true;
    end;
    //BC Upgrade kamnay01 std cost >>
    procedure GetBOMVersion_DTW(BOMHeaderNo: Code[20]; Date: Date; OnlyCertified: Boolean) VersionCode: Code[20]

    var
        ProductionBOMVersion: Record "Production BOM Version";
    begin
        ProductionBOMVersion.SetCurrentKey("Production BOM No.", "Starting Date");
        ProductionBOMVersion.SetRange("Production BOM No.", BOMHeaderNo);

        // HEI.02 >>
        if ForBlankVersionCode then
            ProductionBOMVersion.SetRange("Version Code", '')
        ELSE
            //HEI.02<<
            // HEI.01 >> 
            ProductionBOMVersion.SetRange("Active FND", true);//Only Active versions


        if OnlyCertified then
            ProductionBOMVersion.SetRange(Status, ProductionBOMVersion.Status::Certified)
        else
            ProductionBOMVersion.SetFilter(Status, '<>%1', ProductionBOMVersion.Status::Closed);
        ProductionBOMVersion.SetLoadFields("Version Code");
        if not ProductionBOMVersion.FindLast() then begin
            VersionCode := '';
            exit;
        end;

        //VersionCode := ''; // BC Upgrade kamnay01 
        VersionCode := ProductionBOMVersion."Version Code" // BC Upgrade kamnay01 
    end;

    procedure CheckBOM_DTW(ProductionBOMNo: Code[20]; VersionCode: Code[20])
    var
        TempProductionBOMHeader: Record "Production BOM Header" temporary;
    begin
        TempProductionBOMHeader."No." := ProductionBOMNo;
        TempProductionBOMHeader.Insert();
        CheckCircularReferencesInProductionBOM_DTW(TempProductionBOMHeader, VersionCode);
    end;

    local procedure CheckCircularReferencesInProductionBOM_DTW(var TempProductionBOMHeader: Record "Production BOM Header" temporary; VersionCode: Code[20])
    var
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOMLine: Record "Production BOM Line";
        ProdItem: Record Item;
        ProductionBOMNo: Code[20];
        NextVersionCode: Code[20];
        CheckNextLevel: Boolean;
        IsHandled: Boolean;
        CircularRefInBOMErr: Label 'The production BOM %1 has a circular reference. Pay attention to the production BOM %2 that closes the loop.', Comment = '%1 = Production BOM No., %2 = Production BOM No.';
    begin
        ProductionBOMLine.SetRange("Production BOM No.", TempProductionBOMHeader."No.");
        ProductionBOMLine.SetRange("Version Code", VersionCode);
        ProductionBOMLine.SetFilter("No.", '<>%1', '');

        if ProductionBOMLine.FindSet() then
            repeat

                if ProductionBOMLine.Type = ProductionBOMLine.Type::Item then begin
                    ProdItem.SetLoadFields("Production BOM No.");
                    ProdItem.Get(ProductionBOMLine."No.");
                    ProductionBOMNo := ProdItem."Production BOM No.";
                end else
                    ProductionBOMNo := ProductionBOMLine."No.";

                if ProductionBOMNo <> '' then begin
                    TempProductionBOMHeader."No." := ProductionBOMNo;
                    if not TempProductionBOMHeader.Insert() then
                        Error(CircularRefInBOMErr, ProductionBOMNo, ProductionBOMLine."Production BOM No.");

                    NextVersionCode := '';
                    if NextVersionCode <> '' then
                        CheckNextLevel := true
                    else begin
                        ProductionBOMHeader.Get(ProductionBOMNo);
                        CheckNextLevel := ProductionBOMHeader.Status = ProductionBOMHeader.Status::Certified;
                    end;

                    if CheckNextLevel then
                        CheckCircularReferencesInProductionBOM_DTW(TempProductionBOMHeader, NextVersionCode);

                    TempProductionBOMHeader.Get(ProductionBOMNo);
                    TempProductionBOMHeader.Delete();
                end;

            until ProductionBOMLine.Next() = 0;
    end;

    //BC Upgrade kamnay01 std cost <<


    [EventSubscriber(ObjectType::Table, Database::"BOM Buffer", OnTransferFromProdCompCopyFields, '', false, false)]
    procedure OnTransferFromProdCompCopyFields(var BOMBuffer: Record "BOM Buffer"; ProductionBOMLine: Record "Production BOM Line"; ParentItem: Record Item; ParentQtyPer: Decimal; ParentScrapQtyPer: Decimal);
    var
        CostCalculationMgt: Codeunit "Cost Calculation Management";
        HeinekenBcUpgrade: Codeunit "Heineken BC Upgrade";
    begin
        //HEI.04>>
        // CostCalculationMgt.ActivateBlankVersionCode(ForBlankVersionCode);//Bc Upgrade Manisha Object regerance change as same function created on multiple objects
        HeinekenBcUpgrade.ActivateBlankVersionCode(ForBlankVersionCode);//Bc Upgrade Manisha Object regerance change as same function created on multiple objects

        //HEI.04<<
    end;

    //BC Upgrade Manisha Table BOM Buffer Start<<


    //BC Upgrade Priya << Page 5754

    // # Subscribed event "OnSetUsageFilterOnAfterSetFiltersByReportUsage" of page 5754 LOCAL procedure SetUsageFilter.
    //HEI.01 FDD-LB-GAPLOG03 IBM NASTAA02 17.07.2018 # Loading Note Almaza
    // # New Option added "Load List (Posted Whse. Shipment)"
    // HEI.02 FDD-LB-GAPLOG09 IBM CHAUHB01 18.07.2018 # Picking List Layout Almaza
    // # New Option added "Combined Pick (Whs Shipment)"
    // HEI.03 IBM HORTOC01 14.08.2018 # Loading Notes
    // # New Option added "Loading notes (Whs Shipment)"

    // HEI.04 IBM.NAIKH01 10.09.2018 # Zone (Whse Movement)
    // # New Option added "Zone (Whse Movement)"
    // HEI.05 IBM HORTOC01 19.04.2019 # add new options "Unloading Note(Whse. Receipt),Picking List By Lot"
    // HEI.06 CHG2011091 IBM GAVANM01 23.05.2019
    // # add new option "Gate Entry Document" on global variable "ReportUsage2"
    // # new code

    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Inventory", OnSetUsageFilterOnAfterSetFiltersByReportUsage, '', false, false)]
    local procedure OnSetUsageFilterOnAfterSetFiltersByReportUsage_5754(ReportUsage2: Enum "Report Selection Usage Inventory"; var Rec: Record "Report Selections")
    begin
        CASE ReportUsage2 OF
            //HEI.01>>
            "Report Selection Usage Inventory"::"Load List (Posted Whse. Shipment)":
                Rec.SETRANGE(Usage, Rec.Usage::"Load List (Pst. Whse. Shipment)");
            //HEI.01<<
            //HEI.02>>
            "Report Selection Usage Inventory"::"Combined Pick (Whs Shipment)":
                Rec.SETRANGE(Usage, Rec.Usage::"Combined Pick (Whs Shipment)");
            //HEI.02<<
            //HEI.03>>
            "Report Selection Usage Inventory"::"Loading Notes (Whse. Shipment)":
                Rec.SETRANGE(Usage, Rec.Usage::"Loading Note(Whse Ship)");
            //HEI.03<<
            //HEI.04<<
            "Report Selection Usage Inventory"::"Zone (Whse Movement)":
                Rec.SETRANGE(Usage, Rec.Usage::"Zone (Whse Movement)");
            //HEI.04>>
            //HEI.05>>
            "Report Selection Usage Inventory"::"Unloading Note(Whse. Receipt)":
                Rec.SETRANGE(Usage, Rec.Usage::"Unloading Note(Whse. Receipt)");
            "Report Selection Usage Inventory"::"Picking List By Lot":
                Rec.SETRANGE(Usage, Rec.Usage::"Picking List By Lot");
            //HEI.05<<
            //HEI.06>>
            "Report Selection Usage Inventory"::"Gate Entry Document":
                Rec.SETRANGE(Usage, Rec.Usage::"Gate Entry Document");
        //HEI.06<<
        //HEI.04<<
        END;
    end;
    //BC Upgrade Priya << Page 5754


    //BC Upgrade SHUKLP03 >> CodeUnit 23

    // HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 26.10.2018 # Counterpoint Interface
    // # Code added to avoid increase of Batch Code depending on setup => Subscribe event "OnBeforeHandleNonRecurringLine" added whole code after "OnBeforeHandleNonRecurringLine" event from procedure "HandleNonRecurringLine"
    // made ISHandled boolean true and also added event publishers OnBeforeIncrBatchName, OnHandleNonRecurringLineOnAfterCopyItemJnlLine3, OnHandleNonRecurringLineOnBeforeSetItemJnlBatchName,
    // OnHandleNonRecurringLineOnAfterItemJnlLineModify and OnHandleNonRecurringLineOnInsertNewLine.

    // HEI.02 CHG2119178 IBM.AS 30.06.2021 => BC Upgrade SHUKLP03 << Event is not found on procedure CheckItemAvailability to add code of HEI.02.
    // # HeiLite Base Stability Changes for Posting functions at JOB NAS
    // # Adding GUIAllowed function added in Functions CheckItemAvailability() for JOB Execution to avoid any manual intervention

    // HEI.03 CHG2154339 HB2904 NORRIQ KOROLA04 27.07.2022
    // # Subscribed event "OnAfterCheckJnlLine" to add new condition to the function CheckLines()

    // HEI.04 CHG2154339 HB2904 NORRIQ KOROLA04 11.08.2022
    // # Subscribed event "OnAfterCheckJnlLine" to add condition to check is empty Reason Code changed for Scrap Code

    // HEI.05 CHG2180069 PRASAA03 22.06.2023 Limiting selection fixing issues coming out of UAT
    // # Subscribed event "OnAfterCheckJnlLine" to add scrap code validation for Positive adjustment.

    // HEI.06 CHG2187702 SAHAL01 12.10.2023 Revaluation journal items in error
    // # Added Custom procedures ValidateRevJnlError, GetItemJnlLine and InsertRevJnlErrorLog
    // # Subscribed events OnPostLinesOnAfterPostLine OnBeforeRaiseExceedLengthError, OnBeforePostLines, OnAfterCopyRegNos, OnAfterCheckJnlLine,
    // OnBeforeOnPostLinesOnBeforePostLineUpdateItemTracking and OnBeforeItemJournalPostSumLine
    // # PostLine code is not added because PostLine base procedure is removed from business central.

    // HEI.07 CHG2187702 PRASAA03 30.10.2023 Revaluation journal items in error
    // # Added Code for dimension issue in Custom procedures ValidateRevJnlError.

    // HEI.08 CHG2187702 PRASAA03 06.12.2023 Revaluation journal items in error
    // # Added Code for Posting setup and latest entries error message in Custom procedures ValidateRevJnlError.

    // HEI.09 CHG2187702 PRASAA03 21.12.2023 Revaluation journal items in error
    // # Added Code for latest entries error message in Custom procedures ValidateRevJnlError and InsertRevJnlErrorLog
    //BC Upgrade kamnay01 The event subscriber was deleted (rather than commented) to ensure it is fully removed from the extension metadata. In Business Central, commented code may still persist in the compiled version if the extension is not redeployed with a version change, causing the old subscriber to be triggered during debugging. Deletion guarantees clean removal.

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnAfterCheckJnlLine, '', false, false)]
    local procedure OnAfterCheckJnlLine_23(var ItemJournalLine: Record "Item Journal Line")
    var
        ErrorTextL: Text[250];
        InventorySetup: Record "Inventory Setup";
        Text011: TextConst ENU = 'Scrap Code cannot be Blank for the Transaction %1, Line No. %2.';
    begin
        //HEI.03 >>
        InventorySetup.GET();
        //HEI.05>>
        //IF (InventorySetup."SCRAP Jnl. Template" = "Journal Template Name") AND ("Entry Type" = "Entry Type"::"Negative Adjmt.") THEN
        IF (InventorySetup."SCRAP Jnl. Template FND" = ItemJournalLine."Journal Template Name") AND ((ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Negative Adjmt.") OR (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Positive Adjmt.")) THEN
            //HEI.05<<
            IF ItemJournalLine."Scrap Code" = '' THEN //HEI.04
                ERROR(Text011, ItemJournalLine."Document No.", ItemJournalLine."Line No.");
        //HEI.03 <<
    end;
    //BC Upgrade kamnay01 The event subscriber was deleted (rather than commented) to ensure it is fully removed from the extension metadata. In Business Central, commented code may still persist in the compiled version if the extension is not redeployed with a version change, causing the old subscriber to be triggered during debugging. Deletion guarantees clean removal.


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnBeforeHandleNonRecurringLine, '', false, false)]
    local procedure OnBeforeHandleNonRecurringLine_23(var ItemJournalLine: Record "Item Journal Line"; var OldEntryType: Enum "Item Ledger Entry Type"; var IsHandled: Boolean)
    var
        ItemJnlLine2: Record "Item Journal Line";
        ItemJnlLine3: Record "Item Journal Line";
        RecordLinkManagement: Codeunit "Record Link Management";
        IncrBatchName: Boolean;
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlTemplate2: Record "Item Journal Template";
    begin

        ItemJnlTemplate.GET(ItemJournalLine."Journal Template Name");
        ItemJnlBatch.GET(ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name");
        ItemJnlLine2.CopyFilters(ItemJournalLine);  // BC Upgrade SHUKLP03 << Changed variable name ItemJnlLine.
        ItemJnlLine2.SetFilter("Item No.", '<>%1', '');
        if ItemJnlLine2.FindLast() then;
        // Remember the last line
        ItemJnlLine2."Entry Type" := OldEntryType;

        ItemJnlLine3.Copy(ItemJournalLine); // BC Upgrade SHUKLP03 << Changed variable name ItemJnlLine.
        OnHandleNonRecurringLineOnAfterCopyItemJnlLine3(ItemJournalLine, ItemJnlLine3); // BC Upgrade SHUKLP03 << Changed variable name ItemJnlLine.
        RecordLinkManagement.RemoveLinks(ItemJnlLine3);
        ItemJnlLine3.DeleteAll();
        ItemJnlLine3.Reset();
        ItemJnlLine3.SetRange("Journal Template Name", ItemJournalLine."Journal Template Name"); // BC Upgrade SHUKLP03 << Changed variable name ItemJnlLine.
        ItemJnlLine3.SetRange("Journal Batch Name", ItemJournalLine."Journal Batch Name"); // BC Upgrade SHUKLP03 << Changed variable name ItemJnlLine.
        if ItemJnlTemplate."Increment Batch Name" then
            if not ItemJnlLine3.FindLast() then begin
                IncrBatchName := IncStr(ItemJournalLine."Journal Batch Name") <> ''; // BC Upgrade SHUKLP03 << Changed variable name ItemJnlLine.
                OnBeforeIncrBatchName(ItemJournalLine, IncrBatchName); // BC Upgrade SHUKLP03 << Changed variable name ItemJnlLine.
                if IncrBatchName then begin
                    //HEI.01>>
                    ItemJnlTemplate2.GET(ItemJournalLine."Journal Template Name"); // BC Upgrade SHUKLP03 << Changed variable name ItemJnlLine.
                    IF NOT ItemJnlTemplate2."Save Batch FND" THEN BEGIN
                        //HEI.01<<
                        ItemJnlBatch.Delete();
                        IsHandled := false;
                        OnHandleNonRecurringLineOnBeforeSetItemJnlBatchName(ItemJnlTemplate, IsHandled);
                        if not IsHandled then
                            ItemJnlBatch.Name := IncStr(ItemJournalLine."Journal Batch Name");  // BC Upgrade SHUKLP03 << Changed variable name ItemJnlLine.
                        if ItemJnlBatch.Insert() then;
                        ItemJournalLine."Journal Batch Name" := ItemJnlBatch.Name; // BC Upgrade SHUKLP03 << Changed variable name ItemJnlLine.
                    end;//HEI.01
                END;
            end;

        OnHandleNonRecurringLineOnInsertNewLine(ItemJnlLine3);

        ItemJnlLine3.SetRange("Journal Batch Name", ItemJournalLine."Journal Batch Name"); // BC Upgrade SHUKLP03 << Changed variable name ItemJnlLine.
        if (ItemJnlBatch."No. Series" = '') and not ItemJnlLine3.FindLast() and
           not (ItemJnlLine2."Entry Type" in [ItemJnlLine2."Entry Type"::Consumption, ItemJnlLine2."Entry Type"::Output])
        then begin
            ItemJnlLine3.Init();
            ItemJnlLine3."Journal Template Name" := ItemJournalLine."Journal Template Name"; // BC Upgrade SHUKLP03 << Changed variable name ItemJnlLine.
            ItemJnlLine3."Journal Batch Name" := ItemJournalLine."Journal Batch Name"; // BC Upgrade SHUKLP03 << Changed variable name ItemJnlLine.
            ItemJnlLine3."Line No." := 10000;
            ItemJnlLine3.Insert();
            ItemJnlLine3.SetUpNewLine(ItemJnlLine2);
            ItemJnlLine3.Modify();
            OnHandleNonRecurringLineOnAfterItemJnlLineModify(ItemJnlLine3);
        end;
        IsHandled := true;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeIncrBatchName(var ItemJournalLine: Record "Item Journal Line"; var IncrBatchName: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnHandleNonRecurringLineOnAfterCopyItemJnlLine3(var ItemJournalLine: Record "Item Journal Line"; var ItemJournalLine3: Record "Item Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnHandleNonRecurringLineOnBeforeSetItemJnlBatchName(ItemJnlTemplate: Record "Item Journal Template"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnHandleNonRecurringLineOnAfterItemJnlLineModify(var ItemJournalLine: Record "Item Journal Line");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnHandleNonRecurringLineOnInsertNewLine(var ItemJournalLine: Record "Item Journal Line")
    begin
    end;


    local procedure IncludeEntryInCalc(ItemLedgEntry: Record "Item Ledger Entry"; PostingDate: Date; IncludeExpectedCost: Boolean): Boolean
    begin
        if IncludeExpectedCost then
            exit(ItemLedgEntry."Posting Date" in [0D .. PostingDate]);
        exit(ItemLedgEntry."Completely Invoiced" and (ItemLedgEntry."Last Invoice Date" in [0D .. PostingDate]));
    end;
    //BC Upgrade SHUKLP03 << CodeUnit 23


    // BC Upgrade SHUKLP03 >> 353 Codeunit
    // HEI.01 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    // # New function "ShowItemAvailFromRequestOrderLine" created to show the availability of Items
    // # Created new local procedures ShowItemAvailByDate, ShowItemAvailByLoc, ShowItemAvailByEvent and ShowItemAvailByVariant for compilation of custom HEI procedures.

    // HEI.02 Defect #3453 IBM NASTAA02 06.11.2018 # Request Order - multiple corrections
    // # New function "ShowItemAvailByFromCodeFromRequestOrderLine" created to show availability of Items in Location from Request Order

    Procedure ShowItemAvailFromRequestOrderLine(VAR RequestHeader: Record "Request Order Header FND"; RequestLine: Record "Request Order Line FND"; AvailabilityType2: Option Date,Location,"Event")
    var
        Item: Record Item;
        AsmHeader: Record "Assembly Header";
        NewDate: Date;
        NewVariantCode: Code[10];
        NewLocationCode: Code[10];
    begin
        //HEI.01>>
        IF Item.GET(RequestLine."Item No.") THEN BEGIN
            Item.RESET();
            Item.SETRANGE("Date Filter", 0D, RequestHeader."Request Date");

            CASE AvailabilityType2 OF
                AvailabilityType2::Date:
                    IF ShowItemAvailByDate(Item, RequestHeader.FIELDCAPTION("Request Date"), RequestHeader."Request Date", NewDate) THEN
                        RequestHeader.VALIDATE("Request Date", NewDate);
                AvailabilityType2::Location:
                    IF ShowItemAvailByLoc(Item, RequestHeader.FIELDCAPTION("To-Code"), RequestHeader."To-Code", NewLocationCode) THEN
                        RequestHeader.VALIDATE("To-Code", NewLocationCode);
                AvailabilityType2::"Event":
                    IF ShowItemAvailByEvent(Item, RequestHeader.FIELDCAPTION("Request Date"), RequestHeader."Request Date", NewDate, FALSE) THEN
                        RequestHeader.VALIDATE("Request Date", NewDate);
            END;
        END;
        //HEI.01<<
    end;

    procedure ShowItemAvailByFromCodeFromRequestOrderLine(VAR RequestHeader: Record "Request Order Header FND"; RequestLine: Record "Request Order Line FND"; AvailabilityType2: Option Date,Location,"Event")
    var
        Item: Record Item;
        AsmHeader: Record "Assembly Header";
        NewDate: Date;
        NewVariantCode: Code[10];
        NewLocationCode: Code[10];
    begin
        //HEI.02>>
        IF Item.GET(RequestLine."Item No.") THEN BEGIN
            Item.RESET();
            Item.SETRANGE("Date Filter", 0D, RequestHeader."Request Date");
            Item.SETRANGE("Location Filter", RequestLine."From-Code");

            CASE AvailabilityType2 OF
                AvailabilityType2::Date:
                    IF ShowItemAvailByDate(Item, RequestHeader.FIELDCAPTION("Request Date"), RequestHeader."Request Date", NewDate) THEN
                        RequestHeader.VALIDATE("Request Date", NewDate);
                AvailabilityType2::Location:
                    IF ShowItemAvailByLoc(Item, RequestHeader.FIELDCAPTION("To-Code"), RequestHeader."To-Code", NewLocationCode) THEN
                        RequestHeader.VALIDATE("To-Code", NewLocationCode);
                AvailabilityType2::"Event":
                    IF ShowItemAvailByEvent(Item, RequestHeader.FIELDCAPTION("Request Date"), RequestHeader."Request Date", NewDate, FALSE) THEN
                        RequestHeader.VALIDATE("Request Date", NewDate);
            END;
        END;
        //HEI.02<<
    end;

    local procedure ShowItemAvailByLoc(VAR Item: Record Item; FieldCaption: Text[80]; OldLocationCode: Code[20]; VAR NewLocationCode: Code[20]): Boolean
    var
        ItemAvailByLoc: Page "Item Availability by Location";
        Text012: TextConst Comment = '%1=FieldCaption, %2=OldDate, %3=NewDate', ENU = 'Do you want to change %1 from %2 to %3?', FRA = 'Voulez-vous remplacer %2 par %3 pour %1 ?';
    begin
        Item.SETRANGE("Location Filter");
        IF FieldCaption <> '' THEN
            ItemAvailByLoc.LOOKUPMODE(TRUE);
        ItemAvailByLoc.SETRECORD(Item);
        ItemAvailByLoc.SETTABLEVIEW(Item);
        IF ItemAvailByLoc.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            NewLocationCode := ItemAvailByLoc.GetLastLocation();
            IF OldLocationCode <> NewLocationCode THEN
                IF CONFIRM(Text012, TRUE, FieldCaption, OldLocationCode, NewLocationCode) THEN
                    EXIT(TRUE);
        END;
    end;

    local procedure ShowItemAvailByDate(VAR Item: Record Item; FieldCaption: Text[80]; OldDate: Date; VAR NewDate: Date): Boolean
    var
        ItemAvailByPeriods: Page "Item Availability by Periods";
        Text012: TextConst Comment = '%1=FieldCaption, %2=OldDate, %3=NewDate', ENU = 'Do you want to change %1 from %2 to %3?', FRA = 'Voulez-vous remplacer %2 par %3 pour %1 ?';
    begin
        Item.SETRANGE("Date Filter");
        IF FieldCaption <> '' THEN
            ItemAvailByPeriods.LOOKUPMODE(TRUE);
        ItemAvailByPeriods.SETRECORD(Item);
        ItemAvailByPeriods.SETTABLEVIEW(Item);
        IF ItemAvailByPeriods.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            NewDate := ItemAvailByPeriods.GetLastDate();
            IF OldDate <> NewDate THEN
                IF CONFIRM(Text012, TRUE, FieldCaption, OldDate, NewDate) THEN
                    EXIT(TRUE);
        END;
    end;

    local procedure ShowItemAvailVariant(VAR Item: Record Item; FieldCaption: Text[80]; OldVariant: Code[20]; VAR NewVariant: Code[20]): Boolean
    var
        ItemAvailByVariant: Page "Item Availability by Variant";
        Text012: TextConst Comment = '%1=FieldCaption, %2=OldDate, %3=NewDate', ENU = 'Do you want to change %1 from %2 to %3?', FRA = 'Voulez-vous remplacer %2 par %3 pour %1 ?';
    begin
        Item.SETRANGE("Variant Filter");
        IF FieldCaption <> '' THEN
            ItemAvailByVariant.LOOKUPMODE(TRUE);
        ItemAvailByVariant.SETRECORD(Item);
        ItemAvailByVariant.SETTABLEVIEW(Item);
        IF ItemAvailByVariant.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            NewVariant := ItemAvailByVariant.GetLastVariant();
            IF OldVariant <> NewVariant THEN
                IF CONFIRM(Text012, TRUE, FieldCaption, OldVariant, NewVariant) THEN
                    EXIT(TRUE);
        END;
    end;

    LOCAL procedure ShowItemAvailByEvent(VAR Item: Record Item; FieldCaption: Text[80]; OldDate: Date; VAR NewDate: Date; IncludeForecast: Boolean): Boolean
    var
        ItemAvailByEvent: Page "Item Availability by Event";
        ForecastName: Code[10];
        Text012: TextConst Comment = '%1=FieldCaption, %2=OldDate, %3=NewDate', ENU = 'Do you want to change %1 from %2 to %3?', FRA = 'Voulez-vous remplacer %2 par %3 pour %1 ?';
    begin
        IF FieldCaption <> '' THEN
            ItemAvailByEvent.LOOKUPMODE(TRUE);
        ItemAvailByEvent.SetItem(Item);
        IF IncludeForecast THEN BEGIN
            ItemAvailByEvent.SetIncludePlan(TRUE);
            IF ForecastName <> '' THEN
                ItemAvailByEvent.SetForecastName(ForecastName);
        END;
        IF ItemAvailByEvent.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            NewDate := ItemAvailByEvent.GetSelectedDate();
            IF (NewDate <> 0D) AND (NewDate <> OldDate) THEN
                IF CONFIRM(Text012, TRUE, FieldCaption, OldDate, NewDate) THEN
                    EXIT(TRUE);
        END;
    end;
    // BC Upgrade SHUKLP03 << 353 Codeunit



    // BC Upgrade NANDIS03 - Code Added for table Gen. Journal Template for HEI.06 >>
    // Blocked GUNREM01 >>
    // [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Template", OnAfterModifyEvent, '', false, false)]
    // local procedure GenJournalTemplateOnModify(var Rec: Record "Gen. Journal Template"; var xRec: Record "Gen. Journal Template"; RunTrigger: Boolean)
    // var
    //     Text50000_GenJnlTemOnModify: TextConst ENU = 'General journal template %1 is blocked and cannot be deleted/modified. Please contact administrator for assistance.';
    // begin
    //     //HEI.06>>
    //     IF Rec.Blocked = xRec.Blocked THEN
    //         IF rec.Blocked THEN
    //             ERROR(Text50000_GenJnlTemOnModify, Rec.Name);
    //     //HEI.06<<
    // end;  Blocked GUNREM01 <<

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Template", OnBeforeDeleteEvent, '', false, false)]
    local procedure GenJournalTemplateOnBeforeDelete(var Rec: Record "Gen. Journal Template"; RunTrigger: Boolean)
    var
        Text50000_GenJnlTemOnModify: TextConst ENU = 'General journal template %1 is blocked and cannot be deleted/modified. Please contact administrator for assistance.';
    begin
        CheckTemplateBlocked(); //HEI.06
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Template", OnAfterRenameEvent, '', false, false)]
    local procedure GenJournalTemplateOnAfterRename(var Rec: Record "Gen. Journal Template"; RunTrigger: Boolean)
    var
        Text50000_GenJnlTemOnModify: TextConst ENU = 'General journal template %1 is blocked and cannot be deleted/modified. Please contact administrator for assistance.';
    begin
        CheckTemplateBlocked(); //HEI.06
    end;

    // BC Upgrade NANDIS03 - This event is created to accomodate the code written in "Source Code" onvalidate trigger in Gen. Journal Template table
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Template", OnAfterValidateEvent, "Source Code", false, false)]
    local procedure OnAfterValidateSourceCode(var Rec: Record "Gen. Journal Template"; var xRec: Record "Gen. Journal Template"; CurrFieldNo: Integer)
    begin
        CheckTemplateBlocked();
    End;

    local procedure CheckTemplateBlocked()  // This function is copied from Gen. Journal Template table
    var
        myInt: Integer;
        GenJournalTemplate: Record "Gen. Journal Template";
        lText50000: TextConst ENU = 'General journal template %1 is blocked and cannot be deleted/modified. Please contact administrator for assistance.';
    begin
        //HEI.06>>
        IF GenJournalTemplate."Blocked FND" THEN
            ERROR(lText50000, GenJournalTemplate.Name);
        //HEI.06<<
    end;
    // BC Upgrade NANDIS03 - Code Added for table Gen. Journal Template for HEI.06 <<


    //BC Upgrade SHUKLP03  >> Codeunit 46

    // HEI.01 FDD-OTCGAP022 Heilite BASE IBM ISYED01 18/07/2017
    // #Cash Collection Order Creation added new function "GetSelectionFilterForIssueCashCollection" for selction filter

    // HEI.02 FDDKDDOTC001 IBM HORTOC01  08.02.2018
    // # new function "GetSelectionFilterForItemCategory"

    // HEI.03 FDDPRDGAP055 ISBM ISYED01 11.05.2018
    // # NEW FUNCTION FOR BIN "GetSelectionFilterForBin" AND ZONE "GetSelectionFilterForZone"

    // HEI.04 FDD-PA-LOGGAP08 IBM POSTOI01 25.07.2018
    // # NEW FUNCTION "GetSelectionFilterForUM" FOR UM

    // HEI.05 Cash Van Sales IBM HORTOC01  30.07.2018 # new function "GetSelectionFilterForGenProdPostingGr" "GetSelectionFilterForGenBusPostingGr" for gen prod posting gr.

    // HEI.06 FDD-BA-PRDGAP01 b IBM ISYED01 27.Sep.2018
    // # NEW FUNCTION "GetSelectionFilterForProject" "GetSelectionFilterForILE" for Porject

    // HEI.07 FDD RMPBREAKAGES IBM ISYED07 13May2019
    // # Added New functions "GetSelectionFilterForPCRPM_Item" "GetSelectionFilterForPCRPM_SROrderNo" to get thr filter on Item and Sales Return order no.

    // HEI.08 FDD-LC-HT736 IBM.GUNERE01 02.10.2019 # new function GetSelectionFilterForCustomerAccountGroup added.
    // HEI.09 Defect # 4550 IBM.GUNERE01 10.10.2019 # new function GetSelectionFilterForItemAttributeValues added.
    // HEI.10 FDD-HT670 IBM BULIMC01 18.02.2020 #new functions added: "GetSelectionFilterForVATProdPostingGr" and "GetSelectionFilterForVATBusPostingGr"
    // HEI.11 FDD-HT671 IBM BULIMC01 18.02.2020 #new functions added: "GetSelectionFilterForWHTProdPostingGr" and "GetSelectionFilterForWHTBusPostingGr"
    // HEI.12 FDD-HT1211 BULIMC01 IBM 20/05/2020 #new function added "GetSelectionFilterforGenJnlBatch"
    // HEI.13 FDD-HT1346 BULIMC01 IBM 29/05/2020 #new function added "GetSelectionFilterforVendLedgerEntries"
    // HEI.14 FDD-HT1617 BULIMC01 IBM 03/12/2020 #new function added "GetSelectionFilterForFADeprBook"
    procedure GetSelectionFilterForIssueCashCollection(VAR CashCollectionHeader: Record "Cash Collection Header FND"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //HEI.01>>
        RecRef.GETTABLE(CashCollectionHeader);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, CashCollectionHeader.FIELDNO("No.")));
        //HEI.01<<
    End;

    procedure GetSelectionFilterForItemCategory(VAR ItemCategory: Record "Item Category"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    begin
        //HEI.02>>
        RecRef.GETTABLE(ItemCategory);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, ItemCategory.FIELDNO(Code)));
        //HEI.02<<
    end;

    procedure GetSelectionFilterForBin(VAR Bin: Record Bin): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //HEI.03>>
        RecRef.GETTABLE(Bin);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, Bin.FIELDNO(Code)));
    End;    //HEI.03<<

    procedure GetSelectionFilterForZone(VAR Zone: Record Zone): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //HEI.03>>
        RecRef.GETTABLE(Zone);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, Zone.FIELDNO(Code)));
        //HEI.03<<
    End;

    procedure GetSelectionFilterForProject(VAR Project: Record "Project FND"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //HEI.06>>
        RecRef.GETTABLE(Project);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, Project.FIELDNO(Code)));
        //HEI.06<<
    End;

    procedure GetSelectionFilterForILE(VAR ItemLedgerEntry: Record "Item Ledger Entry"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //HEI.06>>
        RecRef.GETTABLE(ItemLedgerEntry);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, ItemLedgerEntry.FIELDNO(Description)));
        //HEI.06<<
    End;

    procedure GetSelectionFilterForPCRPM_Item(VAR CustomerDifferencesRPM: Record "Posted Customer Diff RPM FND"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //HEI.07>>
        RecRef.GETTABLE(CustomerDifferencesRPM);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, CustomerDifferencesRPM.FIELDNO("Item No.")));
        //HEI.07<<
    End;

    procedure GetSelectionFilterForPCRPM_SROrderNo(VAR CustomerDifferencesRPM: Record "Posted Customer Diff RPM FND"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //HEI.07>>
        RecRef.GETTABLE(CustomerDifferencesRPM);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, CustomerDifferencesRPM.FIELDNO("Sales return order no.")));
        //HEI.07<<
    End;

    procedure GetSelectionFilterForCustomerAccountGroup(VAR AccountGroup: Record "Account Group FND"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //>> HEI.08
        RecRef.GETTABLE(AccountGroup);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, AccountGroup.FIELDNO(Code)));
        //<< HEI.08
    End;

    procedure GetSelectionFilterForItemAttributeValues(VAR ItemAttributeValue: Record "Item Attribute Value"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //>> HEI.09
        RecRef.GETTABLE(ItemAttributeValue);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, ItemAttributeValue.FIELDNO(Value)));
        //<< HEI.09
    End;

    procedure GetSelectionFilterForVATBusPostingGr(VAR VATBusinessPostingGroup: Record "VAT Business Posting Group"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //HEI.10>>
        RecRef.GETTABLE(VATBusinessPostingGroup);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, VATBusinessPostingGroup.FIELDNO(Code)));
        //HEI.10<<
    End;

    procedure GetSelectionFilterForVATProdPostingGr(VAR VATProductPostingGroup: Record "VAT Product Posting Group"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //HEI.10>>
        RecRef.GETTABLE(VATProductPostingGroup);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, VATProductPostingGroup.FIELDNO(Code)));
        //HEI.10<<
    End;

    procedure GetSelectionFilterForWHTBusPostingGr(VAR WHTBusinessPostingGroup: Record "WHT Business Posting Group FND"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //HEI.11>>
        RecRef.GETTABLE(WHTBusinessPostingGroup);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, WHTBusinessPostingGroup.FIELDNO(Code)));
        //HEI.11<<
    End;

    procedure GetSelectionFilterForWHTProdPostingGr(VAR WHTProductPostingGroup: Record "WHT Product Posting Group FND"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //HEI.11>>
        RecRef.GETTABLE(WHTProductPostingGroup);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, WHTProductPostingGroup.FIELDNO(Code)));
        //HEI.11<<
    End;

    procedure GetSelectionFilterForGenBusPostingGr(VAR GenBusinessPostingGroup: Record "Gen. Business Posting Group"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //HEI.05>>
        RecRef.GETTABLE(GenBusinessPostingGroup);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, GenBusinessPostingGroup.FIELDNO(Code)));
        //HEI.05<<
    End;

    procedure GetSelectionFilterForVendLedgerEntries(VAR VendorLedgerEntry: Record "Vendor Ledger Entry"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //HEI.13>>
        RecRef.GETTABLE(VendorLedgerEntry);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, VendorLedgerEntry.FIELDNO("Document No.")));
        //HEI.13<<
    End;

    procedure GetSelectionFilterForGenJnlBatch(VAR GenJournalBatch: Record "Gen. Journal Batch"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //HEI.12>>
        RecRef.GETTABLE(GenJournalBatch);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, GenJournalBatch.FIELDNO(Name)));
        //HEI.12<<
    End;

    procedure GetSelectionFilterForFADeprBook(VAR FADepreciationBook: Record "FA Depreciation Book"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //HEI.14>>
        RecRef.GETTABLE(FADepreciationBook);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, FADepreciationBook.FIELDNO("Depreciation Book Code")));
        //HEI.14<<
    End;

    // BC Upgrade Priya 22/09/25 >> 
    PROCEDURE GetSelectionFilterForUM(VAR UM: Record "Unit of Measure"): Text;
    VAR
        RecRef: RecordRef;
        SelectionFilterMgt: Codeunit SelectionFilterManagement;
    BEGIN
        //HEI.04>>
        RecRef.GETTABLE(UM);
        EXIT(SelectionFilterMgt.GetSelectionFilter(RecRef, UM.FIELDNO(Code)));
        //HEI.04<<
    END;
    // BC Upgrade Priya 22/09/25 <<

    procedure GetSelectionFilterForGenProdPostingGr(VAR GenProductPostingGroup: Record "Gen. Product Posting Group"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin
        //HEI.05>>
        RecRef.GETTABLE(GenProductPostingGroup);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, GenProductPostingGroup.FIELDNO(Code)));
        //HEI.05<<
    End;


    //BC Upgrade SHUKLP03 << Codeunit 46


    //BC Upgrade SHUKLP03 >> Codeunit 6500

    // HEI.01 CHG2100218 IBM SAXENA03 25.03.2021
    // # Code written for Sales Post optimizaiton
    // # To Replace FINDSET with FINDSET(FALSE,FALSE) of Function SumUpItemTracking() subscribed event OnBeforeSumUpItemTracking added whole code also added
    //  local procedure GetItemTrackingCode(), event OnBeforeFindTempHandlingSpecification, event OnSumUpItemTrackingOnBeforeTempHandlingSpecificationModify and event OnBeforeTempHandlingSpecificationInsert 
    // # HEI.01 code is not added because event did not find on procedure ExistingExpirationDateAndQty() also changes in base code,Base code is not using FINDSET.

    // HEI.02 CHG2119178 IBM.AS 30.06.2021
    // # HEI.02 code is not added because event did not find HeiLite Base Stability Changes for Posting functions at JOB NAS
    // # HEI.02 code is not added because event did not find to add GUIAllowed function in Functions SynchronizeItemTracking2(),SynchronizeWhseItemTracking2(),
    // CopyLotNoInformation(), CopySerialNoInformation()

    // HEI.03 CHG2075364 IBM.LS      22.07.2021
    // # Subscribed events OnIsOrderNetworkEntity, OnAfterItemTrkgTypeIsManagedByWhse and OnSyncActivItemTrkgOnBeforeInsertTempReservEntry.
    // # Created local procedure RDITZoneWhse and blocked DrinkIT called procedures FindReservEntries() and FindTrackingEntries() inside procedure RDITZoneWhse.
    // # HEI.03 Code is not added for DrinkIT created procedure TableSignFactor() and RetrieveDocumentItemTracking().
    // # On subscribed event OnSyncActivItemTrkgOnBeforeInsertTempReservEntry, some part of HEI.03 code blocked because DrinkIT field "Bin Code" is used.

    var
        CachedItem: Record Item;
        CachedItemTrackingCode: Record "Item Tracking Code";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Management", OnBeforeSumUpItemTracking, '', false, false)]
    local procedure OnBeforeSumUpItemTracking(var IsHandled: Boolean; var ReservEntry: Record "Reservation Entry"; var SumPerLine: Boolean; var SumPerTracking: Boolean; var TempHandlingSpecification: Record "Tracking Specification" temporary)
    var
        ItemTrackingCode: Record "Item Tracking Code";
        ItemTrackingSetup: Record "Item Tracking Setup";
        NextEntryNo: Integer;
        ExpDate: Date;
        EntriesExist: Boolean;
        ItemTrackManage: Codeunit "Item Tracking Management";
    begin
        // Sum up Item Tracking in a temporary table (to defragment the ReservEntry records)
        TempHandlingSpecification.Reset();
        TempHandlingSpecification.DeleteAll();
        if SumPerTracking then
            TempHandlingSpecification.SetTrackingKey();
        //<<HEI.01
        //IF ReservEntry.FINDSET THEN
        if ReservEntry.FindSet(FALSE) then begin
            //<<HEI.01
            GetItemTrackingCode(ReservEntry."Item No.", ItemTrackingCode);
            repeat
                if ReservEntry.TrackingExists() then begin
                    if SumPerLine then
                        TempHandlingSpecification.SetRange("Source Ref. No.", ReservEntry."Source Ref. No."); // Sum up line per line
                    if SumPerTracking then begin
                        TempHandlingSpecification.SetTrackingFilterFromReservEntry(ReservEntry);
                        TempHandlingSpecification.SetNewTrackingFilterFromNewReservEntry(ReservEntry);
                    end;
                    OnBeforeFindTempHandlingSpecification(TempHandlingSpecification, ReservEntry);
                    if TempHandlingSpecification.FindFirst() then begin
                        TempHandlingSpecification."Quantity (Base)" += ReservEntry."Quantity (Base)";
                        TempHandlingSpecification."Qty. to Handle (Base)" += ReservEntry."Qty. to Handle (Base)";
                        TempHandlingSpecification."Qty. to Invoice (Base)" += ReservEntry."Qty. to Invoice (Base)";
                        TempHandlingSpecification."Quantity Invoiced (Base)" += ReservEntry."Quantity Invoiced (Base)";
                        TempHandlingSpecification."Qty. to Handle" :=
                          TempHandlingSpecification."Qty. to Handle (Base)" / ReservEntry."Qty. per Unit of Measure";
                        TempHandlingSpecification."Qty. to Invoice" :=
                          TempHandlingSpecification."Qty. to Invoice (Base)" / ReservEntry."Qty. per Unit of Measure";
                        if not ReservEntry.IsReservationOrTracking() then // Late Binding
                            TempHandlingSpecification."Buffer Value1" += TempHandlingSpecification."Qty. to Handle (Base)";
                        OnSumUpItemTrackingOnBeforeTempHandlingSpecificationModify(TempHandlingSpecification, ReservEntry);
                        TempHandlingSpecification.Modify();
                    end else begin
                        TempHandlingSpecification.Init();
                        TempHandlingSpecification.TransferFields(ReservEntry);
                        NextEntryNo += 1;
                        TempHandlingSpecification."Entry No." := NextEntryNo;
                        TempHandlingSpecification."Qty. to Handle" :=
                          TempHandlingSpecification."Qty. to Handle (Base)" / ReservEntry."Qty. per Unit of Measure";
                        TempHandlingSpecification."Qty. to Invoice" :=
                          TempHandlingSpecification."Qty. to Invoice (Base)" / ReservEntry."Qty. per Unit of Measure";
                        if not ReservEntry.IsReservationOrTracking() then // Late Binding
                            TempHandlingSpecification."Buffer Value1" += TempHandlingSpecification."Qty. to Handle (Base)";

                        if ItemTrackingCode."Use Expiration Dates" then begin
                            ItemTrackingSetup.CopyTrackingFromReservEntry(ReservEntry);
                            ExpDate :=
                                ItemTrackManage.ExistingExpirationDate(
                                    ReservEntry."Item No.", ReservEntry."Variant Code", ItemTrackingSetup, false, EntriesExist);
                            if EntriesExist then
                                TempHandlingSpecification."Expiration Date" := ExpDate;
                        end;
                        OnBeforeTempHandlingSpecificationInsert(TempHandlingSpecification, ReservEntry, ItemTrackingCode, EntriesExist);
                        TempHandlingSpecification.Insert();
                    end;
                end;
            until ReservEntry.Next() = 0;
        end;

        IsHandled := true;
    end;

    local procedure GetItemTrackingCode(ItemNo: Code[20]; var ItemTrackingCode: Record "Item Tracking Code")
    begin
        if CachedItem."No." <> ItemNo then begin
            // searching for a new item, clear the cached item
            Clear(CachedItem);

            // get the item from the database
            if CachedItem.Get(ItemNo) then begin
                if CachedItem."Item Tracking Code" <> CachedItemTrackingCode.Code then
                    Clear(CachedItemTrackingCode); // item tracking code changed, clear the cached tracking code

                if CachedItem."Item Tracking Code" <> '' then
                    // item tracking code changed to something not empty, so get the new item tracking code from the database
                    CachedItemTrackingCode.Get(CachedItem."Item Tracking Code");
            end else
                Clear(CachedItemTrackingCode); // can't find the item, so clear the cached tracking code as well
        end;

        ItemTrackingCode := CachedItemTrackingCode;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeFindTempHandlingSpecification(var TempTrackingSpecification: Record "Tracking Specification" temporary; ReservEntry: Record "Reservation Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnSumUpItemTrackingOnBeforeTempHandlingSpecificationModify(var TempHandlingSpecification: Record "Tracking Specification" temporary; ReservEntry: Record "Reservation Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTempHandlingSpecificationInsert(var TempTrackingSpecification: Record "Tracking Specification" temporary; ReservationEntry: Record "Reservation Entry"; var ItemTrackingCode: Record "Item Tracking Code"; var EntriesExist: Boolean)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Management", OnIsOrderNetworkEntity, '', false, false)]
    local procedure OnIsOrderNetworkEntity(Subtype: Integer; Type: Integer; var IsNetworkEntity: Boolean)
    begin
        case Type OF
            //HEI.03>>
            DATABASE::"Warehouse Activity Line":
                IsNetworkEntity := Subtype IN [3];
        //HEI.03<<
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Management", OnAfterItemTrkgTypeIsManagedByWhse, '', false, false)]
    local procedure OnAfterItemTrkgTypeIsManagedByWhse(Type: Integer; var TypeIsManagedByWhse: Boolean)
    begin
        TypeIsManagedByWhse := Type in [Database::"Sales Line",
                         Database::"Purchase Line",
                         Database::"Transfer Line",
                         AssemblyHeaderID(),
                         AssemblyLineID(),
                        //HEI.03>>
                        DATABASE::"Warehouse Activity Line",
                         //HEI.03<<
                         ProdOrderLineID(),
                         ProdOrderCompID(),
                         Database::Job];
    end;

    local procedure AssemblyHeaderID(): Integer
    begin
        exit(900);
    end;

    local procedure AssemblyLineID(): Integer
    begin
        exit(901);
    end;

    local procedure ProdOrderLineID(): Integer
    begin
        exit(5406);
    end;

    local procedure ProdOrderCompID(): Integer
    begin
        exit(5407);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Management", OnSyncActivItemTrkgOnBeforeInsertTempReservEntry, '', false, false)]
    local procedure OnSyncActivItemTrkgOnBeforeInsertTempReservEntry(var TempReservEntry: Record "Reservation Entry" temporary; WhseActivLine: Record "Warehouse Activity Line")
    begin
        //HEI.03>>
        TempReservEntry."Zone Code FND" := WhseActivLine."Zone Code";
        //TempReservEntry."Bin Code" := WhseActivLine."Bin Code"; // BC Upgrade Priya << code blocked because DrinkIT field "Bin Code" is used.
        //HEI.03<<
    end;

    LOCAL procedure RDITZoneWhse(var TempTrackingSpecBuffer: Record "Tracking Specification" temporary; SourceID: Code[20]; SourceSubType: Option)
    var
        WhseActivityLineL: Record "Warehouse Activity Line";
        Item: Record Item;
        Descr: Text[50];
    begin
        //HEI.03>>
        WhseActivityLineL.SETRANGE("Activity Type", SourceSubType);
        WhseActivityLineL.SETRANGE("No.", SourceID);
        IF NOT WhseActivityLineL.ISEMPTY THEN BEGIN
            WhseActivityLineL.FINDSET();
            REPEAT
                IF (WhseActivityLineL."Item No." <> '') AND (WhseActivityLineL."Qty. (Base)" <> 0) THEN BEGIN
                    IF Item.GET(WhseActivityLineL."Item No.") THEN
                        Descr := Item.Description;
                    // BC Upgrade SHUKLP03 >> Code Blocked because DrinkIT procedure "FindReservEntries" and "FindTrackingEntries" is called.
                    // FindReservEntries(TempTrackingSpecBuffer, DATABASE::"Warehouse Activity Line", WhseActivityLineL."Activity Type",
                    //     WhseActivityLineL."No.", FORMAT(WhseActivityLineL."Action Type"), WhseActivityLineL."Linked To Line No.",
                    //     WhseActivityLineL."Line No.", Descr);
                    // FindTrackingEntries(TempTrackingSpecBuffer, DATABASE::"Warehouse Activity Line", WhseActivityLineL."Activity Type",
                    //     WhseActivityLineL."No.", FORMAT(WhseActivityLineL."Action Type"), WhseActivityLineL."Linked To Line No.",
                    //     WhseActivityLineL."Line No.", Descr);
                    // BC Upgrade SHUKLP03 << Code Blocked because DrinkIT procedure "FindReservEntries" and "FindTrackingEntries" is called.
                END;
            UNTIL WhseActivityLineL.NEXT() = 0;
        END;
    end;
    //HEI.03<<
    //BC Upgrade SHUKLP03 << Codeunit 6500

    //BC Upgrade Yadavm09 CU WMS Management 16-10-2025>>

    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt
    //   #Code for zone transfer movement
    // HEI.02 PRDGAP038 IBM HORTO01 16.10.2017 - fill in "Quality status"
    // HEI.03 FDD-HT1075 CHG2039144 IBM.GUNERE01 16.03.2020 # InsertLinkWhseRqst(),InsertLinkWhseRqst2() funcs. parameters modified
    //                                                        length 10 -> 20
    // DITW113.00.15 MSF 06/11/2019 NRQ#126042  Impossible to create a warehouse shipment from a transfer order via the route planning worksheet
    //                                                Added Parameter to function ShowWhseDocLineBySrcDoc
    // HEI.05 CHG2119178 IBM.AS 30.06.2021
    //   # HeiLite Base Stability Changes for Posting functions at JOB NAS
    //   # Adding GUIAllowed function added in Functions CheckPutAwayAvailability()


    /* // BCUPGRADE YADAVM09 Drink it field "Quality Status" Code Commented>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"WMS Management", 'OnAfterCreateWhseJnlLine', '', false, false)]
    local procedure OnAfterCreateWhseJnlLine(var WhseJournalLine: Record "Warehouse Journal Line"; ItemJournalLine: Record "Item Journal Line"; ToTransfer: Boolean)
    var
        LotNoInformation: Record "Lot No. Information";
    begin
        //HEI.02>>
        IF LotNoInformation.GET(WhseJournalLine."Item No.", WhseJournalLine."Variant Code", WhseJournalLine."Lot No.") THEN
            WhseJournalLine."Quality Status" := LotNoInformation."Quality Status";
        //HEI.02<<
    end;
    */ // BCUPGRADE YADAVM09 Drink it field "Quality Status" Code Commented>>


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"WMS Management", 'OnBeforeConfirmExceededCapacity', '', false, false)]
    local procedure OnBeforeConfirmExceededCapacity(var IsHandled: Boolean; BinCode: Code[20]; CheckFieldCaption: Text[100]; CheckTableCaption: Text[100]; ValueToPutAway: Decimal; ValueAvailable: Decimal)
    var
        Text002: Label '\Do you still want to use this %1 ?';
        Text004: Label '%1 to place (%2) exceeds the available capacity (%3) on %4 %5.';
        Text007: Label 'Cancelled.';
    begin
        //>>HEI.05
        IF GUIALLOWED THEN BEGIN
            //<<HEI.05
            if not Confirm(
             StrSubstNo(
               Text004, CheckFieldCaption, ValueToPutAway, ValueAvailable,
               CheckTableCaption, BinCode) + StrSubstNo(Text002, CheckTableCaption), false)
        then
                Error(Text007);
            //>>HEI.05
        END;
        IsHandled := true;
        //<<HEI.05
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"WMS Management", 'OnBeforeGetAllowedLocation', '', false, false)]
    local procedure OnBeforeGetAllowedLocation(var LocationCode: Code[10]; var IsHandled: Boolean)
    var
        WMSManagementCU: Codeunit "WMS Management";
        // WarehouseEmployee: Record "Warehouse Employee";//BC UPGRADE KUMARR78 Replacing Stnd Table with Custamised Table
        WarehouseEmployee: Record "Warehouse Employee_DTW FND";//BC UPGRADE KUMARR78 Replacing Stnd Table with Custamised Table
    begin
        WMSManagementCU.CheckUserIsWhseEmployee();
        //HEI.01 PRDGAP024 BEGIN DELETE
        // if WarehouseEmployee.Get(UserId, LocationCode) then
        //    exit(LocationCode);
        //HEI.01 PRDGAP024 END DELETE
        //HEI.01 PRDGAP024>>
        WarehouseEmployee.SETRANGE("User ID", UPPERCASE(USERID));
        WarehouseEmployee.SETRANGE("Location Code", LocationCode);
        IF WarehouseEmployee.FINDFIRST() THEN
            IsHandled := true;
        if IsHandled then
            exit else begin
            //HEI.01 PRDGAP024<<
            LocationCode := WMSManagementCU.GetDefaultLocation();
            IsHandled := true;
        end;
    end;

    /* // BCUPGRADE YADAVM09 Drink it field "Quality Status" Code Commented>>
       [EventSubscriber(ObjectType::Codeunit, Codeunit::"WMS Management", 'OnAfterCheckWhseJnlLine', '', false, false)]
       local procedure OnAfterCheckWhseJnlLine(var WhseJnlLine: Record "Warehouse Journal Line"; SourceJnl: Option " ",ItemJnl,OutputJnl,ConsumpJnl,WhseJnl; DecreaseQtyBase: Decimal; ToTransfer: Boolean; var Item: Record Item)
       var
           LotNoInformation: Record "Lot No. Information";
       begin
           //HEI.02>>
           IF LotNoInformation.GET(WhseJnlLine."Item No.", WhseJnlLine."Variant Code", WhseJnlLine."Lot No.") THEN
               WhseJnlLine."Quality Status" := LotNoInformation."Quality Status";
           //HEI.02<<
       end;
 
        */ // BCUPGRADE YADAVM09 Drink it field "Quality Status" Code Commented>>

    //BC Upgrade YADAVM09 CU WMS Management 16-10-2025<<

    // BC UPGRADE PATHAA02-04.11.25  Subsribed to this event for Function-SetUsageFilter on Page 524>>
    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Reminder", OnSetUsageFilterOnAfterSetFiltersByReportUsage, '', false, false)]
    local procedure "Report Selection - Reminder_OnSetUsageFilterOnAfterSetFiltersByReportUsage"(var Rec: Record "Report Selections"; ReportUsage2: Enum "Report Selection Usage Reminder")
    begin
        //HEI.01>>
        IF ReportUsage2 = ReportUsage2::"Cash Collection" then
            Rec.SETRANGE(Usage, ReportUsage2::"Cash Collection");
        //HEI.01<<
    end;
    //BC UPGRADE PATHAA02-04.11.25 Subsribed to this event for Function-SetUsageFilter on Page 524<<

    //     DITW15.00.00.01 DDR 19/02/2008 Added function ReadDimBufToJnlLineDim() to read the current buffer TempDimBuf2
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.01 DDR 31/03/2008 Added Drink-It Item Charges functionnalities to update attached lines
    // DITW15.00.00.24 DDR 18/08/2008 Added function CMoveJnlLineDimToJnlLineDim(),SetJnlLineDimToDimBuf()
    //                                Added function TypeToTableID9000() using field "Source Type" & "Source No."
    //                                  with table2013768 "Sales Disc. & Promo. Worksheet"
    //                                Added function TypeToTableID9001() using field "Type" & "No."
    //                                  with table2013768 "Sales Disc. & Promo. Worksheet"
    //                                Change function ReadDimBufToJnlLineDim()
    //                                Change function SaveJnlLineDim(),SaveJnlLineNewDim()
    //                                Added function GetPreviousJnlDefaultDim()
    //                     20/10/2009 issue 796 Added functions CopyDimBufToAnyDocDim()
    // DITW15.00.00.35 DDR 10/04/2009 Added functions
    //                                  ShowDefaultDim(),LookupAnyDimValueCode(),ValidateAnyDimValueCode(),SaveAnyDefaultDim()
    //                                  ChangeAnyValuePostingDefDim(),SaveAnyServContractDim(),SaveAnyTempDim(),
    //                                  MoveDefaultDimToDefaultDim()
    //                                Updated function
    //                                  SetupObjectNoList() -> new table2034841 Building
    //                                                      -> new table2034851 FA Template
    //                     26/08/2009 Added functions
    //                                  UpdateAnyDefaultDim(),UpdateSetupDimValueCode(),UpdateSetupAnyDimValueCode()
    //                     01/10/2009 Added functions
    //                                  MoveDocDimToDefaultDim(),UpdateAnyDocDim()
    //                     27/05/2010 issue 480 Added functions
    //                                  MoveDocDimToBuf(),ReadDimBufToDocDim(),SetDocDimToDimBuf(),CMoveDocDimToDocDim()
    // DITW15.00.00.38 DDR 02/08/2010 #1214  missing table2034902 "Serv. Purch. Contract Template" to set default dimensions
    //                                         into function SetupObjectNoList()
    // DITW16.00.00.38 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    // DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added table Item category for Default dimensions
    //                                  Modified function MoveDefaultDimToDefaultDim(),MoveDocDimToDefaultDim()
    // DITW15.00.00.38 DDR 22/12/2010 issue 1253 NAVW16.00.01 Upgrade of W15.00 SP1
    //                                  Replace functions UpdateDimBuffer@31() -> MoveTempDimToBuf@31();
    //                                                      CopySCDimToLedgEntryDim@33 -> UpdateDocDefaultDim2@33()
    //                                  Modify  functions SetupObjectNoList@40()
    //                                  Added   functions UpdateSCInvLineDim@200(),CopyJnlLineDimToBuffer@86(),
    //                                  Copy    function  UpdatePurchSCInvLineDim() for DIT Purchase service contract
    //                     22/12/2010 issue 822 Added functions CopyPostedDocDimToJnlLineDim()
    //                     16/03/2011 issue 1292 Added functions CopyTempDimBuf1To(),CopyTempDimBuf2To()
    // DITW16.00.00.40 DDR 17/01/2012 DIT-715 #195 Added function CopyDimBufToAnyDocDim2()
    //                                             Removed 'Replace' parameter for function CopyDimBufToAnyDocDim()
    //                                             Bugfix to return the 'shortcut dimension' parameter for function CopyDimBufToAnyDocDim()
    //                     19/01/2012 DIT-715 #196 Added function ReadDimBufToJnlLineDim()
    // DITW16.00.00.41 AHU 07/08/2012 DIT-715 #327 Added function TypeToTableID2034932() to return tableID
    //                                               with field "Service Contract type"::[Service Contract,DIT Contract]
    //                                             Updated function SetupObjectNoList()
    //                                               new table2034910 Contract Header DIT
    //                                               new table2034890 Service Purch. Contract Header
    //                 AHU 10/08/2012 DIT-715 #378 Updated function SetupObjectNoList()
    //                                               new table2014317 Indirect Journal Line
    //                                               new table2014320 Indirect Cust. Ledger Entry
    //                 AHU 23/08/2012 DIT-715 #393 Added functions CopySCDimToJnlDim()
    //                 AHU 27/08/2012 DIT-715 #426 Added functions UpdateSalesDITCInvLineDim()
    //                 AHU 31/08/2012 DIT-715 #327 Bugfix functions TypeToTableID2034932()
    // DITW16.00.00.42 DDR 29/11/2012 DIT-715 #470 Added functions RenameSetupAnyDimValueCode(),RenameSetupDimValueCode(),
    //                                                             RenameAnyDefaultDim(),SaveAnyDefaultDim2()
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0014.1
    //                             interdoc approval
    // DITW17.00.02 SR 20/09/2013 DIT-770 #187 : New Function "SelectDimObj2,UpdateDefaultDimObj2,ChangeDimObj2,UpdateChangeDimObj2" Added to Add & Update the Cost Object 2 in Cost Accounting
    // DITW17.00.02 SR 20/09/2013 DIT-770 #137 : New Code Added for Dimension
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : Code Added to Update Customer Link Dimension
    // DITW17.00.02 AT 10/01/2014 DIT-770 #351 : Correction in data for Dimension Value
    // DITW17.10.02 VSC 16/04/2014 DIT-770 #613 : Use Selected Dim Filter and not the Table Data.
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW18.00.06 MSF 20/02/2015 DIT-770 #1188 Chapter (6.1 Access per Site )
    //                                           Added Function CheckAllowedDim
    // DITW18.00.06 MSF 14/05/2015 DIT-770 #1316 Error message on Dimension Button on Vendor Templates
    // DITW18.00.06 DDR 13/07/2015 DIT-770 #1460 Performance GetShortcutDimensions() function
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                           Added field "Financial Contract No."
    //                                           Rename Caption Contract No. by Service contract No.
    //                                           Change ID of field Contract Type to Foundation layer 2035393
    //                                           Added blank Option to Contract Type
    // DITW19.00.07 MVN 30/12/2015 DIT-770 #001 Upgrade: Set Global GlobalDimNo
    // DITW18.00.07 MSF 13/05/2015 DIT-770 #1953 only one Dim shortcut have a value in PO and Sales order line

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 10/03/2017 NRQ#20699 UPGRADE NAV 2017 renamed function CheckAllowedDim() -> CheckUserAllowedDim()
    //                                                         deleted unused functions SelectDimObj2();UpdateDefaultDimObj2(),ChangeDimObj2();UpdateChangeDimObj2()
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // DITW110.00.10 YHE 20/06/2017 NRQ#24534 fix Shortcut Dimension issue
    // FINXL10.01 AKH 19/07/2017 NRQ#33089 Added code to autocreate dimensions for customers, vendors & items
    // DITW110.00.10 AKH 28/07/2017 NRQ#23005 Adjusted code after merge from XL (NRQ#33089)
    // HEI.01 FDD-SLSGAP015 IBM NASTAA02 24.04.2018 # Default Dimensions in the Promotion Charges
    //   # Added new Table 2013788 - "Free Reason Code" on "SetupObjectNoList" Function
    // HEI.02 CHG2119178 IBM.AS 30.06.2021
    //   # HeiLite Base Stability Changes for Posting functions at JOB NAS
    //   # Adding GUIAllowed function added in Functions UpdateJobTaskDim() for JOB Execution to avoid any manual intervention
    // HEI.03 CHG2123219 IBM.BHATTA09 01.12.2021
    //   # Functions added to get SKU CCC Dimension Code
    // HEI.04 CHG2145896 BHATTA09 14.03.2022
    //   # Code fine tuning for getting SKU CCC Dimension
    // HEI.05 CHG2221449 IBM SISUM01 26.09.2023 Dimension Value Code Re-design for Import 80milions
    //   # Remove Temporary the NAV Validation on the Dimension VALUE Comb, in order to avoid the tables locks
    // HEI.06 CHG2224366 IBM SISUM01 17.10.2023 Enable the Dimension Combination Validation
    //   # Enable the Dimension Combination Validation after the initial load (CHG2221449)
    // HEI.07 CHG2266140 IBM POENAB02 27.08.2024 Update missing CC dimension which are missing in posted documents
    //   # Modified function GetGLSetup
    //   # Increased GLSetupShortcutDimCode variable array from 8 to 14
    // HEI.08 CHG2266140 IBM POENAB02 28.08.2024 Update missing CC dimension which are missing in posted documents
    //   # Removed HEI.07 changes
    //   # GLSetupShortcutDimCode variable array changed back from 14 to 8
    //   # Modified function LookupDimValueCode

    //BC Upgrade SHARMP16 begin>> ---- 408 DimensionManagement--- Free Reason Code table Drinlk-IT 
    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::DimensionManagement, OnAfterSetupObjectNoList, '', false, false)]
    //     local procedure OnAfterSetupObjectNoListvar(var TempAllObjWithCaption: Record AllObjWithCaption temporary)
    //    var
    //    Dim: Codeunit "DimensionManagement";
    //     begin
    //         Dim.InsertObject(TempAllObjWithCaption, DATABASE::"Free Reason Code"); //HEI.01
    //     end;
    //BC Upgrade SHARMP16 end<< ---- Free Reason Code table Drinlk-IT
    //BC Upgrade SHARMP16 begin>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::DimensionManagement, 'OnUpdateJobTaskDimOnBeforConfirm', '', false, false)]
    local procedure OnUpdateJobTaskDimOnBeforConfirmHandler(DefaultDimension: Record "Default Dimension"; var IsHandled: Boolean)
    var
        Text019: Label 'You have changed a dimension.\\Do you want to update the lines?';
    begin
        //<<HEI.02 - Custom Confirmation Logic
        if GuiAllowed then begin
            if not Confirm(Text019, true) then begin
                IsHandled := true; // Prevents standard confirmation logic
                exit;
            end;
        end;
        //>>HEI.02
    end;

    local procedure GETCCCFromSKU()
    var
        lGLSetUp: Record "General Ledger Setup";
        lDimVal: Record "Dimension Value";
    begin
        //HEI.03
        gCCCDimCode := '';
        IF (gItemNo <> '') AND (gLocationCode <> '') THEN BEGIN
            //HEI.04>>
            //   {gSKU.RESET;
            //             gSKU.SETRANGE("Item No.", gItemNo);
            //             gSKU.SETRANGE("Location Code", gLocationCode);
            //             IF gSKU.FINDFIRST THEN}
            //HEI.04//Old code commented
            //HEI.04>>
            IF gSKU.GET(gLocationCode, gItemNo, '') THEN
                gCCCDimCode := gSKU."CCC Dim. Code FND";
            //HEI.04<<
        END;
        lGLSetUp.GET();
        // {lDimVal.RESET;
        //         lDimVal.SETRANGE("Dimension Code", lGLSetUp."Shortcut Dimension 2 Code");
        //         lDimVal.SETRANGE(Code, gCCCDimCode);
        //         IF lDimVal.FINDFIRST THEN}
        //HEI.04//Old code commented
        IF lDimVal.GET(lGLSetUp."Shortcut Dimension 2 Code", gCCCDimCode) THEN//HEI.04
            gDimValID := lDimVal."Dimension Value ID";
        //HEI.03
    end;

    procedure GetItemNoAndLocation(ItemNo: Code[20]; LocationCode: Code[10])
    begin
        //HEI.03
        gItemNo := ItemNo;
        gLocationCode := LocationCode;
        //HEI.03
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::DimensionManagement, OnGetDefaultDimIDOnAfterAttributeGlobalDims, '', false, false)]
    local procedure OnGetDefaultDimIDOnAfterAttributeGlobalDims(var GlobalDim1Code: Code[20]; var GlobalDim2Code: Code[20])
    var
        TempDimBuf2: Record "Dimension Buffer";
    begin
        //>>HEI.03
        IF GlobalDim2Code[2] = TempDimBuf2."Dimension Code" THEN BEGIN
            GlobalDim2Code := TempDimBuf2."Dimension Value Code";
            GetCCCFromSKU();
            IF gCCCDimCode <> '' THEN BEGIN
                GlobalDim2Code := gCCCDimCode;
                TempDimBuf2."Dimension Value Code" := GlobalDim2Code;
                TempDimBuf2.MODIFY();
            END;
        END;
        //HEI.03<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::DimensionManagement, OnBeforeLookupDimValueCode, '', false, false)]
    local procedure OnBeforeLookupDimValueCodeHandler(FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    var
        DimVal: Record "Dimension Value";
        DimMgmt: Codeunit DimensionManagement;
    begin
        //HEI.08>> Custom Lookup logic for FieldNumber 9–13

        case FieldNumber of
            9:
                DimVal.SetRange("Dimension Code", 'SKU');
            10:
                DimVal.SetRange("Dimension Code", 'INV_LEV');
            11:
                DimVal.SetRange("Dimension Code", 'AUTO_CUST');
            12:
                DimVal.SetRange("Dimension Code", 'SERVICE ZONE');
            13:
                DimVal.SetRange("Dimension Code", 'L_WRITE_OFF');
            else
                exit;
        end;

        DimVal."Dimension Code" := DimVal.GetRangeMin("Dimension Code");
        DimVal.Code := ShortcutDimCode;

        if Page.RunModal(0, DimVal) = Action::LookupOK then begin
            ShortcutDimCode := DimVal.Code;
        end;

        IsHandled := true;
        //HEI.08<<
    end;

    var
        gCCCDimCode: Code[10];
        gItemNo: Code[20];
        gLocationCode: Code[10];
        gSKU: Record "Stockkeeping Unit";
        gDimValID: Integer;
    //BC Upgrade SHARMP16 end<<--408 DimensionManagement---


    //HEI YADAVM09 codeunit 179 Reversal Post>>
    //     HEI.01 PTPGAP083 IBM NASTAA02 13.06.2018 # Mark Reversed Rejected Payments
    //   # Created function "MarkReversedRejectedPayment"
    //   # Field "Reversed" from "Gen. Journal Line Archive" should be ticked when a transaction is reversed
    // HEI.02 DEFECT 5029 IBM BULIMC01 13/12/2019 #code changed to check the new Reversal Posting Date
    //   #new functions created: CheckReversalPostingDate(), DateNotAllowed()



    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reversal-Post", 'OnRunOnAfterConfirm', '', true, true)]
    // local procedure OnRunOnAfterConfirm(var ReversalEntry: Record "Reversal Entry"; var Handled: Boolean; PrintRegister: Boolean; HideDialog: Boolean)
    // var
    //     ErrorReversalPostingDate: Label 'Reversal Posting Date %1 is not within your range of allowed posting dates.';
    //     Text011: Label 'Please provide a reversal posting date!';
    //     Rec: Record "Reversal Entry";
    //     Number: Integer;
    //     GenJnlTemplate: Record "Gen. Journal Template";
    //     Text003: Label 'The entries were successfully reversed.';
    //     GenJnlPostReverse: Codeunit "Gen. Jnl.-Post Reverse";
    //     GLReg: Record "G/L Register";
    //     PostedDeferralHeader: Record "Posted Deferral Header";
    //     Text008: Label 'Changes have been made to posted entries after the window was opened.\Close and reopen the window to continue.';
    // begin
    //     Rec := ReversalEntry;
    //     if Rec."Reversal Type" = Rec."Reversal Type"::Transaction then
    //         ReversalEntry.SetReverseFilter(Rec."Transaction No.", Rec."Reversal Type")
    //     else
    //         ReversalEntry.SetReverseFilter(Rec."G/L Register No.", Rec."Reversal Type");
    //     //HEI.02>>
    //     IF CheckReversalPostingDate() THEN BEGIN
    //         IF InputReversalPostingDate <> 0D THEN BEGIN
    //             ReversalEntry."Posting Date" := InputReversalPostingDate;
    //             IF DateNotAllowed(InputReversalPostingDate) THEN
    //                 ERROR(ErrorReversalPostingDate, InputReversalPostingDate)
    //         END ELSE
    //             ERROR(Text011);
    //     END ELSE
    //         ReversalEntry.CheckEntries();
    //     //HEI.02<<
    //     Rec.Get(1);
    //     if Rec."Reversal Type" = Rec."Reversal Type"::Register then
    //         Number := Rec."G/L Register No."
    //     else
    //         Number := Rec."Transaction No.";
    //     if not ReversalEntry.VerifyReversalEntries(Rec, Number, Rec."Reversal Type") then
    //         Error(Text008);
    //     GenJnlPostReverse.Reverse(ReversalEntry, Rec);
    //     if PrintRegister then begin
    //         GenJnlTemplate.Validate(Type);
    //         if GenJnlTemplate."Posting Report ID" <> 0 then
    //             if GLReg.FindLast() then begin
    //                 GLReg.SetRecFilter();
    //                 //OnBeforeGLRegPostingReportPrint(GenJnlTemplate."Posting Report ID", false, false, GLReg, Handled);
    //                 if not Handled then
    //                     REPORT.Run(GenJnlTemplate."Posting Report ID", false, false, GLReg);
    //             end;
    //     end;
    //     // OnRunOnBeforeDeleteAll(Rec, Number);
    //     MarkReversedRejectedPayment(ReversalEntry); //HEI.01
    //     Rec.DeleteAll();
    //     PostedDeferralHeader.DeleteForDoc("Deferral Document Type"::"G/L".AsInteger(), ReversalEntry."Document No.", '', 0, '');
    //     if not HideDialog then
    //         Message(Text003);

    //     Handled := true;
    // end;

    // procedure CheckReversalPostingDate(): Boolean
    // var
    //     ConfirmDialog: Page ConfirmDialog;
    // begin
    //     //HEI.02>>
    //     ConfirmDialog.LOOKUPMODE(TRUE);
    //     IF ConfirmDialog.RUNMODAL() = ACTION::Yes THEN BEGIN
    //         InputReversalPostingDate := ConfirmDialog.ReturnEnteredNumber();
    //         EXIT(TRUE)
    //     END ELSE
    //         EXIT(FALSE);
    //     //HEI.02<<
    // end;

    // procedure DateNotAllowed(PostingDate: Date): Boolean
    // var
    //     AllowPostingFrom: Date;
    //     AllowPostingTo: Date;
    //     UserSetup: Record "User Setup";
    //     GLSetup: Record "General Ledger Setup";
    // begin
    //     //HEI.02>>
    //     IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
    //         IF USERID <> '' THEN
    //             IF UserSetup.GET(USERID) THEN BEGIN
    //                 AllowPostingFrom := UserSetup."Allow Posting From";
    //                 AllowPostingTo := UserSetup."Allow Posting To";
    //             END;
    //         IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
    //             GLSetup.GET();
    //             AllowPostingFrom := GLSetup."Allow Posting From";
    //             AllowPostingTo := GLSetup."Allow Posting To";
    //         END;
    //         IF AllowPostingTo = 0D THEN
    //             AllowPostingTo := DMY2DATE(31, 12, 9999);
    //     END;
    //     EXIT((PostingDate < AllowPostingFrom) OR (PostingDate > AllowPostingTo));
    //     //HEI.02
    // end;

    // LOCAL procedure MarkReversedRejectedPayment(ReversalEntry: Record "Reversal Entry")
    // var
    //     GenJournalLineArchive: Record "Gen. Journal Line Archive";
    // begin
    //     //HEI.01>>
    //     GenJournalLineArchive.SETRANGE("Document Type", ReversalEntry."Document Type");
    //     GenJournalLineArchive.SETRANGE("Document No.", ReversalEntry."Document No.");
    //     GenJournalLineArchive.SETRANGE("Posting Date", ReversalEntry."Posting Date");
    //     GenJournalLineArchive.SETRANGE("Account No.", ReversalEntry."Account No.");
    //     IF GenJournalLineArchive.FINDSET() THEN
    //         REPEAT
    //             GenJournalLineArchive.Reversed := TRUE;
    //             GenJournalLineArchive.MODIFY();
    //         UNTIL GenJournalLineArchive.NEXT() = 0;
    //     //HEI.01<<
    // end;/BC SHARMP16-- GAPFitchanges 10March26-- shifted to CU50287
    //HEI YADAVM09 codeunit 179 Reversal Post>> 


    //BC UPGRADE PATHAA02-Ext for CU5407-ProdOrderStatusMgmt 13.11.25>>
    //     HEI.01 IBM.AK INC2972521 (corrective change)
    // # System error when reversing wrong production order
    // # Code changed on Function-MatrOrCapConsumpExists
    // HEI.02 CHG2129985 IBM.LS      21.02.2022
    //   # Created New Function - OnAfterReleasedProdOrder
    //   # Added Code to call function
    // HEI.03 CHG2149734 SAHAL01 08.11.2022 Astro - I/F Production - ProductionOrderSync
    //   # Created New Function - OnAfterReleasedProdOrderforAstro
    //   # Added Code to call function


    //HEI.01-CU5407>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", OnBeforeMatrOrCapConsumpExists, '', false, false)]
    local procedure ProdOrderStatusManagement_OnBeforeMatrOrCapConsumpExists(ProdOrderLine: Record "Prod. Order Line"; var EntriesExist: Boolean; var IsHandled: Boolean)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        CapLedgEntry: Record "Capacity Ledger Entry";

    begin
        ItemLedgEntry.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.");
        ItemLedgEntry.SETRANGE("Order Type", ItemLedgEntry."Order Type"::Production);
        ItemLedgEntry.SETRANGE("Order No.", ProdOrderLine."Prod. Order No.");
        ItemLedgEntry.SETRANGE("Order Line No.", ProdOrderLine."Line No.");
        ItemLedgEntry.SETRANGE("Entry Type", ItemLedgEntry."Entry Type"::Consumption);
        // {IF NOT ItemLedgEntry.ISEMPTY THEN
        //     EXIT(TRUE);} //commented std HEI.01 comment base
        //HEI.01 >>
        IF ItemLedgEntry.FINDFIRST() THEN BEGIN
            ItemLedgEntry.CALCSUMS(Quantity);
            IF ItemLedgEntry.Quantity <> 0 THEN BEGIN
                EntriesExist := TRUE;
                IsHandled := TRUE; // skipping standard
                EXIT;
            END;
        END;
        //HEI.01<<

        CapLedgEntry.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.", "Routing No.", "Routing Reference No.");
        CapLedgEntry.SETRANGE("Order Type", CapLedgEntry."Order Type"::Production);
        CapLedgEntry.SETRANGE("Order No.", ProdOrderLine."Prod. Order No.");
        CapLedgEntry.SETRANGE("Routing No.", ProdOrderLine."Routing No.");
        CapLedgEntry.SETRANGE("Routing Reference No.", ProdOrderLine."Routing Reference No.");
        //HEI.01>>
        IF CapLedgEntry.FINDFIRST() THEN BEGIN
            CapLedgEntry.CALCSUMS(Quantity);
            IF CapLedgEntry.Quantity <> 0 THEN BEGIN
                EntriesExist := TRUE;
                IsHandled := TRUE; // skipping standard
                EXIT;
            END;
        END;
        //HEI.01<<
        EntriesExist := FALSE;
        Ishandled := TRUE; // If No entries found, still skipping standard as per custom logic
    end;
    //BC UPGRADE PATHAA02-Ext for CU5407-ProdOrderStatusMgmt-HEI.01 13.11.25<<



    // Codeunit 99000830 Create Reserv. Entry>>Bc Upgrade YADAVM09

    // DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008 BrewIt & Quality
    // DITW15.00.00.38 DDR 16/11/2010 issue 1139 SSCC Functionnalities
    //                                  Modified function TransferReservEntry() to retrieve the new transfer reservation entry
    //                     22/11/2010   Added to copy the item reservation into SSCC Reservation automatically
    //                     26/11/2010   Added function SkipSynchronizationSSCC()
    // DITW15.00.00.38 PRODW14.00.00.08.17 DDR 03/12/2010 issue 1238 Bugfix to save "Your reference" field (of item tracking line)
    //                                                      into the reservation entries
    // DITW15.00.00.39 DDR 06/10/2011 issue 1436 Bugfix skip when item quantity reservation without Lot and/or SSCC nos
    // DITW16.00.00.40 DDR 03/02/2012 #1331 (HIT0069.1 VVE 19/04/2011) FEFO tracking
    //                                  Added 'pcodBinCode' parameter for function SetCustomFields()
    // DITW16.00.00.42 DDR 08/03/2013 DIT-715 #581 Bugfix call SSCC functions CreateEntry()

    // FINXL7.00.001 RBE 20/03/2013: Assign Lot and Serial Nos.

    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added functions SetStrengthValues(),SetNewStrengthValue()
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Added functions SetVolStrengthValues(),SetNewVolStrengthValue()
    //                                      Modified function CreateRemainingReservEntry()
    // DITW19.00.08 DDR 14/11/2016 BL#10443 Bugfix missing sign with functions SetVolStrengthValues(),SetNewVolStrengthValue()

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 AKH 30/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Changes for Backorders
    // DITW110.00.11 VSC 25/09/2017 NRQ#32776 Incorrect (lot) reservation entries for production orders type < surplus should not copy Lot and Serial No.
    //                              Back to NAV Standard.
    // HEI.01 CHG2075364 IBM.LS      23.07.2021
    //   # Added Code
    // HEI.02 CHG2119481 IBM.LS      10.12.2021
    //   # Added Code in function - SetWeightOfExtractValues
    // HEI.03 CHG2119481 IBM.LS      21.01.2022
    //   # Bc Upgrade YADAVM09 Added code to call the function GetLastInsertReservEntry to get the referance for table InsertReservEntry

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnAfterSignFactor', '', true, true)]
    local procedure OnAfterSignFactor(ReservationEntry: Record "Reservation Entry"; var Sign: Integer)
    var
    begin
        case ReservationEntry."Source Type" of
            //HEI.01>>
            DATABASE::"Warehouse Activity Line":
                IF ReservationEntry."Source Subtype" IN [3] THEN
                    Sign := -1;
        //HEI.01<<
        end;
    end;

    procedure SetZoneCode(ZoneCode: Code[10])
    var
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        InsertReservEntry: Record "Reservation Entry";
    begin
        CreateReservEntry.GetLastInsertReservEntry(InsertReservEntry);//Bc Upgrade YADAVM09
        //HEI.01>>
        InsertReservEntry."Zone Code FND" := ZoneCode;
        CreatereserveInsertReservEntry2."Zone Code FND" := ZoneCode;//BC Upgrade Kamnay01 <<07/04/2026 FDD - DTW011   changed the varible from InsertReservEntry2 to  CreatereserveInsertReservEntry2
        //HEI.01<<
    End;



    //BC Upgrade Kamnay01 >>07/04/2026 FDD - DTW011 subscribe this event to store the value from InsertReservEntry2 to global varibale CreatereserveInsertReservEntry2
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", OnAfterCopyFromInsertReservEntry, '', false, false)]
    local procedure "Create Reserv. Entry_OnAfterCopyFromInsertReservEntry"(var InsertReservEntry: Record "Reservation Entry"; var ReservEntry: Record "Reservation Entry"; FromReservEntry: Record "Reservation Entry"; Status: Enum "Reservation Status"; var QtyToHandleAndInvoiceIsSet: Boolean)
    begin
        CreatereserveInsertReservEntry2 := InsertReservEntry;
    end;
    //BC Upgrade Kamnay01 <<07/04/2026 FDD - DTW011 subscribe this event to store the value from InsertReservEntry2 to global varibale CreatereserveInsertReservEntry2

    procedure SetWeightOfExtractValues("KG/HL": Decimal; WeightOfExtract: Decimal)
    var
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        InsertReservEntry: Record "Reservation Entry";
    begin
        CreateReservEntry.GetLastInsertReservEntry(InsertReservEntry);//Bc Upgrade YADAVM09
        //HEI.02>>
        InsertReservEntry."KG/HL FND" := "KG/HL";
        InsertReservEntry."Weight of Extract FND" := WeightOfExtract;
        CreatereserveInsertReservEntry2."KG/HL FND" := "KG/HL";//BC Upgrade Kamnay01 <<07/04/2026 FDD - DTW011   changed the varible from InsertReservEntry2 to  CreatereserveInsertReservEntry2
        CreatereserveInsertReservEntry2."Weight of Extract FND" := WeightOfExtract;//BC Upgrade Kamnay01 <<07/04/2026 FDD - DTW011 Changed the varible from InsertReservEntry2 to  CreatereserveInsertReservEntry2
        //HEI.02<<
    end;

    procedure SetRefNo(RefNo: Code[20])
    var
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        InsertReservEntry: Record "Reservation Entry";
    begin
        CreateReservEntry.GetLastInsertReservEntry(InsertReservEntry);//Bc Upgrade YADAVM09
        //HEI.03>>
        InsertReservEntry."Reference No. FND" := RefNo;
        CreatereserveInsertReservEntry2."Reference No. FND" := RefNo;//BC Upgrade Kamnay01 <<07/04/2026 FDD - DTW011   changed the varible from InsertReservEntry2 to  CreatereserveInsertReservEntry2
        //HEI.03<<
    end;

    // Codeunit 99000830 Create Reserv. Entry<< Bc Upgrade YADAVM09


    //BC Upgrade KAPOOV01-Ext for CU20-Posting Preview Event Handler 17.11.25>>

    //HEI.01 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //   #New function created #OnInsertLevyTaxEntry
    //    code added in Function #ShowEntries
    //                           #FillDocumentEntries
    // version NAVW110.0,HEI.01

    //--------------------------------------------------------------------------------------------------------------
    //BC Upgrade KAPOOV01 17.11.2025 #Added three new event subscriber functions - OnAfterShowEntries,OnAfterFillDocumentEntry,OnInsertLevyTaxEntry under tag-//HEI.01-CU20

    //Bc upgrade YADAVM09 code added in Levy custom codeunit>>
    //HEI.01-CU20>>
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Preview Event Handler", 'OnAfterShowEntries', '', false, false)]
    // local procedure OnAfterShowEntries(TableNo: Integer)
    // var

    //     TempLevyTaxEntries: Record "Levy Tax Entries FND" temporary;
    // begin
    //     CASE TableNo OF
    //         //HEI.01>>
    //         DATABASE::"Levy Tax Entries FND":
    //             PAGE.RUN(PAGE::"Levy Tax Entries", TempLevyTaxEntries);

    //     //HEI.01<<
    //     end
    // end;//Bc upgrade YADAVM09 code added in Levy custom codeunit<<


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Preview Event Handler", 'OnAfterFillDocumentEntry', '', false, false)]
    // local procedure OnAfterFillDocumentEntry(var DocumentEntry: Record "Document Entry" temporary)
    // var
    //     TempLevyTaxEntries: Record "Levy Tax Entries FND" temporary;
    //     PostingPreviewEventHandler: Codeunit "Posting Preview Event Handler";
    //     PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    // begin
    //     //HEI.01>>
    //     PurchasesPayablesSetup.GET();
    //     IF PurchasesPayablesSetup."H&S Levy Tax FND" THEN
    //         //InsertDocumentEntry(TempLevyTaxEntries,TempDocumentEntry); //BC Upgrade KAPOOV01 Commented as need to change variable name-TempDocumentEntry to DocumentEntry as defined in the Event Subcriber function.
    //         PostingPreviewEventHandler.InsertDocumentEntry(TempLevyTaxEntries, DocumentEntry);
    //     //BC Upgrade KAPOOV01<<
    //     //HEI.01<<
    // end;


    // [EventSubscriber(ObjectType::Table, Database::"Levy Tax Entries FND", OnAfterInsertEvent, '', false, false)]
    // local procedure OnInsertLevyTaxEntry(VAR Rec: Record "Levy Tax Entries FND"; RunTrigger: Boolean)
    // var
    //     TempLevyTaxEntries: Record "Levy Tax Entries FND" temporary;
    //     PostingPreviewEventHandler: Codeunit "Posting Preview Event Handler";
    //     PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    // begin
    //     //HEI.01>>
    //     PurchasesPayablesSetup.GET();
    //     IF PurchasesPayablesSetup."H&S Levy Tax FND" THEN BEGIN
    //         IF Rec.ISTEMPORARY THEN
    //             EXIT;
    //         PostingPreviewEventHandler.PreventCommit();
    //         TempLevyTaxEntries := Rec;
    //         TempLevyTaxEntries."Doc. No." := '***';
    //         TempLevyTaxEntries.INSERT();
    //     END;
    //     //HEI.01<<
    // end;//Bc Upgrade YADAVM09 code added in Levy custom codeunit<<
    // //HEI.01-CU20<<
    //BC Upgrade KAPOOV01-Ext for CU20-Posting Preview Event Handler 17.11.25<<





    //BC Upgrade SHUKLP03 >> Codeunit 6501

    // HEI.01 RFC-CHG2026226 IBM.KUMARN15 25.09.2019
    // # Subscribed event OnAfterAssistEditTrackingNoLookupLotNo and OnSelectMultipleTrackingNoOnBeforeSetSources to add code.

    // HEI.02 CHG2045567 IBM.TUDOSG01 22.02.2020
    // # Subscribed event OnSelectMultipleTrackingNoOnBeforeSetSources to add code.

    // HEI.03 CHG2075364 IBM.LS      21.07.2021
    // # Subscribed event OnCreateEntrySummary2OnBeforeInsertOrModify, OnAfterAssistEditTrackingNoLookupLotNo, OnSelectMultipleTrackingNoOnBeforeSetSources, OnAssistEditTrackingNoOnBeforeSetSources
    // OnSelectMultipleTrackingNoOnBeforeAutoSelectTrackingNo, OnLookupTrackingAvailabilityOnBeforeSetSources, OnTransferItemLedgToTempRecOnBeforeInsert
    // OnBeforeUpdateBinContent, OnCreateEntrySummary2OnAfterSetDoubleEntryAdjustment, OnCreateEntrySummary2OnBeforeInsertOrModify
    // OnAddSelectedTrackingToDataSetOnAfterInitTrackingSpecification2, OnAddSelectedTrackingToDataSetOnAfterSetTrackingFilterFromEntrySummary
    // OnBeforeTempTrackingSpecificationInsert and OnUpdateBinContentOnBeforeCalcSumsQtyBase.
    // # HEI.03 code at the end of procedure AddSelectedTrackingToDataSet is not added because event did not found, procedure name changed from
    //  to AddSelectedLotSNToDataSet = NAV to AddSelectedTrackingToDataSet = BC.  
    // # Subscribed event OnAfterRetrieveLookupData to add code for procedure AdjustForDoubleEntriesForManufacturing, procedure name changed from AdjustForDoubleEntries = Nav to AdjustForDoubleEntriesForManufacturing = BC.
    // # Added procedure ApplyFilters() and procedure SetCurrentZoneCode
    // # some part of HEI.03 code is not added for Procedure CreateEntrySummary2() because code is written inside DrinkIT code.	
    // # On subscribed event OnUpdateBinContentOnBeforeCalcSumsQtyBase, some part of HEI.03 code blocked because DrinkIT field "Location Code" and "Bin Code" is used.

    // HEI.04 CHG2119481 IBM.LS      10.12.2021
    // # Some part of HEI.04 code is Blocked on subscribed event OnBeforeTempTrackingSpecificationInsert because DrinkIT fields "Strength Spec. Code", 	"KG/HL" and "Weight of Extract" are used.

    // HEI.05 CHG2119481 IBM.LS      21.01.2022
    // # Subscribed event OnAddSelectedTrackingToDataSetOnAfterInitTrackingSpecification2 to add code for Reference No.

    // HEI.06 CHG2132707 IBM.LS      18.01.2022
    // # Subscribed event OnSelectMultipleTrackingNoOnBeforeSetSources and event OnAddSelectedTrackingToDataSetOnAfterInitTrackingSpecification2 to add Code to apply Bin Content filter and to update New Bine Code
    // # blocked some part of event OnAddSelectedTrackingToDataSetOnAfterInitTrackingSpecification2 because of DrinkIT field "New Location Code", "New bin Code" is used.

    var
        EnabledApplyFilters: Boolean;
        CurrZoneCode: Code[10];
        ITDC: Codeunit "Item Tracking Data Collection";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", OnAfterAssistEditTrackingNoLookupLotNo, '', false, false)]
    local procedure OnAfterAssistEditTrackingNoLookupLotNo(TempTrackingSpecification: Record "Tracking Specification" temporary; var ItemTrackingSummaryPage: Page "Item Tracking Summary")
    var
        ItemJnlTemplate: Record "Item Journal Template";
        TempGlobalEntrySummary: Record "Entry Summary" temporary;
    begin
        //<<HEI.01
        ItemJnlTemplate.RESET();
        ItemJnlTemplate.SETRANGE("Page ID", PAGE::"Production Journal");
        ItemJnlTemplate.SETRANGE(Recurring, FALSE);
        ItemJnlTemplate.SETRANGE(Type, ItemJnlTemplate.Type::"Prod. Order");
        ItemJnlTemplate.FINDFIRST();
        CASE TRUE OF
            (TempTrackingSpecification."Source Type" = DATABASE::"Prod. Order Component") AND
            (TempTrackingSpecification."Source Subtype" = 3),
            (TempTrackingSpecification."Source Type" = DATABASE::"Item Journal Line") AND
            (TempTrackingSpecification."Source Subtype" = 5) AND
            (TempTrackingSpecification."Source ID" = ItemJnlTemplate.Name):
                BEGIN
                    TempGlobalEntrySummary.SETFILTER("Total Quantity", '>0');
                    TempGlobalEntrySummary.SETFILTER("Total Available Quantity", '>0');
                    TempGlobalEntrySummary.SETFILTER("Bin Content", '>0');
                END;
        END;
        //>>HEI.01
        //HEI.03>>
        IF EnabledApplyFilters THEN BEGIN
            IF (TempTrackingSpecification."Source Type" = DATABASE::"Warehouse Activity Line") AND
              (TempTrackingSpecification."Source Subtype" = 3) THEN BEGIN
                TempGlobalEntrySummary.SETFILTER("Total Quantity", '<>0');
                TempGlobalEntrySummary.SETFILTER("Total Available Quantity", '<>0');
                TempGlobalEntrySummary.SETFILTER("Bin Content", '<>0');
            END;
        END;
        //HEI.03<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", OnSelectMultipleTrackingNoOnBeforeSetSources, '', false, false)]
    local procedure OnSelectMultipleTrackingNoOnBeforeSetSources(var MaxQuantity: Decimal; var TempGlobalEntrySummary: Record "Entry Summary" temporary; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    var
        ItemJnlTemplate: Record "Item Journal Template";
        ItemTrackingSummaryForm: Page "Item Tracking Summary";
    begin
        //<<HEI.01
        ItemJnlTemplate.RESET();
        ItemJnlTemplate.SETRANGE("Page ID", PAGE::"Production Journal");
        ItemJnlTemplate.SETRANGE(Recurring, FALSE);
        ItemJnlTemplate.SETRANGE(Type, ItemJnlTemplate.Type::"Prod. Order");
        ItemJnlTemplate.FINDFIRST();
        CASE TRUE OF
            (TempTrackingSpecification."Source Type" = DATABASE::"Prod. Order Component") AND
            (TempTrackingSpecification."Source Subtype" = 3),
            (TempTrackingSpecification."Source Type" = DATABASE::"Item Journal Line") AND
            (TempTrackingSpecification."Source Subtype" = 5) AND
            (TempTrackingSpecification."Source ID" = ItemJnlTemplate.Name):
                BEGIN
                    TempGlobalEntrySummary.SETFILTER("Total Quantity", '>0');
                    TempGlobalEntrySummary.SETFILTER("Total Available Quantity", '>0');
                    TempGlobalEntrySummary.SETFILTER("Bin Content", '>0');
                END;
        END;
        //>>HEI.01
        //HEI.03>>
        IF EnabledApplyFilters THEN BEGIN
            IF (TempTrackingSpecification."Source Type" = DATABASE::"Warehouse Activity Line") AND
                (TempTrackingSpecification."Source Subtype" = 3) THEN BEGIN
                TempGlobalEntrySummary.SETFILTER("Total Quantity", '<>0');
                TempGlobalEntrySummary.SETFILTER("Total Available Quantity", '<>0');
                TempGlobalEntrySummary.SETFILTER("Bin Content", '<>0');
            END;
        END;
        //HEI.03<<
        //HEI.06>>
        CASE TempTrackingSpecification."Source Type" OF
            DATABASE::"Item Journal Line":
                BEGIN
                    CASE TempTrackingSpecification."Source Subtype" OF
                        TempTrackingSpecification."Source Subtype"::"4":
                            BEGIN
                                TempGlobalEntrySummary.SETFILTER("Bin Content", '>0');
                            END;
                    END;
                END;
        END;
        //HEI.06<<
        ItemTrackingSummaryForm.SetTableView(TempGlobalEntrySummary);
        TempGlobalEntrySummary.SetFilter("Table ID", '<>%1', 0); // Filter out summations

        //HEI.02>>
        IF (TempTrackingSpecification."Source Type" = 37) OR
        (TempTrackingSpecification."Source Type" = 5741) OR
        (TempTrackingSpecification."Source Type" = 7347) OR
        (TempTrackingSpecification."Source Type" = 901) THEN BEGIN
            TempGlobalEntrySummary.SETFILTER("Total Available Quantity", '>%1', 0);
            TempGlobalEntrySummary.SETFILTER("Total Quantity", '>%1', 0);
            TempGlobalEntrySummary.SETFILTER("Bin Content", '>%1', 0);
        END;
        //HEI.02<<

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", OnAssistEditTrackingNoOnBeforeSetSources, '', false, false)]
    local procedure OnAssistEditTrackingNoOnBeforeSetSources(var MaxQuantity: Decimal; var TempGlobalEntrySummary: Record "Entry Summary" temporary; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    var
        ItemTrackingSummaryForm: Page "Item Tracking Summary";
    begin
        //HEI.03>>
        IF EnabledApplyFilters THEN BEGIN
            ItemTrackingSummaryForm.ApplyFilters();
            ItemTrackingSummaryForm.SetCurrentZoneCode(CurrZoneCode);
        END;
        //HEI.03<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", OnSelectMultipleTrackingNoOnBeforeAutoSelectTrackingNo, '', false, false)]
    local procedure OnSelectMultipleTrackingNoOnBeforeAutoSelectTrackingNo()
    var
        ItemTrackingSummaryForm: Page "Item Tracking Summary";
    begin
        //HEI.03>>
        IF EnabledApplyFilters THEN BEGIN
            ItemTrackingSummaryForm.ApplyFilters();
            ItemTrackingSummaryForm.SetCurrentZoneCode(CurrZoneCode);
        END;
        //HEI.03<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", OnLookupTrackingAvailabilityOnBeforeSetSources, '', false, false)]
    local procedure OnLookupTrackingAvailabilityOnBeforeSetSources(TempTrackingSpecification: Record "Tracking Specification" temporary; ItemTrackingType: Enum "Item Tracking Type"; var TempGlobalEntrySummary: Record "Entry Summary" temporary)
    var
        ItemTrackingSummaryForm: Page "Item Tracking Summary";
    begin
        //HEI.03>>
        IF EnabledApplyFilters THEN BEGIN
            ItemTrackingSummaryForm.ApplyFilters();
            ItemTrackingSummaryForm.SetCurrentZoneCode(CurrZoneCode);
        END;
        //HEI.03<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", OnTransferItemLedgToTempRecOnBeforeInsert, '', false, false)]
    local procedure OnTransferItemLedgToTempRecOnBeforeInsert(ItemLedgerEntry: Record "Item Ledger Entry"; TrackingSpecification: Record "Tracking Specification"; var IsHandled: Boolean; var TempGlobalReservEntry: Record "Reservation Entry" temporary)
    begin
        //HEI.03>>
        IF EnabledApplyFilters THEN
            TempGlobalReservEntry."Zone Code FND" := CurrZoneCode;
        //HEI.03<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", OnBeforeUpdateBinContent, '', false, false)]
    local procedure OnBeforeUpdateBinContent(var CurrBinCode: Code[20]; var CurrItemTrackingCode: Record "Item Tracking Code"; var TempEntrySummary: Record "Entry Summary" temporary; var TempReservationEntry: Record "Reservation Entry" temporary)
    begin
        //HEI.03>>
        IF EnabledApplyFilters THEN
            TempEntrySummary."Zone Code FND" := TempReservationEntry."Zone Code FND";
        //HEI.03<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", OnCreateEntrySummary2OnBeforeInsertOrModify, '', false, false)]
    local procedure OnCreateEntrySummary2OnBeforeInsertOrModify(TempReservEntry: Record "Reservation Entry" temporary; TrackingSpecification: Record "Tracking Specification"; var TempGlobalEntrySummary: Record "Entry Summary" temporary)
    begin
        //HEI.03>>
        IF EnabledApplyFilters THEN BEGIN
            IF TempGlobalEntrySummary."Expiration Date" = 0D THEN
                TempGlobalEntrySummary."Empty Expiration Date FND" := TRUE
            ELSE
                TempGlobalEntrySummary."Empty Expiration Date FND" := FALSE;
        END;
        //HEI.03<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", OnAddSelectedTrackingToDataSetOnAfterInitTrackingSpecification2, '', false, false)]
    local procedure OnAddSelectedTrackingToDataSetOnAfterInitTrackingSpecification2(TempTrackingSpecification: Record "Tracking Specification" temporary; var TrackingSpecification: Record "Tracking Specification")
    begin
        //HEI.03>>
        IF EnabledApplyFilters THEN
            TrackingSpecification."Zone Code FND" := TempTrackingSpecification."Zone Code FND";
        //HEI.03<<
        //HEI.05>>
        CASE TrackingSpecification."Source Type" OF
            DATABASE::"Item Journal Line":
                BEGIN
                    CASE TrackingSpecification."Source Subtype" OF
                        //HEI.06>>
                        TrackingSpecification."Source Subtype"::"4":
                            BEGIN
                                // BC Upgrade SHUKLP03 >> Code blocked because DrinkIT fields "New Location Code" and "New Bin Code" is used.
                                // TrackingSpecification."New Location Code" := TempTrackingSpecification."New Location Code";
                                // TrackingSpecification."New Bin Code" := TempTrackingSpecification."New Bin Code";
                                // BC Upgrade SHUKLP03 << Code blocked because DrinkIT fields "New Location Code" and "New Bin Code" is used.
                            END;
                        //HEI.06<<
                        TrackingSpecification."Source Subtype"::"5":
                            BEGIN
                                TrackingSpecification."Reference No. FND" := TempTrackingSpecification."Reference No. FND";
                            END;
                    END;
                END;
        END;
        //HEI.05<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", OnAddSelectedTrackingToDataSetOnAfterSetTrackingFilterFromEntrySummary, '', false, false)]
    local procedure OnAddSelectedTrackingToDataSetOnAfterSetTrackingFilterFromEntrySummary(var TempGlobalEntrySummary: Record "Entry Summary" temporary; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    begin
        //HEI.03>>
        IF EnabledApplyFilters THEN
            TempTrackingSpecification.SETRANGE("Zone Code FND", TempGlobalEntrySummary."Zone Code FND");
        //HEI.03<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", OnBeforeTempTrackingSpecificationInsert, '', false, false)]
    local procedure OnBeforeTempTrackingSpecificationInsert(var TempEntrySummary: Record "Entry Summary" temporary; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    begin
        //HEI.03>>
        IF EnabledApplyFilters THEN
            TempTrackingSpecification."Zone Code FND" := TempEntrySummary."Zone Code FND";
        //HEI.03<<
        //HEI.04>>
        CASE TempTrackingSpecification."Source Type" OF
            DATABASE::"Item Journal Line":
                BEGIN
                    CASE TempTrackingSpecification."Source Subtype" OF
                        TempTrackingSpecification."Source Subtype"::"5":
                            BEGIN

                                //BC Upgrade Kamnay01>> 07/04/2026 - FDD-DTW -011 - add the Drinkit field Strength 3 Code 101FDW & Strength 3 Value 101FDW
                                IF (TempTrackingSpecification."Strength 3 Code 101FDW" = 'EXT.[%W/W]') AND (TempTrackingSpecification."Strength 3 Value 101FDW" <> 0) THEN BEGIN
                                    TempTrackingSpecification."KG/HL FND" := (0.99894 * TempTrackingSpecification."Strength 3 Value 101FDW") +
                                                                       (0.00377 * POWER(TempTrackingSpecification."Strength 3 Value 101FDW", 2)) +
                                                                         (0.000016682 * POWER(TempTrackingSpecification."Strength 3 Value 101FDW", 3));
                                    TempTrackingSpecification."Weight of Extract FND" := TempTrackingSpecification."Quantity (Base)" * TempTrackingSpecification."KG/HL FND";
                                END;
                                //BC Upgrade Kamnay01<< 07/04/2026 - FDD-DTW -011 - add the Drinkit field Strength 3 Code 101FDW & Strength 3 Value 101FDW
                            END;
                    END;
                END;
        END;
        //HEI.04<<
        //    TempTrackingSpecification.INSERT();  //BC Upgrade GUNREM01 >> Bug fix executing the code twice because of calling insert in standard code, so commented this line.
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", OnUpdateBinContentOnBeforeCalcSumsQtyBase, '', false, false)]
    local procedure OnUpdateBinContentOnBeforeCalcSumsQtyBase(var TempEntrySummary: Record "Entry Summary" temporary; var WarehouseEntry: Record "Warehouse Entry"; var IsHandled: Boolean)
    begin
        //HEI.03>>
        IF EnabledApplyFilters THEN BEGIN
            //WarehouseEntry.SETRANGE("Location Code", TempEntrySummary."Location Code"); // BC Upgrade SHUKLP03 Blocked because DrinkIT field "Location Code" is used.
            WarehouseEntry.SETRANGE("Zone Code", TempEntrySummary."Zone Code FND");
            //WarehouseEntry.SETRANGE("Bin Code", TempEntrySummary."Bin Code"); // BC Upgrade SHUKLP03 Blocked because DrinkIT field "Bin Code" is used.
        END;
        //HEI.03<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", OnAfterRetrieveLookupData, '', false, false)]
    local procedure OnAfterRetrieveLookupData(var TempGlobalReservEntry: Record "Reservation Entry" temporary; var TrackingSpecification: Record "Tracking Specification")
    var
        TempGlobalTrackingSpec: Record "Tracking Specification" temporary;
    begin

        TempGlobalTrackingSpec.RESET();
        TempGlobalTrackingSpec.DELETEALL();

        //HEI.03>>
        TempGlobalReservEntry.RESET();
        TempGlobalReservEntry.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Ref. No.", "Source Batch Name");
        TempGlobalReservEntry.SETRANGE("Source Type", DATABASE::"Warehouse Activity Line");
        TempGlobalReservEntry.SETRANGE("Source Subtype", 3);
        IF TempGlobalReservEntry.FINDSET() THEN
            REPEAT
                ITDC.SumUpTempTrkgSpec(TempGlobalTrackingSpec, TempGlobalReservEntry);
            UNTIL TempGlobalReservEntry.NEXT() = 0;
        //HEI.03<<


    end;

    procedure ApplyFilters()
    begin
        //HEI.03>>
        EnabledApplyFilters := TRUE;
        //HEI.03<<
    end;

    procedure SetCurrentZoneCode(ZoneCode: Code[10])
    var
        xZoneCode: Code[10];
    begin
        //HEI.03>>
        xZoneCode := CurrZoneCode;
        CurrZoneCode := ZoneCode;
        //HEI.03<<
    end;
    //BC Upgrade SHUKLP03 << Codeunit 6501


    // BC Upgrade SHUKLP03 << Codeunit 1501

    // HEI.01 FDD-PTPGAP002 IBM HORTOC01 19.08.2017
    // # New function "OnAfterHandleEventWithxRec"
    // DITW111.00.13A DDR 03/07/2019 NRQ#103938 Fix NAV? Variant record is not read when next workflow refers the same record (first workflow modified it)
    // HEI.02 CHG2183672 DEBUSD01 05.12.2022 Fix lock new sales order runmodal page
    // HEI.03 CHG2183672 DEBUSD01 12.12.2022 Fix lock new sales order runmodal page


    // BC Upgrade SHUKLP03 >>
    // HEI.01 FDD-PTPGAP002 IBM HORTOC01 19.08.2017
    // # To add new function "OnAfterHandleEventWithxRec" subscribed event OnBeforeHandleEventWithxRec.
    // Custom event publisher OnAfterHandleEventWithxRec.
    // HEI.02 => Added custome procedure SetHideValidationDialogWFM(), changed name from SetHideValidationDialogWF to SetHideValidationDialogWFM because same name procedure is created in Approval mgmt.
    // HEI.03 => Added custome procedure SetShowNotificationDialogWFM(), changed name from SetShowNotificationDialogWF TO SetShowNotificationDialogWFM because same name procedure is created in Approval mgmt
    // HEI.02, HEI.03 => Code is not added because no event is found in Procedure ExecuteResponses(). So, As per discussion with Sakshi for now no need to add this code, we need to find some other workaround.
    // Changed variable name form HideValidationDialogWF to HideValidationDialogWFM, ShowNotificationDialogWF to ShowNotificationDialogWFM because same name variable is created in Approval mgmt
    // BC Upgrade SHUKLP03 <<



    [EventSubscriber(ObjectType::Codeunit, codeunit::"Workflow Management", OnBeforeHandleEventWithxRec, '', false, false)]
    local procedure OnBeforeHandleEventWithxRec(FunctionName: Code[128]; var IsHandled: Boolean; Variant: Variant; xVariant: Variant)
    var
        RecRef: RecordRef;
        WM: Codeunit "Workflow Management";
        ActionableWorkflowStepInstance: Record "Workflow Step Instance";
        FeatureTelemetry: Codeunit "Feature Telemetry";
        TelemetryDimensions: Dictionary of [Text, Text];
        WorkflowEventEndTelemetryTxt: Label 'Workflow event: End Scope', Locked = true;
    begin
        RecRef.GetTable(Variant);
        if RecRef.IsTemporary() then
            exit;

        if WM.FindEventWorkflowStepInstance(ActionableWorkflowStepInstance, FunctionName, Variant, xVariant) then begin
            WM.ExecuteResponses(Variant, xVariant, ActionableWorkflowStepInstance);
            OnAfterHandleEventWithxRec(Variant, xVariant);//HEI.01>>
            FeatureTelemetry.LogUsage('0000GDQ', 'Workflows', 'Event processed');
        end;

        Session.LogMessage('0000DYV', WorkflowEventEndTelemetryTxt, Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, TelemetryDimensions);
        IsHandled := true;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterHandleEventWithxRec(Variant: Variant; xVariant: Variant)
    begin
    end;

    procedure SetHideValidationDialogWFM(NewHideValidationDialogWF: Boolean)
    begin
        //HEI.02>>
        HideValidationDialogWFM := NewHideValidationDialogWF;
    end;

    procedure SetShowNotificationDialogWFM(NewShowNotificationDialogWF: Boolean)
    begin
        //HEI.03>>
        ShowNotificationDialogWFM := NewShowNotificationDialogWF;
    end;

    // BC Upgrade SHUKLP03 << Codeunit 1501 .




    //CD-EXT333.Req. Wksh.-Make Order.al

    // version NAVW110.0.00.16996,FINXL10.00,MANXL7.00.001,DITW110.00.10,FM,HEI.13

    // DITW15.00.00.37 DDR 05/05/2010 issue 1136 Added to skip DIT item charges while creating purchase order lines
    // DITW16.00.00.39 DDR 02/12/2011 DIT-715 #182 Bugfix function InsertPurchOrderLine() to skip all DIT charges
    //                     21/05/2012 DIT-715 #182 Review item charge workflow when Purchase order linked to Prod. order (subcontract

    // MANXL7.00.001 DAT 05/03/2014 #18: Add code to fill "Blanket Order No." + "Blanket Order Line No." + "Requester ID"
    // MANXL7.00.001 WSA 11/07/2014 #87: Added code MANXL security
    // FINXL8.00.001 BSA 05/06/2015 #182: Create Emergency Orders + Add info on lines if checked

    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05  AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.07 AKH 29/02/2016 DIT-770 #1425 Automatic Drop Shipments and Special orders: Added functions GetPurchHeaderCounter(),CarryOutBatchActionTemp()
    //                                                                                        Added temporary DIT-770 #1399
    // DITW18.00.07 AKH 01/03/2016 DIT-770 #1425 Adjusted code
    // DITW18.00.07 VSC 17/03/2016 DIT-770 #2054 Suspend Status Check
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1228 Append and Update to Existing Purchase Order.
    // DITW18.00.07 VSC 20/03/2016 DIT-770 #1228 Check Item Exclusivity;
    // DITW18.00.07 VSC 23/06/2016 DIT-770 #1228 Remove standard nav commit. to prevent partial purch. docs on error
    // DITW18.00.07 VSC 30/06/2016 DIT-770 #1228 Testfield Quantity on Append mode must be on SalesLine.Quantity not Outstanding Quantity
    // DITW19.00.08 AKH 14/10/2016 BL#9753 (DIT-770 #1399) BugFix on automatic item charges for Purch. Orders (Dop Ship./Special ord.) created via Requisition Worksheet

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4

    // DITW110.00.10 DDR 12/05/2017 NRQ#26354 fix auto-create drop shipment when multi-vendors
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Changes for Backorders

    // HEI.01 FDD-PRDGAP061 - Planning nonBOM items v0.2,  IBM.NAIKH01 - 19.12.2018
    //   # Added code in Function "InsertPurchOrderLine" to restrict the creation of PO if the Blanket Order No is Blank and
    //     add Blanket Order Details in New purch Line.
    //   # Added code in Function "InsertHeader"

    // HEI.02 S&OP Core interfaces IBM POSTOI01 20.05.2019
    //   # new global variable ReleasePurchDoc
    //   # add code to Code, the Purchase Order should becreated with Realeased Status, not Open
    // HEI.04 FDD-HT657 IBM NASTAA02 16.12.2019 # Ethiopia Intercompany Automation
    //   # Restriction on Blanket Order No. should not be checked for Drop Shipments on function "InsertPurchOrderLine"
    // HEI.05 CHG2033409 S&OP Core interfaces IBM POSTOI01 Purchase requisition
    //   # Restriction on Blanket Order No. should not be checked for IC Partener Code (vendor card) <> '' on function "InsertPurchOrderLine"
    // HEI.07 CHG2073467 HB1369 IBM GAVANM01 17.08.2020  Enhancements to the Intercompany automation functionality
    //   # new global var PurchaseOrdersNos
    //   # new function GetPurchaseOrdersNos
    // HEI.08 CHG2073468 HB1369 IBM GAVANM01 04.01.2021 Enhancements to Intercompany Part 3
    //   # code added to copy the "Sales Order No" into "Special Order No." in Purch Additional Header
    // HEI.09 CHG2119830 IBM NANDIS01 25.04.2022 Implement S&OP Core Purchase Requisition Interface
    //   # Few fields validation will be stopped from contract - Location code, Direct Unit Cost in PO line level
    //   # Due Date from PO Header
    // HEI.10 CHG2119830 IBM NANDIS01 03.03.2022 Implement S&OP Core Purchase Requisition Interface
    //   # New PO created from Req worksheet should be kept OPEN
    //   # Import Validation added
    // HEI.11 CHG2119830 IBM NANDIS01 20.03.2022 Implement S&OP Core Purchase Requisition Interface
    //   # Expected Receipt Date will be populated from Due Date of Requisition Line AND populated SRM Cobtract Line No as well
    // HEI.12 CHG2261624 IBM SRIVAS07 06.08.2024 # S&OP Fit import purchase requisitions-Development
    //   # Code added to InsertPurchOrderLine()
    // HEI.13 CHG2261624 IBM SRIVAS07 12.08.2024 # S&OP Fit import purchase requisitions-Development
    //   # Code added to InsertPurchOrderLine()


    //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    //BC Upgrade KAPOOV01 19.11.2025 # Created new below Event Subscriber functions-
    //HEI.12,HEI.13-OnInitPurchOrderLineOnAfterValidateLineDiscount
    //HEI.01,HEI.09,HEI.11-OnBeforePurchOrderLineInsert
    //HEI.01,HEI.04,HEI.05-OnBeforeInsertPurchOrderLineSubscriber
    //HEI.10-OnAfterInsertPurchOrderLine
    //HEI.01,HEI.09-OnAfterInsertPurchOrderHeader
    //Created new Global Variable-PurchaseOrdersNos for as this variable is used in various functions.
    //HEI.07-Created new local procedure-GetPurchaseOrdersNos and Event Subscriber function-OnCodeOnBeforeSetPurchOrderHeader,OnAfterInsertPurchOrderHeader.


    //HEI.12,HEI.13-CD-333>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", OnInitPurchOrderLineOnAfterValidateLineDiscount, '', false, false)]
    local procedure OnInitPurchOrderLineOnAfterValidateLineDiscount(var PurchOrderLine: Record "Purchase Line"; PurchOrderHeader: Record "Purchase Header"; RequisitionLine: Record "Requisition Line")
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        //HEI.12>>
        PurchasesPayablesSetup.GET(); //HEI.13
        IF (PurchasesPayablesSetup."Excluded Incoterms FND" <> '') AND (PurchasesPayablesSetup."Location Code Imp Proc. FND" <> '') THEN BEGIN
            IF STRPOS(PurchasesPayablesSetup."Excluded Incoterms FND", PurchOrderHeader."Shipment Method Code") = 0 THEN
                PurchOrderLine.VALIDATE("Location Code", PurchasesPayablesSetup."Location Code Imp Proc. FND")
            ELSE
                PurchOrderLine.VALIDATE("Location Code", RequisitionLine."Location Code");
        END ELSE
            PurchOrderLine.VALIDATE("Location Code", RequisitionLine."Location Code");
        //HEI.12<<
    end;
    //HEI.12,HEI.13-CD-333>>

    //HEI.01,HEI.09,HEI.11-CD-333>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", OnBeforePurchOrderLineInsert, '', false, false)]
    local procedure OnBeforePurchOrderLineInsert(var PurchOrderHeader: Record "Purchase Header"; var PurchOrderLine: Record "Purchase Line"; var ReqLine: Record "Requisition Line"; CommitIsSuppressed: Boolean)
    var
        PurchaseLine1: Record "Purchase Line";
        Vendor: Record Vendor;
    begin
        IF Vendor.GET(ReqLine."Vendor No.") THEN; //BC Upgrade KAPOOV01 added new code to Get vendor used later in this function.
        //>>Hei.01
        PurchaseLine1.RESET();
        PurchaseLine1.SETRANGE(PurchaseLine1."Document Type", PurchaseLine1."Document Type"::"Blanket Order");
        //BC Upgrade KAPOOV01 Drink-IT commented as Customization done on Drink-IT fields>>
        // PurchaseLine1.SETRANGE(PurchaseLine1."Document No.", ReqLine."Blanket Order No.");
        // PurchaseLine1.SETRANGE(PurchaseLine1."Line No.", ReqLine."Blanket Order Line No.");
        //BC Upgrade KAPOOV01 Drink-IT commented as Customization done on Drink-IT fields<<
        IF PurchaseLine1.FINDFIRST() THEN BEGIN
            //PurchOrderLine."Location Code"  := PurchaseLine1."Location Code";//HEI.09
            PurchOrderLine."Description 2" := PurchaseLine1."Description 2";
            //PurchOrderLine."Direct Unit Cost excl. VAT" := PurchaseLine1."Direct Unit Cost";
            //PurchOrderLine."Direct Unit Cost" := PurchaseLine1."Direct Unit Cost";//HEI.09

            PurchOrderLine."Unit Cost" := PurchaseLine1."Unit Cost";
            PurchOrderLine."Vendor Item No." := PurchaseLine1."Vendor Item No.";
            PurchOrderLine."Dimension Set ID" := PurchaseLine1."Dimension Set ID";
            //HEI.09>>
            //PurchOrderLine."Requested Receipt Date" := PurchaseLine1."Requested Receipt Date";
            PurchOrderLine.VALIDATE("Requested Receipt Date", CALCDATE(Vendor."Lead Time Calculation", WORKDATE()));
            //HEI.09<<
            PurchOrderLine.VALIDATE("Expected Receipt Date", ReqLine."Due Date");  //HEI.11
            PurchOrderLine."SRM Contract No. FND" := PurchaseLine1."SRM Contract No. FND";
            PurchOrderLine."SRM Contract Line No. FND" := PurchaseLine1."SRM Contract Line No. FND";  //HEI.11
                                                                                                      //PurchOrderLine."SRM Contract Name
                                                                                                      //PurchOrderLine."Contract Type" := PurchaseLine1."Contract Type";//BC Upgrade KAPOOV01 Drink-IT Customization done on Drink-IT fields>>
            PurchOrderLine."Valid From FND" := PurchaseLine1."Valid From FND";
            PurchOrderLine."Valid To FND" := PurchaseLine1."Valid To FND";
            PurchOrderLine."CMG Code FND" := PurchaseLine1."CMG Code FND";
            //HEI.09>>
            //PurchOrderLine."Consumption Location Code" := PurchaseLine1."Consumption Location Code";
            PurchOrderLine."Consumption Location Code FND" := PurchOrderLine."Location Code";
            //HEI.09<<
            PurchOrderLine."Target Value Currency FND" := PurchaseLine1."Target Value Currency FND";
            PurchOrderLine."Target Value Amount FND" := PurchaseLine1."Target Value Amount FND";
            //BC Upgrade KAPOOV01 Drink-IT commented as Customization done on Drink-IT fields>>
            // PurchOrderLine."Company Tax Registration No." := PurchaseLine1."Company Tax Registration No.";
            // PurchOrderLine.Weight := PurchaseLine1.Weight;
            //BC Upgrade KAPOOV01 Drink-IT commented as Customization done on Drink-IT fields<<

        END;

        //<<Hei.01
        //HEI.01,HEI.09,HEI.11-CD-333<<
    end;


    //HEI.01,HEI.04,HEI.05-CD-333>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", OnBeforeInsertPurchOrderLine, '', false, false)]
    local procedure OnBeforeInsertPurchOrderLineSubscriber(var RequisitionLine: Record "Requisition Line"; var PurchaseHeader: Record "Purchase Header"; var NextLineNo: Integer; var IsHandled: Boolean; var PrevPurchCode: code[10]; var PrevShipToCode: code[10]; var PlanningResiliency: boolean; TempDocumentEntry: Record "Document Entry" temporary; var SuppressCommit: Boolean; var PostingDateReq: date; var ReferenceReq: text[35]; var OrderDateReq: date; var ReceiveDateReq: date; var OrderCounter: integer; var HideProgressWindow: Boolean; var PrevLocationCode: code[10]; var LineCount: Integer; var PurchOrderHeader: Record "Purchase Header"; PurchasingCode: Record Purchasing; var PurchOrderLine: Record "Purchase Line")
    var
        Vendor: Record Vendor;
        SalesHeader: Record "Sales Header";
        Err001: TextConst ENU = 'PO cannot be created. Blanket Order No. is Blank for WorkSheet template Name= %1, Journal Batch Name= %2,Line No.= %3';
    begin
        //BC Upgrade KAPOOV01>>
        if (RequisitionLine."No." = '') or (RequisitionLine."Vendor No." = '') or (RequisitionLine.Quantity = 0) then
            exit;
        //BC Upgrade KAPOOV01<<
        //HEI.05>>
        IF Vendor.GET(RequisitionLine."Vendor No.") THEN;
        //HEI.05<<

        IF Vendor."IC Partner Code" <> '' THEN BEGIN //HEI.05
                                                     //HEI.04>>
            SalesHeader.GET(SalesHeader."Document Type"::Order, RequisitionLine."Sales Order No.");
            // IF NOT SalesHeader."Special Order" THEN  // BC Upgrade BHARDA11 - Special Order fields is for Ethiopia hence blocked
            //HEI.04<<
            //<<HEI.01
            //IF RequisitionLine."Blanket Order No." = '' THEN //BC Upgrade KAPOOV01 Drink-IT commented as Customization done on Drink-IT fields
            // ERROR(Err001, RequisitionLine."Worksheet Template Name", RequisitionLine."Journal Batch Name", RequisitionLine."Line No.");  // BC Upgrade BHARDA11 - Special Order fields is for Ethiopia hence blocked
            //HEI.01>>
            //HEI.05>>
        END ELSE BEGIN
            //IF RequisitionLine."Blanket Order No." = '' THEN //BC Upgrade KAPOOV01 Drink-IT commented as Customization done on Drink-IT fields
            ERROR(Err001, RequisitionLine."Worksheet Template Name", RequisitionLine."Journal Batch Name", RequisitionLine."Line No.");
        END;
        //HEI.05<<
    end;
    //HEI.01,HEI.04,HEI.05-CD-333<<



    //HEI.08-CD-333>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", OnInsertHeaderOnBeforeSetShipToForSpecOrder, '', false, false)]
    local procedure OnInsertHeaderOnBeforeSetShipToForSpecOrder(var PurchaseHeader: Record "Purchase Header"; RequisitionLine: Record "Requisition Line"; var ShouldSetShipToForSpecOrder: Boolean)
    var
        PurchHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //HEI.08<<
        IF PurchHeaderAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") THEN BEGIN
            PurchHeaderAdditional."Special Order No." := RequisitionLine."Sales Order No.";
            PurchHeaderAdditional.MODIFY();
        END;
        //HEI.08>>
    end;
    //HEI.08-CD-333>>


    //HEI.10-CD-333>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", OnAfterInsertPurchOrderLine, '', false, false)]
    local procedure OnAfterInsertPurchOrderLine(var PurchOrderLine: Record "Purchase Line"; var NextLineNo: Integer; var RequisitionLine: Record "Requisition Line"; var PurchOrderHeader: Record "Purchase Header")
    var

    begin
        PurchOrderHeader.VALIDATE("Shipment Method Code");  //HEI.10
    end;
    //HEI.10-CD-333<<


    //HEI.01,HEI.09-CD-333>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", OnAfterInsertPurchOrderHeader, '', false, false)]
    local procedure OnAfterInsertPurchOrderHeader(var RequisitionLine: Record "Requisition Line"; var PurchaseOrderHeader: Record "Purchase Header"; CommitIsSuppressed: Boolean; SpecialOrder: Boolean)
    var
        PurchaseHeader1: Record "Purchase Header";
    begin
        //>>Hei.01
        PurchaseHeader1.RESET();
        PurchaseHeader1.SETRANGE("Document Type", PurchaseHeader1."Document Type"::"Blanket Order");
        //PurchaseHeader1.SETRANGE("No.", RequisitionLine."Blanket Order No.");//BC Upgrade KAPOOV01 Commented as Customization done on Drink-IT fields
        IF PurchaseHeader1.FINDFIRST() THEN BEGIN
            PurchaseOrderHeader."Payment Terms Code" := PurchaseHeader1."Payment Terms Code";
            //PurchOrderHeader."Due Date" := PurchaseHeader1."Due Date";//HEI.09
            PurchaseOrderHeader."Shipment Method Code" := PurchaseHeader1."Shipment Method Code";
            PurchaseOrderHeader."Shipment Method Location FND" := PurchaseHeader1."Shipment Method Location FND";
            PurchaseOrderHeader."Currency Code" := PurchaseHeader1."Currency Code";
            PurchaseOrderHeader."Purchaser Code" := PurchaseHeader1."Purchaser Code";
            PurchaseOrderHeader."Recalculate Invoice Disc." := PurchaseHeader1."Recalculate Invoice Disc.";
            //PurchOrderHeader.Prepayment Payment Terms Code
            PurchaseOrderHeader."SRM Contract No. FND" := PurchaseHeader1."SRM Contract No. FND";
            PurchaseOrderHeader."SRM Contract Name FND" := PurchaseHeader1."SRM Contract Name FND";
            //PurchaseOrderHeader."Contract Type" := PurchaseHeader1."Contract Type"; //BC Upgrade KAPOOV01 Commented as Customization done on Drink-IT fields
            PurchaseOrderHeader."Valid From FND" := PurchaseHeader1."Valid From FND";
            PurchaseOrderHeader."Valid To FND" := PurchaseHeader1."Valid To FND";
            PurchaseOrderHeader."Channel FND" := PurchaseHeader1."Channel FND";
            PurchaseOrderHeader."Consumption Date FND" := PurchaseHeader1."Consumption Date FND";
            PurchaseOrderHeader."Target Value Currency FND" := PurchaseHeader1."Target Value Currency FND";
            PurchaseOrderHeader."Target Value Amount FND" := PurchaseHeader1."Target Value Amount FND";
            //PurchaseOrderHeader."Blanket Order No." := RequisitionLine."Blanket Order No.";  //BC Upgrade KAPOOV01 Commented as Customization done on Drink-IT fields

        END;
        //<<Hei.01
    end;
    //HEI.01,HEI.09-CD-333<<



    //HEI.07-CD-333>>

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", OnAfterInsertPurchOrderHeader, '', false, false)]
    local procedure "Req. Wksh.-Make Order_OnAfterInsertPurchOrderHeader"(var RequisitionLine: Record "Requisition Line"; var PurchaseOrderHeader: Record "Purchase Header"; CommitIsSuppressed: Boolean; SpecialOrder: Boolean)
    begin
        //HEI.07>>
        IF PurchaseOrdersNos <> '' THEN
            PurchaseOrdersNos += ',' + PurchaseOrderHeader."No."
        ELSE
            PurchaseOrdersNos := PurchaseOrderHeader."No.";
        //HEI.07<<
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", OnCodeOnBeforeSetPurchOrderHeader, '', false, false)]
    local procedure OnCodeOnBeforeSetPurchOrderHeader(var RequisitionLine: Record "Requisition Line"; var IsHandled: Boolean)
    var

    begin
        PurchaseOrdersNos := '';   //HEI.07
                                   //BC Upgrade KAPOOV01 Added HEI commented code below>>
                                   //HEI.02
                                   //ReleasePurchDoc.DocStatusRelease(PurchOrderHeader,PurchOrderHeader);  //HEI.10
                                   //HEI.02//
                                   //BC Upgrade KAPOOV01 Added HEI commented code below<<
    end;

    procedure GetPurchaseOrdersNos(): Text
    var

    begin
        //HEI.07
        EXIT(PurchaseOrdersNos)
    end;
    //HEI.07-CD-333<<
    //BC Upgrade KAPOOV01<<



    // BC Upgrade SHUKLP03 >> Codeunit 1535 Approvals Mgmt.

    // HEI.01 FDD-PTPGAP002 IBM HORTOC01 19.08.2017
    // # Code is blocked in Nav. => call function "OnRejectApprovalRequestCust

    // HEI.02 Defect #1066 IBM NASTAA02 13.12.2017 # Bank sensitive details change
    // # Subscribed event OnBeforeRejectSelectedApprovalRequestChanged to Code changed on function "RejectSelectedApprovalRequest" and parameter is same as BC.
    // # Subscribed event OnBeforeApproveSelectedApprovalRequest to Code changed on function "ApproveSelectedApprovalRequest"

    // HEI.03 PTPGAP077 - IBM HORTOC01 23.03.2018
    // #new function TryDeleteJournalBatch()

    // HEI.04 FDD PTPGAP084 IBM POSTOI01 20.04.2018
    // # Subscribed event OnBeforeApproveSelectedApprovalRequest to Code changed on function ""RejectSelectedApprovalRequest"".

    // HEI.07 FDD-PURGAP027 - Maximo POs approval flow, IBM.POENAB02 , 28.02.2019
    // # Modified function CopyApprovalEntryQuoteToOrder

    // HEI.08 FDD-PURGAP027 IBM NASTAA02 04.06.2019 # Maximo POs approval flow
    // # Subscribed events OnBeforeApproveSelectedApprovalRequest, OnBeforeCreateApprovalRequestForApproverChain, OnAfterPopulateApprovalEntryArgument to add code to functions "ApproveSelectedApprovalRequest","PopulateApprovalEntryArgument" and "CreateApprovalRequestForApproverChain"
    // # Reverted changes made with HEI.07 on function "CopyApprovalEntryQuoteToOrder"

    // HEI.09 FDD-HB396 BULIMC01 IBM 30.01.2020 
    // # Subscribed event OnApproveApprovalRequestsForRecordOnBeforeApprovalEntryToUpdateModify to add code to function "ApproveApprovalRequestsForRecord" to create notification for SenderID.

    // HEI.11 CHG2052196 IBM.PANDES01 12.06.2020
    // # Added Code for check ledger entry workflow.
    // DITW114.00.15 DDR 25/06/2020 NRQ#149486 Add key in function GetFirstSenderID()
    // DITW114.00.15 DDR 28/07/2020 NRQ#152502 Fix Approver chain status if sufficient for approbation
    // HEI.12 CHG2069321 IBM.GAVANM01 13.10.2020 - MTC Sales Approval App
    // # new gloval var ApproverIDfromWS
    // # new function SetApproverIDfromWS
    // DITW114.00.15 NLAB 16/11/2020 NRQ#163535 Disable NRQ#152502
    // HEI.13 CHG2049056 IBM.LS      02.03.2021
    // # Added Code
    // HEI.14 CHG2100218 IBM SAXENA03 25.03.2021
    // # Code written for Sales Post optimizaiton
    // # Replace ApprovalEntry.FINSET with ApprovalEntry.FINSET(FALSE,FALSE) in PostApprovalEntries().
    // DITW114.00.15 NLAB NRQ#177508 13/04/2021 Added addition checks when WF is automatically approved
    // NRQ178517 NLAB 19/04/2021 Merged NRQ#177508 - Adjusted code for 2017 version
    // HEI.15 CHG2098629 HB2014 IBM NANDIS01 08.04.2021 - LOG_Automatic creation of Transfer Order for Import PO
    // # Code added under function - ApproveApprovalRequests
    // HEI.16 CHG2112262 IBM SAXENA03 02.06.2021
    // # Code written for Sales Post optimizaiton
    // # Suugested by NORRIQ
    // # Added optimized code in Function IsSalesApprovalsWorkflowEnabled()
    // DITW114.00.15 EZOG 22/10/2021 NRQ#198973  Remove code
    // NRQ199479 EZOG 22/10/2021 Merge NRQ#198973
    // HEI.17 CHG2183672 DEBUSD01 05.12.2022 Fix lock new sales order runmodal page
    // HEI.18 CHG2183672 DEBUSD01 12.12.2022 Fix lock new sales order runmodal page
    // # Replace message dialog box by Notification
    // HEI.19 CHG2193616 IBM BHANDS01 31.03.23 Sales Order API Optimization
    // # Added code in PopulateApprovalEntryArgument()
    // HEI.20 CHG2200245 HB3430 IBM MAJUMS03 19.07.2023 To block users not to release PQ with no value
    // # Code added in PrePostApprovalCheckPurch() function to Validate the PQ when converting the PQ into PO, if there is no PQ Line found in the PQ
    // then System will not allow the system to convert PQ into PO. Create a system check for the “Make Order” function to not allow to proceed in case
    // there are no Line (Table ID. 39) linked to the Header (Table ID. 38) for Doc. Type = Purchase Quote of that particular PQ.
    // HEI.21 CHG2200245 HB3430 IBM MAJUMS03 28.07.2023 To block users not to release PQ with no value
    // # Code added in PrePostApprovalCheckPurch() function to Validate the PQ when converting the PQ into PO, checking is done for the Amount field of
    // Purchase Line as per updated version of FDD.
    // HEI.22 CHG2200245 HB3430 IBM MAJUMS03 02.08.2023 To block users not to release PQ with no value
    // # Code added in PrePostApprovalCheckPurch() function to Validate the PQ when converting the PQ into PO, checking is done for the Purchase Quote
    // Line Only.
    // HEI.23 CHG2200245 HB3430 IBM MAJUMS03 11.08.2023 To block users not to release PQ with no value
    // # Code added in PrePostApprovalCheckPurch() function to Validate the PQ when converting the PQ into PO, checking is done for the Purchase Quote
    // Line Only. Converting PQ to PO is only happened if there is no non zero PQ Line. Code done against HEI.20, HEI21,HEI.22 are also blocked as per
    // latest update against this Change.
    // HEI.24 CHG2218936 CC-INC4818312 IBM MAJUMS03 05.09.2023 # Couldn't convert PQ to PO. It is showing there is no Value in PQ even if we fill value.
    // # Code is blocked under PrePostApprovalCheckPurch() function to roll back the change against Change# CHG2200245 "To block users not to release
    // PQ with no value".
    // HEI.25 CHG2336029 SS40 17.03.2026 # Workflow Approval Functionality for Stock Adjustments
    //   # Added code in Function : PopulateApprovalEntryArgument
    //   # Added code in Function : IsSufficientApprover
    //   # Created New function   : IsSufficientItemJournalLineApprover

    // BC Upgrade PATELS08 >>
    // # Tag HEI.25 added for documentation.
    // BC Upgrade PATELS08 <<

    // BC Upgrade SHUKLP03 >>

    // IsSalesApprovalsWorkflowEnabled() => No event is found inside this procedure. So, as per discussion with Sakshi, code is written inside this procedure for optimization purpose but requires more discussion. Sakshi said, she will check with Saikat, whether we need this HEI code or not in BC.
    // FindApprovalEntryForCurrUser() => As per discussion with Sakshi, need to check the change of this HEI tag code if its required in BC
    // InformUserOnStatusChange() => No event is found inside this procedure. So, As per discussion with Sakshi, for now no need to add "HideValidationDialog" code we have to find some another workaround for this.
    // GetApproverIDfromWS() => Added this procedure, procedure has customised HEI code, but no HEI tag found for this function

    // # HEI.01 Code is blocked in Nav. => call function "OnRejectApprovalRequestCust

    // HEI.02 => Subscribed event OnBeforeApproveSelectedApprovalRequest, OnBeforeRejectSelectedApprovalRequest to add code and made IsHandled true.

    // HEI.03 => Created procedure TryDeleteJournalBatch()
    // HEI.04 => Subscribed event OnBeforeRejectSelectedApprovalRequest to add code and made IsHandled true.

    // HEI.08 => Subscribed event OnBeforeApproveSelectedApprovalRequest, OnBeforeCreateApprovalRequestForApproverChain to add code and made IsHandled true.
    // HEI.08 => To add code, subscribed event OnBeforePopulateApprovalEntryArgument and made Ishandled true and then added whole code in subscribed event OnAfterPopulateApprovalEntryArgument.
    // HEI.08 => Subscribed event OnBeforeDeletePurchQuote() of codeunit 96 to add code because no event found inside procedure CopyApprovalEntryQuoteToOrder().

    // HEI.07 => Subscribed event OnBeforeDeletePurchQuote() of codeunit 96 to add code because no event found inside procedure CopyApprovalEntryQuoteToOrder().

    // HEI.09 => Subscribed event OnApproveApprovalRequestsForRecordOnBeforeApprovalEntryToUpdateModify to add code

    // HEI.11 => To add code, subscribed event OnBeforePopulateApprovalEntryArgument and made Ishandled true and then added whole code in subscribed event OnAfterPopulateApprovalEntryArgument.
    // HEI.11 => To add code subscribed event OnSetStatusToPendingApproval and made Ishandled true.
    // HEI.11 => Created Procedure CheckCheckLedgerApprovalsWorkflowEnabled(), created custom event OnSendCheckLedgerInt()

    // HEI.12 => Subscribed event OnBeforeApproveSelectedApprovalRequest, OnBeforeRejectSelectedApprovalRequest to add code
    // HEI.12 => Created Procedure SetApproverIDfromWS(), GetApproverIDfromWS()

    // HEI.13 => Subscribed event OnBeforeApproveSelectedApprovalRequest, OnBeforeRejectSelectedApprovalRequest, OnBeforeCreateApprovalEntryNotification, OnBeforeRunApprovalCommentsPage to add code
    // HEI.13 => To add code, subscribed event OnBeforePopulateApprovalEntryArgument and made Ishandled true and then added whole code in subscribed event OnAfterPopulateApprovalEntryArgument.
    // HEI.13 => Created Procedure SendItemJournalBatchApprovalRequest(), SendItemJournalLineApprovalRequest(), CancelItemJournalBatchApprovalRequest(), CancelItemJournalLineApprovalRequest(), LOCAL GetItemJournalBatch(), CheckItemJournalBatchApprovalsWorkflowEnabled(),CheckItemJournalLineApprovalsWorkflowEnabled(), HasAnyOpenItemJournalLineApprovalEntries(), Created events OnSendItemJournalBatchForApprovalRequest, OnSendItemJournalLineForApprovalRequest, OnCancelItemJournalBatchApprovalRequest, OnCancelItemJournalLineApprovalRequest

    // HEI.17 => Procedure ShowSalesApprovalStatus() code is not added because DrinkIT has passed parameter 'ApproverType' and 'WorkflowInstanceId' in procedure. As per discussion with Saikat, we will wait for DrinkIT extension to add this code.
    // HEI.17 => Created Procedure SetHideValidationDialogWF(),IsHideValidationDialogWF()

    // HEI.18 => Procedure ShowSalesApprovalStatus() code is not added because DrinkIT has passed parameter 'ApproverType' and 'WorkflowInstanceId' in procedure. As per discussion with Saikat, we will wait for DrinkIT extension to add this code.
    // HEI.18 => Created Procedure SetShowNotificationDialogWF(),IsShowNotificationDialogWF(),GetApprovalStatusMessgeId()

    // HEI.19 => To add code, subscribed event OnBeforePopulateApprovalEntryArgument and made Ishandled true and then added whole code in subscribed event OnAfterPopulateApprovalEntryArgument.

    // Event publishers OnApproveApprovalRequest, OnBeforeCheckStatus, OnBeforeCheckUserAsApprovalAdministrator, OnRejectApprovalRequest, OnCreateApprovalRequestForApproverChainOnAfterSetApprovalEntryFilters, OnBeforeFindUserSetupBySalesPurchCode, OnAfterFindUserSetupBySalesPurchCode, OnCreateApprovalRequestForApproverChainOnAfterCheckApprovalEntrySenderID, OnCreateApprovalRequestForApproverChainOnBeforeCheckApproverId, OnCreateApprovalRequestForApproverChainOnAfterCheckUserSetupSenderID, OnAfterCreateApprovalRequestForApproverChain, OnPopulateApprovalEntryArgument, OnSendCheckLedgerInt, OnSendItemJournalBatchForApprovalRequest, OnSendItemJournalLineForApprovalRequest, OnCancelItemJournalBatchApprovalRequest, OnCancelItemJournalLineApprovalRequest, 

    // BC Upgrade SHUKLP03 <<

    var
        ApproverIDfromWS: Code[50];
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
        NoSuitableApproverFoundErr: Label 'No qualified approver was found.';
        ApproverUserIdNotInSetupErr: Label 'You must set up an approver for user ID %1 in the Approval User Setup window.', Comment = 'You must set up an approver for user ID NAVUser in the Approval User Setup window.';
        ApprovalMgmt: Codeunit "Approvals Mgmt.";
        ApproverChainErr: Label 'No sufficient approver was found in the approver chain.';
        PendingApprovalMsg: Label 'An approval request has been sent.';
        PurchaserUserNotFoundErr: Label 'The salesperson/purchaser user ID %1 does not exist in the Approval User Setup window for %2 %3.', Comment = 'Example: The salesperson/purchaser user ID NAVUser does not exist in the Approval User Setup window for Salesperson/Purchaser code AB.';
        DocStatusChangedMsg: TextConst Comment = 'Order 1001 has been automatically approved. The status has been changed to Released.', ENU = '%1 %2 has been automatically approved. The status has been changed to %3.', FRA = 'Le/la %1 %2 a été automatiquement approuvé(e). Le statut a été remplacé par %3.';
        CustVendorBankWorkflow: Codeunit "Cust/Vendor Bank Acc. Workflow";

        WorkflowManagementA: Codeunit "Workflow Management";
        HideValidationDialogWF: Boolean;
        ShowNotificationDialogWF: Boolean;
        Heineken_WorkflowEventHandling: Codeunit "Heineken BC Upgrade";
        Rec_ApprovalEntry: Record "Approval Entry";


    //BC Upgrade SHARMP16 BEGIN>> -- commenting the code because this is bypassing the base logic written by priya shukla
    // [EventSubscriber(ObjectType::Codeunit, 1535, OnBeforeApproveSelectedApprovalRequest, '', false, false)]
    // local procedure OnBeforeApproveSelectedApprovalRequest(var ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    // var
    //     ApproveOnlyOpenRequestsErr: Label 'You can only approve open approval requests.';
    //     WorkflowMgmt: Codeunit "Cust/Vendor Bank Acc. Workflow";
    //     PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    //     WorkflowStepInstanceL: Record "workflow Step Instance";
    // begin
    //     CheckOpenStatus(ApprovalEntry, "Approval Action"::Approve, ApproveOnlyOpenRequestsErr);

    //     //HEI.12>>
    //     IF ApproverIDfromWS <> '' THEN BEGIN
    //         IF ApprovalEntry."Approver ID" <> ApproverIDfromWS THEN
    //             CheckUserAsApprovalAdministrator(ApprovalEntry);
    //     END ELSE
    //         //HEI.12<<
    //         IF ApprovalEntry."Approver ID" <> USERID THEN
    //             CheckUserAsApprovalAdministrator(ApprovalEntry);

    //     WorkflowMgmt.OnApproveApprovalRequestCust(ApprovalEntry); //HEI.02

    //     ApprovalEntry.VALIDATE(Status, ApprovalEntry.Status::Approved);
    //     ApprovalEntry.MODIFY(TRUE);
    //     //HEI.13>>
    //     Rec_ApprovalEntry.SETFILTER("Document No.", '<>%1', '');
    //     //HEI.13<<
    //     //HEI.08>>
    //     IF (ApprovalEntry."Document Type" = ApprovalEntry."Document Type"::Quote) AND
    //     (ApprovalEntry.Status = ApprovalEntry.Status::Approved) AND
    //     PurchaseHeaderAdditional.GET(ApprovalEntry."Document Type", ApprovalEntry."Document No.")
    //     THEN BEGIN
    //         PurchaseHeaderAdditional."PQ Approver" := ApprovalEntry."Approver ID";
    //         PurchaseHeaderAdditional.MODIFY();
    //     END;
    //     //HEI.08<<

    //     //HEI.13>>
    //     IF ApprovalEntry."Table ID" IN [DATABASE::"Gen. Journal Batch", DATABASE::"Gen. Journal Line",
    //     DATABASE::"Item Journal Batch", DATABASE::"Item Journal Line"] THEN BEGIN
    //         WorkflowStepInstanceL.SETCURRENTKEY(ID, "Workflow Code", "Created By User ID", Status, "Function Name");
    //         WorkflowStepInstanceL.SETRANGE(ID, ApprovalEntry."Workflow Step Instance ID");
    //         WorkflowStepInstanceL.SETRANGE("Workflow Code", ApprovalEntry."Approval Code");
    //         WorkflowStepInstanceL.SETRANGE("Created By User ID", ApprovalEntry."Sender ID");
    //         WorkflowStepInstanceL.SETRANGE(Status, WorkflowStepInstanceL.Status::Inactive);
    //         WorkflowStepInstanceL.SETRANGE("Function Name", 'SENDAPPROVALREQUESTFORAPPROVAL');
    //         IF WorkflowStepInstanceL.FINDFIRST() THEN
    //             ApprovalMgmt.CreateApprovalEntryNotification(ApprovalEntry, WorkflowStepInstanceL);
    //     END;
    //     //HEI.13<<
    //     OnApproveApprovalRequest(ApprovalEntry);

    //     IsHandled := true;
    // end;
    //BC Upgrade SHARMP16 END<< -- commenting the code because this is bypassing the base logic written by priya shukla
    //BC Upgrade SHARMP16 BEGIN>> -- code restructure 
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt.", OnBeforeApproveSelectedApprovalRequest, '', false, false)]
    local procedure OnBeforeApproveSelectedApprovalRequest(var ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    var
        ApproveOnlyOpenRequestsErr: Label 'You can only approve open approval requests.';
        WorkflowMgmt: Codeunit "Cust/Vendor Bank Acc. Workflow";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        WorkflowStepInstanceL: Record "workflow Step Instance";
    begin
        CheckOpenStatus(ApprovalEntry, "Approval Action"::Approve, ApproveOnlyOpenRequestsErr);
        ApproverIDfromWS := ApprovalEntry."Approver ID"; // BC Upgrade SHUKLP03 <<

        //HEI.12>>
        IF ApproverIDfromWS <> '' THEN BEGIN
            IF ApprovalEntry."Approver ID" <> ApproverIDfromWS THEN
                CheckUserAsApprovalAdministrator(ApprovalEntry);
        END ELSE
            //HEI.12<<
            IF ApprovalEntry."Approver ID" <> USERID THEN
                CheckUserAsApprovalAdministrator(ApprovalEntry);

        //  WorkflowMgmt.OnApproveApprovalRequestCust(ApprovalEntry); //HEI.02
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnApproveApprovalRequest, '', false, false)]
    local procedure OnApproveApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        WorkflowMgmt: Codeunit "Cust/Vendor Bank Acc. Workflow";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        WorkflowStepInstanceL: Record "Workflow Step Instance";
    begin

        WorkflowMgmt.OnApproveApprovalRequestCust(ApprovalEntry);//HEI.02

        //HEI.13>>
        Rec_ApprovalEntry.SETFILTER("Document No.", '<>%1', '');
        //HEI.13<<

        //HEI.08>>
        IF (ApprovalEntry."Document Type" = ApprovalEntry."Document Type"::Quote) AND
           PurchaseHeaderAdditional.GET(ApprovalEntry."Document Type", ApprovalEntry."Document No.") THEN BEGIN
            PurchaseHeaderAdditional."PQ Approver" := ApprovalEntry."Approver ID";
            PurchaseHeaderAdditional.Modify();
        END;
        //HEI.08<<
        // HEI.13>>
        IF ApprovalEntry."Table ID" IN [DATABASE::"Gen. Journal Batch", DATABASE::"Gen. Journal Line",
        DATABASE::"Item Journal Batch", DATABASE::"Item Journal Line"] THEN BEGIN
            WorkflowStepInstanceL.SETCURRENTKEY(ID, "Workflow Code", "Created By User ID", Status, "Function Name");
            WorkflowStepInstanceL.SETRANGE(ID, ApprovalEntry."Workflow Step Instance ID");
            WorkflowStepInstanceL.SETRANGE("Workflow Code", ApprovalEntry."Approval Code");
            WorkflowStepInstanceL.SETRANGE("Created By User ID", ApprovalEntry."Sender ID");
            WorkflowStepInstanceL.SETRANGE(Status, WorkflowStepInstanceL.Status::Inactive);
            WorkflowStepInstanceL.SETRANGE("Function Name", 'SENDAPPROVALREQUESTFORAPPROVAL');
            IF WorkflowStepInstanceL.FINDFIRST() THEN
                ApprovalMgmt.CreateApprovalEntryNotification(ApprovalEntry, WorkflowStepInstanceL);
        END;
    end;

    //BC Upgrade SHARMP16 END<< -- code restructure 

    // [IntegrationEvent(false, false)]
    // procedure OnApproveApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    // begin
    // end;


    local procedure CheckOpenStatus(ApprovalEntry: Record "Approval Entry"; ApprovalAction: Enum "Approval Action"; ErrorMessage: Text)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckStatus(ApprovalEntry, ApprovalAction, IsHandled);
        if IsHandled then
            exit;

        if ApprovalEntry.Status <> ApprovalEntry.Status::Open then
            Error(ErrorMessage);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckStatus(var ApprovalEntry: Record "Approval Entry"; ApprovalAction: Enum "Approval Action"; var IsHandled: Boolean)
    begin
    end;


    local procedure CheckUserAsApprovalAdministrator(ApprovalEntry: Record "Approval Entry")
    var
        UserSetup: Record "User Setup";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckUserAsApprovalAdministrator(ApprovalEntry, IsHandled);
        if IsHandled then
            exit;

        UserSetup.Get(UserId);
        UserSetup.TestField("Approval Administrator");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckUserAsApprovalAdministrator(ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnBeforeRejectSelectedApprovalRequest, '', false, false)]
    local procedure OnBeforeRejectSelectedApprovalRequest(var ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    var
        WorkflowMgmt: Codeunit "Cust/Vendor Bank Acc. Workflow";
        WorkflowStepInstanceL: Record "Workflow Step Instance";
        RejectOnlyOpenRequestsErr: Label 'You can only reject open approval entries.';
        WorkfloeEventHandeling: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        CheckOpenStatus(ApprovalEntry, "Approval Action"::Reject, RejectOnlyOpenRequestsErr);
        ApproverIDfromWS := ApprovalEntry."Approver ID"; // BC Upgrade SHUKLP03 <<

        //HEI.12>>
        IF ApproverIDfromWS <> '' THEN BEGIN
            IF ApprovalEntry."Approver ID" <> ApproverIDfromWS THEN
                CheckUserAsApprovalAdministrator(ApprovalEntry);
        END ELSE
            //HEI.12<<
            IF ApprovalEntry."Approver ID" <> USERID THEN
                CheckUserAsApprovalAdministrator(ApprovalEntry);

        WorkflowMgmt.OnRejectApprovalRequestCust(ApprovalEntry); //HEI.02
        WorkflowMgmt.OnRejectApprovalRequestVend(ApprovalEntry);  //HEI.04

        OnRejectApprovalRequest(ApprovalEntry);
        ApprovalEntry.Get(ApprovalEntry."Entry No.");
        ApprovalEntry.Validate(Status, ApprovalEntry.Status::Rejected);
        ApprovalEntry.Modify(true);

        //HEI.13>>
        IF ApprovalEntry."Table ID" IN [DATABASE::"Gen. Journal Batch", DATABASE::"Gen. Journal Line",
          DATABASE::"Item Journal Batch", DATABASE::"Item Journal Line"] THEN BEGIN
            WorkflowStepInstanceL.SETCURRENTKEY(ID, "Workflow Code", "Created By User ID", Status, "Function Name");
            WorkflowStepInstanceL.SETRANGE(ID, ApprovalEntry."Workflow Step Instance ID");
            WorkflowStepInstanceL.SETRANGE("Workflow Code", ApprovalEntry."Approval Code");
            WorkflowStepInstanceL.SETRANGE("Created By User ID", ApprovalEntry."Sender ID");
            WorkflowStepInstanceL.SETRANGE(Status, WorkflowStepInstanceL.Status::Inactive);
            WorkflowStepInstanceL.SETRANGE("Function Name", 'REJECTALLAPPROVALREQUESTS');
            IF WorkflowStepInstanceL.FINDFIRST() THEN
                ApprovalMgmt.CreateApprovalEntryNotification(ApprovalEntry, WorkflowStepInstanceL);
        END;
        //HEI.13<<
        // BC Upgrade BHARDA11 >> --This code has been written because, due to the IsHandled = true condition, the base code is not executing. Additionally, a function in the base application, OnRejectApprovalRequest, is also not being triggered. Below is the code of the event where this function is being used.
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(WorkfloeEventHandeling.RunWorkflowOnRejectApprovalRequestCode(),
               ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        // BC Upgrade BHARDA11 << --This code has been written because, due to the IsHandled = true condition, the base code is not executing. Additionally, a function in the base application, OnRejectApprovalRequest, is also not being triggered. Below is the code of the event where this function is being used.
        IsHandled := true;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    begin
    end;


    LOCAL procedure IsHideValidationDialogWF(): Boolean
    begin
        //HEI.17>>
        EXIT(HideValidationDialogWF);
    end;

    procedure SetShowNotificationDialogWF(NewShowNotificationDialogWF: Boolean)
    begin
        //HEI.18>>
        ShowNotificationDialogWF := NewShowNotificationDialogWF;
    end;

    LOCAL procedure IsShowNotificationDialogWF(): Boolean
    begin
        //HEI.18>>
        EXIT(ShowNotificationDialogWF);
    end;

    LOCAL procedure GetApprovalStatusMessgeId(): GUID
    begin
        //HEI.18>>
        EXIT('93fa2c4a-6225-4a61-a81f-ab8ce681120e');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnApproveApprovalRequestsForRecordOnAfterApprovalEntrySetFilters, '', false, false)]
    local procedure OnApproveApprovalRequestsForRecordOnAfterApprovalEntrySetFilters(var ApprovalEntry: Record "Approval Entry")
    begin
        Clear(ApprovalEntry.Status);
        ApprovalEntry.SETFILTER(Status, '%1|%2|%3', ApprovalEntry.Status::Created, ApprovalEntry.Status::Open, ApprovalEntry.Status::Approved); //hei.c
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnApproveApprovalRequestsForRecordOnBeforeApprovalEntryToUpdateModify, '', false, false)]
    local procedure OnApproveApprovalRequestsForRecordOnBeforeApprovalEntryToUpdateModify(var ApprovalEntryToUpdate: Record "Approval Entry")
    begin
        //HEI.09<<
        IF ApprovalEntryToUpdate."Approver ID" <> ApprovalEntryToUpdate."Sender ID" THEN BEGIN
            ApprovalEntryToUpdate."Approver ID" := ApprovalEntryToUpdate."Sender ID";
        END;
        //HEI.09>>
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnBeforeCreateApprovalEntryNotification, '', false, false)]
    local procedure OnBeforeCreateApprovalEntryNotification(ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        NotificationEntry: Record "Notification Entry";
        IsNotificationRequiredForCurrentUser: Boolean;
        IsNotifySenderRequired: Boolean;

    begin
        if not WorkflowStepArgument.Get(WorkflowStepInstance.Argument) then
            exit;

        IsNotificationRequiredForCurrentUser := (ApprovalEntry."Approver ID" <> UserId) or IsBackground();
        IsNotifySenderRequired := ((ApprovalEntry."Sender ID" <> UserId) or IsBackground()) and (ApprovalEntry."Sender ID" <> ApprovalEntry."Approver ID");

        //HEI.13>>
        IF (ApprovalEntry.Status IN [ApprovalEntry.Status::Approved, ApprovalEntry.Status::Rejected]) AND
          (ApprovalEntry."Table ID" IN [DATABASE::"Gen. Journal Batch", DATABASE::"Gen. Journal Line",
            DATABASE::"Item Journal Batch", DATABASE::"Item Journal Line"]) THEN BEGIN
            WorkflowStepArgument.VALIDATE("Notification User ID", ApprovalEntry."Sender ID");
            WorkflowStepArgument.VALIDATE("Approver User ID", ApprovalEntry."Approver ID");
        END;
        //HEI.13<<

        ApprovalEntry.Reset();
        if IsNotificationRequiredForCurrentUser and (ApprovalEntry.Status <> ApprovalEntry.Status::Rejected) then
            NotificationEntry.CreateNotificationEntry(
                NotificationEntry.Type::Approval, ApprovalEntry."Approver ID",
                ApprovalEntry, WorkflowStepArgument."Link Target Page", WorkflowStepArgument."Custom Link", CopyStr(UserId(), 1, 50));
        if WorkflowStepArgument."Notify Sender" and IsNotifySenderRequired then
            NotificationEntry.CreateNotificationEntry(
                NotificationEntry.Type::Approval, ApprovalEntry."Sender ID",
                ApprovalEntry, WorkflowStepArgument."Link Target Page", WorkflowStepArgument."Custom Link", CopyStr(UserId(), 1, 50));

        IsHandled := true;
    end;

    local procedure IsBackground(): Boolean
    var
        ClientTypeManagement: Codeunit "Client Type Management";
    begin
        exit(ClientTypeManagement.GetCurrentClientType() in [ClientType::Background]);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnBeforeCreateApprovalRequestForApproverChain, '', false, false)]
    local procedure OnBeforeCreateApprovalRequestForApproverChain(ApprovalEntryArgument: Record "Approval Entry"; SufficientApproverOnly: Boolean; var IsHandled: Boolean; WorkflowStepArgument: Record "Workflow Step Argument")
    var
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
        ApproverId: Code[50];
        SequenceNo: Integer;
        MaxCount: Integer;
        i: Integer;
    begin
        //HEI.08>>
        IF ApprovalEntryArgument."PQ Approver FND" <> '' THEN
            ApproverId := ApprovalEntryArgument."PQ Approver FND"
        ELSE
            ApproverId := CopyStr(UserId(), 1, MaxStrLen(ApproverId));
        //HEI.08<<
        ApprovalEntry.SetCurrentKey("Record ID to Approve", "Workflow Step Instance ID", "Sequence No.");
        ApprovalEntry.SetRange("Table ID", ApprovalEntryArgument."Table ID");
        ApprovalEntry.SetRange("Record ID to Approve", ApprovalEntryArgument."Record ID to Approve");
        ApprovalEntry.SetRange("Workflow Step Instance ID", ApprovalEntryArgument."Workflow Step Instance ID");
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Created);
        OnCreateApprovalRequestForApproverChainOnAfterSetApprovalEntryFilters(ApprovalEntry, ApprovalEntryArgument);
        if ApprovalEntry.FindLast() then
            ApproverId := ApprovalEntry."Approver ID"
        else
            if (WorkflowStepArgument."Approver Type" = WorkflowStepArgument."Approver Type"::"Salesperson/Purchaser") and
                (WorkflowStepArgument."Approver Limit Type" = WorkflowStepArgument."Approver Limit Type"::"First Qualified Approver")
            then begin
                FindUserSetupBySalesPurchCode(UserSetup, ApprovalEntryArgument);
                ApproverId := UserSetup."User ID";
            end;

        UserSetup.Reset();
        MaxCount := UserSetup.Count();

        if not UserSetup.Get(ApproverId) then
            Error(ApproverUserIdNotInSetupErr, ApprovalEntry."Sender ID");

        IsHandled := false;
        OnCreateApprovalRequestForApproverChainOnAfterCheckApprovalEntrySenderID(UserSetup, WorkflowStepArgument, ApprovalEntryArgument, IsHandled);
        if IsHandled then
            exit;

        IF ApproverId <> ApprovalEntryArgument."PQ Approver FND" THEN BEGIN //HEI.08
            if not ApprovalMgmt.IsSufficientApprover(UserSetup, ApprovalEntryArgument) then
                repeat
                    i += 1;
                    if i > MaxCount then
                        Error(ApproverChainErr);
                    ApproverId := UserSetup."Approver ID";

                    IsHandled := false;
                    OnCreateApprovalRequestForApproverChainOnBeforeCheckApproverId(UserSetup, WorkflowStepArgument, ApprovalEntryArgument, IsHandled);
                    if IsHandled then
                        exit;

                    if ApproverId = '' then
                        Error(NoSuitableApproverFoundErr);

                    if not UserSetup.Get(ApproverId) then
                        Error(ApproverUserIdNotInSetupErr, UserSetup."User ID");

                    OnCreateApprovalRequestForApproverChainOnAfterCheckUserSetupSenderID(UserSetup, WorkflowStepArgument, ApprovalEntryArgument);

                    // Approval Entry should not be created only when IsSufficientApprover is false and SufficientApproverOnly is true
                    if ApprovalMgmt.IsSufficientApprover(UserSetup, ApprovalEntryArgument) or (not SufficientApproverOnly) then begin
                        SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument) + 1;
                        ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo, ApproverId, WorkflowStepArgument);
                    end;

                until ApprovalMgmt.IsSufficientApprover(UserSetup, ApprovalEntryArgument);
            //HEI.08>>
        END ELSE BEGIN
            IF NOT ApprovalMgmt.IsSufficientApprover(UserSetup, ApprovalEntryArgument) THEN
                REPEAT
                    ApproverId := UserSetup."Approver ID";

                    IF ApproverId = '' THEN
                        ERROR(NoSuitableApproverFoundErr);

                    IF NOT UserSetup.GET(ApproverId) THEN
                        ERROR(ApproverUserIdNotInSetupErr, UserSetup."User ID");

                    IF ApprovalMgmt.IsSufficientApprover(UserSetup, ApprovalEntryArgument) OR (NOT SufficientApproverOnly) THEN BEGIN
                        SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument) + 1;
                        ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo, ApproverId, WorkflowStepArgument);
                    END;
                UNTIL ApprovalMgmt.IsSufficientApprover(UserSetup, ApprovalEntryArgument)
            ELSE
                IF ApprovalMgmt.IsSufficientApprover(UserSetup, ApprovalEntryArgument) OR (NOT SufficientApproverOnly) THEN BEGIN
                    SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument) + 1;
                    ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo, ApproverId, WorkflowStepArgument);
                END;
        END;
        //HEI.08<<

        OnAfterCreateApprovalRequestForApproverChain(ApprovalEntryArgument, ApproverId, WorkflowStepArgument, UserSetup, SufficientApproverOnly);

        IsHandled := true;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreateApprovalRequestForApproverChainOnAfterSetApprovalEntryFilters(var ApprovalEntry: Record "Approval Entry"; ApprovalEntryArgument: Record "Approval Entry")
    begin
    end;

    local procedure FindUserSetupBySalesPurchCode(var UserSetup: Record "User Setup"; ApprovalEntryArgument: Record "Approval Entry")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeFindUserSetupBySalesPurchCode(UserSetup, ApprovalEntryArgument, IsHandled);
        if not IsHandled then
            if ApprovalEntryArgument."Salespers./Purch. Code" <> '' then begin
                UserSetup.SetCurrentKey("Salespers./Purch. Code");
                UserSetup.SetRange("Salespers./Purch. Code", ApprovalEntryArgument."Salespers./Purch. Code");
                if not UserSetup.FindFirst() then
                    Error(
                      PurchaserUserNotFoundErr, UserSetup."User ID", UserSetup.FieldCaption("Salespers./Purch. Code"),
                      UserSetup."Salespers./Purch. Code");
            end;

        OnAfterFindUserSetupBySalesPurchCode(UserSetup, ApprovalEntryArgument);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeFindUserSetupBySalesPurchCode(var UserSetup: Record "User Setup"; ApprovalEntryArgument: Record "Approval Entry"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFindUserSetupBySalesPurchCode(var UserSetup: Record "User Setup"; ApprovalEntry: Record "Approval Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreateApprovalRequestForApproverChainOnAfterCheckApprovalEntrySenderID(var UserSetup: Record "User Setup"; WorkflowStepArgument: Record "Workflow Step Argument"; ApprovalEntryArgument: Record "Approval Entry"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreateApprovalRequestForApproverChainOnBeforeCheckApproverId(var UserSetup: Record "User Setup"; WorkflowStepArgument: Record "Workflow Step Argument"; ApprovalEntryArgument: Record "Approval Entry"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreateApprovalRequestForApproverChainOnAfterCheckUserSetupSenderID(var UserSetup: Record "User Setup"; WorkflowStepArgument: Record "Workflow Step Argument"; ApprovalEntryArgument: Record "Approval Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreateApprovalRequestForApproverChain(var ApprovalEntryArgument: Record "Approval Entry"; var ApproverId: Code[50]; var WorkflowStepArgument: Record "Workflow Step Argument"; var UserSetup: Record "User Setup"; var SufficientApproverOnly: Boolean)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnBeforePopulateApprovalEntryArgument, '', false, false)]
    local procedure OnBeforePopulateApprovalEntryArgument(var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnAfterPopulateApprovalEntryArgument, '', false, false)]
    local procedure OnAfterPopulateApprovalEntryArgument(var ApprovalEntryArgument: Record "Approval Entry"; var IsHandled: Boolean; var RecRef: RecordRef; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        Customer: Record Customer;
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        PurchaseHeader: Record "Purchase Header";
        SalesHeader: Record "Sales Header";
        IncomingDocument: Record "Incoming Document";
        Vendor: Record Vendor;
        EnumAssignmentMgt: Codeunit "Enum Assignment Management";
        ApprovalAmount: Decimal;
        ApprovalAmountLCY: Decimal;
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        Rec_CLE: Record "Check Ledger Entry";
        ItemJournalBatchL: Record "Item Journal Batch";
        ItemJournalLineL: Record "Item Journal Line";
    begin
        // ApprovalEntryArgument.Init();//BC UPGRADE KUMARR78 -- 07-05-2026 Error Resolution for Sales Invoice.
        ApprovalEntryArgument."Table ID" := RecRef.Number;
        ApprovalEntryArgument."Record ID to Approve" := RecRef.RecordId;
        ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
        ApprovalEntryArgument."Approval Code" := WorkflowStepInstance."Workflow Code";
        ApprovalEntryArgument."Workflow Step Instance ID" := WorkflowStepInstance.ID;

        case RecRef.Number of
            DATABASE::"Purchase Header":
                begin
                    RecRef.SetTable(PurchaseHeader);
                    ApprovalMgmt.CalcPurchaseDocAmount(PurchaseHeader, ApprovalAmount, ApprovalAmountLCY);
                    ApprovalEntryArgument."Document Type" := EnumAssignmentMgt.GetPurchApprovalDocumentType(PurchaseHeader."Document Type");
                    ApprovalEntryArgument."Document No." := PurchaseHeader."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := PurchaseHeader."Purchaser Code";
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := PurchaseHeader."Currency Code";
                    //HEI.08>>
                    IF PurchaseHeaderAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") THEN
                        ApprovalEntryArgument."PQ Approver FND" := PurchaseHeaderAdditional."PQ Approver";
                    //HEI.08<<
                end;
            DATABASE::"Sales Header":
                begin
                    RecRef.SetTable(SalesHeader);
                    ApprovalMgmt.CalcSalesDocAmount(SalesHeader, ApprovalAmount, ApprovalAmountLCY);
                    ApprovalEntryArgument."Document Type" := EnumAssignmentMgt.GetSalesApprovalDocumentType(SalesHeader."Document Type");
                    ApprovalEntryArgument."Document No." := SalesHeader."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := SalesHeader."Salesperson Code";
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := SalesHeader."Currency Code";
                    ApprovalEntryArgument."Available Credit Limit (LCY)" := GetAvailableCreditLimit(SalesHeader);
                    // BC Upgrade SHUKLP03 >> Blocked because DrinkIT field "Approved Credit limit Amount" is used.
                    // //HEI.19>>
                    // SalesHeader.GET(SalesHeader."Document Type", SalesHeader."No.");
                    // SalesHeader."Approved Credit limit Amount" := 0;
                    // SalesHeader.MODIFY(FALSE);
                    // //HEI.19<<
                    // BC Upgrade SHUKLP03 << Blocked because DrinkIT field "Approved Credit limit Amount" is used.
                end;
            DATABASE::Customer:
                begin
                    RecRef.SetTable(Customer);
                    ApprovalEntryArgument."Salespers./Purch. Code" := Customer."Salesperson Code";
                    ApprovalEntryArgument."Currency Code" := Customer."Currency Code";
                    ApprovalEntryArgument."Available Credit Limit (LCY)" := Customer.CalcAvailableCredit();
                end;
            DATABASE::"Gen. Journal Batch":
                RecRef.SetTable(GenJournalBatch);
            DATABASE::"Gen. Journal Line":
                begin
                    RecRef.SetTable(GenJournalLine);
                    case GenJournalLine."Document Type" of
                        GenJournalLine."Document Type"::Invoice:
                            ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Invoice;
                        GenJournalLine."Document Type"::"Credit Memo":
                            ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Credit Memo";
                        GenJournalLine."Document Type"::" ":
                            ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
                        GenJournalLine."Document Type"::"Payment":
                            ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Payment";
                        else
                            ApprovalEntryArgument."Document Type" := GenJournalLine."Document Type";
                    end;
                    ApprovalEntryArgument."Document No." := GenJournalLine."Document No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := GenJournalLine."Salespers./Purch. Code";
                    ApprovalEntryArgument.Amount := GenJournalLine.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := GenJournalLine."Amount (LCY)";
                    ApprovalEntryArgument."Currency Code" := GenJournalLine."Currency Code";
                end;
            //HEI.13>>
            DATABASE::"Item Journal Batch":
                // BC Upgrade PATELS08 >>
                //HEI.25>>
                //RecRef.SETTABLE(ItemJournalBatchL);
                BEGIN
                    RecRef.SETTABLE(ItemJournalBatchL);
                    ItemJournalBatchL.CALCFIELDS("Amount FND");
                    ApprovalEntryArgument."Amount (LCY)" := ItemJournalBatchL."Amount FND";
                END;
            //HEI.25<<
            // BC Upgrade PATELS08 <<
            DATABASE::"Item Journal Line":
                BEGIN
                    RecRef.SETTABLE(ItemJournalLineL);
                    ApprovalEntryArgument."Document Type" := ItemJournalLineL."Document Type";
                    ApprovalEntryArgument."Document No." := ItemJournalLineL."Document No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := ItemJournalLineL."Salespers./Purch. Code";
                END;
            //HEI.13<<
            DATABASE::"Incoming Document":
                begin
                    RecRef.SetTable(IncomingDocument);
                    ApprovalEntryArgument."Document No." := Format(IncomingDocument."Entry No.");
                end;
            //>>HEI.11
            DATABASE::"Check Ledger Entry":
                BEGIN
                    RecRef.SETTABLE(Rec_CLE);
                    ApprovalEntryArgument."Document No." := (Rec_CLE."Document No.");
                END;
            //<<HEI.11
            DATABASE::Vendor:
                begin
                    RecRef.SetTable(Vendor);
                    ApprovalEntryArgument."Salespers./Purch. Code" := Vendor."Purchaser Code";
                end;
            else
                OnPopulateApprovalEntryArgument(RecRef, ApprovalEntryArgument, WorkflowStepInstance);
        end;
    end;

    // BC Upgrade PATELS08 >>
    LOCAL procedure IsSufficientItemJournalLineApprover(UserSetup: Record "User Setup"; ApprovalAmountLCY: Decimal): Boolean
    begin
        //HEI.25>>
        IF UserSetup."User ID" = UserSetup."Approver ID" THEN
            EXIT(TRUE);

        IF UserSetup."Unlimited Journ.Approval FND" OR
        ((ApprovalAmountLCY <= UserSetup."Journal Amt Approval Limit FND") AND (UserSetup."Journal Amt Approval Limit FND" <> 0))
            THEN
            EXIT(TRUE);

        EXIT(FALSE);
        //HEI.25<<
    end;
    // BC Upgrade PATELS08 <<

    // BC Upgrade PATELS08 >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnSufficientApproverElseCase, '', false, false)]
    local procedure OnSufficientApproverElseCase(UserSetup: Record "User Setup"; ApprovalEntryArgument: Record "Approval Entry"; var IsSufficient: Boolean)
    begin
        IF ApprovalEntryArgument."Table ID" = DATABASE::"Item Journal Batch" THEN
            //HEI.25>>
            IsSufficient := IsSufficientItemJournalLineApprover(UserSetup, ApprovalEntryArgument."Amount (LCY)");
        //HEI.25<<
    end;
    // BC Upgrade PATELS08 <<


    LOCAL procedure GetAvailableCreditLimit(SalesHeader: Record "Sales Header"): Decimal
    begin
        EXIT(SalesHeader.CheckAvailableCreditLimit());
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnSetStatusToPendingApproval, '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var IsHandled: Boolean; var Variant: Variant)
    var
        UnsupportedRecordTypeErr: Label 'Record type %1 is not supported by this workflow response.', Comment = 'Record type Customer is not supported by this workflow response.';
        CheckLEntry: Record "Check Ledger Entry";
    begin
        //>>HEI.11
        CASE RecRef.NUMBER OF
            DATABASE::"Check Ledger Entry":
                BEGIN
                    RecRef.SETTABLE(CheckLEntry);
                    IF CheckLEntry."Approval Status FND" = CheckLEntry."Approval Status FND"::" " THEN BEGIN
                        CheckLEntry."Approval Status FND" := CheckLEntry."Approval Status FND"::"Awaiting approval";
                        CheckLEntry."Requester ID FND" := USERID;
                        CheckLEntry."Request Date FND" := TODAY;
                        CheckLEntry.MODIFY(TRUE);
                    END;
                END
            ELSE
                ERROR(UnsupportedRecordTypeErr, RecRef.CAPTION);
        End;//<<HEI.11

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnBeforeRunApprovalCommentsPage, '', false, false)]
    local procedure OnBeforeRunApprovalCommentsPage(var ApprovalCommentLine: Record "Approval Comment Line"; var IsHandle: Boolean; WorkflowStepInstanceID: Guid)
    begin
        //HEI.13>>
        ApprovalCommentLine.SETCURRENTKEY("Entry No.");
        IF ApprovalCommentLine.FINDLAST() THEN;
        //HEI.13<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnBeforeCreateApprovalRequestForUser, '', false, false)]
    local procedure OnBeforeCreateApprovalRequestForUser()
    begin
        //HEI.17>>
        IF IsHideValidationDialogWF() THEN
            EXIT;
        //HEI.17<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnCreateApprovalRequestsOnAfterCreateRequests, '', false, false)]
    local procedure OnCreateApprovalRequestsOnAfterCreateRequests(WorkflowStepArgument: Record "Workflow Step Argument"; RecRef: RecordRef)
    var
    begin
        if WorkflowStepArgument."Show Confirmation Message" then begin
            //HEI.17>>
            IF IsHideValidationDialogWF() THEN begin
                WorkflowStepArgument."Show Confirmation Message" := false;
                WorkflowStepArgument.Modify();
                EXIT;
            end;
            //HEI.17<<
        end;
    end;

    procedure TryDeleteJournalBatch(VAR GenJournalLine: Record "Gen. Journal Line")
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        PendingJournalBatchApprovalExistsErr: Label 'An approval request already exists.', Comment = '%1 is the Document No. of the journal line';

    begin
        //HEI.03>>
        GetGeneralJournalBatch(GenJournalBatch, GenJournalLine);
        IF ApprovalMgmt.HasOpenApprovalEntries(GenJournalBatch.RECORDID) OR
        ApprovalMgmt.HasAnyOpenJournalLineApprovalEntries(GenJournalBatch."Journal Template Name", GenJournalBatch.Name)
        THEN
            ERROR(PendingJournalBatchApprovalExistsErr);
        //HEI.03<<
    end;

    local procedure GetGeneralJournalBatch(var GenJournalBatch: Record "Gen. Journal Batch"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        if not GenJournalBatch.Get(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name") then
            GenJournalBatch.Get(GenJournalLine.GetFilter("Journal Template Name"), GenJournalLine.GetFilter("Journal Batch Name"));
    end;

    procedure CheckCheckLedgerApprovalsWorkflowEnabled(VAR CheckLedgerRec: Record "Check Ledger Entry"): Boolean
    begin
        //>>HEI.11
        IF NOT WorkflowManagementA.CanExecuteWorkflow(CheckLedgerRec, CustVendorBankWorkflow.RunWorkflowOnSendVoidCheckfromCheckLedgerEntryCode()) THEN
            ERROR('No workflow');
        EXIT(TRUE);
        //<<HEI.11
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendCheckLedgerInt(VAR CheckLedgerRec: Record "Check Ledger Entry")
    begin
    end;

    procedure SetApproverIDfromWS(ApproverID: Code[50])
    begin
        ApproverIDfromWS := ApproverID;   //HEI.12
    end;

    procedure GetApproverIDfromWS(): Code[50]
    begin
        EXIT(ApproverIDfromWS);
    end;

    Procedure SendItemJournalBatchApprovalRequest(VAR ItemJournalLine: Record "Item Journal Line")
    var
        ItemJournalBatch: Record "Item Journal Batch";
        PendingJournalBatchApprovalExistsErr: Label 'An approval request already exists.', Comment = '%1 is the Document No. of the journal line';
    begin
        //HEI.13>>
        GetItemJournalBatch(ItemJournalBatch, ItemJournalLine);
        CheckItemJournalBatchApprovalsWorkflowEnabled(ItemJournalBatch);
        IF ApprovalMgmt.HasOpenApprovalEntries(ItemJournalBatch.RECORDID) OR
        HasAnyOpenItemJournalLineApprovalEntries(ItemJournalBatch."Journal Template Name", ItemJournalBatch.Name) THEN
            ERROR(PendingJournalBatchApprovalExistsErr);
        OnSendItemJournalBatchForApprovalRequest(ItemJournalBatch);
        //HEI.13<<
    end;

    Procedure SendItemJournalLineApprovalRequest(VAR ItemJournalLine: Record "Item Journal Line")
    var
        LinesSent: Integer;
        NoApprovalsSentMsg: TextConst ENU = 'No approval requests have been sent, either because they are already sent or because related workflows do not support the journal line.';
        PendingApprovalForSelectedLinesMsg: TextConst ENU = 'Approval requests have been sent.';
        PendingApprovalForSomeSelectedLinesMsg: TextConst ENU = 'Approval requests have been sent.\\Requests for some journal lines were not sent, either because they are already sent or because related workflows do not support the journal line.';
    begin
        //HEI.13>>
        IF ItemJournalLine.COUNT = 1 THEN
            CheckItemJournalLineApprovalsWorkflowEnabled(ItemJournalLine);
        REPEAT
            IF WorkflowManagementA.CanExecuteWorkflow(ItemJournalLine,
                Heineken_WorkflowEventHandling.RunWorkflowOnSendItemJournalLineForApprovalRequestCode()) AND
                NOT ApprovalMgmt.HasOpenApprovalEntries(ItemJournalLine.RECORDID) THEN BEGIN
                OnSendItemJournalLineForApprovalRequest(ItemJournalLine);
                LinesSent += 1;
            END;
        UNTIL ItemJournalLine.NEXT() = 0;

        CASE LinesSent OF
            0:
                MESSAGE(NoApprovalsSentMsg);
            ItemJournalLine.COUNT:
                MESSAGE(PendingApprovalForSelectedLinesMsg);
            ELSE
                MESSAGE(PendingApprovalForSomeSelectedLinesMsg);
        END;
        //HEI.13<<
    end;

    Procedure CancelItemJournalBatchApprovalRequest(VAR ItemJournalLine: Record "Item Journal Line")
    var
        ItemJournalBatch: Record "Item Journal Batch";
    begin
        //HEI.13>>
        GetItemJournalBatch(ItemJournalBatch, ItemJournalLine);
        OnCancelItemJournalBatchApprovalRequest(ItemJournalBatch);
        //HEI.13<<
    end;

    Procedure CancelItemJournalLineApprovalRequest(VAR ItemJournalLine: Record "Item Journal Line")
    VAR
        ApprovalReqCanceledForSelectedLinesMsg: Label 'The approval request for the selected record has been canceled.';
    begin
        //HEI.13>>
        REPEAT
            IF ApprovalMgmt.HasOpenApprovalEntries(ItemJournalLine.RECORDID) THEN
                OnCancelItemJournalLineApprovalRequest(ItemJournalLine);
        UNTIL ItemJournalLine.NEXT() = 0;
        MESSAGE(ApprovalReqCanceledForSelectedLinesMsg);
        //HEI.13<<
    end;

    LOCAL procedure GetItemJournalBatch(VAR ItemJournalBatch: Record "Item Journal Batch"; VAR ItemJournalLine: Record "Item Journal Line")
    begin
        //HEI.13>>
        IF NOT ItemJournalBatch.GET(ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name") THEN
            ItemJournalBatch.GET(ItemJournalLine.GETFILTER("Journal Template Name"), ItemJournalLine.GETFILTER("Journal Batch Name"));
        //HEI.13<<
    end;

    Procedure CheckItemJournalBatchApprovalsWorkflowEnabled(VAR ItemJournalBatch: Record "Item Journal Batch"): Boolean
    begin
        //HEI.13>>
        IF NOT WorkflowManagementA.CanExecuteWorkflow(ItemJournalBatch,
        Heineken_WorkflowEventHandling.RunWorkflowOnSendItemJournalBatchForApprovalRequestCode()) THEN
            ERROR(NoWorkflowEnabledErr);

        EXIT(TRUE);
        //HEI.13<<
    end;

    Procedure CheckItemJournalLineApprovalsWorkflowEnabled(VAR ItemJournalLine: Record "Item Journal Line"): Boolean
    begin
        //HEI.13>>
        IF NOT WorkflowManagementA.CanExecuteWorkflow(ItemJournalLine,
        Heineken_WorkflowEventHandling.RunWorkflowOnSendItemJournalLineForApprovalRequestCode()) THEN
            ERROR(NoWorkflowEnabledErr);

        EXIT(TRUE);
        //HEI.13<<
    end;

    Procedure HasAnyOpenItemJournalLineApprovalEntries(JournalTemplateName: Code[20]; JournalBatchName: Code[20]): Boolean
    var
        ItemJournalLine: Record "Item Journal Line";
        ApprovalEntry: Record "Approval Entry";
        ItemJournalLineRecRef: RecordRef;
        ItemJournalLineRecordID: RecordID;
    begin
        //HEI.13>>
        ApprovalEntry.SETCURRENTKEY("Table ID", Status, "Related to Change");
        ApprovalEntry.SETRANGE("Table ID", DATABASE::"Item Journal Line");
        ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SETRANGE("Related to Change", FALSE);
        IF ApprovalEntry.ISEMPTY THEN
            EXIT(FALSE);

        ItemJournalLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name");
        ItemJournalLine.SETRANGE("Journal Template Name", JournalTemplateName);
        ItemJournalLine.SETRANGE("Journal Batch Name", JournalBatchName);
        IF ItemJournalLine.ISEMPTY THEN
            EXIT(FALSE);

        IF ItemJournalLine.COUNT < ApprovalEntry.COUNT THEN BEGIN
            ItemJournalLine.FINDSET();
            REPEAT
                IF ApprovalMgmt.HasOpenApprovalEntries(ItemJournalLine.RECORDID) THEN
                    EXIT(TRUE);
            UNTIL ItemJournalLine.NEXT() = 0;
        END ELSE BEGIN
            ApprovalEntry.FINDSET();
            REPEAT
                ItemJournalLineRecordID := ApprovalEntry."Record ID to Approve";
                ItemJournalLineRecRef := ItemJournalLineRecordID.GETRECORD();
                ItemJournalLineRecRef.SETTABLE(ItemJournalLine);
                IF (ItemJournalLine."Journal Template Name" = JournalTemplateName) AND
                (ItemJournalLine."Journal Batch Name" = JournalBatchName) THEN
                    EXIT(TRUE);
            UNTIL ApprovalEntry.NEXT() = 0;
        END;

        EXIT(FALSE)
        //HEI.13<<
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendItemJournalBatchForApprovalRequest(VAR ItemJournalBatch: Record "Item Journal Batch")
    begin

    end;    //HEI.13

    [IntegrationEvent(false, false)]
    PROCEDURE OnSendItemJournalLineForApprovalRequest(VAR ItemJournalLine: Record "Item Journal Line")
    begin

    end;    //HEI.13


    [IntegrationEvent(false, false)]
    procedure OnCancelItemJournalBatchApprovalRequest(VAR ItemJournalBatch: Record "Item Journal Batch")
    begin

    end;    //HEI.13


    [IntegrationEvent(false, false)]
    procedure OnCancelItemJournalLineApprovalRequest(VAR ItemJournalLine: Record "Item Journal Line")
    begin

    end;    //HEI.13

    procedure SetHideValidationDialogWF(NewHideValidationDialogWF: Boolean)
    begin
        //HEI.17>>
        HideValidationDialogWF := NewHideValidationDialogWF;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", OnBeforeDeletePurchQuote, '', false, false)]
    local procedure OnBeforeDeletePurchQuote(var OrderPurchHeader: Record "Purchase Header"; var QuotePurchHeader: Record "Purchase Header")
    var
        FromApprovalEntry: Record "Approval Entry";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        ToApprovalEntry: Record "Approval Entry";
        FromRecID: RecordId;
    begin
        FromRecID := QuotePurchHeader.RecordId;
        FromApprovalEntry.SetRange("Table ID", FromRecID.TableNo);
        FromApprovalEntry.SetRange("Record ID to Approve", FromRecID);
        if FromApprovalEntry.FindSet() then
            repeat
                //HEI.08>>
                //HEI.07>>
                //IF lPurchaseHeader.GET(ToApprovalEntry."Document Type",ToDocNo) THEN
                //IF lPurchaseHeader."Payment User" <> '' THEN
                //ToApprovalEntry."Approver ID" := lPurchaseHeader."Payment User";
                IF PurchaseHeaderAdditional.GET(ToApprovalEntry."Document Type", OrderPurchHeader."No.") THEN
                    IF PurchaseHeaderAdditional."PQ Approver" <> '' THEN begin
                        ToApprovalEntry."Approver ID" := PurchaseHeaderAdditional."PQ Approver";
                        ToApprovalEntry.Modify();
                    end;

            //HEI.07<<
            //HEI.08<<
            until FromApprovalEntry.Next() = 0;
    end;
    // BC Upgrade SHUKLP03 << Codeunit 1535 Approvals Mgmt.


    // BC Upgrade SHUKLP03 >> Codeunit 1520

    // HEI.01 CHG2049056 IBM.LS      05.03.2021
    // # Added Code
    // HEI.02 CHG2183672 DEBUSD01 05.12.2022 Fix lock new sales order runmodal page
    // HEI.03 CHG2183672 DEBUSD01 12.12.2022 Fix lock new sales order runmodal page
    // HEI.04 CHG2246789 IBM KAPOOV01 22.04.2024 Code Optimization for Journal Posting
    // # Modified Function RunWorkflowOnAfterInsertGeneralJournalLine()

    // BC Upgrade SHUKLP03 >>
    // HEI.01 => Whole code inside Procedure RunWorkflowOnSendItemJournalLineForApprovalRequestCode() is blocked in Nav, but added this procedure because this procedure is calling in procedure CanExecuteWorkflow() of codeunit Workflow Management(1501) as a parameter with some other parameter.
    // HEI.01 => code is not added of Procedure RunWorkflowOnCancelItemJournalLineApprovalRequestCode() and EVENT Subscriber RunWorkflowOnSendItemJournalLineForApprovalReq,RunWorkflowOnCancelItemJournalLineApprovalReq because code blocked in Nav.
    // HEI.01 => No event is found in between procedure AddEventPredecessors() to add code. So for now, subscribe event OnAddWorkflowEventPredecessorsToLibrary to add HEI tag code.
    // HEI.02, HEI.03 => Code is not added of event subscriber RunWorkflowOnSendSalesDocForApproval. Because as per discussion with Sakshi for now no need to add this code, we need to find some other workaround.
    // HEI.04 => Code is not added because event is already subscribe in codeunit and not found solution to add this code.
    // BC Upgrade SHUKLP03 <<

    var
        WorkflowManagement1501: Codeunit "Workflow Management";
        ItemJournalBatchSendForApprovalEventDescTxt: TextConst ENU = 'Approval of a Phys. Inv. Journal batch is requested.';
        ItemJournalBatchApprovalRequestCancelEventDescTxt: TextConst ENU = 'An approval request for a Phys. Inv. Journal batch is canceled.';
        ItemJournalLineSendForApprovalEventDescTxt: TextConst ENU = 'Approval of a Phys. Inv. Journal line is requested.';
        ItemJournalLineApprovalRequestCancelEventDescTxt: TextConst ENU = 'An approval request for a Phys. Inv. Journal line is canceled.';
        ItemJournalBatchBalancedEventDescTxt: TextConst ENU = 'A Phys. Inv. Journal batch is selected.';
        WEH: Codeunit "Workflow Event Handling";
        ItemJournalBatchNotBalancedEventDescTxt: TextConst ENU = '	A Phys. Inv. Journal batch is not selected.';

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventsToLibrary, '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
    begin
        //HEI.01>>
        WEH.AddEventToLibrary(RunWorkflowOnSendItemJournalBatchForApprovalRequestCode(), DATABASE::"Item Journal Batch",
          ItemJournalBatchSendForApprovalEventDescTxt, 0, FALSE);
        WEH.AddEventToLibrary(RunWorkflowOnCancelItemJournalBatchApprovalRequestCode(), DATABASE::"Item Journal Batch",
          ItemJournalBatchApprovalRequestCancelEventDescTxt, 0, FALSE);

        //AddEventToLibrary(RunWorkflowOnSendItemJournalLineForApprovalRequestCode,DATABASE::"Item Journal Line",
        //ItemJournalLineSendForApprovalEventDescTxt,0,FALSE);
        //AddEventToLibrary(RunWorkflowOnCancelItemJournalLineApprovalRequestCode,DATABASE::"Item Journal Line",
        //ItemJournalLineApprovalRequestCancelEventDescTxt,0,FALSE);

        WEH.AddEventToLibrary(RunWorkflowOnItemJournalBatchBalancedCode(), DATABASE::"Item Journal Batch",
          ItemJournalBatchBalancedEventDescTxt, 0, FALSE);
        WEH.AddEventToLibrary(RunWorkflowOnItemJournalBatchNotBalancedCode(), DATABASE::"Item Journal Batch",
          ItemJournalBatchNotBalancedEventDescTxt, 0, FALSE);
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventPredecessorsToLibrary, '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin
        case EventFunctionName of
            //HEI.01>>
            RunWorkflowOnCancelItemJournalBatchApprovalRequestCode():
                WEH.AddEventPredecessor(RunWorkflowOnCancelItemJournalBatchApprovalRequestCode(), RunWorkflowOnSendItemJournalBatchForApprovalRequestCode());
            //HEI.01<<
            WEH.RunWorkflowOnApproveApprovalRequestCode():
                BEGIN
                    //HEI.01>>
                    WEH.AddEventPredecessor(WEH.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendItemJournalBatchForApprovalRequestCode());
                    WEH.AddEventPredecessor(WEH.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnItemJournalBatchBalancedCode());
                    //AddEventPredecessor(RunWorkflowOnApproveApprovalRequestCode,RunWorkflowOnSendItemJournalLineForApprovalRequestCode);
                    //HEI.01<<
                end;
            WEH.RunWorkflowOnRejectApprovalRequestCode():
                BEGIN
                    //HEI.01>>
                    WEH.AddEventPredecessor(WEH.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendItemJournalBatchForApprovalRequestCode());
                    WEH.AddEventPredecessor(WEH.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnItemJournalBatchBalancedCode());
                    //AddEventPredecessor(RunWorkflowOnRejectApprovalRequestCode,RunWorkflowOnSendItemJournalLineForApprovalRequestCode);
                    //HEI.01<<
                END;
            WEH.RunWorkflowOnDelegateApprovalRequestCode():
                BEGIN
                    //HEI.01>>
                    WEH.AddEventPredecessor(WEH.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendItemJournalBatchForApprovalRequestCode());
                    WEH.AddEventPredecessor(WEH.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnItemJournalBatchBalancedCode());
                    //AddEventPredecessor(RunWorkflowOnDelegateApprovalRequestCode,RunWorkflowOnSendItemJournalLineForApprovalRequestCode);
                    //HEI.01<<
                END;

            //HEI.01>>
            RunWorkflowOnItemJournalBatchBalancedCode():
                WEH.AddEventPredecessor(RunWorkflowOnItemJournalBatchBalancedCode(), RunWorkflowOnSendItemJournalBatchForApprovalRequestCode());
            RunWorkflowOnItemJournalBatchNotBalancedCode():
                WEH.AddEventPredecessor(RunWorkflowOnItemJournalBatchNotBalancedCode(), RunWorkflowOnSendItemJournalBatchForApprovalRequestCode());
        //HEI.01<<
        end;
    end;

    procedure RunWorkflowOnSendItemJournalBatchForApprovalRequestCode(): Code[128]
    begin
        //HEI.01>>
        EXIT(UPPERCASE('RunWorkflowOnSendItemJournalBatchForApprovalReq'));
        //HEI.01<<
    end;

    procedure RunWorkflowOnCancelItemJournalBatchApprovalRequestCode(): Code[128]
    begin
        //HEI.01>>
        EXIT(UPPERCASE('RunWorkflowOnCancelItemJournalBatchApprovalReq'));
        //HEI.01<<
    end;

    procedure RunWorkflowOnItemJournalBatchBalancedCode(): Code[128]
    begin
        //HEI.01>>
        EXIT(UPPERCASE('RunWorkflowOnItemJournalBatchBalanced'));
        //HEI.01<<
    end;

    procedure RunWorkflowOnItemJournalBatchNotBalancedCode(): Code[128]
    begin
        //HEI.01>>
        EXIT(UPPERCASE('RunWorkflowOnItemJournalBatchNotBalanced'));
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Heineken BC Upgrade", OnSendItemJournalBatchForApprovalRequest, '', false, false)]
    local procedure RunWorkflowOnSendItemJournalBatchForApprovalReq(var ItemJournalBatch: Record "Item Journal Batch")
    begin
        //HEI.01>>
        WorkflowManagement1501.HandleEvent(RunWorkflowOnSendItemJournalBatchForApprovalRequestCode(), ItemJournalBatch);
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Heineken BC Upgrade", OnCancelItemJournalBatchApprovalRequest, '', false, false)]
    local procedure RunWorkflowOnCancelItemJournalBatchApprovalReq(var ItemJournalBatch: Record "Item Journal Batch")
    begin
        //HEI.01>>
        WorkflowManagement1501.HandleEvent(RunWorkflowOnCancelItemJournalBatchApprovalRequestCode(), ItemJournalBatch);
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Batch", OnItemJournalBatchBalanced, '', false, false)]
    local procedure RunWorkflowOnItemJournalBatchBalanced(sender: Record "Item Journal Batch")
    begin
        //HEI.01>>
        WorkflowManagement1501.HandleEvent(RunWorkflowOnItemJournalBatchBalancedCode(), Sender);
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Batch", OnItemJournalBatchNotBalanced, '', false, false)]
    local procedure RunWorkflowOnItemJournalBatchNotBalanced(sender: Record "Item Journal Batch")
    begin
        //HEI.01>>
        WorkflowManagement1501.HandleEvent(RunWorkflowOnItemJournalBatchNotBalancedCode(), Sender);
        //HEI.01<<
    end;

    procedure RunWorkflowOnSendItemJournalLineForApprovalRequestCode(): Code[128]
    begin
        //HEI.01>>
        //EXIT(UPPERCASE('RunWorkflowOnSendItemJournalLineForApprovalReq'));
        //HEI.01<<
    end;


    // BC Upgrade SHUKLP03 << Codeunit 1520


    // BC Upgrade SHUKLP03 >> Page 5776 Warehouse Document-Print 
    //     HEI.01 FDD LA- GAPLOG02 Transfer Order Layout IBM.NAIKH01 10.09.2018
    //   # Added code in function "PrintMovementHeader" to print the report from Report Selection Usage.
    // HEI.02 IBM HORTOC01 19.04.2019 # Print UnLoadingNote and Picking List
    // HEI.03 CHG2011091 IBM GAVANM01 23.05.2019 # Print Gate Entry Document
    // HEI.04 Defect4465 IBM BULIMC01 21/11/2019 #apply fixes on PrintPostedShptHeader

    // BC Upgrade SHUKLP03 >>
    // HEI.01 => Subscribed evevt OnBeforePrintMovementHeader to add code of PROCEDURE PrintMovementHeader()
    // HEI.04 => Subscribed event OnBeforePrintPostedShptHeader to add code of Procedure PrintPostedShptHeader()
    // HEI.02 => Custome Procedure added PrintPickingListWhseActivity() and PrintUnloadingNoteWhseReceipt().
    // HEI.03 => Custome Procedure added PrintGateEntryDocument()
    // BC Upgrade SHUKLP03 <<


    var
        ReportSelections: Record "Report Selections";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Warehouse Document-Print", OnBeforePrintMovementHeader, '', false, false)]
    local procedure OnBeforePrintMovementHeader(var IsHandled: Boolean; var WarehouseActivityHeader: Record "Warehouse Activity Header")
    var
        MovementList: Report "Movement List";
    begin
        //HEI.01 >>
        ReportSelections.RESET();
        ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"Zone (Whse Movement)");
        ReportSelections.SETFILTER("Report ID", '<>0');
        IF ReportSelections.FINDSET() THEN BEGIN
            WarehouseActivityHeader.SETRANGE("No.", WarehouseActivityHeader."No.");
            IF WarehouseActivityHeader.FIND() THEN;
            REPORT.RUN(ReportSelections."Report ID", TRUE, FALSE, WarehouseActivityHeader);
        END;
        //HEI.01<<
        IsHandled := True;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Warehouse Document-Print", OnBeforePrintPostedShptHeader, '', false, false)]
    local procedure OnBeforePrintPostedShptHeader(var IsHandled: Boolean; var PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header")
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        PostedRcptHeader: Record "Posted Whse. Receipt Header";
    begin
        PostedWhseShipmentHeader.SETRANGE("No.", PostedWhseShipmentHeader."No.");
        //HEI.04>>
        ReportSelections.RESET();
        ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"Delivery Note(Whse Ship)");
        ReportSelections.SETFILTER("Report ID", '<>0');
        IF ReportSelections.FINDSET() THEN BEGIN
            SalesShipmentHeader.SETRANGE("Posted Whse. Shipment No. FND", PostedWhseShipmentHeader."No.");
            IF SalesShipmentHeader.FIND() THEN;
            REPORT.RUN(ReportSelections."Report ID", TRUE, FALSE, SalesShipmentHeader)
        END;
        //HEI.04>>
        IsHandled := True;
    end;

    procedure PrintUnloadingNoteWhseReceipt(WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        WhseReceiptHeader: Record "Warehouse Receipt Header";
    begin
        //HEI.02>>
        ReportSelections.RESET();
        ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"Unloading Note(Whse. Receipt)");
        ReportSelections.SETFILTER("Report ID", '<>0');
        IF ReportSelections.FINDSET() THEN BEGIN
            WhseReceiptHeader.SETRANGE("No.", WarehouseReceiptHeader."No.");
            IF WhseReceiptHeader.FIND() THEN;
            REPORT.RUN(ReportSelections."Report ID", TRUE, FALSE, WhseReceiptHeader);
        END;
        //HEI.02<<
    end;

    procedure PrintPickingListWhseActivity(WarehouseActivityHeader: Record "Warehouse Activity Header")
    var
        WhseActivityHeader: Record "Warehouse Activity Header";
    begin    //HEI.02>>
        ReportSelections.RESET();
        ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"Picking List By Lot");
        ReportSelections.SETFILTER("Report ID", '<>0');
        IF ReportSelections.FINDSET() THEN BEGIN
            WhseActivityHeader.SETRANGE("No.", WarehouseActivityHeader."No.");
            IF WhseActivityHeader.FIND() THEN;
            REPORT.RUN(ReportSelections."Report ID", TRUE, FALSE, WhseActivityHeader);
        END;
        //HEI.02<<
    end;

    procedure PrintGateEntryDocument(GateEntryHeader: Record "Gate Entry Header FND")
    var
        GEHeader: Record "Gate Entry Header FND";
    begin
        //HEI.03>>
        ReportSelections.RESET();
        ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"Gate Entry Document");
        ReportSelections.SETFILTER("Report ID", '<>0');
        IF ReportSelections.FINDSET() THEN BEGIN
            GEHeader.SETRANGE("Gate Entry Document No.", GateEntryHeader."Gate Entry Document No.");
            IF GEHeader.FIND() THEN;
            REPORT.RUN(ReportSelections."Report ID", TRUE, FALSE, GEHeader);
        END;
        //HEI.03<<
    end;
    // BC Upgrade SHUKLP03 >> Page 5776 Warehouse Document-Print 


    //Bc Upgrade YADAVM09 Codeunit Item Charge Assgnt. (Purch.)>>
    //     DITW15.00.00.01 DDR 03/01/2008 Added function SetCheckFromLineSuspend()
    // DITW15.00.00.01 DDR 04/01/2008 Bugfix to skip some tests
    // DITW15.00.00.01 DDR 10/01/2008 Added function SetAutoAssignParentOnly()
    // DITW15.00.00.01 DDR 30/01/2008 Change function SuggestAssgnt2() to assign only for main attached item
    // DITW15.00.00.01 DDR 12/02/2008 Correct test into function SuggestAssignment2()
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 22/04/2008 Bugfix function SuggestAssgnt2() to check quantity from purchase line
    // DITW15.00.00.23 DDR 01/08/2008 Bugfix Hide all item charge lines when create default lines with function CreateDocChargeAssgn()
    // DITW15.00.00.30 DDR 09/01/2009 Added function SetSkipAutoCreateExistLines()
    // DITW15.00.00.35 DDR 27/07/2009 Removed filter "is item charge"
    //                     31/07/2009 Bugfix lrPurchLine record local variable in function SuggestAssgnt2()
    //                     23/10/2009 issue 796 Added Recalculation Qty. to assign with lines per order
    // DITW15.00.00.37 DDR 19/05/2010 issue 1137 Added to (re)create the assignment line automatically when is attached to DIT line
    //                                           Added functions CreateDefaultDocChargeAssgn()
    //                                           Added rounding unit cost when Item charge is for DIT Taxes
    //                     09/06/2010 issue 1153 Bugfix to initialize currency record when no currency code
    //                                             in function CreateDefaultDocChargeAssgn()

    // FINXL7.00.001 RBE 25/03/2013: Item description to 80 positions (expanded Description2 of function InsertItemChargeAssgnt)

    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.02 DDR 12/12/2013 DIT-770 #281 Bugfix Upgrade R2
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05  AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019 # SuggestAssgnt func. modified, variables added
    //                                            AssignEqually,AssignByAmount,AssignByWeight,
    //                                            AssignByVolume, AssignByItemWeight, AssignByItemCubag,
    //                                            AssignByQuantity, GetItemValues, AssignPurchItemCharge
    //                                            GetItemUomValues, SuggestAssgnt3 funcs. added
    // HEI.02 FDD-HT658 IBM.GUNERE01 05.11.2019 # SuggestAssgnt func. modified
    // HEI.03 FDD-HT1075 CHG2039144 IBM.GUNERE01 14.01.2020 # CreateTransferShptChargeAssgnt func. added


    //Bc Upgrade YADAVM09 Event OnAfterUpdateQty Subscribe for function UpdateQty.
    //Bc Upgrade YADAVM09 OnBeforeAssignItemCharges event is subscribed to add code //HEI.01 FDD-HT658
    //Bc Upgrade YADAVM09 New function created
    //   #AssignByItemWeightText
    //   #AssignByItemCubbageText
    //   #AssignByItemQuantityText
    // Bc Upgrade YADAVM09 Drink it field code commented.





    [EventSubscriber(ObjectType::Codeunit, codeunit::"Item Charge Assgnt. (Purch.)", 'OnBeforeAssignItemCharges', '', true, true)]
    local procedure OnBeforeAssignItemCharges(var PurchaseLine: Record "Purchase Line"; TotalQtyToAssign: Decimal; TotalAmtToAssign: Decimal; var IsHandled: Boolean; TotalQtyToHandle: Decimal; TotalAmtToHandle: Decimal; SelectionTxt: Text)
    var
        Currency: Record Currency;
        PurchHeader: Record "Purchase Header";
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        ItemChargesAssigned: Boolean;
        CUItemChargeAssignment: Codeunit "Item Charge Assgnt. (Purch.)";

    begin
        PurchaseLine.TestField("Qty. to Invoice");
        PurchHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.");
        if not Currency.Get(PurchHeader."Currency Code") then
            Currency.InitRoundingPrecision();

        ItemChargeAssgntPurch.SetRange("Document Type", PurchaseLine."Document Type");
        ItemChargeAssgntPurch.SetRange("Document No.", PurchaseLine."Document No.");
        ItemChargeAssgntPurch.SetRange("Document Line No.", PurchaseLine."Line No.");

        if not ItemChargeAssgntPurch.IsEmpty() then begin
            ItemChargeAssgntPurch.ModifyAll("Amount to Assign", 0);
            ItemChargeAssgntPurch.ModifyAll("Qty. to Assign", 0);
            ItemChargeAssgntPurch.ModifyAll("Amount to Handle", 0);
            ItemChargeAssgntPurch.ModifyAll("Qty. to Handle", 0);
            ItemChargeAssgntPurch.FindSet();
            //>> HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
            case SelectionTxt of
                CUItemChargeAssignment.AssignEquallyMenuText():
                    //AssignEqually(ItemChargeAssgntPurch, Currency, TotalQtyToAssign, TotalAmtToAssign, TotalQtyToHandle, TotalAmtToHandle);
                    AssignEqually(ItemChargeAssgntPurch, Currency, TotalQtyToAssign, TotalAmtToAssign, PurchaseLine);//BC Upgrade Manisha
                CUItemChargeAssignment.AssignByAmountMenuText():
                    //AssignByAmount(ItemChargeAssgntPurch, Currency, PurchHeader, TotalQtyToAssign, TotalAmtToAssign, TotalQtyToHandle, TotalAmtToHandle);
                    AssignByAmount(ItemChargeAssgntPurch, Currency, PurchHeader, TotalQtyToAssign, TotalAmtToAssign, PurchaseLine);
                CUItemChargeAssignment.AssignByWeightMenuText():
                    //AssignByWeight(ItemChargeAssgntPurch, Currency, TotalQtyToAssign);
                    AssignByWeight(ItemChargeAssgntPurch, Currency, TotalQtyToAssign, PurchaseLine);
                CUItemChargeAssignment.AssignByVolumeMenuText():
                    // AssignByVolume(ItemChargeAssgntPurch, Currency, TotalQtyToAssign);
                    AssignByVolume(ItemChargeAssgntPurch, Currency, TotalQtyToAssign, PurchaseLine);
                AssignByItemWeightText():
                    AssignByItemWeight(ItemChargeAssgntPurch, Currency, TotalQtyToAssign, PurchaseLine);
                AssignByItemCubbageText():
                    AssignByItemCubage(ItemChargeAssgntPurch, Currency, TotalQtyToAssign, PurchaseLine);
                AssignByItemQuantityText():
                    AssignByQuantity(ItemChargeAssgntPurch, Currency, TotalQtyToAssign, TotalAmtToAssign, PurchaseLine);

            // //else begin
            //    CUItemChargeAssignment.OnAssignItemCharges(
            //      SelectionTxt, ItemChargeAssgntPurch, Currency, PurchHeader, TotalQtyToAssign, TotalAmtToAssign, ItemChargesAssigned);
            //    if not ItemChargesAssigned then
            //        Error(ItemChargesNotAssignedErr);
            //end;
            end;
            //<< HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
        end;
        IsHandled := true;
    end;

    procedure AssignByItemWeightText(): Text
    begin
        exit(ByItemWeight)
    end;

    procedure AssignByItemCubbageText(): Text
    begin
        exit(ByItemCubbage)
    end;

    procedure AssignByItemQuantityText(): Text
    begin
        exit(ByItemQuantity)
    end;

    LOCAL procedure AssignByVolume(VAR ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; Currency: Record Currency; TotalQtyToAssign: Decimal; PurchLineItemCharge: Record "Purchase Line")
    var
        TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary;
        TotalUnitVolume: Decimal;
        QtyRemainder: Decimal;
        AmountRemainder: Decimal;
        LineAray: array[3] of Decimal;
    begin
        //>> HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
        REPEAT
            IF NOT ItemChargeAssgntPurch.PurchLineInvoiced() THEN BEGIN
                TempItemChargeAssgntPurch.INIT();
                TempItemChargeAssgntPurch := ItemChargeAssgntPurch;
                TempItemChargeAssgntPurch.INSERT();
                GetItemValues(TempItemChargeAssgntPurch, LineAray);
                TotalUnitVolume := TotalUnitVolume + (LineAray[3] * LineAray[1]);
            END;
        UNTIL ItemChargeAssgntPurch.NEXT() = 0;

        IF TempItemChargeAssgntPurch.FINDSET(TRUE) THEN
            REPEAT
                GetItemValues(TempItemChargeAssgntPurch, LineAray);
                IF TotalUnitVolume <> 0 THEN
                    TempItemChargeAssgntPurch."Qty. to Assign" :=
                      (TotalQtyToAssign * LineAray[3] * LineAray[1]) / TotalUnitVolume + QtyRemainder
                ELSE
                    TempItemChargeAssgntPurch."Qty. to Assign" := 0;
                AssignPurchItemCharge(ItemChargeAssgntPurch, TempItemChargeAssgntPurch, Currency, QtyRemainder, AmountRemainder);
            UNTIL TempItemChargeAssgntPurch.NEXT() = 0;
        TempItemChargeAssgntPurch.DELETEALL();
        //<< HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019

    end;

    procedure GetItemValues(TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary; VAR DecimalArray: ARRAY[3] OF Decimal)
    var
        PurchLine: Record "Purchase Line";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ReturnRcptLine: Record "Return Receipt Line";
        ReturnShptLine: Record "Return Shipment Line";
        TransferRcptLine: Record "Transfer Receipt Line";
        SalesShptLine: Record "Sales Shipment Line";
        TransferShptLine: Record "Transfer Shipment Line";
    begin
        //>> HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
        CLEAR(DecimalArray);
        CASE TempItemChargeAssgntPurch."Applies-to Doc. Type" OF
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::Order,
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::Invoice,
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Return Order",
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Credit Memo":
                BEGIN
                    PurchLine.GET(TempItemChargeAssgntPurch."Applies-to Doc. Type", TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
                    DecimalArray[1] := PurchLine.Quantity;
                    DecimalArray[2] := PurchLine."Gross Weight";
                    DecimalArray[3] := PurchLine."Unit Volume";
                END;
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::Receipt:
                BEGIN
                    PurchRcptLine.GET(TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
                    DecimalArray[1] := PurchRcptLine.Quantity;
                    DecimalArray[2] := PurchRcptLine."Gross Weight";
                    DecimalArray[3] := PurchRcptLine."Unit Volume";
                END;
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Return Receipt":
                BEGIN
                    ReturnRcptLine.GET(TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
                    DecimalArray[1] := ReturnRcptLine.Quantity;
                    DecimalArray[2] := ReturnRcptLine."Gross Weight";
                    DecimalArray[3] := ReturnRcptLine."Unit Volume";
                END;
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Return Shipment":
                BEGIN
                    ReturnShptLine.GET(TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
                    DecimalArray[1] := ReturnShptLine.Quantity;
                    DecimalArray[2] := ReturnShptLine."Gross Weight";
                    DecimalArray[3] := ReturnShptLine."Unit Volume";
                END;
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Transfer Receipt":
                BEGIN
                    TransferRcptLine.GET(TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
                    DecimalArray[1] := TransferRcptLine.Quantity;
                    DecimalArray[2] := TransferRcptLine."Gross Weight";
                    DecimalArray[3] := TransferRcptLine."Unit Volume";
                END;
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Sales Shipment":
                BEGIN
                    SalesShptLine.GET(TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
                    DecimalArray[1] := SalesShptLine.Quantity;
                    DecimalArray[2] := SalesShptLine."Gross Weight";
                    DecimalArray[3] := SalesShptLine."Unit Volume";
                END;
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Transfer Shipment":
                BEGIN
                    TransferShptLine.GET(TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
                    DecimalArray[1] := TransferShptLine.Quantity;
                    DecimalArray[2] := TransferShptLine."Gross Weight";
                    DecimalArray[3] := TransferShptLine."Unit Volume";
                END;
        END;
        //<< HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
    end;

    LOCAL procedure AssignByWeight(VAR ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; Currency: Record Currency; TotalQtyToAssign: Decimal; PurchLineItemCharge: Record "Purchase Line")
    var
        TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary;
        TotalUnitVolume: Decimal;
        QtyRemainder: Decimal;
        TotalGrossWeight: Decimal;
        LineAray: array[3] of Decimal;
        AmountRemainder: Decimal;
    begin
        //>> HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
        REPEAT
            IF NOT ItemChargeAssgntPurch.PurchLineInvoiced() THEN BEGIN
                TempItemChargeAssgntPurch.INIT();
                TempItemChargeAssgntPurch := ItemChargeAssgntPurch;
                TempItemChargeAssgntPurch.INSERT();
                GetItemValues(TempItemChargeAssgntPurch, LineAray);
                TotalGrossWeight := TotalGrossWeight + (LineAray[2] * LineAray[1]);
            END;
        UNTIL ItemChargeAssgntPurch.NEXT() = 0;

        IF TempItemChargeAssgntPurch.FINDSET(TRUE) THEN
            REPEAT
                GetItemValues(TempItemChargeAssgntPurch, LineAray);
                IF TotalGrossWeight <> 0 THEN
                    TempItemChargeAssgntPurch."Qty. to Assign" :=
                      (TotalQtyToAssign * LineAray[2] * LineAray[1]) / TotalGrossWeight + QtyRemainder
                ELSE
                    TempItemChargeAssgntPurch."Qty. to Assign" := 0;
                AssignPurchItemCharge(ItemChargeAssgntPurch, TempItemChargeAssgntPurch, Currency, QtyRemainder, AmountRemainder);
            UNTIL TempItemChargeAssgntPurch.NEXT() = 0;
        TempItemChargeAssgntPurch.DELETEALL();
        //<< HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
    end;

    LOCAL procedure AssignPurchItemCharge(VAR ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; ItemChargeAssgntPurch2: Record "Item Charge Assignment (Purch)"; Currency: Record Currency; VAR QtyRemainder: Decimal; VAR AmountRemainder: Decimal)
    begin
        //>> HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
        ItemChargeAssgntPurch.GET(
          ItemChargeAssgntPurch2."Document Type",
          ItemChargeAssgntPurch2."Document No.",
          ItemChargeAssgntPurch2."Document Line No.",
          ItemChargeAssgntPurch2."Line No.");
        ItemChargeAssgntPurch."Qty. to Assign" := ROUND(ItemChargeAssgntPurch2."Qty. to Assign", 0.00001);
        ItemChargeAssgntPurch."Amount to Assign" :=
          ItemChargeAssgntPurch."Qty. to Assign" * ItemChargeAssgntPurch."Unit Cost" + AmountRemainder;
        AmountRemainder := ItemChargeAssgntPurch."Amount to Assign" -
          ROUND(ItemChargeAssgntPurch."Amount to Assign", Currency."Amount Rounding Precision");
        QtyRemainder := ItemChargeAssgntPurch2."Qty. to Assign" - ItemChargeAssgntPurch."Qty. to Assign";
        ItemChargeAssgntPurch."Amount to Assign" :=
          ROUND(ItemChargeAssgntPurch."Amount to Assign", Currency."Amount Rounding Precision");
        ItemChargeAssgntPurch.MODIFY();
        //<< HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
    end;

    LOCAL procedure AssignByAmount(VAR ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; Currency: Record Currency; PurchHeader: Record "Purchase Header"; TotalQtyToAssign: Decimal; TotalAmtToAssign: Decimal; PurchLineItemCharge: Record "Purchase Line")
    var
        lrPurchLine: Record "Purchase Line";
        TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary;
        PurchLine: Record "Purchase Line";
        lTempItemChargeAssgntPurchInv: Record "Item Charge Assignment (Purch)" temporary;
        PurchRcptLine: Record "Purch. Rcpt. Line";
        CurrencyCode: Code[10];
        CurrExchRate: Record "Currency Exchange Rate";
        ReturnShptLine: Record "Return Shipment Line";
        SalesShptLine: Record "Sales Shipment Line";
        ReturnRcptLine: Record "Return Receipt Line";
        TransferReceiptLine: Record "Transfer Receipt Line";
        Item: Record Item;
        SKU: Record "Stockkeeping Unit";
        TransferShipmentLine: Record "Transfer Shipment Line";
        TotalAppliesToDocLineAmount: Decimal;
    begin
        //>> HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
        REPEAT
            IF (ItemChargeAssgntPurch."Applies-to Doc. Type" <> ItemChargeAssgntPurch."Document Type") AND
               (ItemChargeAssgntPurch."Applies-to Doc. Type".AsInteger() <= ItemChargeAssgntPurch."Applies-to Doc. Type"::"Blanket Order".AsInteger())
            THEN
                lrPurchLine.GET(
                  ItemChargeAssgntPurch."Applies-to Doc. Type",
                  ItemChargeAssgntPurch."Applies-to Doc. No.",
                  ItemChargeAssgntPurch."Applies-to Doc. Line No.");

            IF NOT ItemChargeAssgntPurch.PurchLineInvoiced() OR
              ((lrPurchLine.Quantity = lrPurchLine."Quantity Invoiced") AND (lrPurchLine.Quantity = 0) AND blnCheckFromLineSuspend)
            THEN BEGIN
                TempItemChargeAssgntPurch := ItemChargeAssgntPurch;
                CASE ItemChargeAssgntPurch."Applies-to Doc. Type" OF
                    ItemChargeAssgntPurch."Applies-to Doc. Type"::Quote,
                    ItemChargeAssgntPurch."Applies-to Doc. Type"::Order,
                    ItemChargeAssgntPurch."Applies-to Doc. Type"::Invoice,
                    ItemChargeAssgntPurch."Applies-to Doc. Type"::"Return Order",
                    ItemChargeAssgntPurch."Applies-to Doc. Type"::"Credit Memo":
                        BEGIN
                            PurchLine.GET(
                              ItemChargeAssgntPurch."Applies-to Doc. Type",
                              ItemChargeAssgntPurch."Applies-to Doc. No.",
                              ItemChargeAssgntPurch."Applies-to Doc. Line No.");
                            /*//Bc Upgrade YADAVM09 Drink it field commented>>
                          IF (PurchLineItemCharge."Item Charge Calculate per" = PurchLineItemCharge."Item Charge Calculate per"::Order) AND
                            (PurchLineItemCharge."Attached to Line No." = 0)
                          THEN BEGIN
                              lTempItemChargeAssgntPurchInv := TempItemChargeAssgntPurch;
                              IF PurchLine.Quantity <> 0 THEN
                                  lTempItemChargeAssgntPurchInv."Applies-to Doc. Line Amount" :=
                                    ABS(PurchLine."Line Amount" / PurchLine.Quantity * ItemChargeAssgntPurch."Qty. to Assign")
                              ELSE
                                  lTempItemChargeAssgntPurchInv."Applies-to Doc. Line Amount" := 0;
                              lTempItemChargeAssgntPurchInv.INSERT;
                          END;
                            *///Bc Upgrade YADAVM09 Drink it field commented<<
                            TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" :=
                              ABS(PurchLine."Line Amount");
                        END;
                    ItemChargeAssgntPurch."Applies-to Doc. Type"::Receipt:
                        BEGIN
                            PurchRcptLine.GET(
                              ItemChargeAssgntPurch."Applies-to Doc. No.",
                              ItemChargeAssgntPurch."Applies-to Doc. Line No.");
                            CurrencyCode := PurchRcptLine.GetCurrencyCodeFromHeader();
                            IF CurrencyCode = PurchHeader."Currency Code" THEN
                                TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" :=
                                  ABS(PurchRcptLine."Item Charge Base Amount")
                            ELSE
                                TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" :=
                                  CurrExchRate.ExchangeAmtFCYToFCY(
                                    PurchHeader."Posting Date", CurrencyCode, PurchHeader."Currency Code",
                                    ABS(PurchRcptLine."Item Charge Base Amount"));
                        END;
                    ItemChargeAssgntPurch."Applies-to Doc. Type"::"Return Shipment":
                        BEGIN
                            ReturnShptLine.GET(
                              ItemChargeAssgntPurch."Applies-to Doc. No.",
                              ItemChargeAssgntPurch."Applies-to Doc. Line No.");
                            CurrencyCode := ReturnShptLine.GetCurrencyCode();
                            IF CurrencyCode = PurchHeader."Currency Code" THEN
                                TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" :=
                                  ABS(ReturnShptLine."Item Charge Base Amount")
                            ELSE
                                TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" :=
                                  CurrExchRate.ExchangeAmtFCYToFCY(
                                    PurchHeader."Posting Date", CurrencyCode, PurchHeader."Currency Code",
                                    ABS(ReturnShptLine."Item Charge Base Amount"));
                        END;
                    ItemChargeAssgntPurch."Applies-to Doc. Type"::"Sales Shipment":
                        BEGIN
                            SalesShptLine.GET(
                              ItemChargeAssgntPurch."Applies-to Doc. No.",
                              ItemChargeAssgntPurch."Applies-to Doc. Line No.");
                            CurrencyCode := SalesShptLine.GetCurrencyCode();
                            IF CurrencyCode = PurchHeader."Currency Code" THEN
                                TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" :=
                                  ABS(SalesShptLine."Item Charge Base Amount")
                            ELSE
                                TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" :=
                                  CurrExchRate.ExchangeAmtFCYToFCY(
                                    PurchHeader."Posting Date", CurrencyCode, PurchHeader."Currency Code",
                                    ABS(SalesShptLine."Item Charge Base Amount"));
                        END;
                    ItemChargeAssgntPurch."Applies-to Doc. Type"::"Return Receipt":
                        BEGIN
                            ReturnRcptLine.GET(
                              ItemChargeAssgntPurch."Applies-to Doc. No.",
                              ItemChargeAssgntPurch."Applies-to Doc. Line No.");
                            CurrencyCode := ReturnRcptLine.GetCurrencyCode();
                            IF CurrencyCode = PurchHeader."Currency Code" THEN
                                TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" :=
                                  ABS(ReturnRcptLine."Item Charge Base Amount")
                            ELSE
                                TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" :=
                                  CurrExchRate.ExchangeAmtFCYToFCY(
                                    PurchHeader."Posting Date", CurrencyCode, PurchHeader."Currency Code",
                                    ABS(ReturnRcptLine."Item Charge Base Amount"));
                        END;

                    ItemChargeAssgntPurch."Applies-to Doc. Type"::"Transfer Receipt":
                        BEGIN
                            TransferReceiptLine.GET(
                              ItemChargeAssgntPurch."Applies-to Doc. No.",
                              ItemChargeAssgntPurch."Applies-to Doc. Line No.");

                            Currency.InitRoundingPrecision();
                            Item.GET(TransferReceiptLine."Item No.");
                            IF SKU.GET(TransferReceiptLine."Transfer-to Code", TransferReceiptLine."Item No.", TransferReceiptLine."Variant Code") AND
                              (SKU."Unit Cost" <> 0)
                            THEN
                                TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" :=
                                  ABS(ROUND(TransferReceiptLine.Quantity * SKU."Unit Cost", Currency."Amount Rounding Precision"))
                            ELSE
                                TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" :=
                                  ABS(ROUND(TransferReceiptLine.Quantity * Item."Unit Cost", Currency."Amount Rounding Precision"));
                        END;
                    ItemChargeAssgntPurch."Applies-to Doc. Type"::"Transfer Shipment":
                        BEGIN
                            TransferShipmentLine.GET(
                              ItemChargeAssgntPurch."Applies-to Doc. No.",
                              ItemChargeAssgntPurch."Applies-to Doc. Line No.");

                            Currency.InitRoundingPrecision();
                            Item.GET(TransferShipmentLine."Item No.");
                            IF SKU.GET(TransferShipmentLine."Transfer-to Code", TransferShipmentLine."Item No.", TransferShipmentLine."Variant Code") AND
                              (SKU."Unit Cost" <> 0)
                            THEN
                                TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" :=
                                  ABS(ROUND(TransferShipmentLine.Quantity * SKU."Unit Cost", Currency."Amount Rounding Precision"))
                            ELSE
                                TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" :=
                                  ABS(ROUND(TransferShipmentLine.Quantity * Item."Unit Cost", Currency."Amount Rounding Precision"));
                        END;
                END;
                IF TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" <> 0 THEN
                    TempItemChargeAssgntPurch.INSERT()
                ELSE BEGIN
                    ItemChargeAssgntPurch."Amount to Assign" := 0;
                    ItemChargeAssgntPurch."Qty. to Assign" := 0;
                    ItemChargeAssgntPurch.MODIFY();
                END;
                TotalAppliesToDocLineAmount += TempItemChargeAssgntPurch."Applies-to Doc. Line Amount";
            END;
        UNTIL ItemChargeAssgntPurch.NEXT() = 0;

        IF TempItemChargeAssgntPurch.FINDSET(TRUE) THEN
            REPEAT
                IF lTempItemChargeAssgntPurchInv.GET(
                  TempItemChargeAssgntPurch."Document Type",
                  TempItemChargeAssgntPurch."Document No.",
                  TempItemChargeAssgntPurch."Document Line No.",
                  TempItemChargeAssgntPurch."Line No.")
                THEN BEGIN
                    TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" :=
                      lTempItemChargeAssgntPurchInv."Applies-to Doc. Line Amount";
                    TempItemChargeAssgntPurch."Qty. to Assign" := 0;
                    IF (TotalAppliesToDocLineAmount <> 0) AND (PurchLine.Quantity <> 0) THEN
                        TempItemChargeAssgntPurch."Qty. to Assign" :=
                          TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" / TotalAppliesToDocLineAmount * PurchLine.Quantity + TotalQtyToAssign
                END ELSE BEGIN
                    TempItemChargeAssgntPurch."Qty. to Assign" := 0;
                    IF (TotalAppliesToDocLineAmount <> 0) AND (TotalQtyToAssign <> 0) THEN
                        TempItemChargeAssgntPurch."Qty. to Assign" :=
                          TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" / TotalAppliesToDocLineAmount * TotalQtyToAssign + TotalQtyToAssign
                END;

                ItemChargeAssgntPurch.GET(
                  TempItemChargeAssgntPurch."Document Type",
                  TempItemChargeAssgntPurch."Document No.",
                  TempItemChargeAssgntPurch."Document Line No.",
                  TempItemChargeAssgntPurch."Line No.");
                IF TotalQtyToAssign = 0 THEN BEGIN
                    ItemChargeAssgntPurch."Qty. to Assign" := 0;
                    ItemChargeAssgntPurch."Amount to Assign" := 0;
                    ItemChargeAssgntPurch."Unit Cost" := 0;
                END ELSE BEGIN
                    ItemChargeAssgntPurch."Qty. to Assign" :=
                      ROUND(
                        TempItemChargeAssgntPurch."Applies-to Doc. Line Amount" / TotalAppliesToDocLineAmount * TotalQtyToAssign, 0.00001);

                    ItemChargeAssgntPurch."Amount to Assign" :=
                      ROUND(
                        ItemChargeAssgntPurch."Qty. to Assign" / TotalQtyToAssign * TotalAmtToAssign,
                      Currency."Amount Rounding Precision");

                    ItemChargeAssgntPurch."Unit Cost" :=
                      ROUND(ItemChargeAssgntPurch."Amount to Assign" / ItemChargeAssgntPurch."Qty. to Assign",
                        Currency."Unit-Amount Rounding Precision");

                    TotalQtyToAssign -= ItemChargeAssgntPurch."Qty. to Assign";
                    TotalAmtToAssign -= ItemChargeAssgntPurch."Amount to Assign";
                    TotalAppliesToDocLineAmount -= TempItemChargeAssgntPurch."Applies-to Doc. Line Amount";
                    ItemChargeAssgntPurch.MODIFY();
                END;
            UNTIL TempItemChargeAssgntPurch.NEXT() = 0;
        TempItemChargeAssgntPurch.DELETEALL();
        //<< HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
    end;

    LOCAL procedure AssignEqually(VAR ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; Currency: Record Currency; TotalQtyToAssign: Decimal; TotalAmtToAssign: Decimal; PurchLineItemCharge: Record "Purchase Line")
    var
        lrPurchLine: Record "Purchase Line";
        RemainingNumOfLines: Integer;
        TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary;
    begin
        //>> HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
        REPEAT
            IF (ItemChargeAssgntPurch."Applies-to Doc. Type" <> ItemChargeAssgntPurch."Document Type") AND
               (ItemChargeAssgntPurch."Applies-to Doc. Type".AsInteger() <= ItemChargeAssgntPurch."Applies-to Doc. Type"::"Blanket Order".AsInteger())
            THEN
                lrPurchLine.GET(
                  ItemChargeAssgntPurch."Applies-to Doc. Type",
                  ItemChargeAssgntPurch."Applies-to Doc. No.",
                  ItemChargeAssgntPurch."Applies-to Doc. Line No.");

            IF NOT ItemChargeAssgntPurch.PurchLineInvoiced() OR
               ((lrPurchLine.Quantity = lrPurchLine."Quantity Invoiced") AND (lrPurchLine.Quantity = 0) AND blnCheckFromLineSuspend)
            THEN BEGIN
                TempItemChargeAssgntPurch := ItemChargeAssgntPurch;
                TempItemChargeAssgntPurch.INSERT();
            END;
        UNTIL ItemChargeAssgntPurch.NEXT() = 0;

        IF TempItemChargeAssgntPurch.FINDSET(TRUE) THEN BEGIN
            RemainingNumOfLines := TempItemChargeAssgntPurch.COUNT;
            REPEAT
                ItemChargeAssgntPurch.GET(
                  TempItemChargeAssgntPurch."Document Type",
                  TempItemChargeAssgntPurch."Document No.",
                  TempItemChargeAssgntPurch."Document Line No.",
                  TempItemChargeAssgntPurch."Line No.");
                ItemChargeAssgntPurch."Qty. to Assign" := ROUND(TotalQtyToAssign / RemainingNumOfLines, 0.00001);

                IF (TotalQtyToAssign = 0) OR (TotalAmtToAssign = 0) THEN
                    ItemChargeAssgntPurch."Amount to Assign" := 0
                ELSE
                    ItemChargeAssgntPurch."Amount to Assign" :=
                      ROUND(
                        ItemChargeAssgntPurch."Qty. to Assign" / TotalQtyToAssign * TotalAmtToAssign,
                        Currency."Amount Rounding Precision");

                IF ItemChargeAssgntPurch."Qty. to Assign" = 0 THEN
                    ItemChargeAssgntPurch."Unit Cost" := 0
                ELSE
                    ItemChargeAssgntPurch."Unit Cost" :=
                      ROUND(ItemChargeAssgntPurch."Amount to Assign" / ItemChargeAssgntPurch."Qty. to Assign",
                        Currency."Unit-Amount Rounding Precision");

                TotalQtyToAssign -= ItemChargeAssgntPurch."Qty. to Assign";
                TotalAmtToAssign -= ItemChargeAssgntPurch."Amount to Assign";
                RemainingNumOfLines := RemainingNumOfLines - 1;
                ItemChargeAssgntPurch.MODIFY();
            UNTIL TempItemChargeAssgntPurch.NEXT() = 0;
        END;
        TempItemChargeAssgntPurch.DELETEALL();
        //<< HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
    end;

    procedure CreateTransferShptChargeAssgnt(VAR FromTransShptLine: Record "Transfer Shipment Line"; ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)")
    var
        ItemChargeAssgntPurch2: Record "Item Charge Assignment (Purch)";
        NextLine: Integer;
        CUInsertChargeAssPurch: Codeunit "Item Charge Assgnt. (Purch.)";
    begin
        //>> HEI.03
        NextLine := ItemChargeAssgntPurch."Line No.";
        ItemChargeAssgntPurch2.SETRANGE("Document Type", ItemChargeAssgntPurch."Document Type");
        ItemChargeAssgntPurch2.SETRANGE("Document No.", ItemChargeAssgntPurch."Document No.");
        ItemChargeAssgntPurch2.SETRANGE("Document Line No.", ItemChargeAssgntPurch."Document Line No.");
        ItemChargeAssgntPurch2.SETRANGE(
          "Applies-to Doc. Type", ItemChargeAssgntPurch2."Applies-to Doc. Type"::"Transfer Shipment");
        REPEAT
            ItemChargeAssgntPurch2.SETRANGE("Applies-to Doc. No.", FromTransShptLine."Document No.");
            ItemChargeAssgntPurch2.SETRANGE("Applies-to Doc. Line No.", FromTransShptLine."Line No.");
            IF NOT ItemChargeAssgntPurch2.FINDFIRST() THEN
                CUInsertChargeAssPurch.InsertItemChargeAssignment(ItemChargeAssgntPurch, ItemChargeAssgntPurch2."Applies-to Doc. Type"::"Transfer Shipment",
                  FromTransShptLine."Document No.", FromTransShptLine."Line No.",
                  FromTransShptLine."Item No.", FromTransShptLine.Description, NextLine);
        UNTIL FromTransShptLine.NEXT() = 0;
        //<< HEI.03
    end;

    procedure GetItemUomValues(TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary; VAR DecimalArray: ARRAY[3] OF Decimal)
    var
        PurchLine: Record "Purchase Line";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ReturnRcptLine: Record "Return Receipt Line";
        ReturnShptLine: Record "Return Shipment Line";
        TransferRcptLine: Record "Transfer Receipt Line";
        SalesShptLine: Record "Sales Shipment Line";
        TransferShptLine: Record "Transfer Shipment Line";
    begin
        //>> HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
        CLEAR(DecimalArray);
        CASE TempItemChargeAssgntPurch."Applies-to Doc. Type" OF
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::Order,
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::Invoice,
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Return Order",
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Credit Memo":
                BEGIN
                    PurchLine.GET(TempItemChargeAssgntPurch."Applies-to Doc. Type", TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
                    DecimalArray[1] := PurchLine.Quantity;
                    //DecimalArray[2] := PurchLine.Weight;//Bc Upgrade YADAVM09 Frink it field commented
                    //DecimalArray[3] := PurchLine.Cubage;//Bc Upgrade YADAVM09 Frink it field commented
                END;
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::Receipt:
                BEGIN
                    PurchRcptLine.GET(TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
                    DecimalArray[1] := PurchRcptLine.Quantity;
                    // DecimalArray[2] := PurchRcptLine.Weight;//Bc Upgrade YADAVM09 Frink it field commented
                    //DecimalArray[3] := PurchRcptLine.Cubage;//Bc Upgrade YADAVM09 Frink it field commented
                END;
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Return Receipt":
                BEGIN
                    ReturnRcptLine.GET(TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
                    DecimalArray[1] := ReturnRcptLine.Quantity;
                    //DecimalArray[2] := ReturnRcptLine.Weight;//Bc Upgrade YADAVM09 Frink it field commented
                    //DecimalArray[3] := ReturnRcptLine.Cubage;//Bc Upgrade YADAVM09 Frink it field commented
                END;
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Return Shipment":
                BEGIN
                    ReturnShptLine.GET(TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
                    DecimalArray[1] := ReturnShptLine.Quantity;
                    //DecimalArray[2] := ReturnShptLine.Weight;//Bc Upgrade YADAVM09 Frink it field commented
                    //DecimalArray[3] := ReturnShptLine.Cubage;//Bc Upgrade YADAVM09 Frink it field commented
                END;
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Transfer Shipment":
                BEGIN
                    TransferShptLine.GET(TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
                    DecimalArray[1] := TransferShptLine.Quantity;
                    //DecimalArray[2] := TransferShptLine.Weight;//Bc Upgrade YADAVM09 Frink it field commented
                    //DecimalArray[3] := TransferShptLine.Cubage;//Bc Upgrade YADAVM09 Frink it field commented
                END;
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Transfer Receipt":
                BEGIN
                    TransferRcptLine.GET(TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
                    DecimalArray[1] := TransferRcptLine.Quantity;
                    //DecimalArray[2] := TransferRcptLine.Weight;//Bc Upgrade YADAVM09 Frink it field commented
                    //DecimalArray[3] := TransferRcptLine.Cubage;//Bc Upgrade YADAVM09 Frink it field commented
                END;
            TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Sales Shipment":
                BEGIN
                    SalesShptLine.GET(TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
                    DecimalArray[1] := SalesShptLine.Quantity;
                    //DecimalArray[2] := SalesShptLine.Weight;//Bc Upgrade YADAVM09 Frink it field commented
                    //DecimalArray[3] := SalesShptLine.Cubage;//Bc Upgrade YADAVM09 Frink it field commented
                END;
        END;
        //<< HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019

    end;

    LOCAL procedure AssignByItemWeight(VAR ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; Currency: Record Currency; TotalQtyToAssign: Decimal; PurchLineItemCharge: Record "Purchase Line")
    var
        TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary;
        TotalWeight: Decimal;
        LineAray: array[3] of Decimal;
        QtyRemainder: Decimal;
        AmountRemainder: Decimal;
    begin
        //>>HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
        REPEAT
            IF NOT ItemChargeAssgntPurch.PurchLineInvoiced() THEN BEGIN
                TempItemChargeAssgntPurch.INIT();
                TempItemChargeAssgntPurch := ItemChargeAssgntPurch;
                TempItemChargeAssgntPurch.INSERT();
                GetItemUomValues(TempItemChargeAssgntPurch, LineAray);
                TotalWeight := TotalWeight + (LineAray[2]);
            END;
        UNTIL ItemChargeAssgntPurch.NEXT() = 0;

        IF TempItemChargeAssgntPurch.FINDSET(TRUE) THEN
            REPEAT
                GetItemUomValues(TempItemChargeAssgntPurch, LineAray);
                IF TotalWeight <> 0 THEN
                    TempItemChargeAssgntPurch."Qty. to Assign" :=
                      (TotalQtyToAssign * LineAray[2]) / TotalWeight + QtyRemainder
                ELSE
                    TempItemChargeAssgntPurch."Qty. to Assign" := 0;
                AssignPurchItemCharge(ItemChargeAssgntPurch, TempItemChargeAssgntPurch, Currency, QtyRemainder, AmountRemainder);
            UNTIL TempItemChargeAssgntPurch.NEXT() = 0;
        TempItemChargeAssgntPurch.DELETEALL();
        //<< HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
    end;

    LOCAL procedure AssignByItemCubage(VAR ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; Currency: Record Currency; TotalQtyToAssign: Decimal; PurchLineItemCharge: Record "Purchase Line")
    var
        TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary;
        TotalCubage: Decimal;
        LineAray: array[3] of Decimal;
        QtyRemainder: Decimal;
        AmountRemainder: Decimal;
    begin
        //>> HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
        REPEAT
            IF NOT ItemChargeAssgntPurch.PurchLineInvoiced() THEN BEGIN
                TempItemChargeAssgntPurch.INIT();
                TempItemChargeAssgntPurch := ItemChargeAssgntPurch;
                TempItemChargeAssgntPurch.INSERT();
                GetItemUomValues(TempItemChargeAssgntPurch, LineAray);
                TotalCubage := TotalCubage + (LineAray[3]);
            END;
        UNTIL ItemChargeAssgntPurch.NEXT() = 0;

        IF TempItemChargeAssgntPurch.FINDSET(TRUE) THEN
            REPEAT
                GetItemUomValues(TempItemChargeAssgntPurch, LineAray);
                IF TotalCubage <> 0 THEN
                    TempItemChargeAssgntPurch."Qty. to Assign" :=
                      (TotalQtyToAssign * LineAray[3]) / TotalCubage + QtyRemainder
                ELSE
                    TempItemChargeAssgntPurch."Qty. to Assign" := 0;
                AssignPurchItemCharge(ItemChargeAssgntPurch, TempItemChargeAssgntPurch, Currency, QtyRemainder, AmountRemainder);
            UNTIL TempItemChargeAssgntPurch.NEXT() = 0;
        TempItemChargeAssgntPurch.DELETEALL();
        //<< HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
    end;

    LOCAL procedure AssignByQuantity(VAR ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; Currency: Record Currency; TotalQtyToAssign: Decimal; TotalAmtToAssign: Decimal; PurchLineItemCharge: Record "Purchase Line")
    var
        lrPurchLine: Record "Purchase Line";
        TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary;
        TotalLineQuantity: Decimal;
        LineAray: array[3] of Decimal;
        QtyRemainder: Decimal;
        AmountRemainder: Decimal;
        RoundedQtyRemainder: Decimal;
        QtyToAssign: Decimal;
    begin
        //>> HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
        REPEAT
            IF (ItemChargeAssgntPurch."Applies-to Doc. Type" <> ItemChargeAssgntPurch."Document Type") AND
               (ItemChargeAssgntPurch."Applies-to Doc. Type".AsInteger() <= ItemChargeAssgntPurch."Applies-to Doc. Type"::"Blanket Order".AsInteger())
            THEN
                lrPurchLine.GET(
                  ItemChargeAssgntPurch."Applies-to Doc. Type",
                  ItemChargeAssgntPurch."Applies-to Doc. No.",
                  ItemChargeAssgntPurch."Applies-to Doc. Line No.");

            IF NOT ItemChargeAssgntPurch.PurchLineInvoiced() OR
               ((lrPurchLine.Quantity = lrPurchLine."Quantity Invoiced") AND (lrPurchLine.Quantity = 0) AND blnCheckFromLineSuspend)
            THEN BEGIN
                TempItemChargeAssgntPurch := ItemChargeAssgntPurch;
                TempItemChargeAssgntPurch.INSERT();
                GetItemValues(TempItemChargeAssgntPurch, LineAray);
                TotalLineQuantity := TotalLineQuantity + LineAray[1];
            END;
        UNTIL ItemChargeAssgntPurch.NEXT() = 0;

        IF TempItemChargeAssgntPurch.FINDSET(TRUE) THEN BEGIN
            REPEAT
                ItemChargeAssgntPurch.GET(
                  TempItemChargeAssgntPurch."Document Type",
                  TempItemChargeAssgntPurch."Document No.",
                  TempItemChargeAssgntPurch."Document Line No.",
                  TempItemChargeAssgntPurch."Line No.");

                GetItemValues(TempItemChargeAssgntPurch, LineAray);

                IF (TotalQtyToAssign = 0) OR (TotalLineQuantity = 0) THEN
                    QtyToAssign := 0
                ELSE
                    QtyToAssign := (LineAray[1] / TotalLineQuantity) * TotalQtyToAssign;

                ItemChargeAssgntPurch."Qty. to Assign" := ROUND(QtyToAssign + RoundedQtyRemainder, 0.00001);
                RoundedQtyRemainder := QtyToAssign - ItemChargeAssgntPurch."Qty. to Assign";

                IF (TotalQtyToAssign = 0) OR (TotalAmtToAssign = 0) THEN
                    ItemChargeAssgntPurch."Amount to Assign" := 0
                ELSE
                    ItemChargeAssgntPurch."Amount to Assign" :=
                      ROUND(
                        ItemChargeAssgntPurch."Qty. to Assign" / TotalQtyToAssign * TotalAmtToAssign,
                        Currency."Amount Rounding Precision");

                IF ItemChargeAssgntPurch."Qty. to Assign" = 0 THEN
                    ItemChargeAssgntPurch."Unit Cost" := 0
                ELSE
                    ItemChargeAssgntPurch."Unit Cost" :=
                      ROUND(ItemChargeAssgntPurch."Amount to Assign" / ItemChargeAssgntPurch."Qty. to Assign",
                        Currency."Unit-Amount Rounding Precision");

                ItemChargeAssgntPurch.MODIFY();
            UNTIL TempItemChargeAssgntPurch.NEXT() = 0;
        END;
        TempItemChargeAssgntPurch.DELETEALL();
        //<< HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019

    end;

    procedure SuggestAssgnt3(PurchHeader: Record "Purchase Header"; PurchLine: Record "Purchase Line"; VAR ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; TotalQtyToAssign: Decimal; TotalAmtToAssign: Decimal; Selection: Integer)
    var
        Currency: Record Currency;
    begin
        //>> HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019
        // identical SuggestAssgnt2 within all input/return parameters from/to temporary mode
        //PurchHeader.GET(PurchLine."Document Type",PurchLine."Document No.");
        IF NOT Currency.GET(PurchHeader."Currency Code") THEN
            Currency.InitRoundingPrecision();

        //Currency.SetRoundingPrecisionDrink(PurchLine."Item Charge Type" = PurchLine."Item Charge Type"::Tax, 0);//Bc Upgrade YADAVM09 Drink it field dependency

        ItemChargeAssgntPurch.SETRANGE("Document Type", PurchLine."Document Type");
        ItemChargeAssgntPurch.SETRANGE("Document No.", PurchLine."Document No.");
        ItemChargeAssgntPurch.SETRANGE("Document Line No.", PurchLine."Line No.");

        IF blnAssignParentOnly THEN
            ItemChargeAssgntPurch.SETRANGE("Applies-to Doc. Line No.", PurchLine."Attached to Line No.");

        IF ItemChargeAssgntPurch.FINDFIRST() THEN
            CASE Selection OF
                1:
                    //AssignEqually(ItemChargeAssgntPurch,Currency,TotalQtyToAssign,TotalAmtToAssign);
                    AssignEqually(ItemChargeAssgntPurch, Currency, TotalQtyToAssign, TotalAmtToAssign, PurchLine);
                2:
                    //AssignByAmount(ItemChargeAssgntPurch,Currency,PurchHeader,TotalQtyToAssign,TotalAmtToAssign);
                    AssignByAmount(ItemChargeAssgntPurch, Currency, PurchHeader, TotalQtyToAssign, TotalAmtToAssign, PurchLine);
                3:
                    //AssignByWeight(ItemChargeAssgntPurch,Currency,TotalQtyToAssign);
                    AssignByWeight(ItemChargeAssgntPurch, Currency, TotalQtyToAssign, PurchLine);
                4:
                    //AssignByVolume(ItemChargeAssgntPurch,Currency,TotalQtyToAssign);
                    AssignByVolume(ItemChargeAssgntPurch, Currency, TotalQtyToAssign, PurchLine);
                10:
                    AssignByItemWeight(ItemChargeAssgntPurch, Currency, TotalQtyToAssign, PurchLine);
                11:
                    AssignByItemCubage(ItemChargeAssgntPurch, Currency, TotalQtyToAssign, PurchLine);
                12:
                    AssignByQuantity(ItemChargeAssgntPurch, Currency, TotalQtyToAssign, TotalAmtToAssign, PurchLine);
            END;
    end;
    //<< HEI.01 FDD-HT658 IBM.GUNERE01 16.10.2019


    //Bc Upgrade YADAVM09 Codeunit Item Charge Assgnt. (Purch.)<<


    // BC Upgrade KAPOOV01 Codeunit-1100-Cost Account Mgt >>

    // HEI.01 CHG2146988 IBM POENAB02 18.03.2022 HB2793 Cost Center Auto Alignment Code Optimizations
    //   # Modified functions UpdateCostCenterFromDim, IndentCostCenters
    //BC Upgrade KAPOOV01 27.11.2025 # Created new Codenit to take HEI related customization of Codeunit-1100-Cost Account Mgt specifically created only for one function-UpdateCostCenterFromDim as this funciton is having HEI code and no trigger found in standard BC to take this HEI customization.
    //BC Upgrade KAPOOV01 27.11.2025 # Created new Custom procedure Custom_UpdateCostCenterFromDim for the standard procedure-UpdateCostCenterFromDim to take HEI customization.
    //HEI.01-CD-1100>>
    procedure Custom_UpdateCostCenterFromDim(VAR DimValue: Record "Dimension Value"; VAR xDimValue: Record "Dimension Value"; CallingTrigger: Option OnInsert,OnModify,,OnRename)

    var

        CostCenter: Record "Cost Center";

    begin
        CostAccSetup.GET();
        IF NOT CanUpdate(CostAccSetup."Align Cost Center Dimension", CostAccSetup."Align Cost Center Dimension"::"No Alignment",
             CostAccSetup."Align Cost Center Dimension"::Prompt, DimValue, CostAccSetup."Cost Center Dimension", CallingTrigger,
             CostCenter.TABLECAPTION)
        THEN
            EXIT;

        CASE CallingTrigger OF
            CallingTrigger::OnInsert:
                BEGIN
                    IF CostCenterExists(DimValue.Code) THEN
                        ERROR(Text023, CostCenter.TABLECAPTION, DimValue.Code, CostCenter.TABLECAPTION);
                    InsertCostCenterFromDimValue(DimValue);
                END;
            CallingTrigger::OnModify:
                BEGIN
                    IF NOT CostCenterExists(DimValue.Code) THEN
                        InsertCostCenterFromDimValue(DimValue)
                    ELSE
                        ModifyCostCenterFromDimValue(DimValue);
                END;
            CallingTrigger::OnRename:
                BEGIN
                    IF NOT CostCenterExists(xDimValue.Code) THEN
                        EXIT;
                    IF CostCenterExists(DimValue.Code) THEN
                        ERROR(Text023, DimValue.TABLECAPTION, DimValue.Code, CostCenter.TABLECAPTION);
                    CostCenter.GET(xDimValue.Code);
                    CostCenter.RENAME(DimValue.Code);
                END;
        END;

        //IndentCostCenters;//HEI.01
        MESSAGE(Text017, CostCenter.TABLECAPTION, DimValue.Code);

    end;
    //HEI.01-CD-1100<<

    local procedure CanUpdate(Alignment: Option; NoAligment: Option; PromptAlignment: Option; DimValue: Record "Dimension Value"; DimensionCode: Code[20]; CallingTrigger: Option; TableCaption: Text[80]): Boolean
    var
        myInt: Integer;
    begin
        IF DimValue."Dimension Code" <> DimensionCode THEN
            EXIT(FALSE);
        IF DimValue."Dimension Value Type" IN
           [DimValue."Dimension Value Type"::"Begin-Total", DimValue."Dimension Value Type"::"End-Total"]
        THEN
            EXIT(FALSE);
        CASE Alignment OF
            NoAligment:
                EXIT(FALSE);
            PromptAlignment:
                IF NOT ConfirmUpdate(CallingTrigger, TableCaption, DimValue.Code) THEN
                    EXIT(FALSE);
        END;
        EXIT(TRUE);
    end;

    procedure ConfirmUpdate(CallingTrigger: Option OnInsert,OnModify,,OnRename; TableCaption: Text[80]; Value: Code[20]): Boolean
    var
        myInt: Integer;
    begin
        IF CallingTrigger = CallingTrigger::OnInsert THEN
            EXIT(CONFIRM(Text016, TRUE, TableCaption, Value));
        EXIT(CONFIRM(Text024, TRUE, TableCaption, Value));
    end;

    procedure CostCenterExists(CostCenterCode: Code[20]): Boolean
    var
        CostCenter: Record "Cost Center";
    begin
        EXIT(CostCenter.GET(CostCenterCode));
    end;

    local procedure InsertCostCenterFromDimValue(DimValue: Record "Dimension Value"): Boolean
    var
        CostCenter: Record "Cost Center";
    begin
        CopyDimValueToCostCenter(DimValue, CostCenter);
        EXIT(CostCenter.INSERT());
    end;

    local procedure CopyDimValueToCostCenter(DimValue: Record "Dimension Value"; VAR CostCenter: Record "Cost Center")
    var

    begin
        CostCenter.INIT();
        CostCenter.Code := DimValue.Code;
        CostCenter.Name := DimValue.Name;
        CostCenter."Line Type" := DimValue."Dimension Value Type";
        CostCenter.Blocked := DimValue.Blocked;
    end;

    local procedure ModifyCostCenterFromDimValue(DimValue: Record "Dimension Value"): Boolean
    var
        CostCenter: Record "Cost Center";
    begin
        CostCenter.GET(DimValue.Code);
        CopyDimValueToCostCenter(DimValue, CostCenter);
        EXIT(CostCenter.MODIFY());
    end;


    //BC Upgrade KAPOOV01 Tab-Ext349.Dimension Value #new Event Subscriber function created for Triggers OnInsert(),OnModify(),OnRename() to call custom procedure - Custom_UpdateCostCenterFromDim created inside custom codeunit-Custom_Cost Account Mgt>>

    [EventSubscriber(ObjectType::Table, Database::"Dimension Value", OnBeforeUpdateCostAccFromDim, '', false, false)]
    local procedure OnBeforeUpdateCostAccFromDim(var DimensionValue: Record "Dimension Value"; var xDimensionValue: Record "Dimension Value"; CallingTrigger: Option OnInsert,OnModify,,OnRename; var IsHandled: Boolean)
    var
        CostAccMgt: Codeunit "Cost Account Mgt";
        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";

    begin
        IsHandled := true;
        if CostAccSetup.Get() then begin
            HeinekenBCUpgrade.Custom_UpdateCostCenterFromDim(DimensionValue, xDimensionValue, CallingTrigger);
            CostAccMgt.UpdateCostObjectFromDim(DimensionValue, xDimensionValue, CallingTrigger);
        end;

    end;

    //BC Upgrade KAPOOV01 Tab-Ext349.Dimension Value #new Event Subscriber function created for Triggers OnInsert(),OnModify(),OnRename() to call custom procedure - Custom_UpdateCostCenterFromDim created inside custom codeunit-Custom_Cost Account Mgt<<
    // BC Upgrade KAPOOV01 Codeunit-1100-Cost Account Mgt <<

    // BC Upgrade SHUKLP03 >> codeunit 2 "Company-Initialize"

    //     HEI.01 FDD-AL-HRPGAP01 IBM HORTOC01 20.09.2017
    //     # init new setup table General OpCo Setup
    // HEI.02 IBM HORTOC01 14.02.2018
    //     init table 2034840

    // BC Upgrade SHUKLP03 >>
    // HEI.01 => Subscribed event OnAfterInitSetupTables.
    // HEI.02 => Blocked because of DrinkIT record "Property Service Mgt. Setup".
    // BC Upgrade SHUKLP03 <<

    var
        GeneralOpCoSetup: Record "General OpCo Setup FND";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Company-Initialize", OnAfterInitSetupTables, '', false, false)]
    local procedure OnAfterInitSetupTables()
    begin
        //HEI.01>>
        // WITH GeneralOpCoSetup DO
        IF NOT GeneralOpCoSetup.FINDFIRST() THEN BEGIN
            GeneralOpCoSetup.INIT();
            GeneralOpCoSetup.INSERT();
        END;
        //HEI.01<<

        // BC Upgrade SHUKLP03 >> DrinkIT record "Property Service Mgt. Setup"
        // //HEI.02>>
        // WITH PropertyServiceMgtSetup DO
        //     IF NOT PropertyServiceMgtSetup.FINDFIRST THEN BEGIN
        //         INIT;
        //         INSERT;
        //     END;
        // //HEI.02<<
        // BC Upgrade SHUKLP03 << DrinkIT record "Property Service Mgt. Setup"

    end;

    // BC Upgrade SHUKLP03 << codeunit 2 "Company-Initialize"


    // BC Upgrade SHUKLP03 >> codeunit 91 "Purch.-Post (Yes/No)"

    //     HEI.01 CHG2119178 IBM.AS 30.06.2021
    //   # HeiLite Base Stability Changes for Posting functions at JOB NAS
    //   # Adding GUIAllowed function added in Functions Code() for JOB Execution to avoid any manual intervention
    // HEI.02 FDD-HB2989 CHG2162714 IBM SRVAS07 17-10- 2022 - Restrict users not to receive items without warehouse documents
    //   # When user tries to post receipt from Purchase Order screen(Card or list) system will check all the item lines whose “Qty to Receive“ is not zero and will pop error to remind the user to create Warehouse Receipt

    // BC Upgrade SHUKLP03 >>
    // HEI.01 => Subscribed event OnBeforeConfirmPostProcedure to add code and also added procedures SelectPostOrderOption, SelectPostReturnOrderOption and events OnBeforeSelectPostOrderOption, OnBeforeSelectPostReturnOrderOption.
    // HEI.01 => code of LOCAL procedure Code() is not added because code is added in between DrinkIT code.
    // HEI.03 => Procedure PreviewSRMInterface() shared with Sakshi.
    // HEI.02=> Subscribed event OnAfterConfirmPost
    // BC Upgrade SHUKLP03 <<
    //BC UPGRADE ATHUKS01 FDDSTP006_GAP11>>
    //1.While posting the Purchase Order, the system was displaying a menu confirmation prompt, which is not part of the behavior in Navision.
    //Yes/No confirmation prompt required The same functionality was observed here due to a custom event trigger. Since this prompt is not required, the corresponding event code has been commented
    //2.Added new event code for yes/No prompt message in Purchase Order & Purchase Return order.
    //BC UPGRADE ATHUKS01 FDDSTP006_GAP11<<


    //BC UPGRADE ATHUKS01 FDDSTP006_GAP11>>
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", OnBeforeConfirmPostProcedure, '', false, false)]
    // local procedure OnBeforeConfirmPostProcedure(var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header"; var DefaultOption: Integer; var Result: Boolean)
    // var
    //     PostingSelectionManagement: Codeunit "Posting Selection Management";
    // begin
    //     case PurchaseHeader."Document Type" of
    //         PurchaseHeader."Document Type"::Order:
    //             if not SelectPostOrderOption(PurchaseHeader, DefaultOption) then
    //                 Result := false;
    //         PurchaseHeader."Document Type"::"Return Order":
    //             if not SelectPostReturnOrderOption(PurchaseHeader, DefaultOption) then
    //                 Result := false;
    //         else
    //         //<<HEI.01
    //         BEGIN
    //             IF GUIALLOWED THEN BEGIN
    //                 //>>HEI.01
    //                 if not PostingSelectionManagement.ConfirmPostPurchaseDocument(PurchaseHeader, DefaultOption, false, false) then
    //                     Result := false;
    //                 //<<HEI.01
    //             END;
    //         END;
    //     //>>HEI.01
    //     end;
    //     PurchaseHeader."Print Posted Documents" := false;
    //     Result := true;
    //     IsHandled := True;
    // end;
    //BC UPGRADE ATHUKS01 FDDSTP006_GAP11<<

    local procedure SelectPostOrderOption(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer) Result: Boolean
    var
        PostingSelectionManagement: Codeunit "Posting Selection Management";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeSelectPostOrderOption(PurchaseHeader, DefaultOption, Result, IsHandled);
        if IsHandled then
            exit(Result);

        Result := PostingSelectionManagement.ConfirmPostPurchaseDocument(PurchaseHeader, DefaultOption, false, false);
        exit(Result);
    end;

    local procedure SelectPostReturnOrderOption(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer) Result: Boolean
    var
        PostingSelectionManagement: Codeunit "Posting Selection Management";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeSelectPostReturnOrderOption(PurchaseHeader, DefaultOption, Result, IsHandled);
        if IsHandled then
            exit(Result);

        Result := PostingSelectionManagement.ConfirmPostPurchaseDocument(PurchaseHeader, DefaultOption, false, false);
        exit(Result);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSelectPostOrderOption(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSelectPostReturnOrderOption(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    //BC UPGRADE ATHUKS01 FDDSTP006_GAP11<<
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", OnBeforeSelectPostOrderOption, '', false, false)]
    local procedure PurchPostYN_OnBeforeSelectPostOrderOption(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        RecMsg: Label 'Do you want to receive the %1 ?';
    begin
        IsHandled := true;
        IF not Confirm(RecMsg, FALSE, PurchaseHeader."Document Type") THEN
            exit;
        PurchaseHeader.Receive := TRUE;
        PurchaseHeader.Invoice := FALSE;
        Result := PurchaseHeader.Receive;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", OnBeforeSelectPostReturnOrderOption, '', false, false)]
    local procedure PurchPostYN_OnBeforeSelectPostReturnOrderOption(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        PoShpMsg: Label 'Do you want to ship the %1 ?';
    begin
        IsHandled := true;
        IF not Confirm(PoShpMsg, FALSE, PurchaseHeader."Document Type") THEN
            exit;
        PurchaseHeader.Ship := TRUE;
        PurchaseHeader.Invoice := FALSE;
        Result := PurchaseHeader.Ship;
    end;
    //BC UPGRADE ATHUKS01 FDDSTP006_GAP11<<

    //BC UPGRADE ATHUKUS01 FDDSTP_007 >>
    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Line", OnBeforeInsertInvLineFromRcptLine, '', false, false)]
    local procedure PurchRcpLine_OnBeforeInsertInvLineFromRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchLine: Record "Purchase Line"; PurchOrderLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        PurchLine."Order No." := PurchRcptLine."Order No.";
        PurchLine."Order Line No." := PurchRcptLine."Order Line No.";
        PurchLine."Original Quantity FND" := PurchOrderLine.Quantity;
    end;
    //BC UPGRADE ATHUKUS01 FDDSTP_007 <<

    //BC UPGRADE ATHUKUS01 FDDSTP_008 <<
    [EventSubscriber(ObjectType::Table, Database::"Return Shipment Line", OnBeforeInsertInvLineFromRetShptLine, '', false, false)]
    local procedure ReturnShipmentLine_OnBeforeInsertInvLineFromRetShptLine(var PurchLine: Record "Purchase Line"; var PurchOrderLine: Record "Purchase Line"; var ReturnShipmentLine: Record "Return Shipment Line"; var IsHandled: Boolean; var NextLineNo: Integer)
    begin
        PurchLine."Original Quantity FND" := PurchOrderLine.Quantity;
        PurchLine."Order No." := ReturnShipmentLine."Return Order No.";
        PurchLine."Order Line No." := ReturnShipmentLine."Return Order Line No.";
    end;
    //BC UPGRADE ATHUKUS01 FDDSTP_008 >> 

    //BC UPGRADE ATHUKUS01 FDDSTP_008 >> 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", OnCopyPurchHeaderFromPostedInvoiceOnBeforeTransferFields, '', false, false)]
    local procedure CopyDocumentMgtOnCopyPurchHeaderFromPostedInvoiceOnBeforeTransferFields(var ToPurchaseHeader: Record "Purchase Header"; OldPurchaseHeader: Record "Purchase Header"; FromPurchInvHeader: Record "Purch. Inv. Header")
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup.ShouldDocumentTotalAmountsBeChecked(ToPurchaseHeader) then begin
            FromPurchInvHeader.CalcFields("Amount Including VAT", Amount);
            ToPurchaseHeader.Validate("Doc. Amount Incl. VAT IBM FND", FromPurchInvHeader."Amount Including VAT");
            ToPurchaseHeader.Validate("Doc. Amount VAT IBM FND", FromPurchInvHeader."Amount Including VAT" - FromPurchInvHeader.Amount);
        end;

    end;
    //BC UPGRADE ATHUKUS01 FDDSTP_008 <<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", OnAfterConfirmPost, '', false, false)]
    local procedure OnAfterConfirmPost(var PurchaseHeader: Record "Purchase Header")
    var
        PurchSetup: Record "Purchases & Payables Setup";
        PurchPostViaJobQueue: Codeunit "Purchase Post via Job Queue";
        PurchaseLine: Record "Purchase Line";
        Location: Record Location;
        WarehouseReceiptError: TextConst ENU = 'Warehouse Receipt must be created and posted for Line No. %1 of Item %2.';
    begin
        //>>HEI.02
        IF PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::Order] THEN BEGIN
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
            PurchaseLine.SETRANGE("Receipt No.", '');
            PurchaseLine.SETRANGE("Receipt Line No.", 0);
            PurchaseLine.SETFILTER("Qty. to Receive", '<>%1', 0);
            IF PurchaseLine.FINDFIRST() THEN
                REPEAT
                    PurchaseLine.TESTFIELD("Location Code");
                    Location.GET(PurchaseLine."Location Code");
                    IF Location."Require Receive" THEN
                        ERROR(WarehouseReceiptError, PurchaseLine."Line No.", PurchaseLine."No.");
                UNTIL PurchaseLine.NEXT() = 0;
        END;
        //<<HEI.02
    end;

    // BC Upgrade SHUKLP03 << codeunit 91 "Purch.-Post (Yes/No)"


    // BC Upgrade SHUKLP03 >> codeunit 19 "Gen. Jnl.-Post Preview"

    // HEI.02 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //    #Function Added #PreviewLevytaxentries

    // BC Upgrade SHUKLP03 >>
    // HEI.01 => Procedure PreviewSRMInterface() shared with Sakshi
    // HEI.02 => Created procedure RunPreview() and event OnRunPreview for procedures PreviewSRMInterface() and PreviewLevytaxentries().
    // BC Upgrade SHUKLP03 <<

    var
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
        PostingPreviewEventHandler: Codeunit "Posting Preview Event Handler";
        NothingToPostMsg: TextConst ENU = 'There is nothing to post.', FRA = 'Il ny a rien à valider.';
        PreviewModeErr: TextConst ENU = 'Preview mode.', FRA = 'Mode Aperçu.';
        SubscriberTypeErr: TextConst ENU = 'Invalid Subscriber type. The type must be CODEUNIT.', FRA = 'Type abonné non valide. Le type doit être CODEUNIT.';
        RecVarTypeErr: TextConst ENU = 'Invalid RecVar type. The type must be RECORD.', FRA = 'Type RecVar non valide. Le type doit être RECORD.';
        PreviewExitStateErr: TextConst ENU = 'The posting preview has stopped because of a state that is not valid.', FRA = 'Laperçu de la validation a cessé en raison dun état non valide.';


    // Procedure PreviewLevytaxentries(Subscriber: Variant; RecVar: Variant)
    // var
    //     RunResult: Boolean;
    // begin
    //     //HEI.02>>
    //     IF NOT Subscriber.ISCODEUNIT THEN
    //         ERROR(SubscriberTypeErr);
    //     IF NOT RecVar.ISRECORD THEN
    //         ERROR(RecVarTypeErr);

    //     BINDSUBSCRIPTION(PostingPreviewEventHandler);

    //     RunResult := RunPreview(Subscriber, RecVar);

    //     UNBINDSUBSCRIPTION(PostingPreviewEventHandler);
    //     IF RunResult OR (GETLASTERRORCALLSTACK = '') THEN
    //         ERROR(PreviewExitStateErr);

    //     IF GETLASTERRORTEXT <> PreviewModeErr THEN
    //         ERROR(GETLASTERRORTEXT);
    //     //HEI.02<<
    // end;//Bc Upgrade YADAVM09 code not required anymore<<

    procedure RunPreview(Subscriber: Variant; RecVar: Variant): Boolean
    var
        Result: Boolean;
    begin
        OnRunPreview(Result, Subscriber, RecVar);
        exit(Result);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRunPreview(var Result: Boolean; Subscriber: Variant; RecVar: Variant)
    begin
    end;

    // BC Upgrade SHUKLP03 << codeunit 19 "Gen. Jnl.-Post Preview"


    // BC Upgrade SHUKLP03 >> codeunit 113 "Vend. Entry-Edit"

    // HEI.01, defect #1438 POSTOI01, 02.02.2018
    // HEI.02 CHG2064806 IBM GUNERE01 24.04.2020 # OnRun func. modified

    // BC Upgrade SHUKLP03 >>
    // HEI.01, HEI.02 => Subscribed event OnBeforeVendLedgEntryModify.

    // BC Upgrade SHUKLP03 <<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Vend. Entry-Edit", OnBeforeVendLedgEntryModify, '', false, false)]
    local procedure OnBeforeVendLedgEntryModify(FromVendLedgEntry: Record "Vendor Ledger Entry"; var VendLedgEntry: Record "Vendor Ledger Entry")
    begin
        VendLedgEntry.VALIDATE("Payment Status FND", FromVendLedgEntry."Payment Status FND");//SOICAD01

        //>>HEI.01
        VendLedgEntry.VALIDATE("Reason Code", FromVendLedgEntry."Reason Code");
        VendLedgEntry.VALIDATE("Vendor Bank Account FND", FromVendLedgEntry."Vendor Bank Account FND");
        //<<HEI.01
        //>> HEI.02
        VendLedgEntry.VALIDATE("WHT Certificate No FND", FromVendLedgEntry."WHT Certificate No FND");
        VendLedgEntry.VALIDATE("WHT Certificate Date FND", FromVendLedgEntry."WHT Certificate Date FND");
        //<< HEI.02
    end;

    // BC Upgrade SHUKLP03 << codeunit 113 "Vend. Entry-Edit"


    // BC Upgrade SHUKLP03 >> codeunit 227 "VendEntry-Apply Posted Entries"

    //     HEI.01 CHG2052196 IBM.PANDES01 20.10.2020
    // # Added code for Void check ledger entry.
    // HEI.02 CHG2213062 IBM NANDIS01 20.07.2023 Issue on application of payment and invoice
    //   # Analysis on VLE Application Issue against INC4335274
    //   # commit will trigger if the codeunit runs successfully in function - ApplyVendEntryFormEntry

    // BC Upgrade SHUKLP03 >>
    // HEI.02 => Subscribed event OnBeforeApplyVendEntryFormEntry to add code also created procedure RunApplyVendEntries() and events OnApplyVendEntryFormEntryOnBeforeRunVendEntryEdit, OnApplyVendEntryFormEntryOnAfterVendLedgEntrySetFilters,OnApplyVendEntryFormEntryOnAfterCheckEntryOpen
    // HEI.01 => Added procedure UnApplyVendLedgEntryforcheck() and updated code 
    // BC Upgrade SHUKLP03 <<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"VendEntry-Apply Posted Entries", OnBeforeApplyVendEntryFormEntry, '', false, false)]
    local procedure OnBeforeApplyVendEntryFormEntry(var ApplyingVendLedgEntry: Record "Vendor Ledger Entry"; var IsHandled: Boolean)
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        ApplyVendEntries: Page "Apply Vendor Entries";
        VendEntryApplID: Code[50];
        CannotApplyClosedEntriesErr: Label 'One or more of the entries that you selected is closed. You cannot apply closed entries.';
        GLSetup: Record "General Ledger Setup";
    begin
        if not ApplyingVendLedgEntry.Open then
            Error(CannotApplyClosedEntriesErr);

        OnApplyVendEntryFormEntryOnAfterCheckEntryOpen(ApplyingVendLedgEntry);

        VendEntryApplID := UserId;
        if VendEntryApplID = '' then
            VendEntryApplID := '***';
        if ApplyingVendLedgEntry."Remaining Amount" = 0 then
            ApplyingVendLedgEntry.CalcFields("Remaining Amount");

        ApplyingVendLedgEntry."Applying Entry" := true;
        if ApplyingVendLedgEntry."Applies-to ID" = '' then
            ApplyingVendLedgEntry."Applies-to ID" := VendEntryApplID;
        ApplyingVendLedgEntry."Amount to Apply" := ApplyingVendLedgEntry."Remaining Amount";
        OnApplyVendEntryFormEntryOnBeforeRunVendEntryEdit(ApplyingVendLedgEntry);
        //CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",ApplyingVendLedgEntry);  //HEI.02
        IF CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", ApplyingVendLedgEntry) THEN // HEI.02
            Commit();

        VendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
        VendLedgEntry.SetRange("Vendor No.", ApplyingVendLedgEntry."Vendor No.");
        VendLedgEntry.SetRange(Open, true);
        RunApplyVendEntries(VendLedgEntry, ApplyingVendLedgEntry, VendEntryApplID);
        IsHandled := TRUE;
    end;

    local procedure RunApplyVendEntries(var VendLedgEntry: Record "Vendor Ledger Entry"; var ApplyingVendLedgEntry: Record "Vendor Ledger Entry"; VendEntryApplID: Code[50])
    var
        ApplyVendEntries: Page "Apply Vendor Entries";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnApplyVendEntryFormEntryOnAfterVendLedgEntrySetFilters(VendLedgEntry, ApplyingVendLedgEntry, IsHandled, VendEntryApplID);
        if IsHandled then
            exit;

        if VendLedgEntry.FindFirst() then begin
            ApplyVendEntries.SetVendLedgEntry(ApplyingVendLedgEntry);
            ApplyVendEntries.SetRecord(VendLedgEntry);
            ApplyVendEntries.SetTableView(VendLedgEntry);
            if ApplyingVendLedgEntry."Applies-to ID" <> VendEntryApplID then
                ApplyVendEntries.SetAppliesToID(ApplyingVendLedgEntry."Applies-to ID");
            ApplyVendEntries.RunModal();
            Clear(ApplyVendEntries);
            ApplyingVendLedgEntry."Applying Entry" := false;
            ApplyingVendLedgEntry."Applies-to ID" := '';
            ApplyingVendLedgEntry."Amount to Apply" := 0;
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnApplyVendEntryFormEntryOnBeforeRunVendEntryEdit(var ApplyingVendLedgEntry: Record "Vendor Ledger Entry");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnApplyVendEntryFormEntryOnAfterVendLedgEntrySetFilters(var VendorLedgEntry: Record "Vendor Ledger Entry"; var ApplyToVendLedgEntry: Record "Vendor Ledger Entry"; var IsHandled: Boolean; var VendEntryApplID: Code[50]);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnApplyVendEntryFormEntryOnAfterCheckEntryOpen(ApplyingVendLedgEntry: Record "Vendor Ledger Entry");
    begin
    end;

    procedure UnApplyVendLedgEntryforcheck(VendLedgEntryNo: Integer)
    var
        VendEtyApplyPE: Codeunit "VendEntry-Apply Posted Entries";
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        ApplicationEntryNo: Integer;
        ApplyUnapplyParameters: Record "Apply Unapply Parameters" temporary;
        NoApplicationEntryErr: TextConst ENU = 'Vendor Ledger Entry No. %1 does not have an application entry.';
    begin
        //>>Hei.01
        VendEtyApplyPE.CheckReversal(VendLedgEntryNo);
        ApplicationEntryNo := VendEtyApplyPE.FindLastApplEntry(VendLedgEntryNo);
        IF ApplicationEntryNo = 0 THEN
            ERROR(NoApplicationEntryErr, VendLedgEntryNo);
        DtldVendLedgEntry.GET(ApplicationEntryNo);

        // BC Upgrade SHUKLP03 >>
        ApplyUnapplyParameters.init();
        ApplyUnapplyParameters."Document No." := DtldVendLedgEntry."Document No.";
        ApplyUnapplyParameters."Posting Date" := DtldVendLedgEntry."Posting Date";
        //end;
        //UnApplyVendor(DtldVendLedgEntry);
        VendEtyApplyPE.PostUnApplyVendor(DtldVendLedgEntry, ApplyUnapplyParameters); // BC Upgrade SHUKLP03 << Parameter of procedure PostUnApplyVendor() is changed from Nav-PostUnApplyVendor(DtldVendLedgEntry2 : Record "Detailed Vendor Ledg. Entry";DocNo : Code[20];PostingDate : Date) to BC PostUnApplyVendor(DtldVendLedgEntry, ApplyUnapplyParameters)
        // BC Upgrade SHUKLP03 <<
        //<<Hei.01
    end;

    // BC Upgrade SHUKLP03 << codeunit 227 "VendEntry-Apply Posted Entries"


    // DITW15.00.00.33 DDR 13/05/2009 Added fields "Item DTax Group Code","Src. DTax Group Code"
    // DITW15.00.00.35 DLE 06/09/2009 issue 516 Added field "Physical Location Group Code" to copy into lines
    // DITW15.00.00.37 DDR 10/06/2010 issue 1061 Added functions GetLast2ShptLine(),GetLast2RcptLine(),GetLocation()
    //                                           Added to fill in field "Physical Location Group Code"
    // DITW15.00.00.39 DDR 12/04/2011 issue 1296 Added AAD/ARC fields into functions
    //                     06/05/2011 issue 1296 Added to update EDI inbox if ARC already exists into source document
    //                     04/08/2011 issue 1396 Added transfer field "Applies-to AAD Trck. Entry No."
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields "Delivery Sequence","Route"
    //                     02/01/2012 DIT-715 issue 185 Added fields "Attached to Line No."
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM

    // DITW17.00.01 DDR 14/04/2013 DIT-770 #071 Bugfix functions FromPurchLine2ShptLine()
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #623 New Customer Exception Tax Group functionality
    //                                          Read "Cust Dtax Group Code" Sales lines
    // DITW17.10.05 MSF 17/07/2014 DIT-770 #698 (Customer)Vendor suspended tax determined per document line + internal
    //                                          Read "Vendor Dtax Group Code" Purchase lines

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added Fields
    //                                "Require 2 Drivers"
    //                                "Driver 2 Code"
    //                                 Route
    //                                "Route Planning No."
    //                                 Trailer Code
    // DITW110.00.11 VSC 06/10/2017 NRQ#33755 Copy Backorder type from SourceLine Sales Order
    // HEI.02 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    //   # code added
    // HEI.03 FDD LOGGAP08 IBM POSTOI01 30.05.2018
    //   # code added
    // HEI.04 FDD INC2088101 IBM ISYED01 03.28.2019 #Zone Code is not appearing on the Warehouse Shipment Lines.
    //   # code added to fix the issue to flow zone based on Bin code.
    // HEI.05 CHG2095415 IBM BULIMC01 21.03.2021#new code added to populate Item Category Code and RPM fields
    // HEI.06 CHG2155847 HB2821 IBM NANDIS01 24.11.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Flow Astro Unique ID to warehs recpt line
    // HEI.07 CHG2204926 COSTES04 16.05.2023 Populated zone code when creating warehouse receipt from sales return order
    //   # Validate Bin Code
    // HEI.08 CHG2217161 SAHAL01 02.11.2023 SPL for Returns and GR cancellations
    //   # Added Code to flow SPL details.
    // HEI.09 CC CHG2226741 BHANDS01 12.03.2024 Blank Return Reason
    //   # Fix from Aptean(Norriq)
    //   # DIT396747 EZOGHLAMI 13/02/2024 copy return reason code to wearhouse receipt line
    //   # Code added in function SalesLine2ReceiptLine()

    //Bc Upgrade YADAVM09 function CreateShptLineFromSalesLine code //HEI.04 and //HEI.02 added in event OnBeforeCreateShptLineFromSalesLine.
    //Bc Upgrade YADAVM09 for function SalesLine2ReceiptLine code added in event OnBeforeCreateReceiptLineFromSalesLine.
    //Bc Upgrade YADAVM09 for function FromPurchLine2ShptLine code added in event OnFromPurchLine2ShptLineOnBeforeCreateShptLine.
    //Bc Upgrade YADAVM09 for function PurchLine2ReceiptLine code added in event OnPurchLine2ReceiptLineOnAfterSetQtysOnRcptLine.
    //Bc Upgrade YADAVM09 for function FromTransline2Shptline code added in event OnBeforeCreateShptLineFromTransLine.
    //Bc Upgrade YADAVM09 for function TransLine2ReceiptLine code added in event OnBeforeUpdateRcptLineFromTransLine.
    //Bc Upgrade YADAVM09 for function CreateShptLine code added in event OnBeforeWhseShptLineInsert.
    //Bc Upgrade YADAVM09 for function CreateShptLine //HEI.01 code is already in base.

    //Bc Upgrade YADAVM09 codeunit 5750 "Whse.-Create Source Document" >>
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales Warehouse Mgt.", 'OnBeforeCreateShptLineFromSalesLine', '', true, true)]
    local procedure OnBeforeCreateShptLineFromSalesLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
    begin
        //IF WarehouseShipmentLine."Bin Code" = '' THEN BEGIN // BC Upgrade YADAVM09 [This code is added here beacuse if we call event OnCreateShptLineFromSalesLineOnBeforeGetSalesHeader then there are couple of internal functions calling from the Codeunit "Whse.-Create Source Document" and if we want to write this code on funtion UpdateShipmentLine in codeunit "Whse.-Create Source Document" then we didn't have the value of Rec Sales Line.
        IF WarehouseShipmentHeader."Bin Code" = '' THEN BEGIN // BC Upgrade YADAVM09
            //HEI.04>>
            //"Bin Code" := SalesLine."Bin Code";
            IF SalesLine."Bin Code" <> '' THEN
                WarehouseShipmentLine.VALIDATE("Bin Code", SalesLine."Bin Code");
        END;
        //HEI.04<<
        //HEI.02>>
        WarehouseShipmentLine."RPM Solution FND" := SalesLine."RPM Solution FND";
        WarehouseShipmentLine."RPM Type FND" := SalesLine."RPM Type FND";
        WarehouseShipmentLine."Item Type FND" := SalesLine."Item Type FND";
        //HEI.02<<
        WarehouseShipmentLine."Item Category Code FND" := SalesLine."Item Category Code"; //HEI.05
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales Warehouse Mgt.", 'OnBeforeCreateReceiptLineFromSalesLine', '', true, true)]
    local procedure OnBeforeCreateReceiptLineFromSalesLine(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; SalesLine: Record "Sales Line")
    var
    begin
        //HEI.07>>
        //IF WarehouseReceiptLine."Bin Code" = '' THEN BEGIN // BC Upgrade YADAVM09 [This code is added here beacuse if we call event OnBeforeSalesLine2ReceiptLine then there are couple of internal functions called from the Codeunit "Whse.-Create Source Document" and if we want to write this code on funtion UpdateReceiptLine in codeunit "Whse.-Create Source Document" then we didn't have the value of Rec Sales Line.
        IF WarehouseReceiptHeader."Bin Code" = '' THEN BEGIN // BC Upgrade YADAVM09
            WarehouseReceiptLine."Bin Code" := SalesLine."Bin Code";
            IF SalesLine."Bin Code" <> '' THEN
                WarehouseReceiptLine.VALIDATE("Bin Code", SalesLine."Bin Code");
        end;
        //HEI.07<<
        //Hei.02>>
        WarehouseReceiptLine."Item Type FND" := SalesLine."Item Type FND";
        WarehouseReceiptLine."RPM Solution FND" := SalesLine."RPM Solution FND";
        WarehouseReceiptLine."RPM Type FND" := SalesLine."RPM Type FND";
        //HEi.02<<
        //HEI.03>>
        WarehouseReceiptLine."Source Original Quantity FND" := SalesLine.Quantity;
        //HEI.03<<

        WarehouseReceiptLine."Item Category Code FND" := SalesLine."Item Category Code"; //HEI.05

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Purchases Warehouse Mgt.", 'OnFromPurchLine2ShptLineOnBeforeCreateShptLine', '', true, true)]
    local procedure OnFromPurchLine2ShptLineOnBeforeCreateShptLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; PurchaseLine: Record "Purchase Line")
    var
    begin
        WarehouseShipmentLine."Item Category Code FND" := PurchaseLine."Item Category Code"; //HEI.05
        //HEI.08>>
        WarehouseShipmentLine."SPL Code FND" := PurchaseLine."SPL Code FND";
        WarehouseShipmentLine."SPL Name FND" := PurchaseLine."SPL Name FND";
        //HEI.08<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Purchases Warehouse Mgt.", 'OnPurchLine2ReceiptLineOnAfterSetQtysOnRcptLine', '', true, true)]
    local procedure OnPurchLine2ReceiptLineOnAfterSetQtysOnRcptLine(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; PurchaseLine: Record "Purchase Line")
    var
    begin
        //HEI.03>>
        WarehouseReceiptLine."Source Original Quantity FND" := PurchaseLine.Quantity;
        //HEI.03<<
        WarehouseReceiptLine."Item Category Code FND" := PurchaseLine."Item Category Code"; //HEI.05
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Transfer Warehouse Mgt.", 'OnBeforeCreateShptLineFromTransLine', '', true, true)]
    local procedure OnBeforeCreateShptLineFromTransLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; TransferLine: Record "Transfer Line"; TransferHeader: Record "Transfer Header")
    var
    begin
        //HEI.05>>
        WarehouseShipmentLine."RPM Solution FND" := TransferLine."RPM Solution FND";
        WarehouseShipmentLine."RPM Type FND" := TransferLine."RPM Type FND";
        WarehouseShipmentLine."Item Type FND" := TransferLine."Item Type FND";
        WarehouseShipmentLine."Item Category Code FND" := TransferLine."Item Category Code"; //HEI.05
                                                                                             //HEI.05<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Transfer Warehouse Mgt.", 'OnBeforeUpdateRcptLineFromTransLine', '', true, true)]
    local procedure OnBeforeUpdateRcptLineFromTransLine(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; TransferLine: Record "Transfer Line")
    var
    begin
        WarehouseReceiptLine."Item Category Code FND" := TransferLine."Item Category Code"; //HEI.05
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Whse.-Create Source Document", 'OnBeforeWhseShptLineInsert', '', true, true)]
    local procedure OnBeforeWhseShptLineInsert(var WarehouseShipmentLine: Record "Warehouse Shipment Line")
    var
        Item: Record Item;
    begin
        Item.ItemSKUGet(Item, WarehouseShipmentLine."Location Code", WarehouseShipmentLine."Variant Code");
        WarehouseShipmentLine."Item Category Code FND" := Item."Item Category Code"; //HEI.05
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Whse.-Create Source Document", 'OnBeforeUpdateShptLine', '', true, true)]
    local procedure OnBeforeUpdateShptLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var IsHandled: Boolean)
    var
    begin
        //HEI.01>>
        IF WarehouseShipmentHeader."Zone Code" <> '' THEN
            WarehouseShipmentLine.VALIDATE("Zone Code", WarehouseShipmentHeader."Zone Code");
        //HEI.01<<
        if WarehouseShipmentHeader."Zone Code" <> '' then
            WarehouseShipmentLine.Validate("Zone Code", WarehouseShipmentHeader."Zone Code");
        if WarehouseShipmentHeader."Bin Code" <> '' then
            WarehouseShipmentLine.Validate("Bin Code", WarehouseShipmentHeader."Bin Code");
        IsHandled := true;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInitNewWhseShptLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; SalesLine: Record "Sales Line"; AssembleToOrder: Boolean; var WhseShptLineQty: Decimal; var WhseShptLineQtyBase: Decimal; var IsHandled: Boolean; var Return: Boolean)
    begin
    end;
    //Bc Upgrade YADAVM09 codeunit 5750 "Whse.-Create Source Document" <<



    // BC Upgrade SHUKLP03 >> codeunit 358 "DateFilter-Calc"
    procedure VerifiyDateFilter(Filter: Text[30])
    begin
        IF Filter = ',,,' THEN
            ERROR(Text10800);

    end;

    procedure ReturnEndingPeriod(StartPeriod: Date; PeriodType: Option "Date","Week","Month","Quarter","Year"): Date
    var
        PeriodDate: Record Date;
    begin
        PeriodDate.SETRANGE("Period Type", PeriodType);
        PeriodDate.SETRANGE("Period Start", StartPeriod);
        IF PeriodDate.FIND('-') THEN
            EXIT(PeriodDate."Period End")
        ELSE
            EXIT(0D);
    end;

    procedure VerifMonthPeriod(Filter: Text[30])
    var
        Date: Record Date;
        FilterDate: Date;
        FilterPos: Integer;
    begin
        //HEI.02>>
        IF COPYSTR(Filter, STRLEN(Filter) - 1, 2) = '..' THEN
            EXIT;
        // Begin Check
        FilterPos := STRPOS(Filter, '..');

        IF FilterPos = 0 THEN
            ERROR(DateInsteadOfPeriodErr);

        EVALUATE(FilterDate, COPYSTR(Filter, 1, FilterPos - 1));
        Date.SETRANGE("Period Type", Date."Period Type"::Month);
        Date.SETRANGE(Date."Period Start", FilterDate);
        IF NOT Date.FIND('-') THEN
            ERROR(Text10801);

        Date.RESET();
        // Ending check
        IF FilterPos <> 0 THEN BEGIN
            EVALUATE(FilterDate, COPYSTR(Filter, FilterPos + 2, 8));
            Date.SETRANGE("Period Type", Date."Period Type"::Month);
            Date.SETRANGE(Date."Period End", CLOSINGDATE(FilterDate));
            IF NOT Date.FIND('-') THEN
                ERROR(Text10802);
        END;
        //HEI.02<<
    end;

    // BC Upgrade SHUKLP03 << codeunit 358 "DateFilter-Calc"

    // BC Upgrade YADAVM09 << codeunit "Inventory Posting to G/L - id - 5802 >>
    // DITW15.00.00.01 DDR 29/01/2008 Added function GetGLReg(),SetGLReg()
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.35 DDR 07/08/2009 issue 757 remove call function SetGLReg()
    // DITW16.00.00.40 - PRODW16.00.00.08.19 DDR 17/01/2012 DIT-715 #189
    // Modified function to Allow WIP Acc. from components (or other)
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7

    // HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 19.12.2018 # Counterpoint Interface
    //   # When Counterpoint Purchases and RTV's are posted "Purchase Account" needs to be used instead of "Direct Cost Applied Account"
    //   # "Interface Code" and "CP Vendor Invoice No." should flow to GL Entry
    // HEI.02 RFC-CHG0270789 IBM.LS 19.02.2019
    //   # Code added to calculate the Output for correct Account.
    // HEI.03 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # VAT Centime - part 2 - Purchases
    //   # Code added
    // HEI.04 CHG2131424 IBM SISUM01 01/05/2023 HB2520 Dimension Validation HeiLite
    //   # Code change to skip dimension combination validation if the entry is created from Sales document and if the setup is true
    // HEI.05 CHG2187702 SAHAL01 18.09.2023 Revaluation journal items in error
    //   # Added Code

    //Bc Upgrade YADAVM09 //HEI.05 added on Subscriber OnBeforeBufferInvtPosting.
    //Bc Upgrade YADAVM09 for Function SetAccNo //HEI.05 OnBeforeGetInvtPostSetup is subscribed.
    //Bc Upgrade YADAVM09 OnAfterSetRunOnlyCheck event is subscribed to get the value of variable CalledFromItemPosting,Calledfromtestreport.
    //Bc Upgrade YADAVM09 for Function SetAccNo //HEI.05,//HEI.02,//HEI.01 OnBeforeSetAccNo is subscribed.
    //Bc Upgrade YADAVM09 OnAfterSetRunOnlyCheck event used to get value of variable CalledFromItemPosting and CalledFromTestReport.
    //Bc Upgrade YADAVM09 for function PostInvtPostBuf //HEI.01,//HEI.04 OnPostInvtPostBufOnAfterInitGenJnlLine event is subscribed.
    //Bc Upgrade YADAVM09 for function PostInvtPostBuf //HEI.05 OnPostInvtPostBufOnBeforeSetAmt event is subscribed.
    //BC Upgrade YADAVM09 HEI.01 Interface code is moved to the Interface codeunit.
    //Bc Upgrade YADAVM09 new event is created for the Interface code - OnBeforeSetAccNoInterfaceCode to handle the interface code.

    // // BC Upgrade YADAVM09 << codeunit "Inventory Posting to G/L - id - 5802 <<
    //BC Upgrade kamnay01 The event subscriber was deleted (rather than commented) to ensure it is fully removed from the extension metadata. In Business Central, commented code may still persist in the compiled version if the extension is not redeployed with a version change, causing the old subscriber to be triggered during debugging. Deletion guarantees clean removal.




    // BC Upgrade SHUKLP03 >> Page "Item Tracking Lines" 

    // HEI.07=> Half part of code of field "Lot No." is added on event OnBeforeLotNoAssistEdit.

    // HEI.07 => To execute HEI.07 code present on onclosepage trigger subscribed events OnBeforeClosePage, OnBeforeSynchronizeWarehouseItemTracking,OnAFterOnClosePage

    // HEI.10, HEI.11 => Subscribe event OnAfterCreateReservEntryFor to add code of procedure RegisterChange()
    // HEI.07 => Subscribe event OnAfterGetInvoiceSource to add code of procedure GetInvoiceSource().
    // # Called below procedures from Page extension of "Item Tracking Lines" on events: 
    // Procedure ==> Event
    // OnBFClosePage() ==> OnBeforeClosePage ----- HEI.07
    // OnBFSynchronizeWarehouseItemTracking() ==> OnBeforeSynchronizeWarehouseItemTracking ----- HEI.07
    // OnAFOnClosePage() ==> OnAFterOnClosePage ------- HEI.01
    // OnBFInsertRecord() ==> OnBeforeOnInsertRecord -------- HEI.04
    // OnBFOnModifyRecord() ==> OnBeforeOnModifyRecord ----- HEI.07
    // OnBFQueryClosePage() ==> OnBeforeQueryClosePage ----------- HEI.03,HEI.08
    // OnQueryClosePageOnBFCurrPageUpdate() ==> OnQueryClosePageOnBeforeCurrPageUpdate ------- HEI.09
    // OnBFLotNoAssistEdit() ==> OnBeforeLotNoAssistEdit ----- HEI.07
    // SetSourceSpecExt() ==> OnBeforeSetSourceSpec ----- HEI.07
    // OnBFFillSourceQuantityArray() ==> OnBeforeFillSourceQuantityArray ------- HEI.09
    // OnAFSetSourceSpec() ==> OnAfterSetSourceSpec ----- HEI.07
    // OnAddReservEntriesToTempRecSetOnBeforeInsertExt() ==> OnAddReservEntriesToTempRecSetOnBeforeInsert
    // SetFiltersC() ==> OnAfterSetFilters ----- HEI.07, HEI.11
    // OnAFMoveFields() ==> OnAfterMoveFields ----- HEI.07
    // OnAFAssignNewTrackingNo() ==> OnAfterAssignNewTrackingNo ----- HEI.07
    // OnSelectEntriesOnBFSelectMultipleTrackingNo() ==> OnSelectEntriesOnBeforeSelectMultipleTrackingNo ----- HEI.12,HEI.07
    // OnSelectEntriesOnAFTransferFields() ==> OnSelectEntriesOnAfterTransferFields ----- HEI.12,HEI.07

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnBeforeClosePage, '', false, false)]
    local procedure OnBeforeClosePage(CurrentRunMode: Enum "Item Tracking Run Mode"; var SkipWriteToDatabase: Boolean; CurrentSourceType: Integer)
    var

    begin
        CurrentSourceTypeOrg := CurrentSourceType;
        SkipWriteToDatabaseOrg := SkipWriteToDatabase;
        CurrentRunModeOrg := CurrentRunMode;
        //HEI.07>>
        ItemTrackLine.OnBFClosePage(SkipWriteToDatabase, CurrentRunMode, CurrentSourceType);
        //HEI.07<<
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnBeforeSynchronizeWarehouseItemTracking, '', false, false)]
    local procedure OnBeforeSynchronizeWarehouseItemTracking(var IsHandled: Boolean)
    begin
        ItemTrackLine.OnBFSynchronizeWarehouseItemTracking(IsHandled);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnAfterOnClosePage, '', false, false)]
    local procedure OnAFterOnClosePage(CurrentRunMode: Enum "Item Tracking Run Mode"; CurrentSourceType: Integer)
    begin
        ItemTrackLine.OnAFOnClosePage(CurrentRunModeOrg, CurrentSourceTypeOrg);

    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnBeforeOnInsertRecord, '', false, false)]
    local procedure OnBeforeOnInsertRecord(var TrackingSpecification: Record "Tracking Specification"; SourceQuantityArray: array[5] of Decimal)
    begin

        ItemTrackLine.OnBFInsertRecord(TrackingSpecification);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnBeforeUpdateTrackingData, '', false, false)]
    local procedure OnBeforeOnModifyRecord(var TrackingSpecification: Record "Tracking Specification")
    begin
        ItemTrackLine.OnBFOnModifyRecord(TrackingSpecification);
    end;
    //BC Upgrade Kamnay01 >> Test script fix
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnBeforeQueryClosePage, '', false, false)]
    local procedure OnBeforeQueryClosePage(var TrackingSpecification: Record "Tracking Specification")
    var
        CloseAction: Action;

        Text000L: TextConst ENU = 'There is still Undefined Quantity %1. Please selsect Lot and Quantity correctly.';
        UndefinedQtyArray: array[3] of Decimal;
        ILE: Page "Item Tracking Lines";
        Text001L: TextConst ENU = 'The Lot No. - %1 has an Extract Content [%w/w] Value = 0.00. Would you like to proceed?';
    begin
        IF TrackingSpecification.findset() THEN BEGIN
            IF UndefinedQtyArray[1] <> 0 THEN
                ERROR(Text000L, UndefinedQtyArray[1])
            else
                ILE.AssignLots(TrackingSpecification);
            EXIT;
        end;
    End;

    //BC Upgrade Kamnay01 << Test script fix 

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnQueryClosePageOnBeforeCurrPageUpdate, '', false, false)]
    local procedure OnQueryClosePageOnBeforeCurrPageUpdate(var IsHandled: Boolean)
    begin
        If ItemTrackLine.OnQueryClosePageOnBFCurrPageUpdate() then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnBeforeLotNoAssistEdit, '', false, false)]
    local procedure OnBeforeLotNoAssistEdit(var TrackingSpecification: Record "Tracking Specification")
    begin
        ItemTrackLine.OnBFLotNoAssistEdit(TrackingSpecification);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnBeforeSetSourceSpec, '', false, false)]
    local procedure OnBeforeSetSourceSpec(var TrackingSpecification: Record "Tracking Specification")
    begin
        ItemTrackLine.SetSourceSpecExt(TrackingSpecification);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnBeforeFillSourceQuantityArray, '', false, false)]
    local procedure OnBeforeFillSourceQuantityArray(TrackingSpecification: Record "Tracking Specification")
    begin
        //HEI.09>>
        ItemTrackLine.OnBFFillSourceQuantityArray(TrackingSpecification)
        //HEI.09<<
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnAfterSetSourceSpec, '', false, false)]
    local procedure OnAfterSetSourceSpec(var AvailabilityDate: Date; var TrackingSpecification: Record "Tracking Specification")
    begin
        ItemTrackLine.OnAFSetSourceSpec(AvailabilityDate, TrackingSpecification);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnAddReservEntriesToTempRecSetOnBeforeInsert, '', false, false)]
    local procedure OnAddReservEntriesToTempRecSetOnBeforeInsert(var TempTrackingSpecification: Record "Tracking Specification" temporary; ReservationEntry: Record "Reservation Entry")
    begin
        ItemTrackLine.OnAddReservEntriesToTempRecSetOnBeforeInsertExt(TempTrackingSpecification, ReservationEntry);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnAfterSetFilters, '', false, false)]
    local procedure OnAfterSetFilters(TrackingSpecification: Record "Tracking Specification"; var TrackingSpecificationRec: Record "Tracking Specification")
    begin
        ItemTrackLine.SetFiltersC(TrackingSpecification);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnAfterMoveFields, '', false, false)]
    local procedure OnAfterMoveFields(var ReservEntry: Record "Reservation Entry"; var TrkgSpec: Record "Tracking Specification")
    begin
        ItemTrackLine.OnAFMoveFields(ReservEntry, TrkgSpec);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnAfterAssignNewTrackingNo, '', false, false)]
    local procedure OnAfterAssignNewTrackingNo(var TrkgSpec: Record "Tracking Specification")
    begin
        ItemTrackLine.OnAFAssignNewTrackingNo(TrkgSpec);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnAfterGetInvoiceSource, '', false, false)]
    local procedure OnAfterGetInvoiceSource(TrackingSpecification: Record "Tracking Specification"; var QtyToInvoiceColumnIsHidden: Boolean)
    begin
        QtyToInvoiceColumnIsHidden :=
            (TrackingSpecification."Source Type" in [Database::"Item Ledger Entry",
                                                     Database::"Item Journal Line",
                                                     Database::"Job Journal Line",
                                                     Database::"Requisition Line",
                                                     Database::"Transfer Line",
                                                     901, // Database::"Assembly Line"
                                                     900, // Database::"Assembly Header"
                                                     5406, // Database::"Prod. Order Line"
                                                     5407]) or // Database::"Prod. Order Component"
                                                               //HEI.07>>
            ((TrackingSpecification."Source Type" = DATABASE::"Warehouse Activity Line") AND (TrackingSpecification."Source Subtype" = 3)) OR           //HEI.07<<

            ((TrackingSpecification."Source Type" in [Database::"Sales Line",
                                                      Database::"Purchase Line"]) and
            (TrackingSpecification."Source Subtype" in [0, 2, 3, 4]));

    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnSelectEntriesOnBeforeSelectMultipleTrackingNo, '', false, false)]
    local procedure OnSelectEntriesOnBeforeSelectMultipleTrackingNo()
    begin
        ItemTrackLine.OnSelectEntriesOnBFSelectMultipleTrackingNo();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnSelectEntriesOnAfterTransferFields, '', false, false)]
    local procedure OnSelectEntriesOnAfterTransferFields()
    begin
        ItemTrackLine.OnSelectEntriesOnAFTransferFields();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnAfterCreateReservEntryFor, '', false, false)]
    local procedure OnAfterCreateReservEntryFor(var OldTrackingSpecification: Record "Tracking Specification")
    var
        CreateReservEntry: Codeunit "Heineken BC Upgrade";
    begin
        //HEI.10>>
        CreateReservEntry.SetWeightOfExtractValues(OldTrackingSpecification."KG/HL FND", OldTrackingSpecification."Weight of Extract FND");
        //HEI.10<<
        //HEI.11>>
        CreateReservEntry.SetRefNo(OldTrackingSpecification."Reference No. FND");
        //HEI.11<<
    end;

    // BC Upgrade SHUKLP03 << Page "Item Tracking Lines" 



    //Codeunit-364-"PostPurch-Delete" Start here >>

    //  DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4

    //   HEI.01 FDD-PURGAP027 IBM NASTAA02 12.06.2019 # Maximo POs Approval Flow
    //     # Code added to update also Addition Purchase Fields

    //Version NAVW110.0.00.15601,DITW110.00.09

    //BC Upgrade KAPOOV01 19.12.2025 #Created new function -OnAfterInitDeleteHeader & Subscribed to event-OnAfterInitDeleteHeader of function-InitDeleteHeader to take HEI.01 customization inside function-InitDeleteHeader.

    //BC Upgrade KAPOOV01 Codeunit-364-HEI.01 #Created new function -OnAfterInitDeleteHeader & Subscribed to event-OnAfterInitDeleteHeader of function-InitDeleteHeader to take HEI.01 customization inside function-InitDeleteHeader>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PostPurch-Delete", OnAfterInitDeleteHeader, '', false, false)]
    local procedure OnAfterInitDeleteHeader(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShptHeader: Record "Return Shipment Header"; var PurchInvHeaderPrepmt: Record "Purch. Inv. Header"; var PurchCrMemoHdrPrepmt: Record "Purch. Cr. Memo Hdr.")
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchRcptHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
        SalesShipHeaderAdditional: Record "Sales Ship. Header Add FND";
        PurchInvHeaderAdditional: Record "Purch. Inv. Header Add FND";
        PurchCrMemoHdrAddition: Record "Purch. Cr. Memo Hdr. Add FND";
    begin
        if (PurchHeader."Receiving No. Series" <> '') and (PurchHeader."Receiving No." <> '') then begin
            //HEI.01>>
            IF PurchaseHeaderAdditional.GET(PurchHeader."Document Type", PurchHeader."No.") THEN BEGIN
                PurchRcptHeaderAdditional.INIT();
                PurchRcptHeaderAdditional.TRANSFERFIELDS(PurchaseHeaderAdditional);
                PurchRcptHeaderAdditional.INSERT();
            END;
            //HEI.01<<
        end;

        if (PurchHeader."Return Shipment No. Series" <> '') and (PurchHeader."Return Shipment No." <> '') then begin
            //HEI.01>>
            IF PurchaseHeaderAdditional.GET(PurchHeader."Document Type", PurchHeader."No.") THEN BEGIN
                SalesShipHeaderAdditional.INIT();
                SalesShipHeaderAdditional.TRANSFERFIELDS(PurchaseHeaderAdditional);
                SalesShipHeaderAdditional.INSERT();
            END;
            //HEI.01<<
        end;

        if (PurchHeader."Posting No. Series" <> '') and
           ((PurchHeader."Document Type" in [PurchHeader."Document Type"::Order, PurchHeader."Document Type"::Invoice]) and
            (PurchHeader."Posting No." <> '') or
            (PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice) and
            (PurchHeader."No. Series" = PurchHeader."Posting No. Series"))
        then begin
            //HEI.01>>
            IF PurchaseHeaderAdditional.GET(PurchHeader."Document Type", PurchHeader."No.") THEN BEGIN
                PurchInvHeaderAdditional.INIT();
                PurchInvHeaderAdditional.TRANSFERFIELDS(PurchaseHeaderAdditional);
                PurchInvHeaderAdditional.INSERT();
            END;
            //HEI.01<<
        end;

        IF (PurchHeader."Posting No. Series" <> '') AND
           ((PurchHeader."Document Type" IN [PurchHeader."Document Type"::"Return Order", PurchHeader."Document Type"::"Credit Memo"]) AND
            (PurchHeader."Posting No." <> '') OR
            (PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo") AND
            (PurchHeader."No. Series" = PurchHeader."Posting No. Series"))
        then begin
            //HEI.01>>
            IF PurchaseHeaderAdditional.GET(PurchHeader."Document Type", PurchHeader."No.") THEN BEGIN
                PurchCrMemoHdrAddition.INIT();
                PurchCrMemoHdrAddition.TRANSFERFIELDS(PurchaseHeaderAdditional);
                PurchCrMemoHdrAddition.INSERT();
            END;
            //HEI.01<<
        end;
    end;
    //BC Upgrade KAPOOV01 Codeunit-364-HEI.01 #Created new function -OnAfterInitDeleteHeader & Subscribed to event-OnAfterInitDeleteHeader of function-InitDeleteHeader to take HEI.01 customization inside function-InitDeleteHeader<<

    //Codeunit-364-"PostPurch-Delete" End here <<



    // Codeunit 241 - Item Jnl.-Post  >>
    //GUNREM01>> subscribed a event to write the customized code..
    //HEI.01 Code written for GUI Allowed.But its not required,because BC posting code uses HideDialog and PreviewMode by default.
    //HEI.02 Added Code to validate Missing Unit Cost Warning message
    //HEI.04 Added Code to limit selection for scrapping item journals
    //HEI.05 Added Code to limit selection for scrapping item journals having item tracking
    //HEI.06 Added Code to limit selection for scrapping item journals having item tracking

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Item Jnl.-Post", OnCodeOnBeforeItemJnlPostBatchRun, '', true, true)]
    local procedure OnCodeOnBeforeItemJnlPostBatchRun(var ItemJournalLine: Record "Item Journal Line")
    var
        Text000: Label 'ENU=cannot be filtered when posting recurring journals;FRA=ne peut pas ˆtre filtr‚(e) lors de la validation de feuilles abonnement';
        Text001: Label 'ENU=Do you want to post the journal lines?;FRA=Souhaitez-vous valider les lignes de la feuille ?';
        Text002: Label 'ENU=There is nothing to post.;FRA=Il n''y a rien … valider.';
        Text003: Label 'ENU=The journal lines were successfully posted.;FRA=Les lignes de la feuille ont ‚t‚ valid‚es avec succŠs.';
        Text004: Label 'ENU="The journal lines were successfully posted. ";FRA="Les lignes de la feuille ont ‚t‚ valid‚es avec succŠs. "';
        Text005: Label 'ENU=You are now in the %1 journal.;FRA=Vous ˆtes maintenant dans la feuille %1.';
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlLine: Record "Item Journal Line";
        TempJnlBatchName: Code[10];
        NegtiveAdjmtErrorTxt: Label 'ENU=Please provide Applied-From Entry transaction to proceed with reversal scrapping';
        ItemLedgerEntry: Record "Item Ledger Entry";
        Item: Record Item;
        ReservationEntry: Record "Reservation Entry";
    begin
        //HEI.04>>
        IF ((ItemJnlTemplate."Limit Type Selection FND") AND (ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Positive Adjmt.")) THEN BEGIN
            //HEI.05>>
            Item.GET(ItemJournalLine."Item No.");
            IF Item."Item Tracking Code" = '' THEN BEGIN
                //HEI.05<<
                IF ItemJournalLine."Applies-from Entry" = 0 THEN
                    ERROR(NegtiveAdjmtErrorTxt)
                ELSE IF ItemLedgerEntry.GET(ItemJournalLine."Applies-from Entry") THEN
                    IF NOT (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::"Negative Adjmt.") THEN
                        ERROR(NegtiveAdjmtErrorTxt);
                //HEI.05>>
            END ELSE BEGIN
                ReservationEntry.RESET();
                ReservationEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
                ReservationEntry.SETRANGE("Source ID", ItemJournalLine."Journal Template Name");
                ReservationEntry.SETRANGE("Source Ref. No.", ItemJournalLine."Line No.");
                ReservationEntry.SETRANGE("Source Type", 83);
                //ReservationEntry.SETRANGE("Source Subtype",3);//HEI.06
                ReservationEntry.SETRANGE("Source Subtype", 2);//HEI.06
                ReservationEntry.SETRANGE("Source Batch Name", ItemJournalLine."Journal Batch Name");
                IF ReservationEntry.FINDSET() THEN
                    REPEAT
                        IF ReservationEntry."Appl.-from Item Entry" = 0 THEN
                            ERROR(NegtiveAdjmtErrorTxt)
                        ELSE IF ItemLedgerEntry.GET(ReservationEntry."Appl.-from Item Entry") THEN
                            IF NOT (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::"Negative Adjmt.") THEN
                                ERROR(NegtiveAdjmtErrorTxt);
                    UNTIL ReservationEntry.NEXT() = 0;
            END;
            //HEI.05<<
        END;
        //HEI.04<<

        //HEI.02>>
        IF NOT AllowedEmptyUnitCost(ItemJnlLine) THEN
            EXIT;
    END;
    //HEI.02<<
    //GUNREM01<< subscribed a event to write the customized code

    //GUNREM01>> Created new procedure as same as navision and updated ItemJournalLine variable.
    //HEI.02 Added Code to validate Missing Unit Cost Warning message
    //HEI.03 Added Code to fix the looping/undefined issue.
    LOCAL PROCEDURE AllowedEmptyUnitCost(VAR ItemJournalLine: Record "Item Journal Line") Post: Boolean;
    VAR
        InventorySetupL: Record "Inventory Setup";
        StockkeepingUnitL: Record "Stockkeeping Unit";
        SKUNotExistL: Boolean;
        DimensionFiltersL: Query "Dimension Filters";
        Text000L: Label 'ENU=Unit Cost of an Item %1 is 0.00. Please contact Controlling Team immediately, in order to set correct Unit Cost in the system. In case you proceed with this transaction as is, accounting transactions posted will be wrong. Would you like to proceed?';
    BEGIN
        //HEI.02>>
        Post := TRUE;
        InventorySetupL.GET();
        IF NOT InventorySetupL."Activate UnitCost Warn.Msg FND" THEN
            EXIT;
        //HEI.03>>
        ItemJournalLine.SETRANGE("Journal Template Name", ItemJnlLine."Journal Template Name");
        ItemJournalLine.SETRANGE("Journal Batch Name", ItemJnlLine."Journal Batch Name");
        ItemJournalLine.SETRANGE("Document No.", ItemJnlLine."Document No.");
        //HEI.03<<
        // IF ItemJournalLine.FINDSET(FALSE, FALSE) THEN  //GUNREM01>> commented becuase its no longer required for new versions.
        IF ItemJournalLine.FINDSET() THEN //GUNREM01<< Added
            REPEAT
                CLEAR(SKUNotExistL);
                IF NOT StockkeepingUnitL.GET(ItemJournalLine."Location Code", ItemJournalLine."Item No.", ItemJournalLine."Variant Code") THEN
                    SKUNotExistL := TRUE;
                IF (StockkeepingUnitL."Unit Cost" = 0) OR SKUNotExistL THEN BEGIN
                    DimensionFiltersL.SETRANGE(No, ItemJournalLine."Item No.");
                    IF InventorySetupL."Exclude CMG Dime. Value FND" <> '' THEN
                        DimensionFiltersL.SETFILTER(Dimension_Value_Code, '<>%1', InventorySetupL."Exclude CMG Dime. Value FND");
                    DimensionFiltersL.OPEN();
                    IF DimensionFiltersL.READ() THEN BEGIN
                        IF NOT CONFIRM(Text000L, FALSE, ItemJournalLine."Item No.") THEN BEGIN
                            //HEI.03>>
                            DimensionFiltersL.CLOSE();
                            //HEI.03<<
                            EXIT(FALSE);
                            //HEI.03>>
                        END;
                        //HEI.03<<
                    END;
                    //HEI.03>>
                    DimensionFiltersL.CLOSE();
                    //HEI.03<<
                END;
            UNTIL ItemJournalLine.NEXT() = 0;
        //HEI.02<<
    END;
    //GUNREM01<< Created new procedure as same as navision and updated ItemJournalLine variable.
    // Codeunit 241 - Item Jnl.-Post  <<
    //BC UPGRADE PATHAA02 01.01.26 Subscribed to this event to handle code HEI.01 of CU7306-"Whse.-Act.-Register (Yes/No)" on Function-Code() >>
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt
    // #Code for zone transfer movement

    // BC Upgrade RD03 - the below EventSubscriber moved to DTW extension -- >>
    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Act.-Register (Yes/No)", 'OnBeforeCode', '', false, false)]
    //local procedure CU7306_OnBeforeCode(var WarehouseActivityLine: Record "Warehouse Activity Line"; var IsHandled: Boolean)
    //var
    //  WMSMgt: Codeunit "WMS Management";
    // text50000: Label 'Do you want to register the %1 Document?';
    // WhseActivityRegister: Codeunit "Whse.-Activity-Register";
    //begin
    //    IsHandled := true;   // Skip entire standard Code() logic        
    //  CustomCheckSourceDocument(WarehouseActivityLine);
    // if NOT WarehouseActivityLine."Zone-Transfer FND" then begin //HEI.01
    //     WMSMgt.CheckBalanceQtyToHandle(WarehouseActivityLine);
    //     IF NOT CONFIRM(text50000, FALSE, WarehouseActivityLine."Activity Type") THEN
    //         EXIT;
    // end;
    //   WhseActivityRegister.Run(WarehouseActivityLine);
    //  Clear(WhseActivityRegister);
    //end;
    // BC Upgrade RD03 - the below EventSubscriber moved to DTW extension -- <<

    local procedure CustomCheckSourceDocument(var WhseLine: Record "Warehouse Activity Line")
    var
        text50000: Label 'The document %1 is not supported.';
    begin
        if (WhseLine."Activity Type" = WhseLine."Activity Type"::"Invt. Movement") and
     not (WhseLine."Source Document" in [WhseLine."Source Document"::" ",
                                 WhseLine."Source Document"::"Prod. Consumption",
                                 WhseLine."Source Document"::"Assembly Consumption"]) then
            Error(text50000, WhseLine."Source Document");
    end;

    //BC UPGRADE PATHAA02 01.01.26 Subscribed to this event to handle code HEI.01 of CU7306-"Whse.-Act.-Register (Yes/No)" on Function-Code()<<



    //BC UPGRADE PATHAA02 CU5510-"Production Journal Mgt"  01.01.26>>
    // -----------------------------
    //     DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008 BrewIt & Quality
    // DITW15.00.00.37 DDR 19/01/2010 issue 1038 Allowed the internal item charges within 'output'/'consumption' entry types
    //                     03/03/2010 issue 1038 Save main item journal line after inserted item charges
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.05 MSF 25/12/2014 DIT-770 #1131
    // DITW19.00.08 DDR 17/08/2016 BL#10443 Bugfix read performance (FINDSET, FINDFIRST, FINDLAST)
    // DITW19.00.08 DDR 29/09/2016 BL#10443 Modified functions DeleteJnlLines() to include Loss Breakdown journal

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.11 SFI 31/08/2017 BL#30569 Added changes for SKU blocking
    // DITW110.00.12A HBA 04/06/2018 NRQ#51793 Updated Setup and Run time while posting
    // DITW110.00.12A HBA 07/06/2018 NRQ#51782 Adjusted code in function InsertConsumptionJnlLine()
    // DITW110.00.12A HBA 04/06/2018 NRQ#51789 Updated Setup and Run time while posting
    // DITW110.00.12A ISL 13/06/2018 NRQ#51789 Added check in function InsertConsumptionJnlLine()

    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt
    // HEI.02 FDD-PRDGAPID027 IBBM.NAIKH01 17/08.2017 # No BIN No. automatic suggested on the prod Journal
    //   # Added a new code on function "InsertConsumptionJnlLine"
    // HEI.03 FDD_CHG2003754 IBM ISYED01 03.19.2019
    //  #Addec code to TrfasferBom disable Component’s lines aggregation during Prod. Order Creation
    // HEI.04 CHG2102527 IBM.LS      18.03.2021
    //   # Added Code
    // HEI.05 CHG2106003 IBM.LS      10.05.2021
    //   # Added Code
    // HEI.05 CHG2120255 IBM.LS      29.07.2021
    //   # Added Code and added Parameter in UpdateCccCode function
    // HEI.06 HB1487 - CHG2070737 IBM NASTAA02 03.06.2022 # Mass Upload of Production Orders
    //   # Code added to update values based on Imported Production Orders

    //----------------------------------Pathaa02 ---------------------------------------------------------------------------------
    // HEI.01, HEI.02, HEI.05,  (Before inserting consumption lines)
    //HEI.06 Is not taken fwd as it is not used by any opco. Informed Meraj to check with GPM and DIT code not taken fwd
    //HEI.07 BC UPGRADE PATHAA02 10.03.26, Functionality related to "Production Jnl Flushing" DIT field is added
    // -------------------------------------------------------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Production Journal Mgt", 'OnBeforeInsertConsumptionJnlLine', '', false, false)]
    local procedure OnBeforeInsertConsumptionJnlLine(var ItemJournalLine: Record "Item Journal Line"; ProdOrderComp: Record "Prod. Order Component"; ProdOrderLine: Record "Prod. Order Line"; Level: Integer)
    var
        CccCode: Code[20];
        ItemJnlLine: Record "Item Journal Line";
    begin
        //CU5510-HEI.02>> – Bin/Zone from Prod Order Component      
        //ItemJournalLine."Bin Code" := ProdOrderComp."Bin Code";
        //CU5510-HEI.02<<
        //CU5510-HEI.01>>
        ItemJournalLine."Bin Code" := ProdOrderComp."Bin Code";
        ItemJournalLine."Zone Code FND" := ProdOrderComp."Zone Code FND";
        ItemJournalLine."Production jnl. flushing FND" := ProdOrderComp."Production jnl. flushing FND";//HEI.07 
        //CU5510-HEI.01<<
        //CU5510-HEI.05>> – Update CCC code (Shortcut Dimension 2)
        CLEAR(CccCode);
        IF (ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Consumption) AND
          (ItemJnlLine."Order Type" = ItemJnlLine."Order Type"::Production) THEN
            IF UpdateCccCode(ItemJnlLine, CccCode) THEN
                ItemJnlLine.VALIDATE("Shortcut Dimension 2 Code", CccCode);
        //CU5510-HEI.05<<
    end;
    // -----------------------------
    // HEI.01 + HEI.04 +  (Output line custom defaults)
    // -----------------------------
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Production Journal Mgt", 'OnBeforeInsertOutputJnlLine', '', false, false)]
    local procedure OnBeforeInsertOutputJnlLine(var ItemJournalLine: Record "Item Journal Line"; ProdOrderRtngLine: Record "Prod. Order Routing Line"; ProdOrderLine: Record "Prod. Order Line")
    begin
        //CU5510-HEI.04>> – If Bin empty but Zone exists on line, carry it
        if (ItemJournalLine."Bin Code" = '') and (ProdOrderLine."Zone Code FND" <> '') then
            ItemJournalLine."Zone Code FND" := ProdOrderLine."Zone Code FND";
        //CU5510-HEI.04<<
        //CU5510-HEI.01>> – Derive Zone from Bin if present
        SetZoneFromBin(ItemJournalLine);
        //CU5510-HEI.01<<
    end;


    //CU5510 HEI.01 o/p>>
    local procedure SetZoneFromBin(var ItemJournalLine: Record "Item Journal Line") //AK1(O/P Jnl)
    var
        BinRec: Record Bin;
    begin
        if ItemJournalLine."Bin Code" <> '' then begin
            if BinRec.Get(ItemJournalLine."Location Code", ItemJournalLine."Bin Code") then
                if BinRec."Zone Code" <> '' then
                    ItemJournalLine."Zone Code FND" := BinRec."Zone Code";
        end;
    end;
    //CU5510 HEI.01 o/p<<


    //CU5510-HEI.05>>
    local procedure UpdateCccCode(ItemJournalLine: Record "Item Journal Line"; VAR CccCode: Code[20]): Boolean
    var
        SourceCodeL: code[10];
        ItemJournalTemplateL: Record "Item Journal Template";
        SourceCodeSetupL: Record "Source Code Setup";
        ProductionOrderL: record "Production Order";
        ProdOrderLineL: record "Prod. Order Line";
        BinL: record Bin;
        DefaultDimensionPriority1L: Record "Default Dimension Priority";
        DefaultDimensionPriority2L: Record "Default Dimension Priority";
        ProdOrderRoutingLineL: Record "Prod. Order Routing Line";
        ItemJnlLineL: Record "Item Journal Line";
        GeneralLedgerSetupL: Record "General Ledger Setup";
        DefaultDimensionL: Record "Default Dimension";
    begin
        CLEAR(CccCode);
        IF (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Consumption) AND
          (ItemJournalLine."Order Type" = ItemJournalLine."Order Type"::Production) THEN BEGIN
            SourceCodeL := ItemJournalLine."Source Code";
            IF (SourceCodeL = '') AND (ItemJournalTemplateL.GET(ItemJournalLine."Journal Template Name")) THEN
                SourceCodeL := ItemJournalTemplateL."Source Code";
            SourceCodeSetupL.GET();
            IF (SourceCodeSetupL."Production Journal" <> '') AND (SourceCodeSetupL."Production Journal" = SourceCodeL) THEN BEGIN
                IF ProductionOrderL.GET(ProductionOrderL.Status::Released, ItemJournalLine."Order No.") THEN BEGIN
                    IF ProdOrderLineL.GET(ProdOrderLineL.Status::Released, ItemJournalLine."Order No.", ItemJournalLine."Order Line No.") THEN BEGIN
                        IF BinL.GET(ProdOrderLineL."Location Code", ProdOrderLineL."Bin Code") AND (BinL."Ccc Code FND" <> '') THEN BEGIN
                            CccCode := BinL."Ccc Code FND";
                            EXIT(TRUE);
                        END;
                        IF DefaultDimensionPriority1L.GET(SourceCodeSetupL."Production Journal", DATABASE::"Work Center") THEN BEGIN
                            IF DefaultDimensionPriority2L.GET(SourceCodeSetupL."Production Journal", DATABASE::Item) THEN BEGIN
                                IF DefaultDimensionPriority1L.Priority < DefaultDimensionPriority2L.Priority THEN BEGIN
                                    ProdOrderRoutingLineL.SETCURRENTKEY(Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", Type, "Work Center No.");
                                    ProdOrderRoutingLineL.SETRANGE(Status, ProdOrderLineL.Status);
                                    ProdOrderRoutingLineL.SETRANGE("Prod. Order No.", ProdOrderLineL."Prod. Order No.");
                                    ProdOrderRoutingLineL.SETRANGE("Routing Reference No.", ProdOrderLineL."Routing Reference No.");
                                    ProdOrderRoutingLineL.SETRANGE("Routing No.", ProdOrderLineL."Routing No.");
                                    ProdOrderRoutingLineL.SETRANGE(Type, ProdOrderRoutingLineL.Type::"Work Center");
                                    ProdOrderRoutingLineL.SETFILTER("Work Center No.", '<>%1', '');
                                    IF ProdOrderRoutingLineL.FINDFIRST() THEN BEGIN
                                        GeneralLedgerSetupL.GET();
                                        IF DefaultDimensionL.GET(DATABASE::"Work Center", ProdOrderRoutingLineL."Work Center No.", GeneralLedgerSetupL."Global Dimension 2 Code") THEN BEGIN
                                            CccCode := DefaultDimensionL."Dimension Value Code";
                                            EXIT(TRUE);
                                        END;
                                    END;
                                END;
                            END;
                        END;
                    END;
                END;
            END;
        END;
        EXIT(FALSE);
    end;
    //CU5510-HEI.05<<
    //BC UPGRADE PATHAA02 CU 5510-"Production Journal Mgt"  01.01.26<<


    //BC Upgrade KAPOOV01 Codeunit-415-"Release Purchase Document" Start here >>
    // FINXL7.00.001 RBE 19/03/2015 : Test on zero price depends on setup parameter
    // FINXL7.00.001 KLU 25/09/2013 : Check invoice lines from receipt
    //                                Only force approval when total amount has changed
    // FINXL7.00.003 KLU 03/10/2013 : "Do not allow zero price" for invoice and credit memo
    // FINXL7.00.003 KLU 04/10/2013 : Check quantity and unit price
    // FINXL7.00.003 KLU 14/10/2013 : Min and max margin + reapproval
    // FINXL7.00.001 KLU 14/10/2013 : Only force approval when total amount has changed

    // DITW15.00.00.01 DDR 22/01/2007 Added Drink-it Discount & Promotion Item Charges functionnalities
    // DITW15.00.00.01 DDR 19/03/2007 added parameter into functions PurchRelease() for discount,promotion
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.24 DDR 27/08/2008 Added "Disc.Promo. Order Calculated" to recalculate the discount/promotion per order
    // DITW15.00.00.37 DDR 04/02/2010 issue 1033 Remove check "Disc.Promo. Order Calculated"
    //                     26/04/2010 issue 1071 Bugfix to reopen the document with discount or promotion per order
    //                     27/04/2010 issue 1107 Added warning message if already exist discounts per order partially posted.
    //                     29/04/2010 issue 1114 Added functions DocumentPreReleaseDiscPromo(),SetHideValidationDiscPromo()
    // DITW16.00.00.37 DDR 13/01/2011 DIT-715 issue 43 RTC Upgrade: Added to remove the RTC new temporary lines marked '<new line>'
    // DITW15.00.00.38 DDR 01/10/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                           Added call function to check the EMCS purchase return order documents (IE815)
    //                     26/11/2010 issue 1217 (DIT711 56)
    //                                           Added call function to check the EMCS purchase order documents (IE818)
    // DITW16.00.00.38 DDR 04/03/2011 DIT-715 #63 RTC Upgrade & Performances
    //                                           Bugfix conflict between function RemoveBlankLines() remove blank lines '<new line>'
    //                                             and the function DocumentPreReleaseDiscPromo(), DelayedItemCharges.SalesRelease()
    // DITW15.00.00.39 DDR 28/06/2011 issue 1330 Added test to relase after prepayments
    // DITW16.00.00.39 DDR 28/06/2011 issue 1330 (Bugffx Std Corrected W16)
    // DITW15.00.00.39 DDR 15/07/2011 issue 1230 Added functions DocStatusRelease(),DocStatusOpen()
    //                                             (from object form42,43,44,6630)
    // DITW16.00.00.39 DDR 18/07/2011 DIT-715 issue 63 Bugfix missing commit after deleting blank lines
    //                     27/07/2011 issue 1407 Added to insert item charges while releasing manually document
    //                                             (field "Autom. Item Charge")
    //                                           Added functions ReleasePostItemCharges(),ReleasePostItemChargesLine()
    //                                           Removed VAR parameter for functions DocStatusRelease(),DocStatusOpen()
    //                                           Bugfix to skip calculation discount-promotion per order while releasing doc
    //                     08/08/2011 issue 1407 Added to insert promotion charge lines when "Autom. Item Charge" is 'Posting'
    //                                           Reviewed function ReleasePostItemCharges(),ReleasePostItemChargesLine()
    //                                           Added functions DocumentPreReleasePromotion()
    //                     11/08/2011 issue 1407 Bugfix function ReleasePostItemCharges()
    //                                             while posting with open status and no whse location
    //                     16/08/2011 issue 1407 Added to insert promotion charge lines when "Autom. Item Charge" is 'PostingExclIem'
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added field "Allow VAT Calculation (Free)" to keep "VAT Base Amount" value after ReOpen
    //                     20/01/2012 DIT-715 #172 Modified workflow (+Rollback)
    // DITW16.00.00.42 DDR 05/04/2013 DIT-715 #597 Bugfix partial posting and recalculate discount/promotion per order for new lines
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 12/02/2014 DIT-770 #223 : Apply Dimension check to the release function of sales and purchase documents
    //                                            NEW Functions  : FctCheckDimPurch - FctCheckDimCombPurch - FctCheckDimValuePostingPurch
    // DITW17.10.03 DDR 13/05/2014 DIT-770 #589 Bugfix missing remove blank lines //temporary before DIT-770 541
    //                                          Added function RemoveAllBlankLines()
    //                                          Renamed local variable DummySalesHeader -> DummyPurchHeader
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.03 DDR 27/06/2014 DIT-770 #541 Remove function RemoveAllBlankLines()
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05  AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 DDR 08/10/2015 DIT-770 #1617 Added to skip recalculation of order discount/promotion after get or copy document
    // DITW18.00.07 DDR 21/01/2016 DIT-770 #1844 Modified flow (remove #1617) Bugfix doesn't recalculate new items
    // DITW18.00.07 DDR 25/03/2016 DIT-770 #1844 Modified call Discount-Promotion release
    // DITW18.00.07 DDR 14/04/2016 DIT-770 #1402 Added "Show Posting Warnings";"Show Reopen Warnings"
    // DITW18.00.07 DDR 11/05/2016 DIT-770 #1402 Modified Hide message DIT discount/promo recalculation information at release
    // DITW18.00.07 VSC 12/05/2016 DIT-770 #1968 Synch Order limits sales to purchase (in order and Route Planning)
    // DITW18.00.07 VSC 25/05/2016 DIT-770 #1968 Remege -> #1488 Modified Route Mandatory for only Order & Return Order + Aditional Fix
    // DITW19.00.07 MVN 25/01/2016 DIT-770 #1740: DISABLED Approval
    // DITW19.00.08 SFI 18/08/2016 BL#10868  (DIT-770 #2141) Added automatic inv. adjustment

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL10.00 KSW 04/04/2017 NRQ#25468: Removed code check on previous status
    // FINXL10.01 OFE 31/08/2017 NRQ#10433 : Purchase Price Mandatory
    // FINXL10.01 MTR 16/08/2017 NRQ#30245: Removed old FINXL code related to "Show Totals on Purch. Inv/CM." setup
    // DITW111.00.13 MSF 04/02/2019 NRQ#87409 Reopen and Release an already approved sales order
    // DITW111.00.13 MSF 20/02/2019 NRQ#87409 Reopen and Release Fix

    // HEI.01 RFC-CHG0249183 IBM.LS 16.01.2019
    //   # Code added to call "SendEmailPurchaseOrder" function.
    //   Code moved from PerformManualRelease to PerformManualCheckAndRelease
    // HEI.02 FDD-PURGAP030 - Send updated PO to supplier with specified  changes_V1.1 IBM.NAIKH01
    //   # Code added on function "PerformManualRelease" to call "SendEmailPurchaseOrder" function.
    // HEI.03 FDD-PURGAP027 - Maximo POs approval flow, IBM.POENAB02 , 28.02.2019
    //   # Modified Code function.
    // HEI.04 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # Field "PQ Approver" has been moved to an extension Table
    // DITW111.00.13 MSF 04/02/2019 NRQ#87409 Added Approval reopend and release function
    // DITW111.00.13 MSF 20/02/2019 NRQ#87409 reopend and release function Fix
    // DITW111.00.13A DDR 01/07/2019 NRQ#103941 Fix double call to discount-promotion release calculation
    // DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix call function CalcBackUnitPriceItem()
    // HEI.08 CHG2044018 IBM KUMARN15 18.12.2019 # Code changed in function PerformManualCheckAndRelease
    // HEI.09 CHG2048419 IBM Shankj03 05.03.2020 # Code changed in function PerformManualCheckAndRelease
    // DITW114.00.15 DDR 22/09/2020 NRQ#155277 Fix (#22821) call Route planning request before Whse request
    // HEI.10 CHG2221624 HB3614 IBM SRIVAS07 05.04.2024 # Block Payment for Invoices with Price Difference higher than the tolerance
    //   # Code Added to PerformManualRelease()
    // HEI.11 CHG2308920 SHARMP16 01.07.2025 CC Issue on PQ in Heilite - Development
    //   # Added Document Type filter in PerformManualCheckAndRelease()

    //-----------------------------------------------------------------------------------------------------------------

    //BC Upgrade KAPOOV01 24.12.2025 #Created new function -OnCodeOnBeforeModifyHeader & Subscribed to event-OnCodeOnBeforeModifyHeader of function-Code() for Tags-HEI.03,HEI.04.
    //BC Upgrade KAPOOV01 24.12.2025 #Created new function -OnBeforePerformManualRelease & Subscribed to event-OnBeforePerformManualRelease of function-PerformManualCheckAndRelease().
    //BC Upgrade KAPOOV01 30.12.2025 #Created new function -OnPerformManualReleaseOnBeforeTestPurchasePrepayment & Subscribed to event-OnPerformManualReleaseOnBeforeTestPurchasePrepayment of function-PerformManualRelease() & added Standard and custom code of function-PerformManualRelease
    //BC Upgrade KAPOOV01 30.12.2025 #Created new function -OnBeforeTestPurchPrepayment & Subscribed to event-OnBeforeTestPurchPrepayment of function-TestPurchasePrepayment() of Codeunit-Prepayment Mgt. to Skip function-TestPurchasePrepayment in PerformManualRelease function as in Heilite Navision this function is not called in PerformManualRelease function
    //BC Upgrade KAPOOV01 30.12.2025 #Created new function -OnBeforePerformManualCheckAndRelease & Subscribed to event-OnBeforePerformManualCheckAndRelease of function-PerformManualRelease() to Skip rest of the BC standard code in PerformManualRelease function as required code is written on event subscriber function-OnPerformManualReleaseOnBeforeTestPurchasePrepayment
    //BC Upgrade KAPOOV01 30.12.2025 #Created new function SetManualReleaseBoolean to set Global variable- gManualRelease_var value to skip
    //BC Upgrade KAPOOV01 30.12.2025 #Created new Global variable to restructure code in standard function-PerformManualRelease.

    //BC Upgrade Kamnay01 Remove HEI.02 Code from event OnPerformManualReleaseOnBeforeTestPurchasePrepayment because the code is commented in Navsion

    //BC Upgrade KAPOOV01 Codeunit-415-HEI.03,HEI.04 #Created new function -OnCodeOnBeforeModifyHeader & Subscribed to event-OnCodeOnBeforeModifyHeader of function-Code() >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", OnCodeOnBeforeModifyHeader, '', false, false)]
    local procedure OnCodeOnBeforeModifyHeader(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; PreviewMode: Boolean; var LinesWereModified: Boolean; var NotOnlyDropShipment: Boolean)
    var
        lApprovalEntry: Record "Approval Entry";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //HEI.03>>
        IF (PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::Quote]) THEN BEGIN
            lApprovalEntry.RESET();
            lApprovalEntry.SETRANGE("Table ID", 38);
            lApprovalEntry.SETRANGE("Document Type", PurchaseHeader."Document Type"::Quote);
            lApprovalEntry.SETRANGE("Document No.", PurchaseHeader."No.");
            IF lApprovalEntry.FINDFIRST() THEN
                //HEI.04>>
                IF PurchaseHeaderAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") THEN
                    //VALIDATE("Payment User",lApprovalEntry."Approver ID");
                    PurchaseHeaderAdditional.VALIDATE("PQ Approver", lApprovalEntry."Approver ID");
            //HEI.04<<
        END;
        //HEI.03<<
    end;
    //BC Upgrade KAPOOV01 Codeunit-415-HEI.03,HEI.04 #Created new function -OnCodeOnBeforeModifyHeader & Subscribed to event-OnCodeOnBeforeModifyHeader of function-Code() <<



    //BC Upgrade KAPOOV01 Codeunit-415 #Created new function -OnBeforePerformManualRelease & Subscribed to event-OnBeforePerformManualRelease of function-PerformManualCheckAndRelease() >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", OnBeforePerformManualRelease, '', false, false)]
    local procedure OnBeforePerformManualRelease(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    var
        PurchaseHeader1: Record "Purchase Header";
        PurchaseHeaderL: Record "Purchase Header";
        PurchasesPayablesSetupL: Record "Purchases & Payables Setup";
        PONoL: Code[20];
        DocTypeL: Enum "Purchase Document Type";
    begin
        IsHandled := true;
        //HEI.01>>
        IF PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::Order,
                                           PurchaseHeader."Document Type"::"Return Order"] THEN BEGIN
            PONoL := PurchaseHeader."No.";
            DocTypeL := PurchaseHeader."Document Type";
        END;
        //HEI.01<<

        CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);

        //HEI.01>>
        IF (DocTypeL IN [DocTypeL::Order, DocTypeL::"Return Order"]) AND (PONoL <> '') AND (NOT PurchaseHeader."Changed FND") THEN BEGIN
            PurchasesPayablesSetupL.GET();
            IF PurchasesPayablesSetupL."Auto E-mail Active FND" THEN BEGIN
                PurchaseHeaderL.SETRANGE("Document Type", DocTypeL);
                PurchaseHeaderL.SETRANGE("No.", PONoL);
                PurchaseHeaderL.SETRANGE(Status, PurchaseHeaderL.Status::Released);
                PurchaseHeaderL.SETRANGE("SRM Order No. FND", '');
                PurchaseHeaderL.SETRANGE("BRC Purchase Order FND", FALSE);
                IF PurchaseHeaderL.FINDFIRST() THEN;
                //PurchaseHeaderL.SendEmailPurchaseOrder(PurchaseHeaderL,TRUE,TRUE);//HEI.09
            END;
        END;
        //HEI.01<<

        //<<HEI.02
        //HEI.11>>
        //IF (PurchHeader."No. Printed" >= 1) AND (PurchHeader.Changed) THEN
        IF (PurchaseHeader."No. Printed" >= 1) AND (PurchaseHeader."Changed FND") AND (PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::"Return Order"]) THEN
          //HEI.11<<
          BEGIN
            PurchaseHeader.SendEmailPurchaseOrder(PurchaseHeader, TRUE, TRUE);
        END;
        //>>HEI.02

        //  CODEUNIT.RUN(CODEUNIT::"Release Purchase Document",PurchHeader);  //>> HEI.08


    end;
    //BC Upgrade KAPOOV01 Codeunit-415 #Created new function -OnBeforePerformManualRelease & Subscribed to event-OnBeforePerformManualRelease of function-PerformManualCheckAndRelease() <<


    //BC Upgrade KAPOOV01 Codeunit-415-HEI.02,HEI.10 #Created new function -OnPerformManualReleaseOnBeforeTestPurchasePrepayment & Subscribed to event-OnPerformManualReleaseOnBeforeTestPurchasePrepayment of function-PerformManualRelease() & added Standard and custom code of function-PerformManualRelease >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", OnPerformManualReleaseOnBeforeTestPurchasePrepayment, '', false, false)]
    local procedure OnPerformManualReleaseOnBeforeTestPurchasePrepayment(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean)
    var
        PurchaseLine: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        PurchasesUtils: Codeunit "Purchases-Utils";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowNotFoundError: TextConst ENU = 'Purchase Invoice %1 have upper tolerance restriction and "tolerance approval" is mandatory in" Purchases & Payable setup" but workflow is not enabled for the same.';
        PrepaymentMgt: Codeunit "Prepayment Mgt.";
        Text005: TextConst ENU = 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.', FRA = 'Il existe des factures dacompte impayées liées au document de type %1 portant le numéro %2.';
        Text002: TextConst ENU = 'This document can only be released when the approval process is complete.', FRA = 'Ce document ne peut ˆtre lanc‚ que lorsque le processus d''approbation est termin‚.';
    begin

        IF (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) AND PrepaymentMgt.TestPurchasePayment(PurchaseHeader) THEN BEGIN
            IF PurchaseHeader.Status <> PurchaseHeader.Status::"Pending Prepayment" THEN BEGIN
                PurchaseHeader.Status := PurchaseHeader.Status::"Pending Prepayment";
                PurchaseHeader.MODIFY();
                COMMIT();
            END;
            ERROR(STRSUBSTNO(Text005, PurchaseHeader."Document Type", PurchaseHeader."No."));
        END;

        //HEI.10>>
        PurchasesPayablesSetup.GET();
        IF (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) AND PurchasesPayablesSetup."Check Tolerance Approval FND" THEN BEGIN
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::" ");
            //IF PurchaseLine.FINDSET(TRUE, FALSE) THEN
            IF PurchaseLine.FINDSET(TRUE) THEN //BC Upgrade KAPOOV01 removed second parameter for UpdateKey from FINDSET function, its being depreciated.
                REPEAT
                    PurchasesUtils.CheckToleranceForEsker(PurchaseLine);
                UNTIL PurchaseLine.NEXT() = 0;
            //----------------------------------
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::" ");
            PurchaseLine.SETRANGE("Tolerance Exceeded FND", TRUE);
            //IF PurchaseLine.FINDSET(TRUE, FALSE) THEN
            IF PurchaseLine.FINDSET(TRUE) THEN //BC Upgrade KAPOOV01 removed second parameter for UpdateKey from FINDSET function, its being depreciated.
                IF (PurchaseHeader.Status = PurchaseHeader.Status::Open) AND NOT ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) THEN
                    ERROR(WorkflowNotFoundError, PurchaseHeader."No.");
        END;
        //HEI.10<<

        IF ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchaseHeader) AND (PurchaseHeader.Status = PurchaseHeader.Status::Open) THEN
            ERROR(Text002);

        CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);

        SetManualReleaseBoolean(true);  //BC Upgrade KAPOOV01 Set Global Variable- gManualRelease_var to true once functions PerformManualRelease completes execution without any error.
    end;
    //BC Upgrade KAPOOV01 Codeunit-415-HEI.02,HEI.10 #Created new function -OnPerformManualReleaseOnBeforeTestPurchasePrepayment & Subscribed to event-OnPerformManualReleaseOnBeforeTestPurchasePrepayment of function-PerformManualRelease() & added Standard and custom code of function-PerformManualRelease <<

    //BC Upgrade KAPOOV01 Codeunit-415 #Created new function -OnBeforeTestPurchPrepayment & Subscribed to event-OnBeforeTestPurchPrepayment of function-TestPurchasePrepayment() of Codeunit-Prepayment Mgt. to Skip function-TestPurchasePrepayment in PerformManualRelease function as in Heilite Navision this function is not called in PerformManualRelease function >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prepayment Mgt.", OnBeforeTestPurchPrepayment, '', false, false)]
    local procedure OnBeforeTestPurchPrepayment(PurchHeader: Record "Purchase Header"; var TestResult: Boolean; var IsHandled: Boolean)
    var

    begin
        if gManualRelease_var = true then begin
            IsHandled := true;
            TestResult := false;
        end;
    end;

    //BC Upgrade KAPOOV01 Codeunit-415 #Created new function -OnBeforeTestPurchPrepayment & Subscribed to event-OnBeforeTestPurchPrepayment of function-TestPurchasePrepayment() of Codeunit-Prepayment Mgt. to Skip function-TestPurchasePrepayment in PerformManualRelease function as in Heilite Navision this function is not called in PerformManualRelease function <<

    //BC Upgrade KAPOOV01 Codeunit-415 #Created new function -OnBeforePerformManualCheckAndRelease & Subscribed to event-OnBeforePerformManualCheckAndRelease of function-PerformManualRelease() to Skip rest of the BC standard code in PerformManualRelease function as required code is written on event subscriber function-OnPerformManualReleaseOnBeforeTestPurchasePrepayment >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", OnBeforePerformManualCheckAndRelease, '', false, false)]
    local procedure OnBeforePerformManualCheckAndRelease(var PurchHeader: Record "Purchase Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    var

    begin
        if gManualRelease_var = true then
            IsHandled := true;

        clear(gManualRelease_var);
    end;
    //BC Upgrade KAPOOV01 Codeunit-415 #Created new function -OnBeforePerformManualCheckAndRelease & Subscribed to event-OnBeforePerformManualCheckAndRelease of function-PerformManualRelease() to Skip rest of the BC standard code in PerformManualRelease function as required code is written on event subscriber function-OnPerformManualReleaseOnBeforeTestPurchasePrepayment <<

    //BC Upgrade KAPOOV01 Codeunit-415 #Created new function SetManualReleaseBoolean to set Global variable- gManualRelease_var value to skip >>
    procedure SetManualReleaseBoolean(ManualRelease_Param: Boolean)
    var
        myInt: Integer;
    begin
        gManualRelease_var := ManualRelease_Param;
    end;

    //BC Upgrade KAPOOV01 Codeunit-415 #Created new function SetManualReleaseBoolean to set Global variable- gManualRelease_var value to skip <<



    //BC Upgrade KAPOOV01 Codeunit-415-"Release Purchase Document" End here <

    var
        InputReversalPostingDate: Date;
        RunFromStockKeepingUnit: Boolean;  // BC Upgrade YADAVM09 - Declared global variable
        StockkeepingUnit2: Record "Stockkeeping Unit";  // BC Upgrade YADAVM09 - Declared global variable
        ForBlankVersionCode: Boolean;  // BC Upgrade YADAVM09 - Declared global variable
        DontShowMsg: Boolean;  // BC Upgrade YADAVM09 - Declared global variable
        CreateLog: Boolean; // BC Upgrade SHUKLP03 << CodeUnit 23
        ErrorTextL: Text[250]; // BC Upgrade SHUKLP03 << CodeUnit 23
        ItemJnlLineError: Record "Item Journal Line"; // BC Upgrade SHUKLP03 << CodeUnit 23
        ItemJnlLine: Record "Item Journal Line"; // BC Upgrade SHUKLP03 << CodeUnit 23
        GLSetup: Record "General Ledger Setup"; // BC Upgrade SHUKLP03 << CodeUnit 23
        HideValidationDialogWFM: Boolean;
        ShowNotificationDialogWFM: Boolean;
        PurchaseOrdersNos: Text;  //BC Upgrade KAPOOV01 created new Global Variable-PurchaseOrdersNos for CU333-Req. Wksh.-Make Order as this variable value is updated in one function and used in another functions under HEI.07 TAG.

        ByItemWeight: Label 'By Item Weight';
        ByItemCubbage: Label 'By Item Cubbage';
        ByItemQuantity: Label 'By Item Quantity';
        blnCheckFromLineSuspend: Boolean;
        blnAssignParentOnly: Boolean;

        CostAccSetup: Record "Cost Accounting Setup";
        GLAcc: Record "G/L Account";
        CostType: Record "Cost Type";
        Window: Dialog;
        i: Integer;
        NoOfCostTypes: Integer;
        NoOfGLAcc: Integer;
        RecsProcessed: Integer;
        RecsCreated: Integer;
        CostTypeExists: Boolean;

        Text016: TextConst Comment = '%1=Table caption Cost Center or Cost Object;%2=Field Value', ENU = 'Do you want to create %1 %2 in Cost Accounting?', FRA = 'Souhaitez-vous créer %1 %2 dans la comptabilité analytique ?';
        Text017: TextConst Comment = '%1=Table caption Cost Center or Cost Object or Cost Type;%2=Field Value', ENU = '%1 %2 has been updated in Cost Accounting.', FRA = '%1 %2 a été mis à jour dans Comptabilité analytique.';
        Text023: TextConst Comment = '%1=Table caption Cost Center or Cost Object or Cost Type or Dimension Value;%2=Field Value', ENU = 'The %1 %2 cannot be inserted because it already exists as %3.', FRA = 'Vous ne pouvez pas insérer %1 %2 car il existe déjà en tant que %3.';
        Text024: TextConst Comment = '%1=Table caption Cost Center or Cost Object;%2=Field Value', ENU = 'Do you want to update %1 %2 in Cost Accounting?', FRA = 'Souhaitez-vous mettre à jour %1 %2 dans la comptabilité analytique ?';

        Text000: TextConst ENU = 'Fiscal Year %1';
        Text10801: TextConst ENU = 'The starting date must be the first day of a month.', FRA = 'La date de début doit être le premier jour du mois.';
        Text10802: TextConst ENU = 'The ending date must be the last day of a month.', FRA = 'La date de fin doit correspondre au dernier jour du mois.';
        Text10800: TextConst ENU = 'The selected date is not a starting period.', FRA = 'La date choisie nest pas un début de période.';
        DateInsteadOfPeriodErr: TextConst ENU = 'You must enter a date interval, such as 01.01.17..31.01.17.', FRA = 'Vous devez entrer un intervalle de temps, par exemple 01.01.17..31.01.17.';
        // ItemJnlLineError: Record "Item Journal Line"; // BC Upgrade YADAVM09 - Declared global variable << codeunit 5802
        // CreateLog: Boolean; // BC Upgrade YADAVM09 - Declared global variable << codeunit 5802
        GCalledFromItemPosting: Boolean;// BC Upgrade YADAVM09 - Declared global variable << codeunit 5802
        GCalledFromTestReport: Boolean;// BC Upgrade YADAVM09 - Declared global variable << codeunit 5802

        ItemTrackLine: Page "Item Tracking Lines";
        CurrentSourceTypeOrg: Integer;
        SkipWriteToDatabaseOrg: Boolean;
        CurrentRunModeOrg: Enum "Item Tracking Run Mode";
        gManualRelease_var: Boolean;  //BC Upgrade KAPOOV01 Codeunit-415 #Created new Global variable to restructure code in standard function-PerformManualRelease.

    // YADAVM09 <<Codeunit5817 "Undo Posting Management">>

    // DITW18.00.06 MSF 06/02/2015 DIT-770 #1185
    // DITW18.00.06 MSF 09/02/2015 DIT-770 #1186 Added param to fct UpdateStdCostSharesSKU
    //Added function RecalcStdCostSKU
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // HEI.01 CHG2100218 IBM SAXENA03 25.03.2021
    // # Replaced FIND('-') with FINDSET(false,false) of function FindUpdateUnitCostSKU() & ExcludeOpenOutbndCosts()
    // # Replaced FIND('+') with FINDLAST of function CalcLastAdjEntryAvgCost()
    // # Added new Key under SETCURRENTKEY() of ExcludeOpenOutbndCosts()
    // # Added SETCURRENTKEY() in FindUpdateUnitCostSKU()

    // HEI.01 CHG2251877 MAJUMS03 17.07.2024 Warehouse Receipt Lines creation issue.
    //# Code added to update "Delivery Finalized" := FALSE of Purchase Line during Undo Operation.

    // YADAVM09 <<Codeunit5817 "Undo Posting Management">>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Posting Management", 'OnUpdatePurchLineOnAfterSetQtyToReceive', '', false, false)]
    local procedure OnUpdatePurchLineOnAfterSetQtyToReceive(var PurchLine: Record "Purchase Line")
    begin
        PurchLine."Delivery Finalized FND" := FALSE; //HEI.01
    end;
    // YADAVM09 <<Codeunit5817 "Undo Posting Management"<<

    //YADAVM09<<5814- "Undo Return Shipment Line">>
    //     DITW15.00.00.16 DDR 27/03/2008 Added Drink-it Undo Item Charges functionnalities
    //                                added function UndoItemChargeAssgnt(),CountPurchItemChargeAssgntLine()
    // DITW15.00.00.23 DDR 22/07/2008 Include undo of Discount/Promotion and any Charge type Lines
    //                     12/08/2008 Certification Rules
    //                                  Remove local variable lrReturnShptLine2 (function UndoItemChargeAssgnt)
    // DITW15.00.00.24 DDR 19/09/2008 Include all item charge types attached to main item
    // DITW15.00.00.28 DDR 28/11/2008 Avoid undo when AAD document has been created.
    // DITW15.00.00.33 DDR 08/05/2009 Added field "Duty Suspended"
    // DITW15.00.00.34 DDR 10/06/2009 Added field "Periodic Disc.-Promo Entry No."
    // DITW15.00.00.35 DDR 29/07/2009 Added fields
    //                                  "Gen. Prod. Posting Free Group","Free Item Posting Type","Free Item",
    //                                  "Free Calculation Type","Include Free Qty. in Minimum";
    //                     07/08/2009 issue 756 Added undo (due) tax item charges posted into G/L entries when duty point shipment
    //                                          Added check if AAD is already created (printed)
    //                                          Added fields "Tax Formula","tariff no.";
    // DITW15.00.00.37 DDR 01/03/2010 issue 1089 Bugfix Invoiced qty item charges after the undo.
    //                                           Bugfix item (promotion) with quantity zero
    //                                           Bugfix the quantity assigned is not undone for exise item charges into Order documents.
    //                                           Bugfix insert new undo item charge lines (per order)
    // DITW15.00.00.38 DDR 11/10/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                           Added to check if line is linked to ARC No. and valid to cancel
    //                                           Added to reverse "No. of Packages"
    //                     19/10/2010 issue 1237 Bugfix undo lines when an item line has more one item tracking line
    //                     19/11/2010 issue 1139 SSCC Functionnalities
    //                                           Added codeunit 'Permissions' property for
    //                                             table2035045 SSCC Entry Relation
    //                     26/11/2010 issue 1217 (DIT711 83) Bugfix to check LRN/ARC with EDI record
    //                     01/12/2010 issue 1226 Undo Whse Shipment documents + links
    //                                           Added codeunit 'Permissions' property for
    //                                             table6509 Whse. Item Entry Relation
    //                                             table2035047 Whse. SSCC Entry Relation
    //                     03/12/2010 issue 1229 Added to undo the posted due taxes
    //                     17/12/2010 issue 703 Added fields "Tax Item No."
    // DITW15.00.00.39 DDR 23/06/2011 issue 1350 Bugfix to undo (free) item as item charge lines
    //                     28/06/2011 issue 1375 Allowed to undo item promotion (posted seperately of linked item
    //                                           Bugfix to skip check item entries with shipment lines when quantity zero
    // DITW15.00.00.40 DDR 17/11/2011 issue 1463 Bugfix Standard Navision W15 SP1
    //                                           Upgrade based on version W16 SP1 (R2)
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added field "Allow VAT Calculation (Free)"
    //                     11/05/2012 DIT-715 #344 Bugfix to call function UpdateItemChargeAssgnt()
    // DITW16.00.00.43 DDR 08/11/2013 DIT-715 #752 Extended SSCC non-Specific
    //                 DDR 13/11/2013 DIT-715 #753 Bugfix to insert the full undo item lines and charges (if more than 10 attached lines)
    //                 DDR 18/11/2013 DIT-715 #752 Bugfix to undo item charge with item/sscc tracking

    // DITW17.00.01 VVE 29/03/2013 Check in EDI Data Setup which draft 810 document should be created
    //              DDR 28/08/2013 DIT-770 #178 Remove UK EMCS
    // DITW17.00.02 DDR 08/11/2013 DIT-715 #752 Merge
    //              DDR 13/11/2013 DIT-715 #753 Merge
    // DITW17.00.02 DDR 18/11/2013 DIT-715 #752 Merge
    // DITW17.10.03 DDR 15/04/2014 DIT-770 #629 Bugfix missing quantity to undo item charges
    // DITW17.10.05 DDR 19/08/2014 DIT-770 #776 Added Deposit point functionality
    // DITW17.10.05 DDR 10/03/2015 DIT-770 #1258 Added undo EMCS composed items (giftbox)
    // DITW17.10.05 DDR 11/03/2015 DIT-770 #1271 Added if license EMCS
    // DITW17.10.05 DDR 13/03/2015 DIT-770 #1275 Added check to cancel draft edi outbox
    // DITW18.00.06 MSF 20/08/2015 DIT- 770 #1298 EMCS: Undo from Shipment Header doesn't automatically create 810 - EDI Outbox anymore

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 13/04/2017 NRQ#13107 Fix review EMCS multi-returnShipments
    //                                        Fix OnRun() local variable Rec3,TempRec3
    // DITW110.00.10 MSF 08/06/2017 NRQ#18228 Impossible to do UNDO Shipment
    // DITW110.00.10 MSF 27/06/2017 NRQ#18228 Undo Purchase receipt line Create too much values entries
    //                                        Rename variable ReturnShptLine to FromReturnShptLine in  Function GetLineValueEntries

    // HEI.01 HLSRM05 IBM LAZARE02 31.08.2017 # Enable undo for G/L accounts and item charges
    // HEI.02 DefectID 442 LAZARE02 10.11.2017 # code added
    // HEI.03 CHG2278883 IBM ADHIKG01 18.03.2025 Create Document Shipping Cost table - Static performance
    //   # Aptean Fix
    //   # NRQ#251610 DDR 07/03/2025 Add undo shipping costs

    //Bc Upgrade YADAVM09 //HEI.01 not added due to dependency on Drink it field.
    //Bc Upgrade YADAVM09 Code function //HEI.01>> is added in event OnBeforeCheckReturnShptLine another code with //HEI.01<< is added in onbeforecorrectionlineno.
    //Bc Upgrade YADAVM09 Function UpdateOrderLine code added in event OnUpdateOrderLineOnBeforeUpdatePurchLine but blocked due to dependency on Drink it field.

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Return Shipment Line", 'OnBeforeCheckReturnShptLine', '', false, false)]
    local procedure OnBeforeCheckReturnShptLine(var ReturnShptLine: Record "Return Shipment Line"; var IsHandled: Boolean)
    var
        Text004: label 'This shipment has already been invoiced. Undo Return Shipment can be applied only to posted, but not invoiced shipments.';
        AlreadyReversedErr: Label 'This return shipment has already been reversed.';
        UndoPostingMgt: Codeunit "Undo Posting Management";
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
    begin
        //HEI.01>>
        IF ReturnShptLine.Type IN [ReturnShptLine.type::"G/L Account", ReturnShptLine.Type::"Charge (Item)"] THEN BEGIN
            IF ReturnShptLine."Return Qty. Shipped Not Invd." <> ReturnShptLine.Quantity THEN
                ERROR(Text004)
        END ELSE begin
            if ReturnShptLine.Correction then
                Error(AlreadyReversedErr);
            if ReturnShptLine."Return Qty. Shipped Not Invd." <> ReturnShptLine.Quantity then
                Error(Text004);

            if ReturnShptLine.Type = ReturnShptLine.Type::Item then begin
                ReturnShptLine.TestProdOrder();

                UndoPostingMgt.TestReturnShptLine(ReturnShptLine);
                IsHandled := false;
                OnCheckReturnShptLineOnBeforeCollectItemLedgEntries(ReturnShptLine, IsHandled);
                if not IsHandled then begin
                    UndoPostingMgt.CollectItemLedgEntries(TempItemLedgEntry, DATABASE::"Return Shipment Line",
                    ReturnShptLine."Document No.", ReturnShptLine."Line No.", ReturnShptLine."Quantity (Base)", ReturnShptLine."Item Shpt. Entry No.");
                    UndoPostingMgt.CheckItemLedgEntries(TempItemLedgEntry, ReturnShptLine."Line No.");
                end;
            end;
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Return Shipment Line", 'OnBeforeGetCorrectionLineNo', '', false, false)]
    local procedure OnBeforeGetCorrectionLineNo(ReturnShptLine: Record "Return Shipment Line"; var Result: Integer; var IsHandled: Boolean)

    var
        CuUndoReturnShipmentLine: Codeunit "Undo Return Shipment Line";
    begin
        //HEI.01>>
        IF ReturnShptLine.Type IN [ReturnShptLine.Type::"G/L Account", ReturnShptLine.Type::"Charge (Item)"] THEN //BEGINBc Upgrade YADAVM09
                                                                                                                  // CLEAR(ItemShptEntryNo);//Bc Upgrade YADAVM09
                                                                                                                  //DocLineNo := ReturnShptLine."Line No." + 100;
            ReturnShptLine."Line No." := ReturnShptLine."Line No." + 100;//Bc Upgrade YADAVM09
                                                                         // END ELSE//Bc Upgrade YADAVM09 Not required as already running in base for type item.
                                                                         //HEI.01<<
                                                                         // ItemShptEntryNo := PostItemJnlLine(ReturnShptLine, DocLineNo);//Bc Upgrade YADAVM09 Not required as already running in base for type item.
    end;


    [IntegrationEvent(false, false)]
    local procedure OnCheckReturnShptLineOnBeforeCollectItemLedgEntries(ReturnShipmentLine: Record "Return Shipment Line"; var IsHandled: Boolean)
    begin
    end;
    //YADAVM09<<5814- "Undo Return Shipment Line"<<

    //YADAVM09<<6620- Copy Document Mgt.>>

    //   DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    //   DITW15.00.00.01 DDR 21/12/2007 Added Drink-it Tax Item Charges functionnalities
    //   DITW15.00.00.01 DDR 03/01/2008 Added field "Item Charge Type"
    //                                  Added Purchase copy Item Charge fields (temp disabled)
    //   DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    //   DITW15.00.00.01 DDR 15/01/2008 Changed function TransfldsFromSalesToPurchLine()
    //                                  Changed function CopyFromSalesDocAssgntToLine(),CopyFromPurchDocAssgntToLine() to copy "Assign Qty."
    //                                  Added Auto-Assign Item charges for lines not assigned yet if recalculate is yes
    //                                  Added function CopyFromSalesDocAssgnToPurchLn()
    //   DITW15.00.00.01 DDR 22/01/2008 Added Drink-it Discount & Promotion Item Charges functionnalities
    //                                  Added field "Collapse"
    //                                  Change calling function to insert Charges into function RecreateSalesLines()
    //                                  Ignore Discount & Promotion with "Item Charge Calculate per"::Order
    //   DITW15.00.00.01 DDR 05/02/2008 Bugfix Copy Drink-it fields between From/to header
    //                                  Added Drink-it Reversing Calculation (Rounding) functionnalities
    //   DITW15.00.00.01 DDR 20/02/2008 Added field2013785 Periodic Disc.-Promo Entry No.
    //   DITW15.00.00.01 DDR 10/03/2008 filters about negative lines to copy
    //   DITW15.00.00.01 DDR 10/03/2008 change parameter function AutoSuggestItemChargeAssgnt()
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.17 DDR 03/04/2008 Bugfix clear fields "
    //                                  Bugfix skip item promotion to call function CalcUnitPriceSalesLine()
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //                       07/04/2008 Change call function insertCharges2() to insertCharges4()
    //                                  Copy the attached charges lines when RecalculateLines = No
    //                                    with function CopyFromSalesDocAssgntToLine(),CopyFromPurchDocAssgntToLine()
    //                                  Create new Assignment Item charges when RecalculateLines = No
    //   DITW15.00.00.23 DDR 25/07/2008 Bugfix to recalculate back new prices into CopySalesLines(),CopyPurchLines()
    //                                  Save current record with new item charges into functions
    //                                    CopyFromSalesToPurchDoc(),CopySalesLine(),CopyPurchLine()
    //                                  Bugfix when no recalculating the Charges (item) lines the auto-quantity is not initialized back
    //                                    CopyFromSalesDocAssgntToLine(),CopyFromPurchDocAssgntToLine()
    //                                  Updated if use "Get Posted Document Lines" in "Return Order"
    //                                    CopySalesShptLinesToDoc();CopySalesInvLinesToDoc();
    //                                    CopySalesReturnRcptLinesToDoc();CopySalesCrMemoLinesToDoc()
    //                                    CopyPurchRcptLinesToDoc();CopyPurchInvLinesToDoc();
    //                                    CopyPurchCrMemoLinesToDoc();CopyPurchReturnShptLinesToDoc()
    //                                  Added parameter standard functions
    //                                    prFromChrgSalesLine,prTempItemTrkgEntry,prNextItemTrkgEntryNo -> SplitPstdSalesLinesPerILE()
    //                                    prFromChrgPurchLine,prTempItemTrkgEntry,prNextItemTrkgEntryNo -> SplitPstdPurchLinesPerILE()
    //                                  Added 3 parameters into standard function
    //                                    prFromChrgSalesLine,prToSalesHeader,prFromSalesHeader -> SplitSalesDocLinesPerItemTrkg()
    //                                    prFromChrgSalesLine,prToPurchHeader,prFromPurchHeader -> SplitPurchDocLinesPerItemTrkg()
    //                                  Added functions
    //                                    CheckMarkedSalesShptLines(),CheckMarkedReturnRcptLines()
    //                                    CheckMarkedSalesInvLines(),CheckMarkedSalesCrMemoLines()
    //                                    CheckMarkedPurchRcptLines(),CheckMarkedReturnShptLines()
    //                                    CheckMarkedPurchInvLines(),CheckMarkedPurchCrMemoLines()
    //                                    GetAttachedSalesShptLines(),GetAttachedReturnRcptLines()
    //                                    GetAttachedSalesInvLines(),GetAttachedSalesCrMemoLines()
    //                                    GetAttachedPurchRcptLines(),GetAttachedReturnShptLines()
    //                                    GetAttachedPurchInvLines(),GetAttachedPurchCrMemoLines()
    //                                    SplitPstdChrgSalesLinesPer(),SplitPstdChrgPurchLinesPer()
    //                                    SubSplitPstdChrgSalesLinesPer(),SubSplitPstdChrgPurchLinesPer()
    //                       12/08/2008 Certification Rules
    //                                    Remove local variable lToFirstLineNo (function CopyPurchReturnShptLinesToDoc)
    //   DITW15.00.00.24 DDR 04/09/2008 Bugfix merge into function UTlocalCall() missed std. c/al
    //   DITW15.00.00.26 DDR 31/10/2008 Added fields to copy (Cubage,Weight,Shipping charge per)
    //   DITW15.00.00.31 DDR 19/02/2009 Recalculate lines with Price include taxes with function 'Move Negative line'
    //                                  Don't move negative (charge) discount lines attached to the items.
    //   DITW15.00.00.33 DDR 08/05/2009 Added field "Duty Suspended"
    //   DITW15.00.00.34 DDR 16/06/2009 Bugfix to retrieve the charge lines when it doesn't recalculate lines
    //   DITW15.00.00.35 DDR 27/07/2009 issue 734: Bugfix when recalculate line, header field "Disc.Promo. Order Calculated" is not cleared
    //                                  issue 669: Added fields
    //                                    "Gen. Prod. Posting Free Group","Free Item Posting Type","Free Item",
    //                                    "Free Calculation Type","Include Free Qty. in Minimum"
    //                                    Review to allow free items and multi-level item charges
    //                                    Updated parameter for all functions GetAttached...Lines()
    //                       21/08/2009 issue 636
    //                                    Review to allow exact cost reversing when Free items
    //                       14/09/2009 Added Purchase Service Functions
    //                                    CopyServPurchContractLines(),ServContractPurchHeaderDocType(),ProcessServPurchContractLine()
    //                       30/10/2009 issue 930 Bugfix missing Auto assign for all item charge per item
    //   DITW15.00.00.36 DDR 23/11/2009 issue 939 Updated parameter function CalcBackUnitPriceItem(),CalcBackDirectCostItem()
    //                       27/11/2009 issue 796 Auto suggest assignment for other item charge types (G/L account)
    //                       10/12/2009 issue 988 Bugfix don't recalculate unit price/direct unit with discount/promotion per order
    //                       11/12/2009 issue 988 sign of discounts after get posted document to reverse
    //                       11/12/2009 issue 988 Bugfix recalculate partial quantity
    //   DITW15.00.00.37 DDR 20/01/2010 issue 1020 Added transfer fields
    //                                    "Location Group Code","Company Tax Registration No.","Physical Location Group Code","Tax Formula"
    //                       04/02/2010 issue 1033 Added field "Disc.Promo. Order Calculated" for lines
    //                       16/02/2010 issue 786 Bugfix don't find the link about attached item charge lines
    //                       16/02/2010 issue 1075 Bugfix item ledger entry not found when quantity = 0 while copying line
    //                       18/02/2010 issue 1066 Bugfix Recalculate the assigned amount in Assignment table after copied line.
    //                       19/02/2010 issue 786 Bugfix std copy line discount % + Amount with item charges
    //                       01/03/2010 issue 786 Bugfix find new link with free items
    //                                  issue 1033 Set field "Disc.Promo. Order Calculated" when no recalculation
    //                                             Removed for Header because converted to flowfield
    //                       04/03/2010 issue 1075 Added to fill in (back) fields "Location Group Code","Physical Location Group Code"
    //                                             Added function GetLocation()
    //                       29/03/2010 issue 1085 copy "discount %" for attached item charges
    //                       14/04/2010 issue 1085 Skipped DIT fields when sales/purchase "type" = ''
    //                       26/04/2010 issue 1071 Bugfix to keep field "Disc.Promo. Order Calculated" when get document functions
    //                       27/10/2010 issue 1085 Skipped DIT fields when sales/purchase "type" = ''
    //                       03/05/2010 issue 1085 Don't recalculate the unit price while copying the item charges with RecalculateLines
    //                       04/05/2010 issue 1133 Bugfix to keep/update item charge unit price with free item price 0.
    //                       11/05/2010 issue 1061 Added field "Physical Location Group Code"
    //                       25/05/2010 issue 1030 Bugfix to skip discount/promotion per order
    //                                               when manual copy document + option 'recalculate lines
    //                       18/06/2010 issue 1145 to recalculate lines per order when splitted per item ledger entry
    //                                               (std using setup: Exact Cost Reversing Mandatory)
    //   DITW15.00.00.38 DDR 10/08/2010 issue 1217 Removed fields "Tax Spec. HL","Tax Spec. Degrees Plato"
    //                                             Added to transfer all EMCS fields
    //                       16/09/2010 issue 1223 Bugfix to copy std. item charges from posted invoice into Cr.memos
    //                       22/10/2010 issue 1139 SSCC Functionnalities
    //                                             Added functions InsertTempSSCCTrkgEntry(),CollectSSCCTrkgPerPstDocLine()
    //                       15/12/2010 issue 1246 Bugfix sign of discount per order (type charge opposite sign)
    //                       17/12/2010 issue 703 Added fields "Tax Item No."
    //                       16/02/2011 issue 1217 (DIT711 148) Added transfer value field "Pack Qty. per Unit of Measure"
    //   DITW15.00.00.39 DDR 11/07/2011 issue 1369 Added  to transfer fields "Applies-to AAD Trck. Entry No."
    //                       27/07/2011 issue 1407 Added to set field "Autom. Item Charge" while copying posted documents
    //                       29/08/2011 issue 1396 Added Item Exclusivity functionnality (check warning while insert item)
    //                       31/08/2011 issue 1403 Added to clear fields "Service Item Document No.","Service Item Line No."
    //   DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added field "Allow VAT Calculation (Free)"
    //                       20/01/2012 DIT-715 #172 Modified workflow (+Rollback)
    //                       19/04/2012 DIT-715 #243 Loyalty functionnality
    //                       22/05/2012 DIT-715 #330 Bugfix functions SplitPstdSalesLinesPerILE(),SplitPstdPurchLinesPerILE()
    //   DITW16.00.00.41 AHU 25/07/2012 DIT-715 #392 Added functions
    //                                                 CopyDITContractLines(),ProcessDITContractLine(),DITContractHeaderDocType()
    //                                               Added to copy Sales/Purchase fields
    //                                                 "Service contract no.","Service contract line no.","dit sub-contract line no."
    //                                                 "Contract Group Code","Service Contract Type"
    //   DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields to Copy Sales/Purchase fields
    //                                                 "Deposit Customer Posting Group","Deposit Vendor Posting Group"
    //                                                 "Deposit Payment Terms Code"
    //                       01/03/2013 DIT-715 #572 Bugfix to copy sales/purchase item charge assignment lines
    //   DITW16.00.00.43 FBL 18/06/2013 DIT-715 #619 Clear field "Created by Contract Batch Job" when copying document lines
    //                   DDR 19/08/2013 DIT-715 #698 Added call function SetDefaultQuantity()
    //                   DDR 05/12/2013 DIT-715 #761 Added extended copy Lot & SSCC tracking
    //                   DDR 22/01/2014 DIT-715 #882 Added fields 2014415 Item Charge Qty. per Uom
    //   DITW16.00.00.44 DDR 14/04/2014 DIT-715 #910 Removed obsolete DIT fields when (split) per item tracking

    //   DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    //   DITW17.00.02 DDR 20/08/2013 DIT-715 #698 merge
    //   DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0014.1
    //   DITW17.00.02 DDR 13/11/2013 DIT-770 #230 Added fields "DDiscount Level Position","DDiscount Include Tax","DDiscount Include Deposit","DDiscount Include Discount"
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW17.00.02 DDR 14/01/2014 DIT-715 #761 Merge
    //   DITW17.00.02 DDR 23/01/2014 DIT-715 #882-893 Merge
    //   DITW17.00.03 DDR 07/03/2014 DIT-770 #531 Bugfix don't recalculate "Line Discount %" on std. item lines
    //   DITW17.00.03 DDR 15/04/2014 DIT-770 #910 Merge
    //   DITW17.10.03 DDR 16/04/2014 DIT-770 #630 Upgrade R2 missing test if item type line
    //   DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #623 New Customer Exception Tax Group functionality
    //                                            copy field "Customer DTax Group Code" sales lines
    //   DITW17.10.03 MSF 28/05/2014 DIT-770 #715 Upgrade W1 Rollup 6 ChangeLog.W1.36366 file 474255
    //   DITW17.10.03 DDR 30/06/2014 DIT-770 #793 Bugfix to round the unit price/ direct unit cost on DIT item charges
    //   DITW17.10.05 MSF 17/07/2014 DIT-770 #698 (Customer)Vendor suspended tax determined per document line + internal Tax
    //                                            copy field "Vendor DTax Group Code" Purchase lines
    //   DITW17.10.05 DDR 05/11/2014 DIT-770 #185 Added code to transfer Loyalty fields
    //   DITW17.10.05 MSF 17/12/2014 DIT-770 #807 Impossible to post sales orders when no SSCC granule in customers license
    //   DITW18.00 MSF 27/04/2015 DIT-770 #1363 Fix Upgrade tag
    //   DITW18.00.06 DDR 28/04/2015 DIT-770 #805 Bugfix License Quality Mgt.
    //   DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                             Rename Field Service contract Type => Contract Type
    //   DITW18.00.06 MSF 30/09/2015 DIT-770 #1617 Bugfix missing or recalculated dimensions on item charges
    //   DITW18.00.06 DDR 08/10/2015 DIT-770 #1617 Bugfix missing free items when no recaculation nor split per ILE
    //   DITW18.00.06 DDR 20/10/2015 DIT-770 #1449 Added fields Production BOM No.","Prod. BOM Version Code","BOM Line No.",
    //                                               "BOM Item No.","BOM Qty. per Unit of Measure"
    //   DITW18.00.06 DDR 26/10/2015 DIT-770 #1412 Added transfer field "No. of Packages"
    //   DITW18.00.07 DDR 21/01/2016 DIT-770 #1844 Bugfix keep discount/promotion per order when not recalculate lines
    //   DITW18.00.07 VSC 25/02/2016 DIT-770 #1843 Reuse of buffer invoice line information "Shipment No." Results in skipping deposit rounding.
    //   DITW19.00.07 MVN 14/03/2016 DIT-770 #1390 Replaced Procedure SetCreateDimParam with Default CreateDim
    //   DITW18.00.07 DDR 25/03/2016 DIT-770 #1844 Modified to keep Discount-Promotion at release after copy document
    //   DITW18.00.07 DDR 25/03/2016 DIT-770 #1936 Bugfix copy promotion per order
    //   DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    //   DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added code to copy/update Document subtype code
    //   DITW18.00.07 DDR 15/04/2016 DIT-770 #1844 Bugfix double disc. and promo. per order (copy document & Get reverse document)
    //                                             Bugfix missing #1617 for all copy functions
    //                                             Bugfix bad return shipment/receipt filters functions SplitPstdChrgSalesLinesPer();SplitPstdChrgPurchLinesPer();
    //                                             Bugfix filter functions DeleteSalesLinesWithNegQty();DeletePurchLinesWithNegQty()
    //                                             Added 'SplitLine' parameter functions SplitPstdChrgSalesLinesPer(); SplitPstdChrgPurchLinesPer()
    //                                             Added 'SplitLine' parameter functions SubSplitPstdChrgSalesLinesPer();SubSplitPstdChrgPurchLinesPer()
    //   DITW18.00.07 DDR 22/04/2016 DIT-770 #1961 Bugfix recalc. discount per order without splitline
    //   DITW18.00.07 DDR 25/04/2016 DIT-770 #1843 Bugfix don't copy/recalculate charges when not splitline
    //                                             Bugfix don't copy/recalculate charges when ExactCostRevMandatory
    //   DITW18.00.07 DDR 26/04/2016 DIT-770 #1844 Bugfix remove extra save from/to line no.
    //   DITW18.00.07 DDR 26/04/2016 DIT-770 #1963 Added Sales/Purch Header parameter functions RefreshRecalcBackSalesLines();RefreshRecalcBackPurchLines()
    //   DITW18.00.07 AKH 27/04/2016 DIT-770 #1508 Disabled code
    //   DITW18.00.07A DDR 29/07/2016 DIT-770 #2131 Modified to save original discount quantity
    //   DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                        Added fields "Strength Spec. Code","Strength Spec. Value","Vol-Strength Spec. Code";"Vol-Strength Spec. Value"
    //   DITW19.00.08 DDR 29/09/2016 BL#10443 added to transfer strength field values
    //   DITW19.00.08 DDR 20/10/2016 BL#10443 Removed "strength Spec. Value","vol-strength Spec. Value"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //   DITW110.00.09 VSC 12/04/2017 NRQ#18376 Init Strength value
    //   DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    //   DITW110.00.10 MSF 15/06/2017 NRQ#13382 Vendor dimension overwriten when validate Linked customer
    //                                          Added parameter to function CreateDim
    //   DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Changes for new fields
    //   HEI.01 FDD-GAPID001 IBM LAZARE02 10.08.2017 # New function SetInterfaceProperties
    //   HEI.02 FDD-PTPGAP085 IBM HORTOC01 03/05.2018 # new code
    //   FINXL11.00 HBA 03/05/2018 NRQ#69018 : Cleared "IC Document" field
    //   DITW111.00.13A NLAB 25/06/2019 NRQ#113801 : Merge NRQ#69018
    //   HEI.03 FDD-SLSGAP014 IBM HORTOC01 19.06.2018 # change check customer function
    //   HEI.04 FDD-PTPRFC161 - GRIR Clearing Report IBM ISYED01
    //     # added code to flow Receipt no while lodaing the Recpt using getdocument.
    //   HEI.05 CHG2009225 IBM ISYED01 5/20/2019 # Reduce labor intensive entries in 1day returns process-FDD
    //    # New filed Created - "Qty to receive"
    //   HEI.06 FDD-PURGAP027 IBM NASTAA02 12.06.2019 # Maximo POs Approval Flow
    //     # Code added to update also Addition Purchase Fields
    //   HEI.07 Defect #4195 IBM NASTAA02 30.07.2019 # Wrong number series of the document
    //     # Code added on function "CopySalesDoc" to update "Posting No. Series" for CTS Documents
    //   DITW113.00.15 DDR 04/10/2019 NRQ#10495 Rename Loyalty 'Cost' -> 'Amount' (all fields)
    //   DITW114.00.15 EZOG 05/02/2020 NRQ#137316 Set fixed Price when using Get Posted doc lines to reverse or Copy document
    //   HEI.08 CHG2024500 Defect #4418 IBM GAVANM01 10.03.2020 # No automatic return reason code in sales return order line when using get doc lines
    //     # new global variable: LocItem
    //     # Code added on functions: CopySalesShptLinesToDoc, CopySalesInvLinesToDoc, CopySalesReturnRcptLinesToDoc, CopySalesCrMemoLinesToDoc
    //   HEI.20 CHG2060654 IBM KUMARN15 16.04.2020
    //     # Code changed in functions CopySalesInvLinesToDoc, SplitSalesDocLinesPerItemTrkg, SubSplitPstdChrgSalesLinesPer
    //   DITW114.00.15 DDR 01/04/2020 NRQ#140339 Fix "item charge value" some cases and parameter 'blnRecalculateLinesSkipCharges'
    //   DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix call function CalcBackUnitPriceItem()
    //   CHG2104608:DITW111.00.13 ISL 18/12/2018 NRQ#96024 Updated code (Deleted field "Prod. BOM Version Code")
    //   HEI.21 FDD-HB2174 CHG2129099 IBM NANDIS01 03.03.2022 Ibecor integration interface INT03 and INT04
    //     # At time of Copy Doc error appears
    //   HEI.22 CHG2168337-HB2821 IBM SOICAD02 27.11.2022 Astro WMS
    //     # copy document should not copy WMS
    //   HEI.23 CHG2224401 HB3624 YADAVM09 05.04.2024 Health and Security Levy Tax
    //      # Code added in function #CopypurchinvlinetoDoc
    //                               #UpdatePurchline
    //   HEI.24 CHG2317685 SAHAL01 17.10.2025 Block Functionality Enhancement for Vendors
    //      # Added Code


    //Bc Upgrade YADAVM09 //HEI.07 NOT added due to dependency on drink it table Document Subtype code setup table.
    //Bc Upgrade YADAVM09 //HEI.22  of function CopySalesDoc added in event OnUpdateSalesCreditMemoHeaderOnBeforeSetShipmentDate.
    //Bc Upgrade YADAVM09 //HEI.03 OF Function CheckCustomer added in event OnBeforeCheckCustomer.
    //Bc Upgrade YADAVM09 //HEI.06 of function CopypurchDoc Added in OnBeforeUpdatePurchHeaderWhenCopyFromPurchHeader.
    //Bc Upgrade YADAVM09 //HEI.02 of function CopyPurchDoc Added in Event OnAfterCopyPostedPurchInvoice.
    //Bc Upgrade YADAVM09 For Function UpdatePurchLine //HEI.04 added in event OnUpdatePurchLineOnAfterCopyDocLine.
    //Bc Upgrade YADAVM09 For Function CopySalesShptLinesToDoc //HEI.08 not added due to dependency on drink it field Return reason code.
    //Bc Upgrade YADAVM09 For Function //HEI.20 CopySalesInvLinesToDoc on event OnBeforeCopySalesInvLinesToBuffer.
    //Bc Upgrade YADAVM09 For Function CopySalesInvLinesToDoc //HEI.08 not added due to due to dependency on drink it field.
    //Bc Upgrade YADAVM09 For Function CopySalesInvLinesToDoc //HEI.20 is added in event OnAfterCopySalesInvLinesToDoc.
    //Bc Upgrade YADAVM09 For Function CopySalesCrMemoLinesToDoc  //HEI.08 not added in OnBeforeCopySalesCrMemoLinesToBuffer.
    //Bc Upgrade YADAVM09 For Function SplitSalesDocLinesPerItemTrkg //HEI.20 code added in event OnBeforeSplitSalesDocLinesPerItemTrkg.
    //Bc Upgrade YADAVM09 For Function CopyPurchRcptLinesToDoc //HEI.06 //HEI.04 code added in event OnCopyPurchRcptLinesToDocOnAfterTransferFields.
    //Bc Upgrade YADAVM09 For Function CopyPurchInvLinesToDoc //HEI.06 code added in event OnCopyPurchInvLinesToDocOnAfterTransferFields
    //Bc Upgrade YADAVM09 For Function CopyPurchCrMemoLinesToDoc //HEI.21 //HEI.06 code added in event OnCopyPurchCrMemoLinesToDocOnAfterTransferFields
    //Bc Upgrade YADAVM09 For Function CopyPurchReturnShptLinesToDoc //HEI.06 OnCopyPurchReturnShptLinesToDocOnAfterTransferFields
    //Bc Upgrade YADAVM09 FOR FUNCTION SubSplitPstdChrgSalesLinesPer //HEI.20 not added as it is drink it function.
    //BC Upgrade YADAVM09 for function CopyPurchDoc //HEI.01 event is subcribed OnCopyPurchDocPurchLineOnAfterSetFilters

    // BC Upgrade PATELS08 >>
    // Tag HEI.24 added to documentation.
    // Made event subscriber 'OnBeforeCopyPurchHeaderDone' to incorporate the changes of HEI.24, originally in 'CopyPurchDoc'
    // BC Upgrade PATELS08 <<

    // BC Upgrade SHUKLP03 >> Subscribed event OnCopySalesDocUpdateHeaderOnBeforeUpdateCustLedgerEntry to add HEI.07 code.

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", OnCopySalesDocUpdateHeaderOnBeforeUpdateCustLedgerEntry, '', false, false)]
    local procedure OnCopySalesDocUpdateHeaderOnBeforeUpdateCustLedgerEntry(var ToSalesHeader: Record "Sales Header")
    var
        DocumentSubtypeCodeSetup: Record "Doc Subtype Code Setup FND";
        DocumentSubtypeCode: Record "Document Subtype Code FND";
    begin
        //HEI.07>>
        DocumentSubtypeCodeSetup.GET();
        IF DocumentSubtypeCode.GET(DocumentSubtypeCodeSetup."CTS Order") AND
            (ToSalesHeader."Document Subtype Code FND" = DocumentSubtypeCodeSetup."CTS Order")
        THEN
            IF ToSalesHeader."Document Type" = ToSalesHeader."Document Type"::Invoice THEN
                ToSalesHeader."Posting No. Series" := DocumentSubtypeCode."Posted Invoice Nos."
            ELSE IF ToSalesHeader."Document Type" = ToSalesHeader."Document Type"::"Credit Memo" THEN
                ToSalesHeader."Posting No. Series" := DocumentSubtypeCode."Posted CM. Nos.";
        //HEI.07<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnBeforeCheckCustomer', '', true, true)]
    local procedure OnBeforeCheckCustomer(var FromSalesHeader: Record "Sales Header"; var ToSalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        Cust: Record Customer;
    begin
        if Cust.Get(FromSalesHeader."Sell-to Customer No.") then
            //Cust.CheckBlockedCustOnDocs(Cust, ToSalesHeader."Document Type", false, false);
           Cust.CheckBlockedCustOnDocs2(Cust, ToSalesHeader."Document Type", FALSE, FALSE, 0, FALSE, FALSE, FALSE);//HEI.03
                                                                                                                   /* //HEI.03
                                                                                                                       IF Cust.GET(FromSalesHeader."Bill-to Customer No.") THEN
                                                                                                                       //Cust.CheckBlockedCustOnDocs(Cust,ToSalesHeader."Document Type",FALSE,FALSE);
                                                                                                                       Cust.CheckBlockedCustOnDocs2(Cust,ToSalesHeader."Document Type",FALSE,FALSE,0,FALSE,FALSE,FALSE);//HEI.03
                                                                                                                   *///HEI.03
        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnBeforeUpdatePurchHeaderWhenCopyFromPurchHeader', '', true, true)]
    local procedure OnBeforeUpdatePurchHeaderWhenCopyFromPurchHeader(var PurchaseHeader: Record "Purchase Header"; OriginalPurchaseHeader: Record "Purchase Header"; FromDocType: Enum "Purchase Document Type From"; var IsHandled: Boolean)
    var
        FromPurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        ToPurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //HEI.06>>
        IF FromPurchaseHeaderAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") THEN
            ToPurchaseHeaderAdditional.TRANSFERFIELDS(FromPurchaseHeaderAdditional, FALSE);
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnAfterCopyPostedReceipt', '', true, true)]
    local procedure OnAfterCopyPostedReceipt(var ToPurchaseHeader: Record "Purchase Header"; OldPurchaseHeader: Record "Purchase Header"; FromPurchRcptHeader: Record "Purch. Rcpt. Header")
    var
        FromPurchRcptHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
        ToPurchRcptHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
        FromPurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        IF FromPurchaseHeaderAdditional.GET(OldPurchaseHeader."Document Type", OldPurchaseHeader."No.") THEN;//BC Upgrade YADAVM09 to get the value for FromPurchaseHeaderAdditional table.
        //HEI.06>>
        IF FromPurchRcptHeaderAdditional.GET(FromPurchRcptHeader."No.") THEN
            ToPurchRcptHeaderAdditional.TRANSFERFIELDS(FromPurchaseHeaderAdditional, FALSE);
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnAfterCopyPostedPurchInvoice', '', true, true)]
    local procedure OnAfterCopyPostedPurchInvoice(var ToPurchaseHeader: Record "Purchase Header"; OldPurchaseHeader: Record "Purchase Header"; FromPurchInvHeader: Record "Purch. Inv. Header")
    var
        FromPurchRcptHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
        HeinekenGlobal: Codeunit "Heineken Global";
        FromPurchInvHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
        ToPurchInvHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
    begin
        //HEI.02>>
        HeinekenGlobal.OnAfterCopyDocumentPurchaseHeader(ToPurchaseHeader);
        //HEI.02<<
        //HEI.06>>
        IF FromPurchInvHeaderAdditional.GET(FromPurchInvHeader."No.") THEN
            ToPurchInvHeaderAdditional.TRANSFERFIELDS(FromPurchInvHeader, FALSE);
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnAfterCopyPostedReturnShipment', '', true, true)]
    local procedure OnAfterCopyPostedReturnShipment(var ToPurchaseHeader: Record "Purchase Header"; OldPurchaseHeader: Record "Purchase Header"; FromReturnShipmentHeader: Record "Return Shipment Header")
    var
        FromSalesShipHeaderAdditional: Record "Sales Ship. Header Add FND";
        ToSalesShipHeaderAdditional: Record "Sales Ship. Header Add FND";
    begin
        //HEI.06>>
        IF FromSalesShipHeaderAdditional.GET(FromReturnShipmentHeader."No.") THEN
            ToSalesShipHeaderAdditional.TRANSFERFIELDS(FromReturnShipmentHeader, FALSE);
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnAfterCopyPurchHeaderFromPostedCreditMemo', '', true, true)]
    local procedure OnAfterCopyPurchHeaderFromPostedCreditMemo(var ToPurchaseHeader: Record "Purchase Header"; OldPurchaseHeader: Record "Purchase Header"; FromPurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.")
    var
        FromPurchCrMemoHdrAddition: Record "Purch. Cr. Memo Hdr. Add FND";
        ToPurchCrMemoHdrAddition: Record "Purch. Cr. Memo Hdr. Add FND";
    begin
        //HEI.06>>
        IF FromPurchCrMemoHdrAddition.GET(FromPurchCrMemoHeader."No.") THEN
            ToPurchCrMemoHdrAddition.TRANSFERFIELDS(FromPurchCrMemoHdrAddition, FALSE);
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnCopyPurchDocRcptLineOnAfterSetFilters', '', true, true)]
    local procedure OnCopyPurchDocRcptLineOnAfterSetFilters(var ToPurchHeader: Record "Purchase Header"; var FromPurchRcptHeader: Record "Purch. Rcpt. Header"; var FromPurchRcptLine: Record "Purch. Rcpt. Line"; var RecalculateLines: Boolean)
    var
        FromPurchRcptHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
        FromPurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        IF FromPurchaseHeaderAdditional.GET(ToPurchHeader."Document Type", ToPurchHeader."No.") THEN;//BC Upgrade YADAVM09 to get the value for FromPurchaseHeaderAdditional
        //HEI.06>>
        IF FromPurchRcptHeaderAdditional.GET(FromPurchRcptHeader."No.") THEN
            FromPurchaseHeaderAdditional.TRANSFERFIELDS(FromPurchRcptHeaderAdditional);
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnCopyPurchDocOnBeforeCopyPurchDocInvLine', '', true, true)]
    local procedure OnCopyPurchDocOnBeforeCopyPurchDocInvLine(var FromPurchInvHeader: Record "Purch. Inv. Header"; var ToPurchaseHeader: Record "Purchase Header")
    var
        FromPurchInvHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
        FromPurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        IF FromPurchaseHeaderAdditional.GET(ToPurchaseHeader."Document Type", ToPurchaseHeader."No.") THEN;//BC Upgrade YADAVM09 to get the value for FromPurchaseHeaderAdditional 
        //HEI.06>>
        IF FromPurchInvHeaderAdditional.GET(FromPurchInvHeader."No.") THEN
            FromPurchaseHeaderAdditional.TRANSFERFIELDS(FromPurchInvHeaderAdditional);
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnCopyPurchDocOnBeforeCopyPurchDocReturnShptLine', '', true, true)]
    local procedure OnCopyPurchDocOnBeforeCopyPurchDocReturnShptLine(var FromReturnShipmentHeader: Record "Return Shipment Header"; var ToPurchaseHeader: Record "Purchase Header")
    var
        FromSalesShipHeaderAdditional: Record "Sales Ship. Header Add FND";
        FromPurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //HEI.06>>
        IF FromSalesShipHeaderAdditional.GET(FromReturnShipmentHeader."No.") THEN
            FromPurchaseHeaderAdditional.TRANSFERFIELDS(FromSalesShipHeaderAdditional);
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnCopyPurchDocOnBeforeCopyPurchDocCrMemoLine', '', true, true)]
    local procedure OnCopyPurchDocOnBeforeCopyPurchDocCrMemoLine(var FromPurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ToPurchaseHeader: Record "Purchase Header")
    var
        FromPurchCrMemoHdrAddition: Record "Purch. Cr. Memo Hdr. Add FND";
        FromPurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //HEI.06>>
        IF FromPurchCrMemoHdrAddition.GET(FromPurchCrMemoHdr."No.") THEN
            FromPurchaseHeaderAdditional.TRANSFERFIELDS(FromPurchCrMemoHdrAddition);
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnUpdatePurchLineOnAfterCopyDocLine', '', true, true)]
    local procedure OnUpdatePurchLineOnAfterCopyDocLine(var ToPurchLine: Record "Purchase Line"; var FromPurchLine: Record "Purchase Line")
    begin
        //HEI.04>>
        ToPurchLine."Receipt No." := FromPurchLine."Receipt No.";
        //HEI.04>>
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnBeforeCopySalesShptLinesToBuffer', '', true, true)]
    local procedure OnBeforeCopySalesShptLinesToBuffer(var FromSalesLine: Record "Sales Line"; var FromSalesShptLine: Record "Sales Shipment Line"; var ToSalesHeader: Record "Sales Header")
    var
        LocItem: Record Item;
    begin
        //HEI.08>>
        //IF LocItem.GET(FromSalesLine."No.") THEN
        //    FromSalesLine."Return Reason Code" := LocItem."Return Reason Code";// BC Upgrade YADAVM09 Drink if Field code Commented.
        //HEI.08<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnBeforeCopySalesInvLinesToBuffer', '', true, true)]
    local procedure OnBeforeCopySalesInvLinesToBuffer(var FromSalesLine: Record "Sales Line"; var FromSalesInvLine: Record "Sales Invoice Line"; var ToSalesHeader: Record "Sales Header")
    var
        LocItem: Record Item;
    begin
        //>>HEI.20
        IF FromSalesInvLine."Quantity to Return FND" <> 0 THEN BEGIN
            FromSalesLine."Reduced Return Factor FND" := FromSalesInvLine."Quantity to Return FND" / FromSalesInvLine.Quantity;
            FromSalesLine."Line Amount" := FromSalesLine."Line Amount" * FromSalesLine."Reduced Return Factor FND";
            FromSalesLine."Quantity (Base)" := ROUND(FromSalesInvLine."Quantity to Return FND" * FromSalesInvLine."Qty. per Unit of Measure", 0.00001);
            FromSalesLine."Is Reduced Return FND" := TRUE;
        END;

        // Quantity to Return zero valid for Promotion and in Lebanon, per Ghada
        /* //Bc Upgrade YADAVM09 Dependency on Item charge type Drink it field>>
        IF (FromSalesInvLine.Type = FromSalesInvLine.Type::Item) AND (FromSalesInvLine."Item Charge Type" = FromSalesInvLine."Item Charge Type"::Promotion) AND// BC upgrade SHARMP16-- Review object
          (UPPERCASE(TENANTID) = 'LEBANON') AND (FromSalesInvLine."Quantity to Return" = 0)
        THEN BEGIN
            FromSalesLine."Reduced Return Factor" := 0;
            FromSalesLine."Line Amount" := 0;
            FromSalesLine."Quantity (Base)" := 0;
            FromSalesLine."Is Reduced Return" := TRUE;
        END;
         */ //Bc Upgrade YADAVM09 Dependency on Item charge type Drink it field<<
        //<<HEI.20
        //HEI.08>>
        //IF LocItem.GET(FromSalesLine."No.") THEN
        //    FromSalesLine."Return Reason Code" := LocItem."Return Reason Code";// BC Upgrade YADAVM09 Drink if Field code Commented.
        //HEI.08<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnAfterCopySalesInvLinesToDoc', '', true, true)]
    local procedure OnAfterCopySalesInvLinesToDoc(var ToSalesHeader: Record "Sales Header"; var FromSalesInvoiceLine: Record "Sales Invoice Line"; var LinesNotCopied: Integer; var MissingExCostRevLink: Boolean)
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        //>>HEI.20
        IF FromSalesInvoiceLine.FINDSET() THEN
            REPEAT
                IF SalesInvoiceLine.GET(FromSalesInvoiceLine."Document No.", FromSalesInvoiceLine."Line No.") THEN BEGIN
                    IF SalesInvoiceLine."Quantity to Return FND" <> 0 THEN BEGIN
                        SalesInvoiceLine.VALIDATE("Quantity to Return FND", 0);
                        SalesInvoiceLine.MODIFY();
                    END;
                END;
            UNTIL FromSalesInvoiceLine.NEXT() = 0;
        //<<HEI.20
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnBeforeCopySalesCrMemoLinesToBuffer', '', true, true)]
    local procedure OnBeforeCopySalesCrMemoLinesToBuffer(var FromSalesLine: Record "Sales Line"; var FromSalesCrMemoLine: Record "Sales Cr.Memo Line"; var ToSalesHeader: Record "Sales Header")
    var
        LocItem: Record Item;
    begin
        //HEI.08>>
        //  IF LocItem.GET(FromSalesLine."No.") THEN
        //    FromSalesLine."Return Reason Code" := LocItem."Return Reason Code";// BC Upgrade YADAVM09 Drink if Field code Commented.
        //HEI.08<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnBeforeCopySalesReturnRcptLinesToBuffer', '', true, true)]
    local procedure OnBeforeCopySalesReturnRcptLinesToBuffer(var FromSalesLine: Record "Sales Line"; var FromReturnReceiptLine: Record "Return Receipt Line"; var ToSalesHeader: Record "Sales Header")
    var
        LocItem: Record Item;
    begin
        //HEI.08>>
        // IF LocItem.GET(FromSalesLine."No.") THEN
        //     FromSalesLine."Return Reason Code" := LocItem."Return Reason Code"; // BC Upgrade YADAVM09 Drink if Field code Commented.
        //HEI.08<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnAfterSetProperties', '', true, true)]
    local procedure OnAfterSetProperties(var IncludeHeader: Boolean; var RecalculateLines: Boolean; var MoveNegLines: Boolean; var CreateToHeader: Boolean; var HideDialog: Boolean; var ExactCostRevMandatory: Boolean; var ApplyFully: Boolean)
    var
    begin
        GMoveNegLines := MoveNegLines;
        GExactCostRevMandatory := ExactCostRevMandatory;
        //GSkippedLine := ski
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnBeforeSplitSalesDocLinesPerItemTrkg', '', true, true)]
    local procedure OnBeforeSplitSalesDocLinesPerItemTrkg(var ItemLedgerEntry: Record "Item Ledger Entry"; var TempReservationEntry: Record "Reservation Entry" temporary; var TempSalesLineBuf: Record "Sales Line" temporary; FromSalesLine: Record "Sales Line"; var TempDocSalesLine: Record "Sales Line" temporary; var NextLineNo: Integer; var NextItemTrkgEntryNo: Integer; var MissingExCostRevLink: Boolean; FromShptOrRcpt: Boolean; var Result: Boolean; var IsHandled: Boolean)
    var
        SalesLineBuf: array[2] of Record "Sales Line" temporary;
        Tracked: Boolean;
        ReversibleQtyBase: Decimal;
        SignFactor: Integer;
        i: Integer;
        "FromSalesLineQty(Base)": Decimal;
    begin
        "FromSalesLineQty(Base)" := FromSalesLine."Quantity (Base)";  //HEI.20
        if FromShptOrRcpt then begin
            TempSalesLineBuf.Reset();
            TempSalesLineBuf.DeleteAll();
            TempReservationEntry.Reset();
            TempReservationEntry.DeleteAll();
        end else
            TempSalesLineBuf.Init();

        if GMoveNegLines or not GExactCostRevMandatory then begin
            IsHandled := true;
            Result := false;//BC Upgrade YADAVM09
        end;
        if FromSalesLine."Quantity (Base)" < 0 then
            SignFactor := -1
        else
            SignFactor := 1;
        OnSplitSalesDocLinesPerItemTrkgOnAfterCalcSignFactor(FromSalesLine, SignFactor);

        ItemLedgerEntry.SetCurrentKey("Document No.", "Document Type", "Document Line No.");
        ItemLedgerEntry.FindSet();
        repeat
            SalesLineBuf[1] := FromSalesLine;
            SalesLineBuf[1]."Line No." := NextLineNo;
            SalesLineBuf[1]."Quantity (Base)" := 0;
            SalesLineBuf[1].Quantity := 0;
            SalesLineBuf[1]."Document No." := ItemLedgerEntry."Document No.";
            if GetSalesDocTypeForItemLedgEntry(ItemLedgerEntry) in
               [SalesLineBuf[1]."Document Type"::Order, SalesLineBuf[1]."Document Type"::"Return Order"]
            then
                SalesLineBuf[1]."Shipment Line No." := 1;
            OnSplitSalesDocLinesPerItemTrkgOnAfterInitSalesLineBuf1(SalesLineBuf[1], ItemLedgerEntry);
            SalesLineBuf[2] := SalesLineBuf[1];
            SalesLineBuf[2]."Line No." := SalesLineBuf[2]."Line No." + 1;

            if not FromShptOrRcpt then begin
                ItemLedgerEntry.SetRange("Document No.", ItemLedgerEntry."Document No.");
                ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type");
                ItemLedgerEntry.SetRange("Document Line No.", ItemLedgerEntry."Document Line No.");
            end;
            repeat
                i := 1;
                CalcReversibleQtyBaseSalesDoc(ItemLedgerEntry, FromSalesLine, SalesLineBuf, TempReservationEntry, ReversibleQtyBase, SignFactor);

                if ReversibleQtyBase <> 0 then begin
                    if not ItemLedgerEntry.Positive then
                        if IsSplitItemLedgEntry(ItemLedgerEntry) then
                            i := 2;

                    UpdateSalesLineQtyBaseFromReversibleQtyBase(FromSalesLine, SalesLineBuf[i], ReversibleQtyBase);
                    // Fill buffer with exact cost reversing link
                    InsertTempReservationEntry(
                      ItemLedgerEntry, TempReservationEntry, -Abs(ReversibleQtyBase),
                      SalesLineBuf[i]."Line No.", NextItemTrkgEntryNo, true);
                    Tracked := true;
                end;
            until (ItemLedgerEntry.Next() = 0) or (FromSalesLine."Quantity (Base)" = 0);

            for i := 1 to 2 do
                if SalesLineBuf[i]."Quantity (Base)" <> 0 then begin
                    TempSalesLineBuf := SalesLineBuf[i];
                    //>>HEI.20
                    IF (TempSalesLineBuf."Quantity (Base)" <> "FromSalesLineQty(Base)") AND ("FromSalesLineQty(Base)" <> 0) THEN BEGIN
                        TempSalesLineBuf."Reduced Return Factor FND" := TempSalesLineBuf."Quantity (Base)" / "FromSalesLineQty(Base)";
                        TempSalesLineBuf."Line Amount" := TempSalesLineBuf."Line Amount" * TempSalesLineBuf."Reduced Return Factor FND";
                        TempSalesLineBuf."Is Reduced Return FND" := TRUE;
                    END;
                    //<<HEI.20
                    TempSalesLineBuf.Insert();
                    AddSalesDocLine(TempDocSalesLine, TempSalesLineBuf."Line No.", ItemLedgerEntry."Document No.", FromSalesLine."Line No.");
                    NextLineNo := SalesLineBuf[i]."Line No." + 1;
                end;

            if not FromShptOrRcpt then begin
                ItemLedgerEntry.SetRange("Document No.");
                ItemLedgerEntry.SetRange("Document Type");
                ItemLedgerEntry.SetRange("Document Line No.");
            end;
        until (ItemLedgerEntry.Next() = 0) or FromShptOrRcpt;

        if (FromSalesLine."Quantity (Base)" <> 0) and not Tracked then
            MissingExCostRevLink := true;
        CheckUnappliedLines(SkippedLine, MissingExCostRevLink);
        IsHandled := true;
        if IsHandled then
            Result := true;//Bc Upgrade YADAVM09
        //exit(true);//Bc Upgrade YADAVM09
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnCopyPurchRcptLinesToDocOnAfterTransferFields', '', true, true)]
    local procedure OnCopyPurchRcptLinesToDocOnAfterTransferFields(var FromPurchaseLine: Record "Purchase Line"; var FromPurchaseHeader: Record "Purchase Header"; var ToPurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var FromPurchRcptLine: Record "Purch. Rcpt. Line")
    var
        FromPurchRcptHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
        FromPurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //HEI.06>>
        IF FromPurchRcptHeaderAdditional.GET(PurchRcptHeader."No.") THEN
            FromPurchaseHeaderAdditional.TRANSFERFIELDS(FromPurchRcptHeaderAdditional);
        //HEI.06<<

        //HEI.04>>
        FromPurchaseLine."Receipt No." := FromPurchRcptLine."Document No.";
        //HEI.04>>
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnCopyPurchRcptLinesToDocOnBeforeCopyPurchLine', '', true, true)]
    local procedure OnCopyPurchRcptLinesToDocOnBeforeCopyPurchLine(ToPurchaseHeader: Record "Purchase Header"; var FromPurchaseLine: Record "Purchase Line"; var CopyItemTrkg: Boolean)
    var
    begin
        //HEI.04>>
        //FromPurchLineBuf."Receipt No." := '';
        //HEI.04<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnCopyPurchInvLinesToDocOnAfterTransferFields', '', true, true)]
    local procedure OnCopyPurchInvLinesToDocOnAfterTransferFields(var FromPurchaseLine: Record "Purchase Line"; var FromPurchaseHeader: Record "Purchase Header"; var ToPurchaseHeader: Record "Purchase Header"; FromPurchInvHeader: Record "Purch. Inv. Header"; var FromPurchInvLine: Record "Purch. Inv. Line")
    var
        FromPurchInvHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
        FromPurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //HEI.06>>
        IF FromPurchInvHeaderAdditional.GET(FromPurchInvHeader."No.") THEN
            FromPurchaseHeaderAdditional.TRANSFERFIELDS(FromPurchInvHeaderAdditional);
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnAfterCopyPurchInvLine', '', true, true)]
    local procedure OnAfterCopyPurchInvLine(FromPurchInvLine: Record "Purch. Inv. Line"; var ToPurchaseLine: Record "Purchase Line"; ToPurchHeader: Record "Purchase Header")
    var
    begin
        GToPurchLine := ToPurchaseLine;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnAfterCopyPurchInvLinesToDoc', '', true, true)]
    local procedure OnAfterCopyPurchInvLinesToDoc(ToPurchaseHeader: Record "Purchase Header"; var FromPurchInvLine: Record "Purch. Inv. Line"; var LinesNotCopied: Integer; var MissingExCostRevLink: Boolean)
    var
    begin
        OnAfterCopyPurchaseDocument(GToPurchLine."Document Type".AsInteger(), GToPurchLine."Document No.", ToPurchaseHeader);//HEI.23
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnCopyPurchCrMemoLinesToDocOnAfterTransferFields', '', true, true)]
    local procedure OnCopyPurchCrMemoLinesToDocOnAfterTransferFields(var FromPurchaseLine: Record "Purchase Line"; var FromPurchaseHeader: Record "Purchase Header"; var ToPurchaseHeader: Record "Purchase Header"; var FromPurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var FromPurchCrMemoLine: Record "Purch. Cr. Memo Line")
    var
        FromPurchCrMemoHdrAddition: Record "Purch. Cr. Memo Hdr. Add FND";
        FromPurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //HEI.06>>
        IF FromPurchCrMemoHdrAddition.GET(FromPurchCrMemoHdr."No.") THEN
            //HEI.21>>
            //FromPurchaseHeaderAdditional.TRANSFERFIELDS(FromPurchCrMemoHeader);
            FromPurchaseHeaderAdditional.TRANSFERFIELDS(FromPurchCrMemoHdrAddition);
        //HEI.21<<
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnCopyPurchReturnShptLinesToDocOnAfterTransferFields', '', true, true)]
    local procedure OnCopyPurchReturnShptLinesToDocOnAfterTransferFields(var FromPurchaseLine: Record "Purchase Line"; var FromPurchaseHeader: Record "Purchase Header"; var ToPurchaseHeader: Record "Purchase Header"; var FromReturnShipmentHeader: Record "Return Shipment Header"; var FromReturnShipmentLine: Record "Return Shipment Line")
    var
        FromSalesShipHeaderAdditional: Record "Sales Ship. Header Add FND";
        FromPurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //HEI.06>>
        IF FromSalesShipHeaderAdditional.GET(FromReturnShipmentHeader."No.") THEN
            FromPurchaseHeaderAdditional.TRANSFERFIELDS(FromSalesShipHeaderAdditional);
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnCopyPurchDocPurchLineOnAfterSetFilters', '', true, true)]
    local procedure OnCopyPurchDocPurchLineOnAfterSetFilters(FromPurchHeader: Record "Purchase Header"; var FromPurchLine: Record "Purchase Line"; var ToPurchHeader: Record "Purchase Header"; var RecalculateLines: Boolean)
    var
    begin
        //HEI.01>>
        IF PurchLineNoToCopy <> 0 THEN
            FromPurchLine.SETRANGE("Line No.", PurchLineNoToCopy);
        //HEI.01<<
    end;

    // BC Upgrade PATELS08 >>
    // HEI.24 >>
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnBeforeCopyPurchHeaderDone', '', false, false)]
    local procedure OnBeforeCopyPurchHeaderDone(
        var ToPurchaseHeader: Record "Purchase Header";
        FromPurchaseHeader: Record "Purchase Header";
        FromDocType: Enum "Purchase Document Type From";
        OldPurchaseHeader: Record "Purchase Header";
        FromPurchRcptHeader: Record "Purch. Rcpt. Header";
        FromPurchInvHeader: Record "Purch. Inv. Header";
        FromReturnShipmentHeader: Record "Return Shipment Header";
        FromPurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        FromPurchaseHeaderArchive: Record "Purchase Header Archive")
    //BuyFromVendor: Record Vendor;
    //PayToVendor: Record Vendor)
    var
        Vend: Record Vendor;
        PurchasesUtils: Codeunit "Purchases-Utils";
    begin
        if Vend.Get(FromPurchaseHeader."Buy-from Vendor No.") then
            PurchasesUtils.CheckBlockedVendorOnDocuments(Vend, FromPurchaseHeader);
        if Vend.Get(FromPurchaseHeader."Pay-to Vendor No.") then begin
            CLEAR(PurchasesUtils);
            PurchasesUtils.CheckBlockedVendorOnDocuments(Vend, FromPurchaseHeader);
        end
    end;
    // HEI.24 <<
    // BC Upgrade PATELS08 <<

    local procedure CheckUnappliedLines(IsSkippedLine: Boolean; var MissingExCostRevLink: Boolean)
    var
        IsHandled: Boolean;
        Text030: Label 'One or more return document lines were not copied. This is because quantities on the posted document line are already fully or partially applied, so the Exact Cost Reversing link could not be created.';
    begin
        IsHandled := false;
        OnBeforeCheckUnappliedLines(IsSkippedLine, MissingExCostRevLink, WarningDone, IsHandled);
        if IsHandled then
            exit;

        if IsSkippedLine and MissingExCostRevLink then begin
            if not WarningDone then
                Message(Text030);
            MissingExCostRevLink := false;
            WarningDone := true;
        end;
    end;

    local procedure InsertTempReservationEntry(ItemLedgEntry: Record "Item Ledger Entry"; var TempReservationEntry: Record "Reservation Entry"; QtyBase: Decimal; DocLineNo: Integer; var NextEntryNo: Integer; FillExactCostRevLink: Boolean)
    begin
        if QtyBase = 0 then
            exit;

        TempReservationEntry.Init();
        TempReservationEntry."Entry No." := NextEntryNo;
        NextEntryNo := NextEntryNo + 1;
        if not FillExactCostRevLink then
            TempReservationEntry."Reservation Status" := TempReservationEntry."Reservation Status"::Prospect;
        TempReservationEntry."Source ID" := ItemLedgEntry."Document No.";
        TempReservationEntry."Source Ref. No." := DocLineNo;
        TempReservationEntry."Item Ledger Entry No." := ItemLedgEntry."Entry No.";
        TempReservationEntry."Quantity (Base)" := QtyBase;
        OnInsertTempReservationEntryOnBeforeInsert(TempReservationEntry, ItemLedgEntry);
        TempReservationEntry.Insert();
    end;

    local procedure UpdateSalesLineQtyBaseFromReversibleQtyBase(var FromSalesLine: Record "Sales Line"; var SalesLineBuf: Record "Sales Line" temporary; ReversibleQtyBase: Decimal)
    var
        IsHandled: Boolean;
        UOMMgt: Codeunit "Unit of Measure Management";
    begin
        IsHandled := false;
        OnBeforeUpdateSalesLineQtyBaseFromReversibleQtyBase(FromSalesLine, SalesLineBuf, ReversibleQtyBase, IsHandled);
        if IsHandled then
            exit;

        SalesLineBuf."Quantity (Base)" := SalesLineBuf."Quantity (Base)" + ReversibleQtyBase;
        if SalesLineBuf."Qty. per Unit of Measure" = 0 then
            SalesLineBuf.Quantity := SalesLineBuf."Quantity (Base)"
        else
            SalesLineBuf.Quantity :=
              Round(
                SalesLineBuf."Quantity (Base)" / SalesLineBuf."Qty. per Unit of Measure", UOMMgt.QtyRndPrecision());
        FromSalesLine."Quantity (Base)" := FromSalesLine."Quantity (Base)" - ReversibleQtyBase;
    end;

    local procedure IsSplitItemLedgEntry(OrgItemLedgEntry: Record "Item Ledger Entry"): Boolean
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemLedgEntry.SetCurrentKey("Document No.");
        ItemLedgEntry.SetRange("Document No.", OrgItemLedgEntry."Document No.");
        ItemLedgEntry.SetRange("Document Type", OrgItemLedgEntry."Document Type");
        ItemLedgEntry.SetRange("Document Line No.", OrgItemLedgEntry."Document Line No.");
        ItemLedgEntry.SetTrackingFilterFromItemLedgEntry(OrgItemLedgEntry);
        ItemLedgEntry.SetFilter("Entry No.", '<%1', OrgItemLedgEntry."Entry No.");
        OnIsSplitItemLedgEntryOnAfterItemLedgEntrySetFilters(ItemLedgEntry, OrgItemLedgEntry);
        exit(not ItemLedgEntry.IsEmpty());
    end;

    local procedure CalcReversibleQtyBaseSalesDoc(var ItemLedgEntry: Record "Item Ledger Entry"; FromSalesLine: Record "Sales Line"; var SalesLineBuf: array[2] of Record "Sales Line" temporary; var TempItemTrkgEntry: Record "Reservation Entry" temporary; var ReversibleQtyBase: Decimal; SignFactor: Integer)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCalcReversibleQtyBaseSalesDoc(FromSalesLine, ItemLedgEntry, ReversibleQtyBase, IsHandled);
        if IsHandled then
            exit;

        if not ItemLedgEntry.Positive then
            ItemLedgEntry."Shipped Qty. Not Returned" :=
              ItemLedgEntry."Shipped Qty. Not Returned" -
              CalcDistributedQty(TempItemTrkgEntry, ItemLedgEntry, SalesLineBuf[2]."Line No." + 1);
        if ItemLedgEntry."Shipped Qty. Not Returned" = 0 then
            SkippedLine := true;

        if ItemLedgEntry."Document Type" in [ItemLedgEntry."Document Type"::"Sales Return Receipt", ItemLedgEntry."Document Type"::"Sales Credit Memo"] then
            if ItemLedgEntry."Remaining Quantity" < FromSalesLine."Quantity (Base)" * SignFactor then
                ReversibleQtyBase := ItemLedgEntry."Remaining Quantity" * SignFactor
            else
                ReversibleQtyBase := FromSalesLine."Quantity (Base)"
        else
            if ItemLedgEntry.Positive then begin
                ReversibleQtyBase := ItemLedgEntry."Remaining Quantity";
                if ReversibleQtyBase < FromSalesLine."Quantity (Base)" * SignFactor then
                    ReversibleQtyBase := ReversibleQtyBase * SignFactor
                else
                    ReversibleQtyBase := FromSalesLine."Quantity (Base)";
            end else
                if -ItemLedgEntry."Shipped Qty. Not Returned" < FromSalesLine."Quantity (Base)" * SignFactor then
                    ReversibleQtyBase := -ItemLedgEntry."Shipped Qty. Not Returned" * SignFactor
                else
                    ReversibleQtyBase := FromSalesLine."Quantity (Base)";
    end;

    local procedure CalcDistributedQty(var TempItemTrkgEntry: Record "Reservation Entry" temporary; ItemLedgEntry: Record "Item Ledger Entry"; NextLineNo: Integer): Decimal
    begin
        TempItemTrkgEntry.Reset();
        TempItemTrkgEntry.SetCurrentKey("Source ID", "Source Ref. No.");
        TempItemTrkgEntry.SetRange("Source ID", ItemLedgEntry."Document No.");
        TempItemTrkgEntry.SetFilter("Source Ref. No.", '<%1', NextLineNo);
        TempItemTrkgEntry.SetRange("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
        TempItemTrkgEntry.CalcSums("Quantity (Base)");
        TempItemTrkgEntry.Reset();
        exit(TempItemTrkgEntry."Quantity (Base)");
    end;

    local procedure GetSalesDocTypeForItemLedgEntry(ItemLedgEntry: Record "Item Ledger Entry"): Enum "Sales Document Type"
    begin
        case ItemLedgEntry."Document Type" of
            ItemLedgEntry."Document Type"::"Sales Shipment":
                exit("Sales Document Type"::Order);
            ItemLedgEntry."Document Type"::"Sales Invoice":
                exit("Sales Document Type"::Invoice);
            ItemLedgEntry."Document Type"::"Sales Credit Memo":
                exit("Sales Document Type"::"Credit Memo");
            ItemLedgEntry."Document Type"::"Sales Return Receipt":
                exit("Sales Document Type"::"Return Order");
        end;
    end;

    local procedure AddSalesDocLine(var TempDocSalesLine: Record "Sales Line" temporary; BufferLineNo: Integer; DocumentNo: Code[20]; DocumentLineNo: Integer)
    begin
        OnBeforeAddSalesDocLine(TempDocSalesLine, BufferLineNo, DocumentNo, DocumentLineNo);

        TempDocSalesLine."Document No." := DocumentNo;
        TempDocSalesLine."Line No." := DocumentLineNo;
        TempDocSalesLine."Shipment Line No." := BufferLineNo;
        TempDocSalesLine.Insert();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeAddSalesDocLine(var TempDocSalesLine: Record "Sales Line" temporary; BufferLineNo: Integer; DocumentNo: Code[20]; DocumentLineNo: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnSplitSalesDocLinesPerItemTrkgOnAfterCalcSignFactor(FromSalesLine: Record "Sales Line"; var SignFactor: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnSplitSalesDocLinesPerItemTrkgOnAfterInitSalesLineBuf1(var SalesLineBuf1: Record "Sales Line" temporary; var ItemLedgerEntry: Record "Item Ledger Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalcReversibleQtyBaseSalesDoc(FromSalesLine: Record "Sales Line"; var ItemLedgEntry: record "Item Ledger Entry"; var ReversibleQtyBase: Decimal; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnIsSplitItemLedgEntryOnAfterItemLedgEntrySetFilters(var ItemLedgEntry: Record "Item Ledger Entry"; OrgItemLedgEntry: Record "Item Ledger Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeUpdateSalesLineQtyBaseFromReversibleQtyBase(var FromSalesLine: Record "Sales Line"; var SalesLineBuffer: record "Sales Line"; ReversibleQtyBase: decimal; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnInsertTempReservationEntryOnBeforeInsert(var TempReservationEntry: Record "Reservation Entry"; ItemLedgerEntry: Record "Item Ledger Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckUnappliedLines(SkippedLine: Boolean; var MissingExCostRevLink: Boolean; var WarningDone: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyPurchaseDocument(FromDocumentType: Option; FromDocumentNo: Code[20]; VAR ToPurchaseHeader: Record "Purchase Header")
    begin

    end;

    procedure SetInterfaceProperties(NewPurchLineNoToCopy: Integer)
    begin
        //HEI.01>>
        PurchLineNoToCopy := NewPurchLineNoToCopy;
        //HEI.01<<
    end;

    //BC UPGRADE PATHAA02- Codeunit 7312-"Create Pick" 20.01.26>>
    //HEI.01>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Pick", 'OnFindBWPickBinOnBeforeUpdateQuantitiesToPick', '', false, false)]
    local procedure OnFindBWPickBinOnBeforeUpdateQuantitiesToPick(var SkipUpdateQuantitiesToPick: Boolean; FromBinContent: Record "Bin Content"; QtyAvailableBase: Decimal; QtyPerUnitofMeasure: Decimal; var QtyToPick: Decimal; var QtyToPickBase: Decimal; var TotalQtyToPick: Decimal; var TotalQtyToPickBase: Decimal)
    var
        Bin: Record Bin;
    begin
        if Bin.Get(FromBinContent."Location Code", FromBinContent."Bin Code") AND Bin."Unavailable Stock FND" then
            SkipUpdateQuantitiesToPick := true // Skip updating quantities for unavailable bins        
    end;
    //HEI.01<<
    //BC UPGRADE PATHAA02- Codeunit 7312-"Create Pick" 20.01.26<<

    // BC Upgrade SHUKLP03 >> Codeunit 11 "Gen. Jnl.-Check Line"

    // HEI.01 FDD RTRGAP021 IBM COSTES02 01.08.2017 Remove checking new fiscal year in accounting period
    // HEI.02 FDD-KDD0TC002 IBM HORTOC01 04.10.2017 - new function

    // HEI.03 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
    //   # New function CheckRPMDamageLossLine created
    // HEI.04 DefectID 911 IBM HORTOC01 07.11.2017 - new function
    // HEI.05 FDD-KDD0TC007 IBM NAIKH01 15.11.2017
    //   # NEw Function Added "CheckFFESecurityPaymentLine"
    // HEI.06 FDD PTPGAP078 IBM POSTOI01 26.05.2018
    //   # Bank Payment Type validation should be active only for "Source Code" <> "Source Code Setup"."Payment Journal Tree"
    // HEI.07 FDD-CHG2022328 IBM POENAB02 07.07.2019 # External document No. duplication in journal
    //   #Code added in RunCheck
    // HEI.08 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New code
    // HEI.09 CHG2040699 IBM POSTOI01 14.01.2020 Ivory Coast - WHT at the moment of payment
    //   # New function: CheckWHTAppliedInvPostingGroups(GenJnlLine)
    //   # new global constant Text013
    // HEI.10 FDD-CD-HT1350 IBM BULIMC01 16.07.2020 #check if the field "Related Sales Order No." is filled in
    // HEI.11 FDD-HB1609 CHG2074002 IBM BULIMC01 09.11.2020 #check if the entries for Free Goods Accounting have already been posted
    // HEI.12 CHG2126534 IBM BHATTA09 15.09.2021
    //  # Code change to bypass the WHT validation for specific users
    // HEI.13 CHG2131424 IBM SISUM01 01/05/2023 HB2520 Dimension Validation HeiLite
    //   # Code change to skip dimension validation only for Sales documents if on setup is true the skip
    // HEI.14 CHG2131424 IBM YADAVM09 10/08/2023 HB2520 Dimension Validation HeiLite
    //   # Code change to skip dimension validation only for Sales Invoice
    // HEI.15 CHG2187702 SAHAL01 13.10.2023 Revaluation journal items in error
    //   # Removed Code
    // HEI.16 CHG2187702 PRASAA03 21.12.2023 Revaluation journal items in error
    //   # Dimension combination error handled for Rev jour items.
    // HEI.17 CHG2255994 IBM KAPOOV01 04.07.2024 P&L Close 2022 in Production Environment
    //   # Added code to Skip Dimension combination error.
    // HEI.18 CHG2262950 IBM KAPOOV01 06.08.2024 The system allows postings on P&L account without CC Dimension
    //   # Modified function-CheckDimensions(GenJnlLine : Record "Gen. Journal Line")

    // BC Upgrade SHUKLP03 >>
    // Not able to set base global variable LogErrorMode value because no event is found to get this variable value we have to find workaround.
    // HEI.08,HEI.02,HEI.05,HEI.06,HEI.03,HEI.04,HEI.07,HEI.09,HEI.10,HEI.11,HEI.12 => subscribe event OnBeforeRunCheck to add HEI code and made IsHandled true.
    // Created events OnAfterCheckGenJnlLine,OnBeforeTestAppliesToID,OnAfterCheckBalAccountNo,OnBeforeCheckElectronicPaymentFields,OnBeforeCheckICPartner,OnBeforeCheckJobNoIsEmpty,OnBeforeCheckBalDocType,OnBeforeCheckBalAccountType,OnBeforeCheckBalAccountNo,OnBeforeCheckDimensions,OnCheckDimensionsOnAfterAssignDimTableIDs,OnBeforeCheckAccountType,OnCheckAccountNoOnBeforeCheckICPartner,OnAfterCheckAccountNo,OnBeforeCheckAccountNo,OnBeforeCheckAppliesToDocNo,OnBeforeCheckZeroAmount,OnBeforeTestAccountAndBalAccountType,OnBeforeTestDocumentNo,OnBeforeDateNotAllowed,OnBeforeCheckVATDate,OnBeforeCheckPostingDateInFiscalYear,OnAfterCheckGenJnlLine
    // Created procedures CheckCurrencyCode(),CheckAccountCurrencyCode(),CheckGLAccountSourceCurrency(),TestAppliesToID(),CalcPmtDiscOnCrMemos(),CheckBalAccountNo(),CheckElectronicPaymentFields(),CheckTransmitted(),CheckICPartner(),CheckJobNoIsEmpty(),CheckBalDocType(),CheckBalAccountType(),CheckDimensions(),ThrowGenJnlLineErrorLocal(),CheckPostedDeferralHeaderExist(),GetDeferralAccountNo(),CheckDeferralHeaderExist(),CheckAccountNo(),CheckAccountType(),CheckAppliesToDocNo(),CheckZeroAmount(),TestAccountAndBalAccountType(),TestDocumentNo(),CheckDates(),CheckVATDate(),HasVAT(),CheckInterestRateCreditLine(),CheckRPMDamageLossLine(),CheckAmountOnRefundLine(),CheckFFESecurityPaymentLine(),CheckWHTGroupsOnPaymJourn(),GetItemJnlLine11(),CheckRevJnlErrorLog()
    // HEI.08 => French locatization code is not added.
    // HEI.16 => Procedure name is changes from GetItemJnlLine to GetItemJnlLine11 to avoid conflict with existing procedure in Heineken BC Upgrade.
    // Subscriber event OnBeforeProcessLines of codeunit "Gen. Jnl.-Post Batch" to set IsBatchMode variable true.
    // BC Upgrade SHUKLP03 <<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", OnBeforeProcessLines, '', false, false)]
    local procedure OnBeforeProcessLines()
    begin
        IsBatchMode := True;  // BC Upgrade SHUKLP03 << Subscriber event to set IsBatchMode variable true.
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", OnBeforeRunCheck, '', false, false)]
    local procedure OnBeforeRunCheck(OverrideDimErr: Boolean; sender: Codeunit "Gen. Jnl.-Check Line"; var GenJournalLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    var
        ICGLAcount: Record "IC G/L Account";
        ICBankAccount: Record "IC Bank Account";
        ErrorMessageHandler: Codeunit "Error Message Handler";
        ErrorContextElement: Codeunit "Error Context Element";
        lGLEntry: Record "G/L Entry";
        lGenJournalLine: Record "Gen. Journal Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SourceCodeSetup: Record "Source Code Setup";
        Text016: Label 'User Setup does not exist for %1';
        lText50000: Label 'External Document No. %1 in already available in Line No. %2 with Template Name %3 & Batch Name %4';
        lText50001: Label 'External Document No. %1 is already available in posted entries';

    begin
        //HEI.08>>
        CompanyInfo.GET();
        //HEI.08<<


        if LogErrorMode then begin  // BC Upgrade SHUKLP03 << Not able to set LogErrorMode variable value because no event is found to get this variable value we have to find workaround.
            ErrorMessageMgt.Activate(ErrorMessageHandler);
            ErrorMessageMgt.PushContext(ErrorContextElement, GenJournalLine.RecordId, 0, '');
        end;

        GLSetup2.Get();
        if GenJournalLine.EmptyLine() then
            exit;

        CheckInterestRateCreditLine(GenJournalLine);//HEI.02
        CheckFFESecurityPaymentLine(GenJournalLine); //HEI.05
        CheckRPMDamageLossLine(GenJournalLine); //HEI.03
        CheckAmountOnRefundLine(GenJournalLine);//HEI.04
        if not GenJnlTemplateFound then begin
            if GenJnlTemplate.Get(GenJournalLine."Journal Template Name") then;
            GenJnlTemplateFound := true;
        end;

        CheckDates(GenJournalLine);

        //BC UPGRADE KUMARR78 >> Blocking as No need Due to Avaiable in Other Ext.
        // //HEI.09
        // //>>HEI.12
        // //CheckWHTGroupsOnPaymJourn(GenJnlLine);
        // BC UPGRADE GUPTAK03 WHT Related -->>
        IF UserSetup.GET(USERID) THEN BEGIN
            IF NOT UserSetup."Allow Bypass WHT Valid FND" THEN BEGIN
                CheckWHTGroupsOnPaymJourn(GenJournalLine);
            END;
        END ELSE
            ERROR(Text016, USERID);
        // BC UPGRADE GUPTAK03 WHT Related -->>
        // //<<HEI.12
        //BC UPGRADE KUMARR78 << Blocking as No need Due to Avaiable in Other Ext.

        //HEI.09

        GenJournalLine.ValidateSalesPersonPurchaserCode(GenJournalLine);

        TestDocumentNo(GenJournalLine);

        //HEI.07>>
        IF GenJnlTemplate."Customer Mandate FND" = TRUE THEN
            IF (GenJournalLine."Source Type" = GenJournalLine."Source Type"::Customer) THEN
                GenJournalLine.TESTFIELD("Source No.");
        IF GenJnlTemplate."RPM Payment FND" = TRUE THEN
            // BC Upgrade SHUKLP03 >> Blocked because dependency on DIT "Item Charge Type" field.
            // IF (GenJournalLine."Item Charge Type" = GenJournalLine."Item Charge Type"::Deposit) THEN BEGIN
            //     GenJournalLine.TESTFIELD("Empties Item No.");
            //     GenJournalLine.TESTFIELD("Deposit Quantity");

            //     GenJournalLine.TESTFIELD("Reason Code");
            //     GenJournalLine.TESTFIELD(Amount);
            // END;
            // BC Upgrade SHUKLP03 << Blocked because dependency on DIT "Item Charge Type" field.

            IF GenJnlTemplate."Ext. Doc. No. Mandatory FND" = TRUE THEN
                GenJournalLine.TESTFIELD("External Document No.");

        GLSetup2.GET();
        IF ((GLSetup2."Restrt Dupli Extrnl Doc FND" = TRUE) AND (GenJnlTemplate."Restrct Dplct. Extrn Doc FND" = TRUE)) THEN
            IF (GenJournalLine."External Document No." <> '') THEN BEGIN
                lGLEntry.RESET();
                lGLEntry.SETRANGE("Document Type", lGLEntry."Document Type"::Payment);
                lGLEntry.SETRANGE("External Document No.", GenJournalLine."External Document No.");
                IF lGLEntry.FINDFIRST() THEN
                    ERROR(lText50001, GenJournalLine."External Document No.");

                lGenJournalLine.RESET();
                lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                lGenJournalLine.SETFILTER("Line No.", '<>%1', GenJournalLine."Line No.");
                lGenJournalLine.SETRANGE("External Document No.", GenJournalLine."External Document No.");
                IF lGenJournalLine.FINDFIRST() THEN
                    ERROR(lText50000, GenJournalLine."External Document No.", lGenJournalLine."Line No.", lGenJournalLine."Journal Template Name", lGenJournalLine."Journal Batch Name");

                lGenJournalLine.RESET();
                lGenJournalLine.SETFILTER("Journal Template Name", '<>%1', GenJournalLine."Journal Template Name");
                lGenJournalLine.SETFILTER("Journal Batch Name", '<>%1', GenJournalLine."Journal Batch Name");
                lGenJournalLine.SETRANGE("External Document No.", GenJournalLine."External Document No.");
                IF lGenJournalLine.FINDFIRST() THEN
                    ERROR(lText50000, GenJournalLine."External Document No.", lGenJournalLine."Line No.", lGenJournalLine."Journal Template Name", lGenJournalLine."Journal Batch Name");

                lGenJournalLine.RESET();
                lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
                lGenJournalLine.SETFILTER("Journal Batch Name", '<>%1', GenJournalLine."Journal Batch Name");
                lGenJournalLine.SETRANGE("External Document No.", GenJournalLine."External Document No.");
                IF lGenJournalLine.FINDFIRST() THEN
                    ERROR(lText50000, GenJournalLine."External Document No.", lGenJournalLine."Line No.", lGenJournalLine."Journal Template Name", lGenJournalLine."Journal Batch Name");

                lGenJournalLine.RESET();
                lGenJournalLine.SETFILTER("Journal Template Name", '<>%1', GenJournalLine."Journal Template Name");
                lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
                lGenJournalLine.SETRANGE("External Document No.", GenJournalLine."External Document No.");
                IF lGenJournalLine.FINDFIRST() THEN
                    ERROR(lText50000, GenJournalLine."External Document No.", lGenJournalLine."Line No.", lGenJournalLine."Journal Template Name", lGenJournalLine."Journal Batch Name");
            END;
        //HEI.07<<


        TestAccountAndBalAccountType(GenJournalLine);

        if GenJournalLine."Bal. Account No." = '' then
            GenJournalLine.TestField("Account No.", ErrorInfo.Create());

        CheckZeroAmount(GenJournalLine);

        if ((GenJournalLine.Amount < 0) xor (GenJournalLine."Amount (LCY)" < 0)) and (GenJournalLine.Amount <> 0) and (GenJournalLine."Amount (LCY)" <> 0) then
            GenJournalLine.FieldError("Amount (LCY)", ErrorInfo.Create(StrSubstNo(Text003, GenJournalLine.FieldCaption(Amount)), true));

        //HEI.10<<
        IF (GenJnlTemplate."SO Cash Application FND") AND (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Payment) THEN
            IF ((GenJournalLine."Account Type" = GenJournalLine."Account Type"::Customer) AND (GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::"G/L Account"))
              OR ((GenJournalLine."Account Type" = GenJournalLine."Account Type"::"G/L Account") AND (GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::Customer)) THEN
                GenJournalLine.TESTFIELD("Related Sales Order FND");
        //HEI.10>>

        //HEI.11<<
        IF GenJournalLine."Free Goods Accounting FND" THEN BEGIN
            SalesInvoiceLine.RESET();
            SalesInvoiceLine.SETRANGE("Document No.", GenJournalLine."Document No.");
            SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Item);
            // SalesInvoiceLine.SETRANGE("Free Item", TRUE);   // BC Upgrade SHUKLP03 << Blocked because of DIT field "Free Item".
            // SalesInvoiceLine.SETFILTER("Free Reason Code", '<>%1', '');  // BC Upgrade SHUKLP03 << Blocked because of DIT field "Free Reason Code".
            IF SalesInvoiceLine.FINDFIRST() THEN
                IF SalesInvoiceLine."Free Goods Posted FND" THEN
                    ERROR(Text015, SalesInvoiceLine."Document No.");
        END;
        //HEI.11>>


        if (GenJournalLine."Account Type" = GenJournalLine."Account Type"::"G/L Account") and
       (GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::"G/L Account")
    then
            CheckAppliesToDocNo(GenJournalLine);

        if (GenJournalLine."Recurring Method" in
            [GenJournalLine."Recurring Method"::"B  Balance", GenJournalLine."Recurring Method"::"RB Reversing Balance"]) and
           (GenJournalLine."Currency Code" <> '')
        then
            Error(
                ErrorInfo.Create(
                    StrSubstNo(
                        Text004,
                        GenJournalLine.FieldCaption("Currency Code"), GenJournalLine.FieldCaption("Recurring Method"), GenJournalLine."Recurring Method"),
                    true,
                    GenJournalLine,
                    GenJournalLine.FieldNo("Recurring Method")));

        if GenJournalLine."Account No." <> '' then
            CheckAccountNo(GenJournalLine);

        if GenJournalLine."Bal. Account No." <> '' then
            CheckBalAccountNo(GenJournalLine);
        if GenJournalLine."IC Account No." <> '' then begin
            if GenJournalLine."IC Account Type" = GenJournalLine."IC Account Type"::"G/L Account" then
                if ICGLAcount.Get(GenJournalLine."IC Account No.") then
                    ICGLAcount.TestField(Blocked, false, ErrorInfo.Create());
            if GenJournalLine."IC Account Type" = GenJournalLine."IC Account Type"::"Bank Account" then
                if ICBankAccount.Get(GenJournalLine."IC Account No.") then
                    ICBankAccount.TestField(Blocked, false, ErrorInfo.Create());
        end;

        if ((GenJournalLine."Account Type" = GenJournalLine."Account Type"::"G/L Account") and
            (GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::"G/L Account")) or
           ((GenJournalLine."Document Type" <> GenJournalLine."Document Type"::Invoice) and
            (not
             ((GenJournalLine."Document Type" = GenJournalLine."Document Type"::"Credit Memo") and
              CalcPmtDiscOnCrMemos(GenJournalLine."Payment Terms Code"))))
        then begin
            GenJournalLine.TestField("Pmt. Discount Date", 0D, ErrorInfo.Create());
            GenJournalLine.TestField("Payment Discount %", 0, ErrorInfo.Create());
        end;

        TestAppliesToID(GenJournalLine);
        //HEI.06>>
        SourceCodeSetup.GET();
        IF GenJournalLine."Source Code" <> SourceCodeSetup."Payment Journal Tree FND" THEN BEGIN
            //HEI.06<<

            if (GenJournalLine."Account Type" <> GenJournalLine."Account Type"::"Bank Account") and
               (GenJournalLine."Bal. Account Type" <> GenJournalLine."Bal. Account Type"::"Bank Account")
            then
                GenJournalLine.TestField("Bank Payment Type", GenJournalLine."Bank Payment Type"::" ", ErrorInfo.Create());
            //HEI.06>>
        END ELSE
            IF (GenJournalLine.Amount < 0) AND (GenJournalLine."Bank Payment Type" = GenJournalLine."Bank Payment Type"::"Computer Check") THEN
                GenJournalLine.TESTFIELD("Check Printed", TRUE);
        //HEI.06<<

        if (GenJournalLine."Account Type" = GenJournalLine."Account Type"::"Fixed Asset") or
           (GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::"Fixed Asset")
        then
            CODEUNIT.Run(CODEUNIT::"FA Jnl.-Check Line", GenJournalLine);

        if (GenJournalLine."Account Type" <> GenJournalLine."Account Type"::"Fixed Asset") and
           (GenJournalLine."Bal. Account Type" <> GenJournalLine."Bal. Account Type"::"Fixed Asset")
        then begin
            GenJournalLine.TestField("Depreciation Book Code", '', ErrorInfo.Create());
            GenJournalLine.TestField("FA Posting Type", 0, ErrorInfo.Create());
        end;

        if GenJournalLine."Deferral Code" <> '' then
            CheckPostedDeferralHeaderExist(GenJournalLine);

        if not OverrideDimErr then
            CheckDimensions(GenJournalLine);

        CheckCurrencyCode(GenJournalLine);

        // if CostAccSetup2.Get() then //BC UPGRADE KUMARR78 Blocking to rename variable.
        if CostAccSetup.Get() then //BC UPGRADE KUMARR78 Adding rename variable.
            CostAccMgt.CheckValidCCAndCOInGLEntry(GenJournalLine."Dimension Set ID");

        OnAfterCheckGenJnlLine(GenJournalLine, ErrorMessageMgt);

        if LogErrorMode then // BC Upgrade SHUKLP03 << Not able to set LogErrorMode variable value because no event is found to get this variable value we have to find workaround.
            ErrorMessageMgt.GetErrors(TempErrorMessage);

        IsHandled := true;
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterCheckGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var ErrorMessageMgt: Codeunit "Error Message Management")
    begin
    end;

    local procedure CheckCurrencyCode(GenJnlLine: Record "Gen. Journal Line")
    var
        ACYOnlyPosting: Boolean;
    begin
        ACYOnlyPosting :=
          (GLSetup2."Additional Reporting Currency" <> '') and
          (GenJnlLine."Additional-Currency Posting" = GenJnlLine."Additional-Currency Posting"::"Additional-Currency Amount Only") and
          (GenJnlLine."Currency Code" = GLSetup2."Additional Reporting Currency");

        if (GenJnlLine."Currency Code" <> '') and (GenJnlLine."Currency Code" <> GLSetup2."LCY Code") then begin
            CheckAccountCurrencyCode(
                GenJnlLine."Account No.", GenJnlLine."Account Type", GenJnlLine."Currency Code", ACYOnlyPosting);
            CheckAccountCurrencyCode(
                GenJnlLine."Bal. Account No.", GenJnlLine."Bal. Account Type", GenJnlLine."Currency Code", ACYOnlyPosting);
        end;
    end;

    local procedure CheckAccountCurrencyCode(AccountNo: Code[20]; AccountType: Enum "Gen. Journal Account Type"; CurrencyCode: Code[10]; ACYOnly: Boolean)
    var
        GLAccount: Record "G/L Account";
        BankAccount: Record "Bank Account";
        BankAccountPostingGroup: Record "Bank Account Posting Group";
        Customer: Record Customer;
        CustomerPostingGroup: Record "Customer Posting Group";
        Vendor: Record Vendor;
        VendorPostingGroup: Record "Vendor Posting Group";
    begin
        if (AccountNo = '') or ACYOnly then
            exit;

        case AccountType of
            AccountType::"G/L Account":
                begin
                    GLAccount.Get(AccountNo);
                    CheckGLAccountSourceCurrency(GLAccount, CurrencyCode);
                end;
            AccountType::Customer:
                begin
                    Customer.Get(AccountNo);
                    CustomerPostingGroup.Get(Customer."Customer Posting Group");
                    GLAccount.Get(CustomerPostingGroup."Receivables Account");
                    CheckGLAccountSourceCurrency(GLAccount, CurrencyCode);
                end;
            AccountType::Vendor:
                begin
                    Vendor.Get(AccountNo);
                    VendorPostingGroup.Get(Vendor."Vendor Posting Group");
                    GLAccount.Get(VendorPostingGroup."Payables Account");
                    CheckGLAccountSourceCurrency(GLAccount, CurrencyCode);
                end;
            AccountType::"Bank Account":
                begin
                    BankAccount.Get(AccountNo);
                    BankAccountPostingGroup.Get(BankAccount."Bank Acc. Posting Group");
                    GLAccount.Get(BankAccountPostingGroup."G/L Account No.");
                    CheckGLAccountSourceCurrency(GLAccount, CurrencyCode);
                end;
        end;
    end;

    local procedure CheckGLAccountSourceCurrency(var GLAccount: Record "G/L Account"; CurrencyCode: Code[10])
    var
        GLAccountSourceCurrency: Record "G/L Account Source Currency";
    begin
        GLSetup2.Get();
        case GLAccount."Source Currency Posting" of
            GLAccount."Source Currency Posting"::"Same Currency":
                if (CurrencyCode <> GLAccount."Source Currency Code") and
                    (GLAccount."Source Currency Code" <> '') and (GLAccount."Source Currency Code" <> GLSetup2."LCY Code")
                then
                    Error(GLAccCurrencyDoesNotMatchErr, CurrencyCode, GLAccount."Source Currency Code", GLAccount."No.");
            GLAccount."Source Currency Posting"::"Multiple Currencies":
                if CurrencyCode <> '' then begin
                    GLAccountSourceCurrency.SetRange("G/L Account No.", GLAccount."No.");
                    GLAccountSourceCurrency.SetRange("Currency Code", CurrencyCode);
                    if GLAccountSourceCurrency.IsEmpty() then
                        Error(GLAccSourceCurrencyDoesNotMatchErr, CurrencyCode, GLAccount."No.");
                end;
            GLAccount."Source Currency Posting"::"LCY Only":
                if CurrencyCode <> '' then
                    Error(GLAccSourceCurrencyDoesNotAllowedErr, CurrencyCode, GLAccount."No.");
        end;
    end;

    local procedure TestAppliesToID(var GenJnlLine: Record "Gen. Journal Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeTestAppliesToID(GenJnlLine, IsHandled);
        if IsHandled then
            exit;

        if GenJnlLine."Applies-to Doc. No." <> '' then
            GenJnlLine.TestField("Applies-to ID", '', ErrorInfo.Create());
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTestAppliesToID(var GenJournalLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
    end;

    local procedure CalcPmtDiscOnCrMemos(PaymentTermsCode: Code[10]): Boolean
    var
        PaymentTerms: Record "Payment Terms";
    begin
        if PaymentTermsCode <> '' then begin
            PaymentTerms.Get(PaymentTermsCode);
            exit(PaymentTerms."Calc. Pmt. Disc. on Cr. Memos");
        end;
    end;

    local procedure CheckBalAccountNo(GenJnlLine: Record "Gen. Journal Line")
    var
        ICPartner: Record "IC Partner";
        CheckDone: Boolean;
    begin
        OnBeforeCheckBalAccountNo(GenJnlLine, CheckDone);
        if CheckDone then
            exit;

        case GenJnlLine."Bal. Account Type" of
            GenJnlLine."Bal. Account Type"::"G/L Account":
                begin
                    if ((GenJnlLine."Bal. Gen. Bus. Posting Group" <> '') or (GenJnlLine."Bal. Gen. Prod. Posting Group" <> '') or
                        (GenJnlLine."Bal. VAT Bus. Posting Group" <> '') or (GenJnlLine."Bal. VAT Prod. Posting Group" <> '')) and
                       not ApplicationAreaMgmt.IsSalesTaxEnabled()
                    then
                        GenJnlLine.TestField("Bal. Gen. Posting Type", ErrorInfo.Create());

                    GenJnlCheckLine.CheckBalGenProdPostingGroupWhenAdjustForPmtDisc(GenJnlLine);

                    if (GenJnlLine."Bal. Gen. Posting Type" <> GenJnlLine."Bal. Gen. Posting Type"::" ") and
                       (GenJnlLine."VAT Posting" = GenJnlLine."VAT Posting"::"Automatic VAT Entry")
                    then begin
                        if GenJnlLine."Bal. VAT Amount" + GenJnlLine."Bal. VAT Base Amount" <> -GenJnlLine.Amount then
                            Error(
                                ErrorInfo.Create(
                                    StrSubstNo(
                                        Text006, GenJnlLine.FieldCaption("Bal. VAT Amount"), GenJnlLine.FieldCaption("Bal. VAT Base Amount"),
                                        GenJnlLine.FieldCaption(Amount)),
                                    true,
                                    GenJnlLine,
                                    GenJnlLine.FieldNo("Bal. VAT Amount")));
                        if GenJnlLine."Currency Code" <> '' then
                            if GenJnlLine."Bal. VAT Amount (LCY)" + GenJnlLine."Bal. VAT Base Amount (LCY)" <> -GenJnlLine."Amount (LCY)" then
                                Error(
                                    ErrorInfo.Create(
                                        StrSubstNo(
                                            Text006, GenJnlLine.FieldCaption("Bal. VAT Amount (LCY)"),
                                            GenJnlLine.FieldCaption("Bal. VAT Base Amount (LCY)"), GenJnlLine.FieldCaption("Amount (LCY)")),
                                                            true,
                                    GenJnlLine,
                                    GenJnlLine.FieldNo("Bal. VAT Amount (LCY)")));
                    end;
                end;
            GenJnlLine."Bal. Account Type"::Customer, GenJnlLine."Bal. Account Type"::Vendor, GenJnlLine."Bal. Account Type"::Employee:
                begin
                    GenJnlLine.TestField("Bal. Gen. Posting Type", 0, ErrorInfo.Create());
                    GenJnlLine.TestField("Bal. Gen. Bus. Posting Group", '', ErrorInfo.Create());
                    GenJnlLine.TestField("Bal. Gen. Prod. Posting Group", '', ErrorInfo.Create());
                    GenJnlLine.TestField("Bal. VAT Bus. Posting Group", '', ErrorInfo.Create());
                    GenJnlLine.TestField("Bal. VAT Prod. Posting Group", '', ErrorInfo.Create());

                    CheckBalAccountType(GenJnlLine);

                    CheckBalDocType(GenJnlLine);

                    if ((GenJnlLine.Amount > 0) xor (GenJnlLine."Sales/Purch. (LCY)" < 0)) and (GenJnlLine.Amount <> 0) and (GenJnlLine."Sales/Purch. (LCY)" <> 0) then
                        GenJnlLine.FieldError("Sales/Purch. (LCY)", ErrorInfo.Create(StrSubstNo(Text009, GenJnlLine.FieldCaption(Amount)), true));
                    CheckJobNoIsEmpty(GenJnlLine);

                    CheckICPartner(GenJnlLine."Bal. Account Type", GenJnlLine."Bal. Account No.", GenJnlLine."Document Type", GenJnlLine);
                end;
            GenJnlLine."Bal. Account Type"::"Bank Account":
                begin
                    GenJnlLine.TestField("Bal. Gen. Posting Type", 0, ErrorInfo.Create());
                    GenJnlLine.TestField("Bal. Gen. Bus. Posting Group", '', ErrorInfo.Create());
                    GenJnlLine.TestField("Bal. Gen. Prod. Posting Group", '', ErrorInfo.Create());
                    GenJnlLine.TestField("Bal. VAT Bus. Posting Group", '', ErrorInfo.Create());
                    GenJnlLine.TestField("Bal. VAT Prod. Posting Group", '', ErrorInfo.Create());
                    if (GenJnlLine.Amount > 0) and (GenJnlLine."Bank Payment Type" = GenJnlLine."Bank Payment Type"::"Computer Check") then
                        GenJnlLine.TestField("Check Printed", true, ErrorInfo.Create());
                    CheckElectronicPaymentFields(GenJnlLine);
                end;
            GenJnlLine."Bal. Account Type"::"IC Partner":
                begin
                    ICPartner.Get(GenJnlLine."Bal. Account No.");
                    ICPartner.CheckICPartner();
                    if GenJnlTemplate.Type <> GenJnlTemplate.Type::Intercompany then
                        GenJnlLine.FieldError("Bal. Account Type", ErrorInfo.Create());
                end;
        end;

        OnAfterCheckBalAccountNo(GenJnlLine);
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterCheckBalAccountNo(var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;

    local procedure CheckElectronicPaymentFields(GenJnlLine: Record "Gen. Journal Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckElectronicPaymentFields(GenJnlLine, IsHandled);
        if IsHandled then
            exit;

        if (GenJnlLine."Bank Payment Type" = GenJnlLine."Bank Payment Type"::"Electronic Payment") or
           (GenJnlLine."Bank Payment Type" = GenJnlLine."Bank Payment Type"::"Electronic Payment-IAT")
        then begin
            GenJnlLine.TestField("Exported to Payment File", true, ErrorInfo.Create());
            if CheckTransmitted(GenJnlLine) then
                GenJnlLine.TestField("Check Transmitted", true, ErrorInfo.Create());
        end;
    end;

    local procedure CheckTransmitted(GenJnlLine: Record "Gen. Journal Line"): Boolean
    var
        BankAccount: Record "Bank Account";
    begin
        if GenJnlLine."Account Type" = GenJnlLine."Account Type"::"Bank Account" then
            if BankAccount.Get(GenJnlLine."Account No.") then
                exit(BankAccount."Check Transmitted");
        if GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"Bank Account" then
            if BankAccount.Get(GenJnlLine."Bal. Account No.") then
                exit(BankAccount."Check Transmitted");
        exit(false);
    end;


    [IntegrationEvent(true, false)]
    local procedure OnBeforeCheckElectronicPaymentFields(var GenJnlLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
    end;

    local procedure CheckICPartner(AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[20]; DocumentType: Enum "Gen. Journal Document Type"; GenJnlLine: Record "Gen. Journal Line")
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        ICPartner: Record "IC Partner";
        Employee: Record Employee;
        CheckDone: Boolean;
    begin
        OnBeforeCheckICPartner(AccountType, AccountNo, DocumentType.AsInteger(), CheckDone, GenJnlLine);
        if CheckDone then
            exit;

        case AccountType of
            AccountType::Customer:
                if Customer.Get(AccountNo) then begin
                    Customer.CheckBlockedCustOnJnls(Customer, DocumentType, true);
                    if (Customer."IC Partner Code" <> '') and (GenJnlTemplate.Type = GenJnlTemplate.Type::Intercompany) and
                       ICPartner.Get(Customer."IC Partner Code")
                    then
                        ICPartner.CheckICPartnerIndirect(Format(AccountType), AccountNo);
                end;
            AccountType::Vendor:
                if Vendor.Get(AccountNo) then begin
                    Vendor.CheckBlockedVendOnJnls(Vendor, DocumentType, true);
                    if (Vendor."IC Partner Code" <> '') and (GenJnlTemplate.Type = GenJnlTemplate.Type::Intercompany) and
                       ICPartner.Get(Vendor."IC Partner Code")
                    then
                        ICPartner.CheckICPartnerIndirect(Format(AccountType), AccountNo);
                end;
            AccountType::Employee:
                if Employee.Get(AccountNo) then
                    Employee.CheckBlockedEmployeeOnJnls(true)
        end;
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeCheckICPartner(AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[20]; DocumentType: Option; var CheckDone: Boolean; GenJnlLine: Record "Gen. Journal Line")
    begin
    end;

    local procedure CheckJobNoIsEmpty(GenJnlLine: Record "Gen. Journal Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckJobNoIsEmpty(GenJnlLine, IsHandled);
        if IsHandled then
            exit;

        GenJnlLine.TestField("Job No.", '', ErrorInfo.Create());
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeCheckJobNoIsEmpty(GenJnlLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
    end;

    local procedure CheckBalDocType(GenJnlLine: Record "Gen. Journal Line")
    var
        IsPayment: Boolean;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckBalDocType(GenJnlLine, IsHandled);
        if IsHandled then
            exit;

        if GenJnlLine."Document Type" <> GenJnlLine."Document Type"::" " then begin
            if (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Employee) and not
               (GenJnlLine."Document Type" in [GenJnlLine."Document Type"::Payment, GenJnlLine."Document Type"::" "])
            then
                GenJnlLine.FieldError("Document Type", ErrorInfo.Create(EmployeeBalancingDocTypeErr, true));

            IsPayment := GenJnlLine."Document Type" in [GenJnlLine."Document Type"::Payment, GenJnlLine."Document Type"::"Credit Memo"];
            if IsPayment = (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer) then
                GenJnlCheckLine.ErrorIfNegativeAmt(GenJnlLine)
            else
                GenJnlCheckLine.ErrorIfPositiveAmt(GenJnlLine);
        end;
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeCheckBalDocType(GenJournalLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
    end;

    local procedure CheckBalAccountType(GenJnlLine: Record "Gen. Journal Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckBalAccountType(GenJnlLine, IsHandled);
        if IsHandled then
            exit;

        if ((GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer) and
            (GenJnlLine."Gen. Posting Type" = GenJnlLine."Gen. Posting Type"::Purchase)) or
           ((GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor) and
            (GenJnlLine."Gen. Posting Type" = GenJnlLine."Gen. Posting Type"::Sale))
        then
            Error(
                ErrorInfo.Create(
                    StrSubstNo(
                        Text010,
                        GenJnlLine.FieldCaption("Bal. Account Type"), GenJnlLine."Bal. Account Type",
                        GenJnlLine.FieldCaption("Gen. Posting Type"), GenJnlLine."Gen. Posting Type"),
                    true,
                    GenJnlLine));
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeCheckBalAccountType(GenJnlLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeCheckBalAccountNo(var GenJnlLine: Record "Gen. Journal Line"; var CheckDone: Boolean)
    begin
    end;

    local procedure CheckDimensions(GenJnlLine: Record "Gen. Journal Line")
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        CheckDone: Boolean;
        FinancialUtils: Codeunit "Financial-Utils";
        InitialDimSetID: Integer;
        SourceCodeDimension: Record "Source Code Dimension FND";
        DimSetEntry: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        DimensionManagement: Codeunit DimensionManagement;
    begin
        OnBeforeCheckDimensions(GenJnlLine, CheckDone);
        if CheckDone then
            exit;

    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeCheckDimensions(var GenJnlLine: Record "Gen. Journal Line"; var CheckDone: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnCheckDimensionsOnAfterAssignDimTableIDs(var GenJournalLine: Record "Gen. Journal Line"; var TableID: array[10] of Integer; var No: array[10] of Code[20]; var CheckDone: Boolean)
    begin
    end;

    local procedure CheckPostedDeferralHeaderExist(GenJnlLine: Record "Gen. Journal Line")
    var
        DeferralHeader: Record "Deferral Header";
        PostedDeferralHeader: Record "Posted Deferral Header";
        AccountNo: Code[20];
        ErrorTxt: Text;
    begin
        if not CheckDeferralHeaderExist(GenJnlLine) then
            exit;

        AccountNo := GetDeferralAccountNo(GenJnlLine);

        if PostedDeferralHeader.Get(
            DeferralHeader."Deferral Doc. Type"::"G/L",
            GenJnlLine."Document No.",
            AccountNo,
            0,
            '',
            GenJnlLine."Line No.")
        then begin
            ErrorTxt := StrSubstNo(DuplicateRecordErr, GenJnlLine."Document No.");
            Error(ErrorInfo.Create(ErrorTxt, true, GenJnlLine, GenJnlLine.FieldNo("Deferral Code")));
        end;
    end;

    local procedure GetDeferralAccountNo(GenJournalLine: Record "Gen. Journal Line"): Code[20]
    var
        CustPostingGr: Record "Customer Posting Group";
        VendPostingGr: Record "Vendor Posting Group";
        BankAcc: Record "Bank Account";
        BankAccPostingGr: Record "Bank Account Posting Group";
        GLAccountType: Enum "Gen. Journal Account Type";
        Account: Code[20];
        GLAccount: Code[20];
    begin
        if (GenJournalLine."Account No." = '') and (GenJournalLine."Bal. Account No." <> '') then begin
            GLAccount := GenJournalLine."Bal. Account No.";
            GLAccountType := GenJournalLine."Bal. Account Type";
        end else begin
            GLAccount := GenJournalLine."Account No.";
            GLAccountType := GenJournalLine."Account Type";
        end;

        case GLAccountType of
            GenJournalLine."Account Type"::Customer:
                begin
                    CustPostingGr.Get(GenJournalLine."Posting Group");
                    Account := CustPostingGr.GetReceivablesAccount();
                end;
            GenJournalLine."Account Type"::Vendor:
                begin
                    VendPostingGr.Get(GenJournalLine."Posting Group");
                    Account := VendPostingGr.GetPayablesAccount();
                end;
            GenJournalLine."Account Type"::"Bank Account":
                begin
                    BankAcc.Get(GLAccount);
                    BankAccPostingGr.Get(BankAcc."Bank Acc. Posting Group");
                    Account := BankAccPostingGr."G/L Account No.";
                end;
            else
                Account := GLAccount;
        end;

        exit(Account);
    end;

    local procedure CheckDeferralHeaderExist(GenJnlLine: Record "Gen. Journal Line"): Boolean
    var
        DeferralHeader: Record "Deferral Header";
    begin
        if DeferralHeader.Get(
            DeferralHeader."Deferral Doc. Type"::"G/L",
            GenJnlLine."Journal Template Name",
            GenJnlLine."Journal Batch Name", 0, '',
            GenJnlLine."Line No.")
        then
            exit(true);
    end;

    local procedure CheckAccountNo(GenJnlLine: Record "Gen. Journal Line")
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        ICPartner: Record "IC Partner";
        CheckDone: Boolean;
        IsHandled: Boolean;
    begin
        OnBeforeCheckAccountNo(GenJnlLine, CheckDone);
        if CheckDone then
            exit;

        case GenJnlLine."Account Type" of
            GenJnlLine."Account Type"::"G/L Account":
                begin
                    if (((GenJnlLine."Gen. Bus. Posting Group" <> '') or (GenJnlLine."Gen. Prod. Posting Group" <> '') or
                        (GenJnlLine."VAT Bus. Posting Group" <> '') or (GenJnlLine."VAT Prod. Posting Group" <> '')) and
                        (GenJnlLine."Gen. Posting Type" = GenJnlLine."Gen. Posting Type"::" "))
                    then
                        Error(
                            ErrorInfo.Create(
                                StrSubstNo(
                                    SpecifyGenPostingTypeErr, GenJnlLine."Account No.", GenJnlLine.FieldCaption("Gen. Posting Type"),
                                    GenJnlLine.FieldCaption("Gen. Bus. Posting Group"), GenJnlLine.FieldCaption("Gen. Prod. Posting Group"),
                                    GenJnlLine.FieldCaption("VAT Bus. Posting Group"), GenJnlLine.FieldCaption("VAT Prod. Posting Group")),
                                true,
                                GenJnlLine,
                                GenJnlLine.FieldNo("Gen. Posting Type")));

                    GenJnlCheckLine.CheckGenProdPostingGroupWhenAdjustForPmtDisc(GenJnlLine);

                    if (GenJnlLine."Gen. Posting Type" <> GenJnlLine."Gen. Posting Type"::" ") and
                       (GenJnlLine."VAT Posting" = GenJnlLine."VAT Posting"::"Automatic VAT Entry")
                    then begin
                        if GenJnlLine."VAT Amount" + GenJnlLine."VAT Base Amount" <> GenJnlLine.Amount then
                            Error(
                                ErrorInfo.Create(
                                    StrSubstNo(
                                        Text005, GenJnlLine.FieldCaption("VAT Amount"), GenJnlLine.FieldCaption("VAT Base Amount"),
                                        GenJnlLine.FieldCaption(Amount)),
                                    true,
                                    GenJnlLine,
                                    GenJnlLine.FieldNo("VAT Amount")));
                        if GenJnlLine."Currency Code" <> '' then
                            if GenJnlLine."VAT Amount (LCY)" + GenJnlLine."VAT Base Amount (LCY)" <> GenJnlLine."Amount (LCY)" then
                                Error(
                                    ErrorInfo.Create(
                                        StrSubstNo(
                                            Text005, GenJnlLine.FieldCaption("VAT Amount (LCY)"),
                                            GenJnlLine.FieldCaption("VAT Base Amount (LCY)"), GenJnlLine.FieldCaption("Amount (LCY)")),
                                        true,
                                        GenJnlLine,
                                        GenJnlLine.FieldNo("VAT Amount (LCY)")));
                    end;
                end;
            GenJnlLine."Account Type"::Customer, GenJnlLine."Account Type"::Vendor, GenJnlLine."Account Type"::Employee:
                begin
                    GenJnlLine.TestField("Gen. Posting Type", 0, ErrorInfo.Create());
                    GenJnlLine.TestField("Gen. Bus. Posting Group", '', ErrorInfo.Create());
                    GenJnlLine.TestField("Gen. Prod. Posting Group", '', ErrorInfo.Create());
                    GenJnlLine.TestField("VAT Bus. Posting Group", '', ErrorInfo.Create());
                    GenJnlLine.TestField("VAT Prod. Posting Group", '', ErrorInfo.Create());

                    CheckAccountType(GenJnlLine);

                    GenJnlCheckLine.CheckDocType(GenJnlLine);

                    if not GenJnlLine."System-Created Entry" and
                       (((GenJnlLine.Amount < 0) xor (GenJnlLine."Sales/Purch. (LCY)" < 0)) and (GenJnlLine.Amount <> 0) and (GenJnlLine."Sales/Purch. (LCY)" <> 0))
                    then
                        GenJnlLine.FieldError("Sales/Purch. (LCY)", ErrorInfo.Create(StrSubstNo(Text003, GenJnlLine.FieldCaption(Amount)), true));
                    CheckJobNoIsEmpty(GenJnlLine);

                    IsHandled := false;
                    OnCheckAccountNoOnBeforeCheckICPartner(GenJnlLine, IsHandled);
                    if not IsHandled then
                        CheckICPartner(GenJnlLine."Account Type", GenJnlLine."Account No.", GenJnlLine."Document Type", GenJnlLine);
                end;
            GenJnlLine."Account Type"::"Bank Account":
                begin
                    GenJnlLine.TestField("Gen. Posting Type", 0, ErrorInfo.Create());
                    GenJnlLine.TestField("Gen. Bus. Posting Group", '', ErrorInfo.Create());
                    GenJnlLine.TestField("Gen. Prod. Posting Group", '', ErrorInfo.Create());
                    GenJnlLine.TestField("VAT Bus. Posting Group", '', ErrorInfo.Create());
                    GenJnlLine.TestField("VAT Prod. Posting Group", '', ErrorInfo.Create());
                    CheckJobNoIsEmpty(GenJnlLine);
                    if (GenJnlLine.Amount < 0) and (GenJnlLine."Bank Payment Type" = GenJnlLine."Bank Payment Type"::"Computer Check") then
                        GenJnlLine.TestField("Check Printed", true, ErrorInfo.Create());
                    CheckElectronicPaymentFields(GenJnlLine);
                end;
            GenJnlLine."Account Type"::"IC Partner":
                begin
                    ICPartner.Get(GenJnlLine."Account No.");
                    ICPartner.CheckICPartner();
                    if GenJnlLine."Journal Template Name" <> '' then begin
                        GenJournalTemplate.Get(GenJnlLine."Journal Template Name");
                        if GenJnlTemplate.Type <> GenJnlTemplate.Type::Intercompany then
                            GenJnlLine.FieldError("Account Type", ErrorInfo.Create());
                    end;
                end;
        end;

        OnAfterCheckAccountNo(GenJnlLine);
    end;

    local procedure CheckAccountType(GenJnlLine: Record "Gen. Journal Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckAccountType(GenJnlLine, IsHandled);
        if IsHandled then
            exit;

        if ((GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer) and
            (GenJnlLine."Bal. Gen. Posting Type" = GenJnlLine."Bal. Gen. Posting Type"::Purchase)) or
           ((GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor) and
            (GenJnlLine."Bal. Gen. Posting Type" = GenJnlLine."Bal. Gen. Posting Type"::Sale))
        then
            Error(
                ErrorInfo.Create(
                    StrSubstNo(
                        Text010,
                        GenJnlLine.FieldCaption("Account Type"), GenJnlLine."Account Type",
                        GenJnlLine.FieldCaption("Bal. Gen. Posting Type"), GenJnlLine."Bal. Gen. Posting Type"),
                    true,
                    GenJnlLine));
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeCheckAccountType(GenJnlLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCheckAccountNoOnBeforeCheckICPartner(var GenJournalLine: Record "Gen. Journal Line"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterCheckAccountNo(var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeCheckAccountNo(var GenJnlLine: Record "Gen. Journal Line"; var CheckDone: Boolean)
    begin
    end;

    local procedure CheckAppliesToDocNo(GenJnlLine: Record "Gen. Journal Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckAppliesToDocNo(GenJnlLine, IsHandled);
        if IsHandled then
            exit;

        GenJnlLine.TestField("Applies-to Doc. No.", '', ErrorInfo.Create());
        GenJnlLine.TestField("Applies-to ID", '', ErrorInfo.Create());
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeCheckAppliesToDocNo(GenJnlLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
    end;

    local procedure CheckZeroAmount(var GenJnlLine: Record "Gen. Journal Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckZeroAmount(GenJnlLine, IsBatchMode, IsHandled);
        if IsHandled then
            exit;

        if GenJnlLine.NeedCheckZeroAmount() and not (GenJnlLine.IsRecurring() and IsBatchMode) then
            GenJnlLine.TestField(Amount, ErrorInfo.Create());
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeCheckZeroAmount(GenJnlLine: Record "Gen. Journal Line"; IsBatchMode: Boolean; var IsHandled: Boolean)
    begin
    end;

    local procedure TestAccountAndBalAccountType(var GenJnlLine: Record "Gen. Journal Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeTestAccountAndBalAccountType(GenJnlLine, IsHandled);
        if IsHandled then
            exit;

        if (GenJnlLine."Account Type" in
                 [GenJnlLine."Account Type"::Customer,
                  GenJnlLine."Account Type"::Vendor,
                  GenJnlLine."Account Type"::"Fixed Asset",
                  GenJnlLine."Account Type"::"IC Partner"]) and
                (GenJnlLine."Bal. Account Type" in
                 [GenJnlLine."Bal. Account Type"::Customer,
                  GenJnlLine."Bal. Account Type"::Vendor,
                  GenJnlLine."Bal. Account Type"::"Fixed Asset",
                  GenJnlLine."Bal. Account Type"::"IC Partner"])
             then
            Error(
                ErrorInfo.Create(
                    StrSubstNo(
                    Text002,
                    GenJnlLine.FieldCaption("Account Type"), GenJnlLine.FieldCaption("Bal. Account Type")),
                true,
                GenJnlLine,
                GenJnlLine.FieldNo("Account Type")));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTestAccountAndBalAccountType(var GenJournalLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
    end;

    local procedure TestDocumentNo(var GenJournalLine: Record "Gen. Journal Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeTestDocumentNo(GenJournalLine, IsHandled);
        if IsHandled then
            exit;

        GenJournalLine.TestField("Document No.", ErrorInfo.Create());
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTestDocumentNo(var GenJournalLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
    end;

    local procedure CheckDates(GenJnlLine: Record "Gen. Journal Line")
    var
        AccountingPeriodMgt: Codeunit "Accounting Period Mgt.";
        DateCheckDone: Boolean;
        IsHandled: Boolean;
        AccountingPeriod: Record "Accounting Period";
        Text000: Label 'can only be a closing date for G/L entries';

    begin
        GenJnlLine.TestField("Posting Date", ErrorInfo.Create());
        if GenJnlLine."Posting Date" <> NormalDate(GenJnlLine."Posting Date") then begin
            if (GenJnlLine."Account Type" <> GenJnlLine."Account Type"::"G/L Account") or
               (GenJnlLine."Bal. Account Type" <> GenJnlLine."Bal. Account Type"::"G/L Account")
            then
                GenJnlLine.FieldError("Posting Date", ErrorInfo.Create(Text000, true));
            AccountingPeriod.GET(NORMALDATE(GenJnlLine."Posting Date") + 1);

            // BC Upgrade SHUKLP03 >> Blocked in Nav.    
            // if not SkipFiscalYearCheck then begin
            //     IsHandled := false;
            //     OnBeforeCheckPostingDateInFiscalYear(GenJnlLine, IsHandled);
            //     if not IsHandled then
            //         AccountingPeriodMgt.CheckPostingDateInFiscalYear(GenJnlLine."Posting Date");
            // end;
            // BC Upgrade SHUKLP03 << Blocked in Nav.    

        end;

        if GLSetup2."Journal Templ. Name Mandatory" then
            GenJnlLine.TestField("Journal Template Name", ErrorInfo.Create());
        if GenJnlCheckLine.DeferralPostingDateNotAllowed(GenJnlLine."Posting Date") then
            GenJnlLine.FieldError("Posting Date", ErrorInfo.Create(Text001, true));
        // DateCheckDone := true;//BC UPGRADE KUMARR78 Blocking
        DateCheckDone := false;//BC UPGRADE KUMARR78 Adding

        OnBeforeDateNotAllowed(GenJnlLine, DateCheckDone);
        if not DateCheckDone then
            if GenJnlCheckLine.DateNotAllowed(GenJnlLine."Posting Date", GenJnlLine."Journal Template Name") then
                GenJnlLine.FieldError("Posting Date", ErrorInfo.Create(Text001, true));

        if GenJnlLine."Document Date" <> 0D then
            if (GenJnlLine."Document Date" <> NormalDate(GenJnlLine."Document Date")) and
               ((GenJnlLine."Account Type" <> GenJnlLine."Account Type"::"G/L Account") or
                (GenJnlLine."Bal. Account Type" <> GenJnlLine."Bal. Account Type"::"G/L Account"))
            then
                GenJnlLine.FieldError("Document Date", ErrorInfo.Create(Text000, true));

        if HasVAT(GenJnlLine) then
            CheckVATDate(GenJnlLine);
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeDateNotAllowed(GenJnlLine: Record "Gen. Journal Line"; var DateCheckDone: Boolean)
    begin
    end;

    local procedure CheckVATDate(var GenJournalLine: Record "Gen. Journal Line")
    var
        VATReportingDateMgt: Codeunit "VAT Reporting Date Mgt";
        IsHandled: Boolean;
        ThrowError: Boolean;
    begin
        IsHandled := false;
        // Posting of some document types do not catch errors with ErrorMessageMgt.
        // For these it is needed that we throw error with message directly to display to user
        ThrowError := GenJournalLine."Document Type" in [Enum::"Gen. Journal Document Type"::" ", Enum::"Gen. Journal Document Type"::"Finance Charge Memo", Enum::"Gen. Journal Document Type"::Reminder, Enum::"Gen. Journal Document Type"::"Credit Memo"];
        OnBeforeCheckVATDate(GenJournalLine, IsHandled);
        if not IsHandled then
            if not VATReportingDateMgt.IsValidDate(GenJournalLine, GenJournalLine.FieldNo("VAT Reporting Date"), ThrowError) then
                Error('');
    end;

    local procedure HasVAT(var GenJnlLine: Record "Gen. Journal Line"): Boolean
    begin
        exit((GenJnlLine."Gen. Posting Type" <> GenJnlLine."Gen. Posting Type"::" ") or
            (GenJnlLine."Bal. Gen. Posting Type" <> GenJnlLine."Bal. Gen. Posting Type"::" "));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckVATDate(var GenJournalLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeCheckPostingDateInFiscalYear(GenJournalLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
    end;

    LOCAL procedure CheckInterestRateCreditLine(GenJournalLine: Record "Gen. Journal Line")
    begin
        //HEI.02>>
        IF GenJournalLine."Document Type" = GenJournalLine."Document Type"::"Interest Rate Credit" THEN BEGIN
            GenJournalLine.TESTFIELD("Bal. Account No.", '');
            GenJournalLine.TESTFIELD("Account Type", GenJournalLine."Account Type"::"G/L Account");
            IF GenJournalLine.Correction = FALSE THEN BEGIN
                IF GenJournalLine.Amount < 0 THEN BEGIN
                    GenJournalLine.TESTFIELD("Source Type", GenJournalLine."Source Type"::Customer);
                    GenJournalLine.TESTFIELD("Source No.");
                END ELSE BEGIN
                    GenJournalLine.TESTFIELD("Source Type", GenJournalLine."Source Type"::" ");
                    GenJournalLine.TESTFIELD("Source No.", '');
                END;
            END ELSE BEGIN
                IF GenJournalLine.Amount > 0 THEN BEGIN
                    GenJournalLine.TESTFIELD("Source Type", GenJournalLine."Source Type"::Customer);
                    GenJournalLine.TESTFIELD("Source No.");
                END ELSE BEGIN
                    GenJournalLine.TESTFIELD("Source Type", GenJournalLine."Source Type"::" ");
                    GenJournalLine.TESTFIELD("Source No.", '');
                END;
            END;
        END;

        //HEI.02<<
    end;

    LOCAL procedure CheckRPMDamageLossLine(GenJournalLine: Record "Gen. Journal Line")
    begin
        //>>HEI.03
        IF GenJournalLine."Document Type" = GenJournalLine."Document Type"::"RPM Damage or Loss" THEN
            IF GenJournalLine."RPM Original Sales Amount FND" > ABS(GenJournalLine."Amount (LCY)") THEN
                ERROR(GreaterRPMAmountErr, GenJournalLine.FIELDCAPTION("RPM Original Sales Amount FND"), GenJournalLine."RPM Original Sales Amount FND", ABS(GenJournalLine."Amount (LCY)"));
        //<<HEI.03
    end;

    LOCAL procedure CheckAmountOnRefundLine(GenJournalLine: Record "Gen. Journal Line")
    begin
        //HEI.04>>
        IF (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Refund) AND (GenJournalLine."Account Type" = GenJournalLine."Account Type"::Vendor) THEN
            IF GenJournalLine.Amount > 0 THEN
                GenJournalLine.TESTFIELD(Amount, -GenJournalLine.Amount)
        //HEI.04<<
    end;

    LOCAL procedure CheckFFESecurityPaymentLine(GenJournalLine: Record "Gen. Journal Line")
    begin
        //HEI.05>>
        IF GenJournalLine."Document Type" = GenJournalLine."Document Type"::"FFE Security Payment" THEN BEGIN
            GenJournalLine.TESTFIELD("Bal. Account No.", '');
            GenJournalLine.TESTFIELD("Account Type", GenJournalLine."Account Type"::"G/L Account");
            IF GenJournalLine.Correction = FALSE THEN BEGIN
                IF GenJournalLine.Amount < 0 THEN BEGIN
                    GenJournalLine.TESTFIELD("Source Type", GenJournalLine."Source Type"::Customer);
                    GenJournalLine.TESTFIELD("Source No.");
                END ELSE BEGIN
                    GenJournalLine.TESTFIELD("Source Type", GenJournalLine."Source Type"::" ");
                    GenJournalLine.TESTFIELD("Source No.", '');
                END;
            END ELSE BEGIN
                IF GenJournalLine.Amount > 0 THEN BEGIN
                    GenJournalLine.TESTFIELD("Source Type", GenJournalLine."Source Type"::Customer);
                    GenJournalLine.TESTFIELD("Source No.");
                END ELSE BEGIN
                    GenJournalLine.TESTFIELD("Source Type", GenJournalLine."Source Type"::" ");
                    GenJournalLine.TESTFIELD("Source No.", '');
                END;
            END;
        END;

        //HEI.05<<
    end;

    // BC UPGRADE GUPTAK03 WHT Related -->>
    LOCAL procedure CheckWHTGroupsOnPaymJourn(GnlJournalLine: Record "Gen. Journal Line")
    var
        PurchInvLine: Record "Purch. Inv. Line";
        WHTPostingSetup: Record "WHT Posting Setup FND";
        WHTIncorrect: Boolean;
        WHTEntry: Record "WHT Entry FND";
        TempWHTEntry: Record "WHT Entry FND";
        EntryNo: Integer;
        PaymEntryNo: Integer;
        GenLedgerSetup: Record "General Ledger Setup";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        SourceCodeSetup: Record "Source Code Setup";
    begin
        //HEI.09>>
        GenLedgerSetup.GET;
        SourceCodeSetup.GET;
        IF GenLedgerSetup."Enable WHT FND" THEN BEGIN
            CASE GnlJournalLine."Source Code" OF
                SourceCodeSetup."Purchase Entry Application":
                    BEGIN
                        //post payment-invoice application for WHT invoices , payment type, not allowded
                        IF (GnlJournalLine."Document Type" = GnlJournalLine."Document Type"::Invoice) THEN BEGIN
                            //post the invoice-payment application from the invoice
                            WHTEntry.RESET;
                            WHTEntry.SETCURRENTKEY("Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.", Closed);
                            WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Invoice);
                            WHTEntry.SETRANGE("Document No.", GnlJournalLine."Document No.");
                            WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                            WHTEntry.SETRANGE(Closed, FALSE);
                            IF WHTEntry.FINDFIRST THEN
                                IF WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group") THEN
                                    IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN
                                        ERROR(Text014, GnlJournalLine."Document No.");
                        END ELSE BEGIN
                            IF (GnlJournalLine."Document Type" = GnlJournalLine."Document Type"::Payment) THEN BEGIN
                                VendLedgerEntry.RESET;
                                VendLedgerEntry.SETCURRENTKEY("Applies-to ID");
                                VendLedgerEntry.SETRANGE("Applies-to ID", GnlJournalLine."Applies-to ID");
                                IF VendLedgerEntry.FINDSET THEN
                                    REPEAT
                                        WHTEntry.RESET;
                                        WHTEntry.SETCURRENTKEY("Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.", Closed);
                                        WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Invoice);
                                        WHTEntry.SETRANGE("Document No.", VendLedgerEntry."Document No.");
                                        WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                                        WHTEntry.SETRANGE(Closed, FALSE);
                                        //if something to pay
                                        IF WHTEntry.FINDFIRST THEN
                                            IF WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group") THEN
                                                IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN
                                                    ERROR(Text014, VendLedgerEntry."Document No.");
                                    UNTIL VendLedgerEntry.NEXT = 0
                            END;
                        END;
                    END;
                ELSE BEGIN
                    //payments posted and applied from payment journal
                    IF (GnlJournalLine."Document Type" = GnlJournalLine."Document Type"::Payment) THEN BEGIN
                        //if the Apply-to Doc No. is used for the payment, not for post application
                        IF (GnlJournalLine."Applies-to Doc. Type" = GnlJournalLine."Applies-to Doc. Type"::Invoice) AND
                            (GnlJournalLine."Applies-to Doc. No." <> '') THEN BEGIN
                            WHTEntry.RESET;
                            WHTEntry.SETCURRENTKEY("Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.", Closed);
                            WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Invoice);
                            WHTEntry.SETRANGE("Document No.", GnlJournalLine."Applies-to Doc. No.");
                            WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                            WHTEntry.SETRANGE(Closed, FALSE);
                            //if something to pay
                            IF WHTEntry.FINDFIRST THEN
                                IF WHTPostingSetup.GET(WHTEntry."WHT Bus. Posting Group", WHTEntry."WHT Prod. Posting Group") THEN
                                    IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN
                                        IF (GnlJournalLine."WHT Business Posting Group FND" <> WHTEntry."WHT Bus. Posting Group") OR
                                          (GnlJournalLine."WHT Product Posting Group FND" <> WHTEntry."WHT Prod. Posting Group") THEN
                                            ERROR(Text013, GnlJournalLine."WHT Business Posting Group FND", GnlJournalLine."WHT Product Posting Group FND", GnlJournalLine."Applies-to Doc. No.", GnlJournalLine."Line No.");
                        END ELSE BEGIN
                            //if Applies-to ID is used for the payment
                            IF GnlJournalLine."Applies-to ID" <> '' THEN BEGIN
                                VendLedgerEntry.RESET;
                                VendLedgerEntry.SETCURRENTKEY("Applies-to ID");
                                VendLedgerEntry.SETRANGE("Applies-to ID", GnlJournalLine."Applies-to ID");
                                IF VendLedgerEntry.FINDSET THEN
                                    REPEAT
                                        IF WHTPostingSetup.GET(GnlJournalLine."WHT Business Posting Group FND", GnlJournalLine."WHT Product Posting Group FND") THEN
                                            IF WHTPostingSetup."Realized WHT Type" = WHTPostingSetup."Realized WHT Type"::Payment THEN BEGIN
                                                WHTEntry.RESET;
                                                WHTEntry.SETCURRENTKEY("Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.", Closed);
                                                WHTEntry.SETRANGE("Document Type", WHTEntry."Document Type"::Invoice);
                                                WHTEntry.SETRANGE("Document No.", VendLedgerEntry."Document No.");
                                                WHTEntry.SETRANGE("Transaction Type", WHTEntry."Transaction Type"::Purchase);
                                                WHTEntry.SETRANGE(Closed, FALSE);
                                                IF WHTEntry.FINDFIRST THEN BEGIN
                                                    WHTEntry.SETRANGE("WHT Bus. Posting Group", GnlJournalLine."WHT Business Posting Group FND");
                                                    WHTEntry.SETRANGE("WHT Prod. Posting Group", GnlJournalLine."WHT Product Posting Group FND");
                                                    IF NOT WHTEntry.FINDFIRST THEN
                                                        ERROR(Text013, GnlJournalLine."WHT Business Posting Group FND", GnlJournalLine."WHT Product Posting Group FND", VendLedgerEntry."Document No.", GnlJournalLine."Line No.");
                                                END;
                                            END;
                                    UNTIL VendLedgerEntry.NEXT = 0;
                            END; //IF GnlJournalLine."Applies-to ID" <> ''
                        END;
                    END;
                END; //begin din case
            END;
        END;
        //HEI.09<<
    end;
    // BC UPGRADE GUPTAK03 WHT Related -->>
    //BC Upgrade kamnay01 The event subscriber was deleted (rather than commented) to ensure it is fully removed from the extension metadata. In Business Central, commented code may still persist in the compiled version if the extension is not redeployed with a version change, causing the old subscriber to be triggered during debugging. Deletion guarantees clean removal.

    // BC Upgrade SHUKLP03 << Codeunit 11 "Gen. Jnl.-Check Line"

    //BC UPGRADE PATHAA02-Codeunit 99000756-VersionManagement 22.01.26>>
    //HEI.01 & HEI.02>>   
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"VersionManagement", 'OnBeforeGetBOMVersion', '', false, false)]
    local procedure OnBeforeGetBOMVersion(BOMHeaderNo: Code[20]; Date: Date; OnlyCertified: Boolean; var VersionCode: Code[20]; var IsHandled: Boolean)
    var
        ProductionBOMVersion: Record "Production BOM Version";
    begin

        IsHandled := true;// To Override standard BC logic

        ProductionBOMVersion.SetCurrentKey("Production BOM No.", "Starting Date");
        ProductionBOMVersion.SetRange("Production BOM No.", BOMHeaderNo);

        // HEI.02 >>
        if ForBlankVersionCode then
            ProductionBOMVersion.SetRange("Version Code", '')
        ELSE
            //HEI.02<<
            // HEI.01 >> 
            ProductionBOMVersion.SetRange("Active FND", true);//Only Active versions

        // ProductionBOMVersion.SetFilter("Starting Date", '%1|..%2', 0D, Date);
        // HEI.01<<

        if OnlyCertified then
            ProductionBOMVersion.SetRange(Status, ProductionBOMVersion.Status::Certified)
        else
            ProductionBOMVersion.SetFilter(Status, '<>%1', ProductionBOMVersion.Status::Closed);
        ProductionBOMVersion.SetLoadFields("Version Code");
        if not ProductionBOMVersion.FindLast() then begin
            VersionCode := '';
            exit;
        end;
        // BC Upgrade RD03 - Assigning value to VersionCode variable -- >>
        VersionCode := ProductionBOMVersion."Version Code";
        // BC Upgrade RD03 - Assigning value to VersionCode variable -- <<
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::VersionManagement, OnBeforeGetRtngVersion, '', false, false)]
    local procedure OnBeforeGetRtngVersion(RoutingNo: Code[20]; Date: Date; OnlyCertified: Boolean; var VersionCode: Code[20]; var IsHandled: Boolean)
    var
        RoutingVersion: Record "Routing Version";
        ManufacturingSetup: Record "Manufacturing Setup";//BC Upgrade Kamnay01 Std cost bug fix
    begin

        IsHandled := true;// To Override standard BC logic
        RoutingVersion.SetCurrentKey("Routing No.", "Starting Date");
        RoutingVersion.SetRange("Routing No.", RoutingNo);

        // HEI.02 >> 
        if ForBlankVersionCode then
            RoutingVersion.SetRange("Version Code", '')
        ELSE

            // HEI.01 >> 
            RoutingVersion.SetRange("Active FND", true);//Only Active versions
        // RoutingVersion.SetFilter("Starting Date", '%1|..%2', 0D, Date);
        // HEI.01 <<

        if OnlyCertified then
            RoutingVersion.SetRange(Status, RoutingVersion.Status::Certified)
        else
            RoutingVersion.SetFilter(Status, '<>%1', RoutingVersion.Status::Closed);

        RoutingVersion.SetLoadFields("Version Code");
        if not RoutingVersion.FindLast() then begin
            VersionCode := '';
            exit;
        end;
        //BC Upgrade Kamnay01 std cost 23-06-2026 >>
        ManufacturingSetup.Get();
        if ManufacturingSetup."Std Cost Version FND" = true then
            VersionCode := ''
        else
            VersionCode := RoutingVersion."Version Code";
        //BC Upgrade Kamnay01 std cost 23-06-2026 <<
    end;

    //HEI.01 & HEI.02<<
    //BC UPGRADE PATHAA02-Codeunit 99000756-VersionManagement 22.01.26<<

    //KUMARS145>>Codeunit 86 - Sales-Quote to Order................................>>
    //   DITW15.00.00.23 DDR 08/08/2008 Drink-it Item Charges functionnalities
    //                                  Added call to function SetBatchInsertCheck() when insert/modify sales line
    //   DITW15.00.00.39 DDR 29/08/2011 issue 1396 Added Item Exclusivity functionnality (check warning while insert item)
    //   DITW16.00.00.42 DDR 01/03/2013 DIT-715 #572 Added "Order Tax Date"
    //   DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    //   DITW18.00 MSF 27/04/2015 DIT-770 #1363 Fix upgrade tag
    //   DITW18.00.07 VSC 23/06/2016 DIT-770 #2058 Set Route No. when creating order
    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //   DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    //   HEI.01 CHG2084621 HB1742 IBM GAVANM01 23.03.2021 - Sales Quotes functionality
    //     # use function CheckBlockedCustOnDocs2 for checking the customer
    //     # set Order No in quote
    //  BC Upgrade KUMARS145 Codeunit Extension Created.
    //  BC Upgrade KUMARS145.........>>
    //  BC Upgrade KUMARS145 (HEI.01 '# set Order No in quote') Code not added here as it depends on Drinkit custom fields ("Order No.", Drinkit field 2014093).
    //  BC Upgrade KUMARS145 Workaround

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", OnBeforeOnRun, '', false, false)]
    local procedure OnBeforeOnRun(var SalesHeader: Record "Sales Header")
    var
        Cust: Record Customer;
        DocType2: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";
    begin
        if Cust.Get(SalesHeader."Sell-to Customer No.") then
            Cust.CheckBlockedCustOnDocs2(Cust, DocType2::Order, TRUE, FALSE, 0, FALSE, FALSE, FALSE);
    end;
    //  BC Upgrade KUMARS145...........................................<<

    // BC Upgrade SHUKLP03 >> Codeunit 13 "Gen. Jnl.-Post Batch"

    // HEI.01 FDD-PTPGAP067 IBM SOICAD01
    // HEI.02 FDD-HNK LOGGAP001 03/10/2018 IBM.CHAUHB01
    //   #Code to avoid deletion of batch if Save Batch is set to yes on Gen. Journal Template
    // HEI.03 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Modified functions
    //     # Code
    //     # FindNextGLRegisterNo

    // HEI.04 FDD-HT903 IBM SURYAS01 19-11-2019
    //   #Added Code in Function - 'code()
    // HEI.05 CHG2052196 IBM PANDES01 09-12-2020
    //     # Added code for Enhancement of check ledger voiding.
    // HEI.06 CHG2201773 HB3442 SRIVAS07 IBM 06/12/23 - Development - Undoing a Goods Receipt for Fixed Asset
    //     # Added Code in Code()
    //     # Added Code in CheckLine()


    // BC Upgrade SHUKLP03 >>
    // HEI.01,HEI.04 => Subscribed event OnProcessBalanceOfLinesOnAfterSetVATEntryCreated to add code.
    // HEI.05 => Subscribed event OnProcessBalanceOfLinesOnAfterCalcShouldCheckDocNoBasedOnNoSeries to add code.
    // HEI.06 => Procedure CheckLine() code is not added because that is for Undo FA Receipt for procedure CheckRestrictions() and now in business central this procedure code has scope for on-prem only.
    // HEI.02 => Subscribed event IncrementBatchName to add code.
    // HEI.03 => Code is not added because that is for France localization which is not applicable for BC Upgrade.
    // BC Upgrade SHUKLP03 <<

    // BC Upgrade SHUKLP03 >> Blocked Temp -> need to find workaround.
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", OnProcessBalanceOfLinesOnAfterCalcShouldCheckDocNoBasedOnNoSeries, '', false, false)]
    // local procedure OnProcessBalanceOfLinesOnAfterCalcShouldCheckDocNoBasedOnNoSeries(CurrentBalance: Decimal; LastDocNo: Code[20]; var GenJournalBatch: Record "Gen. Journal Batch"; var GenJournalLine: Record "Gen. Journal Line"; var ShouldCheckDocNoBasedOnNoSeries: Boolean; var SkipCheckingPostingNoSeries: Boolean)
    // var
    //     NoSeriesBatch: Codeunit "No. Series - Batch";
    // begin
    //     //>>HEI.05
    //     if ShouldCheckDocNoBasedOnNoSeries then BEGIN
    //         //IF GenJnlBatch."Bank Payment Type" <> GenJnlBatch."Bank Payment Type"::"Computer Check" THEN //HEI.06
    //         IF (GenJournalBatch."Bank Payment Type" <> GenJournalBatch."Bank Payment Type"::"Computer Check") AND (NOT GenJournalLine."Undo FA Receipt") THEN BEGIN
    //             //CheckDocNoBasedOnNoSeries(LastDocNo, GenJnlBatch."No. Series", NoSeriesMgt);  // BC Upgrade SHUKLP03 - Commented and write procedure CheckDocNoBasedOnNoSeries() code below as per base.
    //             if GenJournalLine."Document No." = NoSeriesBatch.PeekNextNo(GenJournalBatch."No. Series", GenJournalLine."Posting Date") then
    //                 // No. used is same as peek so need to save it.
    //                 NoSeriesBatch.GetNextNo(GenJournalBatch."No. Series", GenJournalLine."Posting Date")
    //             else
    //                 // manual nos should be allowed.
    //                 NoSeriesBatch.TestManual(GenJournalBatch."No. Series", GenJournalLine."Document No.");
    //         end;
    //     END;
    //     // CheckDocNoBasedOnNoSeries(LastDocNo,GenJnlBatch."No. Series",NoSeriesMgt);
    //     //<<HEI.05
    //     ShouldCheckDocNoBasedOnNoSeries := false; // BC Upgrade SHUKLP03 << To avoid duplicate check in base code.

    // end;
    // BC Upgrade SHUKLP03 << Blocked Temp -> need to find workaround.

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", OnProcessBalanceOfLinesOnAfterSetVATEntryCreated, '', false, false)]
    local procedure OnProcessBalanceOfLinesOnAfterSetVATEntryCreated(GenJournalLine: Record "Gen. Journal Line"; var VATEntryCreated: Boolean)
    var
        PurchPayableSetup: Record "Purchases & Payables Setup";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchHeader: Record "Purchase Header";
        HNKGlobal: Codeunit "Heineken Global";

    begin

        GenJnlTemplateGlo.GET(GenJournalLine."Journal Template Name"); // BC Upgrade SHUKLP03 << To get Gen. Journal Template Record.
        //HEI.01>>
        //HEI.04<<
        PurchPayableSetup.GET();
        // IF PurchPayableSetup."Prepmt. Via deduction on final" = TRUE THEN BEGIN // BC Upgrade BHARDA11 --FDD STP 009 (if set to False, the Heilite prepayment functionality is executed). As part of the rollback, this conditional logic will be removed/modified to ensure that only the standard Navision prepayment functionality is executed across all scenarios.
        VendorLedgerEntry.RESET();
        VendorLedgerEntry.SETRANGE("Applies-to ID", GenJournalLine."Document No.");
        VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
        IF VendorLedgerEntry.FINDSET() THEN
            REPEAT

                PurchInvHeader.RESET();
                PurchInvHeader.SETRANGE("No.", VendorLedgerEntry."Document No.");
                IF PurchInvHeader.FINDSET() THEN
                    REPEAT
                        PurchHeader.RESET();
                        PurchHeader.SETRANGE("No.", PurchInvHeader."Prepayment Order No.");
                        IF PurchHeader.FINDSET() THEN
                            REPEAT
                                CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchHeader);
                            UNTIL PurchHeader.NEXT() = 0;
                    UNTIL PurchInvHeader.NEXT() = 0;
            UNTIL VendorLedgerEntry.NEXT() = 0;
        // END; // BC Upgrade BHARDA11 --FDD STP 009 (if set to False, the Heilite prepayment functionality is executed). As part of the rollback, this conditional logic will be removed/modified to ensure that only the standard Navision prepayment functionality is executed across all scenarios.
        //HEi.04>>
        // BC Upgrade BHARDA11 >>--FDD STP 009 (if set to False, the Heilite prepayment functionality is executed). As part of the rollback, this conditional logic will be removed/modified to ensure that only the standard Navision prepayment functionality is executed across all scenarios.
        // IF NOT PurchPayableSetup."Prepmt. Via deduction on final" = TRUE THEN BEGIN//HEI.04
        //     IF GenJnlTemplateGlo.Type = GenJnlTemplateGlo.Type::Payments THEN
        //         HNKGlobal.ReversePrepaymentInvoice(GenJournalLine);
        // END; //Hei.04
        // BC Upgrade BHARDA11 <<--FDD STP 009 (if set to False, the Heilite prepayment functionality is executed). As part of the rollback, this conditional logic will be removed/modified to ensure that only the standard Navision prepayment functionality is executed across all scenarios.
        //HEI.01<<
    end;
    // BC Upgrade BHARAD11 >> 
    // BC Upgrade BHARDA11 >> --FDD STP 009 --This event is used for  Release purchase document
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Release Purchase Document", 'OnCodeOnBeforeCalcAndUpdateVATOnLines', '', false, false)]
    local procedure OnCodeOnBeforeCalcAndUpdateVATOnLines(var PurchaseHeader: Record "Purchase Header")
    begin
        // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488 (temporary OSPv2)
        PurchaseHeader.VALIDATE(Status);
        // >>DITW18.00.07 DDR DIT-770 #1488
    end;
    // BC Upgrade BHARDA11 << --FDD STP 009 --This event is used for  Release purchase document
    // BC Upgrade BHARDA11 << 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", OnProcessLinesOnAfterAssignGLNegNo, '', false, false)]
    local procedure OnProcessLinesOnAfterAssignGLNegNo(var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLineGlo := GenJournalLine; // BC Upgrade SHUKLP03 << Passed value in global variable to use in other event subscriber in this codeunit.
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", OnUpdateAndDeleteLinesOnBeforeInBatchName, '', false, false)]
    local procedure OnUpdateAndDeleteLinesOnBeforeInBatchName(var GenJnlBatch: Record "Gen. Journal Batch"; var GenJnlLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    var
        TempGenJnlLine2: Record "Gen. Journal Line" temporary;

    begin
        GenJnlLine2.Copy(GenJournalLineGlo); // BC Upgrade SHUKLP03 << Copy value from global variable to local variable.
        GenJnlLine2.SetFilter("Account No.", '<>%1', ''); // BC Upgrade SHUKLP03 << 
        if GenJnlLine2.FindLast() then; // Remember the last line // BC Upgrade SHUKLP03 << 
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", OnBeforeIncrementBatchName, '', false, false)]
    local procedure OnBeforeIncrementBatchName(var GenJnlBatch: Record "Gen. Journal Batch"; var IsHandled: Boolean)
    var
        LocGenJournalTemplate: Record "Gen. Journal Template";
    begin
        if IncStr(GenJournalLineGlo."Journal Batch Name") <> '' then begin
            //<<FDD-HNK LOGGAP001 IBM.CHAUHB01 03/10/2018
            LocGenJournalTemplate.GET(GenJournalLineGlo."Journal Template Name");
            IF NOT LocGenJournalTemplate."Save Batch FND" THEN BEGIN
                //<<FDD-HNK LOGGAP001 IBM.CHAUHB01 03/10/2018
                GenJnlBatch.Delete();
                if GenJnlTemplateGlo.Type = GenJnlTemplateGlo.Type::Assets then
                    FAJnlSetup.IncGenJnlBatchName(GenJnlBatch);
                GenJnlBatch.Name := IncStr(GenJournalLineGlo."Journal Batch Name");
                if GenJnlBatch.Insert() then;
                GenJournalLineGlo."Journal Batch Name" := GenJnlBatch.Name;
                OnAfterIncrementBatchName(GenJnlBatch, GenJnlLine2."Journal Batch Name");
            end;//FDD-HNK LOGGAP001 IBM.CHAUHB01 03/10/2018
        end;

        IsHandled := True;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterIncrementBatchName(var GenJournalBatch: Record "Gen. Journal Batch"; OldBatchName: Code[10])
    begin
    end;
    // BC Upgrade SHUKLP03 << Codeunit 13 "Gen. Jnl.-Post Batch"


    //BC UPGRADE SIVA 5604 >>
    // DITW16.00.00.41 AHU 09/08/2012 DIT-715 #327 Added to transferfields
    //"DIT Sub-Contract Type","Contract Group Code","Service Contract No.",
    //"Service Contract Line No.","Service Contract Type"
    //DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //Added field "Financial Contract No."
    //Rename Caption Contract No. by Service contract No.
    //Change ID of field Contract Type to Foundation layer 2035393
    //Added blank Option to Contract Type
    //   HEI.01 FDD-RTRGAP056 IBM HORTOC01 25.08.2017
    //# Add Code into function "CopyFromGenJnlLine"
    //HEI.02 IBM PATHAA02 NavBugFix 19.09.2017
    //HEI.03 FDD-HT665 - Ethiopia Customize FA Ledger Entries IBM NASTAA02 09.07.2019 # Ethiopia Customize FA Ledger Entries
    //# Code added on function "CopyFromGenJnlLine"
    //BC Upgrade SIVA Codeunit-5604 #Created new function -OnAfterCopyFromGenJnlLine & Subscribed the event-OnAfterCopyFromGenJnlLine of Make FA Ledger Entry  so as to handle Copying values related to HEI TAGS custom code

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Make FA Ledger Entry", OnAfterCopyFromGenJnlLine, '', false, false)]
    local procedure OnAfterCopyFromGenJnlLine(var FALedgerEntry: Record "FA Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        FALedgerEntry2: record "FA Ledger Entry";
        DefaultDimension: Record "Default Dimension";
    begin
        FALedgerEntry."Comment FND" := GenJournalLine.Comment; //HEI.02
        FALedgerEntry."Purchase Receipt Line No. FND" := GenJournalLine."Purchase Receipt Line No. FND";//HEI.01
        //HEI.03>>
        DefaultDimension.SETRANGE("Table ID", DATABASE::"Fixed Asset");
        DefaultDimension.SETRANGE("Dimension Code", 'CAPEX');
        DefaultDimension.SETRANGE("No.", FALedgerEntry."FA No.");
        IF DefaultDimension.FINDFIRST() THEN
            FALedgerEntry."CAPEX Code FND" := DefaultDimension."Dimension Value Code";
        IF (GenJournalLine."Account Type" = GenJournalLine."Account Type"::"Fixed Asset") AND
           (GenJournalLine."Source Type" = GenJournalLine."Source Type"::Vendor)
        THEN BEGIN
            FALedgerEntry."Vendor ID FND" := GenJournalLine."Source No.";
            FALedgerEntry."Reference Number FND" := GenJournalLine."Reference Number FND";
            FALedgerEntry."PO Number FND" := GenJournalLine."PO Number FND";
        END ELSE
            IF GenJournalLine."Source Type" = GenJournalLine."Source Type"::" " THEN BEGIN
                FALedgerEntry2.Reset();
                FALedgerEntry2.SETRANGE("Document Type", GenJournalLine."Document Type");
                FALedgerEntry2.SETRANGE("Document No.", GenJournalLine."Document No.");
                FALedgerEntry2.SETRANGE(Description, GenJournalLine.Description);
                IF FALedgerEntry2.FINDFIRST() THEN BEGIN
                    FALedgerEntry."Vendor ID FND" := FALedgerEntry2."Vendor ID FND";
                    FALedgerEntry."Reference Number FND" := FALedgerEntry2."Reference Number FND";
                    FALedgerEntry."PO Number FND" := FALedgerEntry2."PO Number FND";
                END;
            END;
        //HEI.03<<
    end;//sharmp16--30 March 2026
        //BC UPGRADE SIVA 5604 <<    //BC UPGRADE SIVA 5604 <<

    //BC UPGRADE SIVA 5640 >>

    //    DITW15.00.00.38 DDR 08/07/2010 issue 1193 Added parameter function CreateDim of table81 Gen. Journal Line
    //       DITW15.00.00.38 DDR 05/01/2011 issue 822 Modified function InsertInsurance() to transfer the FA posting type
    //       DITW16.00.00.41 AHU 31/08/2012 DIT-715 #327 Renamed Captions fields2034915,2034310,2014311
    //       DITW16.00.00.41 AHU 20/09/2012 DIT-715 #327 Added parameters to call function CreateDim() Gen. and  Journals
    //       DITW17.10.03 MSF 28/05/2014 DIT-770 #715 Upgrade W1 Rollup 6 ChangeLog.W1.36366 file 474255
    //       DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                                 Added field 2014319  "Financial Contract No."
    //       HEI.01 FDD RTRGAP071 IBM POSTOI01 24.04.2018
    //        #Write a code to get balance Offset account
    // BC UPGRADE ATHUKS01>>
    //1.Commented code & new added code for posting error in fixed asset.
    //2.Adjust the code from OnBeforeGenJnlLineInsert event to AfterGenJnlLineInsert event for safe posting.  
    //BC UPGRADE ATHUKS01<<  
    var
        BCGenJnlPosting: Boolean; //BC UPGRADE ATHUKS01
        BCDuplicateInGenJnl: Boolean; //BC UPGRADE ATHUKS01

    //BC Upgrade SIVA Codeunit-5640 #Created new function -OnBeforeGenJnlLineInsert & Subscribed the event-OnBeforeGenJnlLineInsert of Duplicate Depr. Book  so as to handle Copying values related to HEI TAGS custom code
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Duplicate Depr. Book", OnBeforeGenJnlLineInsert, '', false, false)]
    // local procedure OnBeforeGenJnlLineInsert(var GenJournalLine: Record "Gen. Journal Line"; GenJnlPosting: Boolean; DuplicateInGenJnl: Boolean)
    // var
    //     FAGetBalanceAccount: Codeunit "FA Insert G/L Account";
    // begin
    //     //BC UPGRADE ATHUKS01 << Commeneted
    //     //>>HEI.01
    //     // IF (GenJournalLine."Account Type" = GenJournalLine."Account Type"::"Fixed Asset") THEN
    //     //   FAGetBalanceAccount.GetBalAcc(GenJournalLine);
    //     //<<HEI.01
    //     //BC UPGRADE ATHUKS01 >> Commeneted
    //     //BC UPGRADE ATHUKS01<<
    //     Clear(BCDuplicateInGenJnl);
    //     Clear(BCGenJnlPosting);
    //     BCGenJnlPosting := GenJnlPosting;
    //     BCDuplicateInGenJnl := DuplicateInGenJnl;
    //     //BC UPGRADE ATHUKS01>>
    // end;
    // //BC UPGRADE SIVA 5640 <<

    // //BC UPGRADE ATHUKS01<<
    // [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", OnAfterInsertEvent, '', false, false)]
    // local procedure AfterGenJnlLineInsert(var Rec: Record "Gen. Journal Line")
    // var
    //     FAGetBalanceAccount: Codeunit "FA Insert G/L Account";
    // begin
    //     //>>HEI.01
    //     if BCGenJnlPosting and BCDuplicateInGenJnl then begin
    //         IF (Rec."Account Type" = Rec."Account Type"::"Fixed Asset") THEN
    //             FAGetBalanceAccount.GetBalAcc(Rec);
    //         //<<HEI.01
    //     end
    // end;
    // //BC UPGRADE ATHUKS01>>

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Duplicate Depr. Book", OnBeforeGenJnlLineInsert, '', false, false)]
    local procedure OnBeforeGenJnlLineInsert1(var GenJournalLine: Record "Gen. Journal Line"; GenJnlPosting: Boolean; DuplicateInGenJnl: Boolean)
    var
        FAGetBalanceAccount: Codeunit "FA Insert G/L Account";
    begin
        //BC UPGRADE ATHUKS01 << Commeneted
        //>>HEI.01
        // IF (GenJournalLine."Account Type" = GenJournalLine."Account Type"::"Fixed Asset") THEN
        //   FAGetBalanceAccount.GetBalAcc(GenJournalLine);
        //<<HEI.01
        //BC UPGRADE ATHUKS01 >> Commeneted
        //BC UPGRADE ATHUKS01<<
        // Clear(BCDuplicateInGenJnl);
        // Clear(BCGenJnlPosting);
        GenJournalLine."BCGenJnlPosting FND" := GenJnlPosting;
        GenJournalLine."BCDuplicateInGenJnl FND" := DuplicateInGenJnl;
        //BCGenJnlPosting := GenJnlPosting;
        //  BCDuplicateInGenJnl := DuplicateInGenJnl;
        //BC UPGRADE ATHUKS01>>
    end;
    //BC UPGRADE SIVA 5640 <<

    //BC UPGRADE ATHUKS01<<
    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", OnAfterInsertEvent, '', false, false)]
    local procedure AfterGenJnlLineInsert1(var Rec: Record "Gen. Journal Line")
    var
        FAGetBalanceAccount: Codeunit "FA Insert G/L Account";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";

    begin
        if Rec."Document Type" IN [Rec."Document Type"::"Purchase Receipt", Rec."Document Type"::Invoice, Rec."Document Type"::"Credit Memo", Rec."Document Type"::"Purchase Shipment"]
        then begin
            if Rec."Document Type" = Rec."Document Type"::Invoice then begin
                PurchInvHeader.Reset();
                PurchInvHeader.SetRange("No.", Rec."Document No.");
                if not PurchInvHeader.FindFirst() then
                    exit;
            end;
            if Rec."Document Type" = Rec."Document Type"::"Credit Memo" then begin
                PurchCrMemoHeader.Reset();
                PurchCrMemoHeader.SetRange("No.", Rec."Document No.");
                if not PurchCrMemoHeader.FindFirst() then
                    exit;
            end;
            //>>HEI.01
            if Rec."BCGenJnlPosting FND" and Rec."BCDuplicateInGenJnl FND" then begin

                IF (Rec."Account Type" = Rec."Account Type"::"Fixed Asset") THEN
                    FAGetBalanceAccount.GetBalAcc(Rec);
                Rec."BCGenJnlPosting FND" := false;
                Rec."BCDuplicateInGenJnl FND" := false;
                Rec.Modify(false);
                //<<HEI.01
            end;
        end;
    end;
    //BC UPGRADE ATHUKS01>>


    //BC UPGRADE SIVA>> Codeunit 7310 "Whse.-Shipment Release" SubscriptionEvenets
    //   DITW15.00.00.39 DDR 22/08/2011 issue 1399 Added function CheckStatusBeforeRelease()
    //                                             Added new values Status field
    //                                             Added text constants Text2014060
    //                                             Bugfix when using Physical location
    //   DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added to check the "Truck Code" and "Driver Code"
    //   DITW19.00.08 MVN 31/08/2016 BL#11248 (DIT-770 #2162) Merge SSCC changes

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.11 DDR 25/10/2017 NRQ#41645 Fix SSCC License
    //   HEI.01 CHG2244491 HB3869 IBM COSTES04 12.11.2024 - Control relation to Zone and Bin Codes shipment and receipt
    //     # Make bin & code mandatory
    //****************************************//
    //BC UPGRADE SIVA // 
    //1.HEI.01 Subscribe below event for Zone and Bin Codes shipment and receipt # Make bin & code mandatory
    //2.Added IsTransGateEntryMandatory,IsSalesGateEntryMandatory procedures in HeinekenCusFunctions.
    //3.Added WhseShpmtIsTransferImportIdentifier procdure in HeinekenGlobal.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Shipment Release", OnBeforeRelease, '', false, false)]
    local procedure OnBeforeRelease(var WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        TransferOrderPostShipment: Codeunit "TransferOrder-Post Shipment";
        SalesPost: Codeunit "Sales-Post";
        HeinekenGlobal: Codeunit "Heineken Global";
        HeinekenCusFunctions: Codeunit "Heineken BC Custom Functions";
    begin
        //HEI.01>>
        IF ((WarehouseShipmentHeader."Source Document Type FND" IN [WarehouseShipmentHeader."Source Document Type FND"::"Inbound Transfer", WarehouseShipmentHeader."Source Document Type FND"::"Outbound Transfer"]) AND HeinekenCusFunctions.IsTransGateEntryMandatory(WarehouseShipmentHeader."Location Code", WarehouseShipmentHeader."Zone Code") AND HeinekenGlobal.WhseShpmtIsTransferImportIdentifier(WarehouseShipmentHeader."No.")) OR
         ((WarehouseShipmentHeader."Source Document Type FND" IN [WarehouseShipmentHeader."Source Document Type FND"::"Sales Order", WarehouseShipmentHeader."Source Document Type FND"::"Sales Return Order"]) AND HeinekenCusFunctions.IsSalesGateEntryMandatory(WarehouseShipmentHeader."Location Code", WarehouseShipmentHeader."Zone Code")) THEN BEGIN
            if Location.Get(WarehouseShipmentHeader."Location Code") then; //BC UPGRADE KUMARR78 FDD-MTC-007
            IF Location."Bin Mandatory" THEN
                WarehouseShipmentHeader.TESTFIELD("Bin Code");
            IF Location."Zone Mandatory FND" THEN
                WarehouseShipmentHeader.TESTFIELD("Zone Code");
        END;
        //HEI.01<< 
    end;
    //BC UPGRADE SIVA<< Codeunit 7310 "Whse.-Shipment Release" SubscriptionEvenets
    var
        PurchLineNoToCopy: Integer;
        GMoveNegLines: Boolean;
        GExactCostRevMandatory: Boolean;
        SkippedLine: Boolean;
        WarningDone: Boolean;
        GToPurchLine: Record "Purchase Line";

        //YADAVM09<<6620- Copy Document Mgt.<<

        // BC Upgrade SHUKLP03 >> Codeunit 11 "Gen. Jnl.-Check Line"
        GLSetup2: Record "General Ledger Setup";
        IsBatchMode: Boolean;
        CompanyInfo: Record "Company Information";
        GenJnlTemplate: Record "Gen. Journal Template";
        LogErrorMode: Boolean;
        ErrorMessageMgt: Codeunit "Error Message Management";
        GenJnlTemplateFound: Boolean;
        GenJnlCheckLine: Codeunit "Gen. Jnl.-Check Line";
        Text001: Label 'is not within your range of allowed posting dates';
        Text002: Label '%1 or %2 must be G/L Account or Bank Account.';
        Text003: Label 'must have the same sign as %1';
        Text004: Label 'You must not specify %1 when %2 is %3.';
        Text013: Label 'The WHT Bus. Posting Group=%1  WHT Prod. Posting Group=%2 from the payment line no %4 are not matching the WHT posting groups from the applied invoice %3';
        CostAccSetup2: Record "Cost Accounting Setup";
        EmployeeBalancingDocTypeErr: Label 'must be empty or set to Payment when Balancing Account Type field is set to Employee';
        Text006: Label '%1 + %2 must be -%3.';
        Text014: Label 'It is not allowed to post a payment-invoice application for WHT invoices %1, type Payments';
        CostAccMgt: Codeunit "Cost Account Mgt";
        Text009: Label 'must have a different sign than %1';
        Text012: Label 'A dimension used in %1 %2, %3, %4 has caused an error. %5';
        TempErrorMessage: Record "Error Message" temporary;
        SpecifyGenPostingTypeErr: Label 'Posting to Account %1 must either be of type Purchase or Sale (see %2), because there are specified values in one of the following fields: %3, %4 , %5, or %6', comment = '%1 an G/L Account number;%2 = Gen. Posting Type; %3 = Gen. Bus. Posting Group; %4 = Gen. Prod. Posting Group; %5 = VAT Bus. Posting Group, %6 = VAT Prod. Posting Group';
        Text010: Label '%1 %2 and %3 %4 is not allowed.';
        DuplicateRecordErr: Label 'Document No. %1 already exists. It is not possible to calculate new deferrals for a Document No. that already exists.', Comment = '%1=Document No.';
        GLAccCurrencyDoesNotMatchErr: Label 'The currency code %1 on general journal line does not match with the currency code %2 of G/L account %3.', Comment = '%1 and %2 - currency code, %3 - G/L Account No.';
        GLAccSourceCurrencyDoesNotMatchErr: Label 'The currency code %1 on general journal line does not match with the any source currency code of G/L account %2.', Comment = '%1 - currency code, %2 - G/L Account No.';
        GLAccSourceCurrencyDoesNotAllowedErr: Label 'The currency code %1 on general journal line does not allowed for posting to G/L account %2.', Comment = '%1 - currency code, %2 - G/L Account No.';
        ApplicationAreaMgmt: Codeunit System.Environment.Configuration."Application Area Mgmt.";
        Text011: Label 'The combination of dimensions used in %1 %2, %3, %4 is blocked. %5';
        DimMgt: Codeunit DimensionManagement;
        Text005: Label '%1 + %2 must be %3.';
        UserSetup: Record "User Setup";
        ItemJnlLineErrorC: Record "Item Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        GreaterRPMAmountErr: Label 'The charged price %1 %2 must not be higher than the FA Value %3.';
        Text015: Label 'The transactions have already been posted for the Sales Invoice No. %1. Please delete the related lines.';

        // BC Upgrade SHUKLP03 << Codeunit 11 "Gen. Jnl.-Check Line"
        // BC Upgrade SHUKLP03 >> Codeunit 13 "Gen. Jnl.-Post Batch"
        GenJournalLineGlo: Record "Gen. Journal Line";
        GenJnlTemplateGlo: Record "Gen. Journal Template";
        FAJnlSetup: Record "FA Journal Setup";
        GenJnlLine2: Record "Gen. Journal Line";
        // BC Upgrade SHUKLP03 << Codeunit 13 "Gen. Jnl.-Post Batch"
        //BC UPGRADE SIVA<< Codeunit 17 "Gen. Jnl.-Post Reverse" >>
        HeniKenBCGlobal: Codeunit "Heineken Global";
        ReverseTransErr: TextConst ENU = 'A Reversed transaction cant be unapplied';
    //BC UPGRADE SIVA<< Codeunit 17 "Gen. Jnl.-Post Reverse" <<



    //YADAVM09<<5814- "Undo Return Shipment Line"<<

    //Bc Upgrade YADAVM09 7301-Whse. Jnl.-Register Line>>
    //     DITW15.00.00.33-PRODW14.00.00.08.12 DLE 07/05/2009
    //                                Convert Whse. Entries to Put-away Unit of Measure code
    //                                The field Item."Put-away Unit of Measure code" is in STD Navision only used with
    //                                "Directed Put-Away and Pick" = Full Warehouse Management
    // DITW15.00.00.34-PRODW14.00.00.08.13 DDR 11/06/2009 Remove (see c/al codeunits 5760 + 5763)
    // DITW16.00.00.40 DDR 15/03/2012 DIT-715 #274 Added SSCC management (SSCC No. field)
    //                                             Added 'Permissions' property codeunit (table Permissions)
    //                                             Added functions InsertSSCCLedgEntry(),UpdateSourceSSCCLedgEntry()
    //                     03/05/2012 DIT-715 #292 Added "Bin Code" into SSCC Ledger Entries
    //                     22/05/2012 DIT-715 #292 Bugfix to apply the old SSCC Ledger entries while posting from Transfer/Reclass item jnl
    // DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457 Added "Work Order No." into Warehouse Entries
    // DITW16.00.00.42 DDR 02/04/2013 DIT-715 #588 Bugfix to save "New Lot No.","New SSCC No.","New Expiration Date" into SSCC Entries
    // DITW16.00.00.43 DDR 03/05/2013 DIT-715 #634 Added field "Applies-from SSCC Entry"
    //                                             Bugfix to update SSCC entry "Remaining Quantity" field (Application)
    //                     17/05/2013 DIT-715 #634 Bugfix when item has no item tracking code
    //                     10/10/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added functions SetWhseJnlLineSSCC(),CodeSSCC()

    // FINXL7.00.001 DAT 29/05/2014 #72: Overflow issue
    //                             changed function GetItemDescription
    //                               FROM: GetItemDescription(ItemNo : Code[20];Description2 : Text[50]) : Text[50])
    //                               TO:   GetItemDescription(ItemNo : Code[20];Description2 : Text[80]) : Text[80])

    // DITW17.00.02 DDR 03/05/2013 DIT-715 #634
    //                  17/05/2013 DIT-715 #634
    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 22/11/2014 DIT-770 #1005 Updated the length of the return value of the function "GetItemDescription" to 80
    // DITW17.10.05 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW19.00.08 MVN 31/08/2016 BL#11248 (DIT-770 #2162) Merge SSCC changes

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt
    //   #Code for zone transfer movement
    // HEI.02 FDD-PRDGAP024 IBM POENAB01 10.08.2017
    // #Code for zone transfer movement
    // HEI.03 PRDGAP038 IBM HORTO01 16.10.2017 - fill in "Quality status"
    // HEI.04 FDD-LB IBM NASTAA02 15.10.2018 # Item Availability excluding Blocked Stock
    //   # "Unavailable Stock (Bin)" will inherit the value from Bin
    //   # "Unavailable Stock (Quality)" will be set to TRUE/FALSE depending on "Quality Status"
    // HEI.05 INC0997769 IBM ISYED01 01.22.2019- flow quality status from "Lot No. Information"
    //  # fix provided to flow quality status from "Lot No. Information" Table
    // HEI.06 INC2116490 IBM NASTAA02 18.04.2019 # Quality Status
    //   # Quality Status should be 'Unrestricted' for no Lot Tracked Items
    // HEI.07 FDD-HT623 CHG2022293 IBM GAVANM01 12.07.2019
    //   # fix Item description
    // HEI.08 FDD-HT623 CHG2022293 IBM GAVANM01 06.08.2019
    //   # applicable for all OpCos
    // HEI.09 FDD-HT623 CHG2022293 IBM TUDOSG01 06.12.2019
    //   # fix Item description
    // HEI.10 CHG2154364 SAHAL01 15.03.2023 Astro - I/F Production - ProductionOrderOperationLinePick
    //   # Added Code to update External Document No. and External Document No.2

    //Bc Upgrade YADAVM09 OnCodeOnAfterGetLastEntryNo event is subscribed to add code function.
    //Bc Upgrade YADAVM09 OnInitWhseEntryCopyFromWhseJnlLine,OnDeleteFromBinContentOnAfterSetFiltersForBinContent event subscribed for function initwhseentry.
    //Bc Upgrade YADAVM09 OnBeforeInsertWhseEntry subscribed for function code InsertWhseEntry.
    //Bc Upgrade YADAVM09 for function GetItemDescription proper event not found.

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Jnl.-Register Line", 'OnCodeOnAfterGetLastEntryNo', '', false, false)]
    local procedure OnCodeOnAfterGetLastEntryNo(var WhseJnlLine: Record "Warehouse Journal Line")
    var
        CdWhsejnlline: Codeunit "Whse. Jnl.-Register Line";
        GlobalWhseEntry: Record "Warehouse Entry";
    begin
        //HEI.01 PRDGAP024>>
        IF WhseJnlLine."Zone-Transfer FND" THEN BEGIN
            IF WhseJnlLine."Transfer Type FND" = WhseJnlLine."Transfer Type FND"::Shipment THEN BEGIN
                WhseJnlLine."Transit-Zone FND" := FALSE;
                CdWhsejnlline.InitWhseEntry(GlobalWhseEntry, WhseJnlLine."From Zone Code", WhseJnlLine."From Bin Code", -1);
                InsertWhseEntry(GlobalWhseEntry, WhseJnlLine);
                WhseJnlLine."Transit-Zone FND" := TRUE;
                CdWhsejnlline.InitWhseEntry(GlobalWhseEntry, WhseJnlLine."In-Transit Zone Code FND", WhseJnlLine."In-Transit Bin Code FND", 1);
                InsertWhseEntry(GlobalWhseEntry, WhseJnlLine);
            END;
            IF WhseJnlLine."Transfer Type FND" = WhseJnlLine."Transfer Type FND"::Receipt THEN BEGIN
                WhseJnlLine."Transit-Zone FND" := TRUE;
                CdWhsejnlline.InitWhseEntry(GlobalWhseEntry, WhseJnlLine."In-Transit Zone Code FND", WhseJnlLine."In-Transit Bin Code FND", -1);
                InsertWhseEntry(GlobalWhseEntry, WhseJnlLine);
                WhseJnlLine."Transit-Zone FND" := FALSE;
                CdWhsejnlline.InitWhseEntry(GlobalWhseEntry, WhseJnlLine."To Zone Code", WhseJnlLine."To Bin Code", 1);
                InsertWhseEntry(GlobalWhseEntry, WhseJnlLine);
            END;
            EXIT;
        END;
        //HEI.01 PRDGAP024<<
    end;

    local procedure InsertWhseEntry(var WhseEntry: Record "Warehouse Entry"; var WhseJnlLine: Record "Warehouse Journal Line")
    var
        ItemTrackingCode: Record "Item Tracking Code";
        Item: Record Item;
        IsHandled: Boolean;
        WMSMgt: Codeunit "WMS Management";
        Text001: Label 'Serial No. %1 is found in inventory .';
    begin
        IsHandled := false;
        OnBeforeInsertWhseEntryProcedure(WhseEntry, WhseJnlLine, IsHandled);
        if IsHandled then
            exit;
        GetLocation(WhseJnlLine."Location Code");//Bc Upgrade YADAVM09
        Item.SetLoadFields("Item Tracking Code");
        Item.ReadIsolation(IsolationLevel::ReadCommitted);
        Item.Get(WhseEntry."Item No.");

        if ItemTrackingCode.Get(Item."Item Tracking Code") then
            if (WhseEntry."Serial No." <> '') and
               (WhseEntry."Bin Code" <> Location."Adjustment Bin Code") and
               (WhseEntry.Quantity > 0) and
               ItemTrackingCode."SN Specific Tracking"
            then begin
                IsHandled := false;
                OnInsertWhseEntryOnBeforeCheckSerialNo(WhseEntry, IsHandled);
                if not IsHandled then
                    if WMSMgt.SerialNoOnInventory(WhseEntry."Location Code", WhseEntry."Item No.", WhseEntry."Variant Code", WhseEntry."Serial No.") then
                        Error(Text001, WhseEntry."Serial No.");
            end;

        CheckExpiration(WhseEntry, ItemTrackingCode);

        OnBeforeInsertWhseEntry(WhseEntry, WhseJnlLine);
        InsertWhseReg(WhseEntry."Entry No.", WhseJnlLine);//Bc Upgrade YADAVM09
        WhseEntry."Warehouse Register No." := WhseReg."No.";
        WhseEntry.Insert(true);
        UpdateBinEmpty(WhseEntry, WhseJnlLine);//Bc Upgrade YADAVM09

        OnAfterInsertWhseEntry(WhseEntry, WhseJnlLine);
    end;



    local procedure UpdateBinEmpty(NewWarehouseEntry: Record "Warehouse Entry"; WhseJnlLine: Record "Warehouse Journal Line")
    var
        WarehouseEntry: Record "Warehouse Entry";
        IsHandled: Boolean;
    begin
        GetBin(WhseJnlLine."Location Code", WhseJnlLine."Bin Code");//Bc Upgrade YADAVM09
        OnBeforeUpdateBinEmpty(NewWarehouseEntry, Bin, IsHandled);
        if IsHandled then
            exit;

        if NewWarehouseEntry.Quantity > 0 then
            ModifyBinEmpty(false)
        else begin
            WarehouseEntry.ReadIsolation(IsolationLevel::ReadUnCommitted);
            WarehouseEntry.SetRange("Bin Code", NewWarehouseEntry."Bin Code");
            WarehouseEntry.SetRange("Location Code", NewWarehouseEntry."Location Code");
            WarehouseEntry.CalcSums("Qty. (Base)");
            ModifyBinEmpty(WarehouseEntry."Qty. (Base)" = 0);
        end;
        OnAfterUpdateBinEmpty(NewWarehouseEntry, Bin);
    end;

    local procedure GetBin(LocationCode: Code[10]; BinCode: Code[20])
    begin
        if (Bin."Location Code" <> LocationCode) or
           (Bin.Code <> BinCode)
        then
            Bin.Get(LocationCode, BinCode);
    end;

    local procedure CheckExpiration(var WarehouseEntry: Record "Warehouse Entry"; ItemTrackingCode: Record "Item Tracking Code")
    var
        ItemTrackingSetup: Record "Item Tracking Setup";
        ExistingExpDate: Date;
        IsHandled: Boolean;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
        IsHandled := false;
        OnBeforeCheckExpiration(WarehouseEntry, ItemTrackingCode, IsHandled);
        if IsHandled then
            exit;

        if ItemTrackingCode."Man. Expir. Date Entry Reqd." and (WarehouseEntry."Entry Type" = WarehouseEntry."Entry Type"::"Positive Adjmt.") and ItemTrackingCode.IsWarehouseTracking() then begin
            WarehouseEntry.TestField("Expiration Date");
            ItemTrackingSetup.CopyTrackingFromWhseEntry(WarehouseEntry);
            ItemTrackingMgt.GetWhseExpirationDate(WarehouseEntry."Item No.", WarehouseEntry."Variant Code", Location, ItemTrackingSetup, ExistingExpDate);
            if (ExistingExpDate <> 0D) and (WarehouseEntry."Expiration Date" <> ExistingExpDate) then begin
                IsHandled := false;
                OnInsertWhseEntryOnBeforeTestFieldExpirationDate(WarehouseEntry, ExistingExpDate, IsHandled);
                if not IsHandled then
                    WarehouseEntry.TestField("Expiration Date", ExistingExpDate);
            end;
        end;
    end;

    local procedure InsertWhseReg(WhseEntryNo: Integer; WhseJnlLine: Record "Warehouse Journal Line")
    begin
        if WhseReg."No." = 0 then begin
            WhseReg.Init();
            WhseReg."No." := WhseReg.GetNextEntryNo();
            WhseReg."From Entry No." := WhseEntryNo;
            WhseReg."To Entry No." := WhseEntryNo;
            WhseReg."Creation Date" := Today;
            WhseReg."Creation Time" := Time;
            WhseReg."Journal Batch Name" := WhseJnlLine."Journal Batch Name";
            WhseReg."Source Code" := WhseJnlLine."Source Code";
            WhseReg."User ID" := CopyStr(UserId(), 1, MaxStrLen(WhseJnlLine."User ID"));
            OnInsertWhseRegOnBeforeInsertRecord(WhseReg, WhseJnlLine, WhseEntryNo);
            WhseReg.InsertRecord();
        end else begin
            if ((WhseEntryNo < WhseReg."From Entry No.") and (WhseEntryNo <> 0)) or
               ((WhseReg."From Entry No." = 0) and (WhseEntryNo <> 0))
            then
                WhseReg."From Entry No." := WhseEntryNo;
            if WhseEntryNo > WhseReg."To Entry No." then
                WhseReg."To Entry No." := WhseEntryNo;
            OnInsertWhseRegOnBeforeModifyWarehouseRegister(WhseReg, WhseJnlLine, WhseEntryNo);
            WhseReg.Modify();
        end;
    end;

    local procedure ModifyBinEmpty(NewEmpty: Boolean)
    begin
        OnBeforeModifyBinEmpty(Bin, NewEmpty);

        if Bin.Empty <> NewEmpty then begin
            Bin.ReadIsolation(IsolationLevel::UpdLock);
            Bin.Find();
            Bin.Empty := NewEmpty;
            Bin.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Jnl.-Register Line", 'OnInitWhseEntryCopyFromWhseJnlLine', '', false, false)]
    local procedure OnInitWhseEntryCopyFromWhseJnlLine(var WarehouseEntry: Record "Warehouse Entry"; var WarehouseJournalLine: Record "Warehouse Journal Line"; OnMovement: Boolean; Sign: Integer; Location: Record Location; BinCode: Code[20]; var IsHandled: Boolean)
    var
        Bin: Record Bin;
        Item2: Record Item;
        LotNoInformation: Record "Lot No. Information";
        InventorySetup: Record "Inventory Setup";
        WHSUTILS: Codeunit "WHS-UTILS";
    begin
        //<<HEI.02 FDD-PRDGAP024
        IF WarehouseEntry."Zone Code" = '' THEN
            IF Bin.GET(WarehouseEntry."Location Code", WarehouseEntry."Bin Code") THEN
                WarehouseEntry."Zone Code" := Bin."Zone Code";
        IF WarehouseEntry."Zone Code" = '' THEN
            IF Bin.GET(WarehouseJournalLine."Location Code", WarehouseJournalLine."Bin Code") THEN
                WarehouseEntry."Zone Code" := Bin."Zone Code";
        //>>HEI.02 FDD-PRDGAP024

        //HEI.07>>
        //IF ((TENANTID = 'ethiopia') {OR (TENANTID = 'default')}) AND (WhseEntry.Description = '') THEN  //commented by HEI.08
        IF WarehouseEntry.Description = '' THEN        //HEI.08
            WarehouseEntry.Description := WarehouseJournalLine.Description;
        //HEI.07<<

        //HEI.10>>
        WarehouseEntry."External Document No. FND" := WarehouseJournalLine."External Document No. FND";
        WarehouseEntry."External Document No.2 FND" := WarehouseJournalLine."External Document No.2 FND";
        //HEI.10<<

        //HEI.05>>
        //WhseEntry."Quality Status" := "Quality Status";//HEI.03
        InventorySetup.Get(); //PATHAA02 GAP014_DTW, IBM GAP DTW 43
        IF LotNoInformation.GET(WarehouseEntry."Item No.", WarehouseEntry."Variant Code", WarehouseEntry."Lot No.") THEN BEGIN
            //HEI.06>>
            IF Item2.GET(WarehouseEntry."Item No.") AND (Item2."Item Tracking Code" = '') THEN
                //WarehouseEntry."Quality Status" := WarehouseEntry."Quality Status"::Unrestricted //PATHAA02 GAP014_DTW, IBM GAP DTW 43
                WarehouseEntry."Inspection Status FND" := InventorySetup."Quality Unrestricted FND" //PATHAA02 GAP014_DTW, IBM GAP DTW 43
            ELSE
                //HEI.06<<
                //WarehouseEntry."Quality Status" := LotNoInformation."Quality Status";//Bc Upgrade YADAVM09 blocked due to dependency on drink it field
                WarehouseEntry."Inspection Status FND" := LotNoInformation."Inspection Status Code 07 FDW";//PATHAA02 GAP014_DTW, IBM GAP DTW 43
            //HEI.05>>
            //HEI.06>>
        END ELSE
            IF Item2.GET(WarehouseEntry."Item No.") AND (Item2."Item Tracking Code" = '') THEN
                //WarehouseEntry."Quality Status" := WarehouseEntry."Quality Status"::Unrestricted; //PATHAA02 GAP014_DTW, IBM GAP DTW 43
                WarehouseEntry."Inspection Status FND" := InventorySetup."Quality Unrestricted FND"; //PATHAA02 GAP014_DTW, IBM GAP DTW 43
                                                                                                     //HEI.06<<
                                                                                                     //HEI.01 PRDGAP024<<


        //HEI.01 PRDGAP024>>
        WarehouseEntry."Zone-Transfer FND" := WarehouseJournalLine."Zone-Transfer FND";
        WarehouseEntry."Reference Line No. FND" := WarehouseJournalLine."Reference Line No. FND";
        WarehouseEntry."Transit-Zone FND" := WarehouseJournalLine."Transit-Zone FND";
        WarehouseEntry."Movement No. FND" := WarehouseJournalLine."Movement No. FND";
        WHSUTILS.OnAferCreateWhseEntry(WarehouseEntry);

        //HEI.05>>
        //Duplicate code commented-PATHAA02>>
        // //HEI.05>>
        // //WhseEntry."Quality Status" := "Quality Status";//HEI.03
        // IF LotNoInformation.GET(WarehouseEntry."Item No.", WarehouseEntry."Variant Code", WarehouseEntry."Lot No.") THEN BEGIN
        //     //HEI.06>>
        //     IF Item2.GET(WarehouseEntry."Item No.") AND (Item2."Item Tracking Code" = '') THEN
        //         WarehouseEntry."Quality Status" := WarehouseEntry."Quality Status"::Unrestricted
        //     //ELSE //Bc Upgrade YADAVM09 blocked due to dependency on drink it field
        //     //HEI.06<<
        //     // WarehouseEntry."Quality Status" := LotNoInformation."Quality Status";//Bc Upgrade YADAVM09 blocked due to dependency on drink it field
        //     //HEI.05>>
        //     //HEI.06>>
        // END ELSE
        //     IF Item2.GET(WarehouseEntry."Item No.") AND (Item2."Item Tracking Code" = '') THEN
        //         WarehouseEntry."Quality Status" := WarehouseEntry."Quality Status"::Unrestricted;
        // //HEI.06<<
        //Duplicate code commented-PATHAA02<

        //HEI.01 PRDGAP024<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Jnl.-Register Line", 'OnBeforeInsertWhseEntry', '', false, false)]
    local procedure OnBeforeInsertWhseEntry(var WarehouseEntry: Record "Warehouse Entry"; var WarehouseJournalLine: Record "Warehouse Journal Line")
    var
        InventorySetup: Record "Inventory Setup";
        Bin: Record Bin;
    begin
        //<<HEI.02 FDD-PRDGAP024
        IF WarehouseEntry."Zone Code" = '' THEN
            IF Bin.GET(WarehouseEntry."Location Code", WarehouseEntry."Bin Code") THEN
                WarehouseEntry."Zone Code" := Bin."Zone Code";
        //>>HEI.02 FDD-PRDGAP024
        //HEI.04>>
        IF Bin.GET(WarehouseEntry."Location Code", WarehouseEntry."Bin Code") THEN //PATHAA02 GAP014_DTW, IBM GAP DTW 43
            WarehouseEntry."Unavailable Stock (Bin) FND" := Bin."Unavailable Stock FND";
        IF WarehouseEntry."Lot No." <> '' THEN
            // IF WarehouseEntry."Quality Status" = WarehouseEntry."Quality Status"::Blocked THEN BEGIN //PATHAA02 GAP014_DTW, IBM GAP DTW 43
            IF WarehouseEntry."Inspection Status FND" = InventorySetup."Quality Blocked FND" THEN BEGIN //PATHAA02 GAP014_DTW, IBM GAP DTW 43                WarehouseEntry."Unavail. Stock (Quality) FND" := TRUE;
                WarehouseEntry."Unavailable Stock FND" := TRUE;
            END ELSE BEGIN
                WarehouseEntry."Unavail. Stock (Quality) FND" := FALSE;
                WarehouseEntry."Unavailable Stock FND" := FALSE;
            END;
        IF (NOT WarehouseEntry."Unavailable Stock (Bin) FND" AND NOT WarehouseEntry."Unavail. Stock (Quality) FND") THEN
            WarehouseEntry."Unavailable Stock FND" := FALSE
        ELSE
            WarehouseEntry."Unavailable Stock FND" := TRUE;
        //WhseEntry."Unavailable Stock" := WhseEntry."Unavailable Stock (Bin)" OR WhseEntry."Unavailable Stock (Quality)";
        //HEI.04<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Jnl.-Register Line", 'OnDeleteFromBinContentOnAfterSetFiltersForBinContent', '', false, false)]
    local procedure OnDeleteFromBinContentOnAfterSetFiltersForBinContent(var BinContent: Record "Bin Content"; WarehouseEntry: Record "Warehouse Entry"; var WhseJnlLine: Record "Warehouse Journal Line"; var WhseReg: Record "Warehouse Register"; var WhseEntryNo: Integer; var IsHandled: Boolean)
    var
        InventorySetup: Record "Inventory Setup";
        Bin: Record Bin;
    begin
        //HEI.04>>
        IF Bin.GET(WarehouseEntry."Location Code", WarehouseEntry."Bin Code") THEN //PATHAA02 GAP014_DTW, IBM GAP DTW 43
            WarehouseEntry."Unavailable Stock (Bin) FND" := Bin."Unavailable Stock FND";
        IF WarehouseEntry."Lot No." <> '' THEN
            // IF WarehouseEntry."Quality Status" = WarehouseEntry."Quality Status"::Blocked THEN BEGIN //PATHAA02 GAP014_DTW, IBM GAP DTW 43
            IF WarehouseEntry."Inspection Status FND" = InventorySetup."Quality Blocked FND" THEN BEGIN //PATHAA02 GAP014_DTW, IBM GAP DTW 43                WarehouseEntry."Unavail. Stock (Quality) FND" := TRUE;
                WarehouseEntry."Unavailable Stock FND" := TRUE;
            END ELSE BEGIN
                WarehouseEntry."Unavail. Stock (Quality) FND" := FALSE;
                WarehouseEntry."Unavailable Stock FND" := FALSE;
            END;
        IF (NOT WarehouseEntry."Unavailable Stock (Bin) FND" AND NOT WarehouseEntry."Unavail. Stock (Quality) FND") THEN
            WarehouseEntry."Unavailable Stock FND" := FALSE
        ELSE
            WarehouseEntry."Unavailable Stock FND" := TRUE;
        //WhseEntry."Unavailable Stock" := WhseEntry."Unavailable Stock (Bin)" OR WhseEntry."Unavailable Stock (Quality)";
        //HEI.04<<
    end;


    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertWhseEntryProcedure(var WarehouseEntry: Record "Warehouse Entry"; WarehouseJournalLine: Record "Warehouse Journal Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnInsertWhseEntryOnBeforeCheckSerialNo(WarehouseEntry: Record "Warehouse Entry"; var IsHandled: Boolean)
    begin
    end;


    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertWhseEntry(var WarehouseEntry: Record "Warehouse Entry"; var WarehouseJournalLine: Record "Warehouse Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeUpdateBinEmpty(WarehouseEntry: Record "Warehouse Entry"; var Bin: Record Bin; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterUpdateBinEmpty(WarehouseEntry: Record "Warehouse Entry"; Bin: Record Bin)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnInsertWhseEntryOnBeforeTestFieldExpirationDate(WhseEntry: Record "Warehouse Entry"; ExistingExpDate: Date; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckExpiration(var WarehouseEntry: Record "Warehouse Entry"; ItemTrackingCode: Record "Item Tracking Code"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnInsertWhseRegOnBeforeInsertRecord(var WarehouseReg: Record "Warehouse Register"; var WarehouseJournalLine: Record "Warehouse Journal Line"; WhseEntryNo: Integer)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnInsertWhseRegOnBeforeModifyWarehouseRegister(var WarehouseReg: Record "Warehouse Register"; var WarehouseJournalLine: Record "Warehouse Journal Line"; WhseEntryNo: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeModifyBinEmpty(var Bin: Record Bin; NewEmpty: Boolean)
    begin
    end;

    var

        WhseReg: Record "Warehouse Register";

        Bin: Record Bin;

    //Bc Upgrade YADAVM09 7301-Whse. Jnl.-Register Line<<

    // BC Upgrade SHUKLP03 >> codeunit 414 "Release Sales Document" 

    // HEI.01 FDD-OTCGAP016C IBM NASTAA02 29.11.2017 # Credit Control Check
    //   # Added new conditions when releasing an Order
    // HEI.02 FDD-SLSGAP014 IBM NASTAA02 16.04.2018 # Customer Blocked for Option 'Ship'
    //   # Used function "CheckBlockedCustOnDocs2" from Customer table to verify if the Customer is blocked
    // HEI.03 FDD-SLSGAP015 IBM NASTAA02 24.04.2018 # Default Dimensions in the Promotion Charges
    //   # New check added in case "Free Reason Code Mandatory" in Sales Setup is ticked
    // HEI.04 FDD-OTCGAP077 IBM HORTOC01 17.07.2018 #fill in "Req delivery date" with "shipment date"
    // HEI.05 CHG2026691 IBM SAMANR01 14.08.2019
    //     #Code Fix #fill in "Req delivery date" with "shipment date"
    // HEI.06 CHG2046145 IBM.COSTES02 03.03.2020 # Sales Order Status Addition
    //   # Code added
    // HEI.07 CHG2065287 IBM SAMANR01 29.06.2020
    //   # Added code for archive the document
    // HEI.08 CHG2077654 IBM.NASTAA02 28.08.2020 # Special Order not created when using Approval Workflows
    //   # Code added to function "PerformManualCheckAndRelease" to create the Special Order after request approvals are approved
    // HEI.09 CHG2073468 HB1369 IBM GAVANM01 04.01.2021 Enhancements to Intercompany Part 3
    //   # Code added to function "PerformManualCheckAndRelease" to create the Special Return Order
    // HEI.10 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # New functions created: "IsAutomaticReopen", "CheckPossibleReopen"
    // HEI.11 CHG2097091 IBM SAMANR01 11-02-2021
    //   # Add code for check the approval entry status before change the status on sales header
    // HEI.12 FDD-HB1234 - CHG2053453 IBM NASTAA02 22.03.2021 # B2B Order Status
    //   # Code added to update 'Approval Status' Field
    // HEI.13 RITM2646474 CHG2098904 IBM GAVANM01 22.04.2021 #Set up Credit Limit workflow approval for MZ SellCo
    //   # when the approval is from interface then pick the interface user setup
    // HEI.14 CHG2183672 DEBUSD01 05.12.2022 Fix lock new sales order runmodal page
    // HEI.15 CHG2183672 DEBUSD01 12.12.2022 Fix lock new sales order runmodal page
    // HEI.16 CHG2205042 IBM BHANDS01 17.05.2023 Deadlock Issue
    //   # Code Optimization
    // HEI.17 CC CHG2226741 BHANDS01 18.03.2024 Blank Return Reason
    //   # Fix from Aptean(Norriq)
    //   # DITW17.00.02 TEC1 09/09/2013 DIT-770 #145 - DITW113.00.15 DDR 17/10/2019 NRQ#22821 Add function TestLineReturnReasonMandatory()
    //   # Added function in Code() and PerformManualCheckAndRelease()
    // HEI.18 CC CHG2245217 BHANDS01 27.03.2024 Route Plan change location after the approval
    //   # Temporary workaround Fix for restricting change of location
    //  Corrective Change CHG2263939 IBM BHANDS01 13.08.2024 : Rollback the change from Aptean APT#186074, HEI.19

    // BC Upgrade SHUKLP03 >>
    // HEI.17 => code of trigger OnRun(), procedure PerformManualCheckAndRelease() and procedure TestLineReturnReasonMandatory() is not added because DIT procedure TestLineReturnReasonMandatory() was called also procedure not found in table.
    // HEI.14, HEI.15, HEI.11 => Code of procedure PerformManualCheckAndRelease() is not added because code is written inside DIT code.
    // HEI.03 => HEI.03 code of event OnCodeOnCheckTracking is blocked dependency on DIT field inside procedure CheckFreeReasonCode(). LOCAL procedure CheckFreeReasonCode() is not added because dependency on DIT field "Free Reason Code".
    // HEI.08 => Code of procedure PerformManualCheckAndRelease() is not added because of DIT codeunit "Purch.-Create DropSpec Shpt.".
    // HEI.04 => Code of procedure DocStatusRelease() is not added because code is written inside DIT code.
    // HEI.16 => Code of procedure ReleasePostItemCharges() and CheckSalesLinePrices() is not added because this is DIT's procedure.
    // Subscribe event OnCodeOnCheckTracking to add HEI.01 code.
    // Subscribe event OnBeforeModifySalesDoc to add HEI.06 code.  
    // Subscribe event OnAfterReleaseATOs, OnCodeOnAfterModifySalesDoc to add HEI.18 code.
    // Subscribe event CheckPossibleReopen to add HEI.10 and HEI.07
    // Subscribe event OnReopenOnBeforeSalesHeaderModify to add HEI.12
    // Subscribe event OnBeforePerformManualReleaseSalesDoc to add HEI.05
    // LOCAL procedure CheckCustomerCreditLimitExceeded() some part of code is blocked because dependency on DIT fields "Unlimited Cr. Limit Customer", "Credit Limit", Unlimited Overdue Approval
    // Added procedures CheckPossibleReopen(),CheckCustomerCreditLimitExceeded(),GetDepositAmount(),GetFinancialContractAmount(),GetFinanceChargeMemoAmount(),GetReminderAmount(),GetCreditMemoAmount(),GetInvoiceAmount(),GetOrderAmount(),GetReturnOrderAmount(),GetReleasedOrderAmount(),GetReturnReceiptsNotInvAmount(),GetShipmentNotInvAmount(),GetOverdueDepositAmount(),GetOverdueFinancialContractAmount(),GetOverdueFinanceChargeMemoAmount(),GetOverdueReminderAmount(),IsAutomaticReopen(),SetHideValidationDialogWF4414(),SetShowNotificationDialogWF414()
    // BC Upgrade SHUKLP03 <<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnCodeOnCheckTracking, '', false, false)]
    local procedure OnCodeOnCheckTracking(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
        SalesSetup.Get(); // BC Upgrade SHUKLP03 <<

        //HEI.01>>
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) THEN
            checkCustomerCreditLimitExceeded(SalesHeader);
        //HEI.01<<

        // BC Upgrade SHUKLP03 >> Blocked because dependency on DIT field inside procedure CheckFreeReasonCode()
        // //HEI.03>>
        // IF SalesSetup."Free Reason Code Mandatory" AND
        //    ((SalesHeader."Document Type" = SalesHeader."Document Type"::Order) OR (SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order"))
        // THEN
        //    // CheckFreeReasonCode(SalesHeader);
        // //HEI.03<<
        // BC Upgrade SHUKLP03 >> Blocked because dependency on DIT field inside procedure CheckFreeReasonCode()

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeModifySalesDoc, '', false, false)]
    local procedure OnBeforeModifySalesDoc(var SalesHeader: Record "Sales Header")
    begin
        //HEI.06>>
        IF SalesHeader."Approval Status FND" = SalesHeader."Approval Status FND"::" " THEN
            SalesHeader."Approval Status FND" := SalesHeader."Approval Status FND"::"Not Set";
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReleaseATOs, '', false, false)]
    local procedure OnAfterReleaseATOs(var SalesHeader: Record "Sales Header")
    var
    begin
        //HEI.18>>
        OldLocationCode := SalesHeader."Location Code";
        OldStatus := SalesHeader.Status;
        //HEI.18<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnCodeOnAfterModifySalesDoc, '', false, false)]
    local procedure OnCodeOnAfterModifySalesDoc(var SalesHeader: Record "Sales Header")
    begin
        //HEI.18>>
        IF (OldLocationCode <> '') AND (OldLocationCode <> SalesHeader."Location Code") THEN BEGIN
            SalesHeader.Status := SalesHeader.Status::Open;
            SalesHeader.VALIDATE("Location Code", OldLocationCode);
            SalesHeader.Status := OldStatus;
            SalesHeader.MODIFY(TRUE);
        END;
        //HEI.18<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeReopenSalesDoc, '', false, false)]
    local procedure OnBeforeReopenSalesDoc(var IsHandled: Boolean; PreviewMode: Boolean; SkipWhseRequestOperations: Boolean; var SalesHeader: Record "Sales Header")
    var
        ArchiveManagement: Codeunit ArchiveManagement;
    begin
        CheckPossibleReopen(SalesHeader); //HEI.10

        if SalesHeader.Status = SalesHeader.Status::Open then
            exit;

        // >>HEI.07
        IF (SalesHeader.Status = SalesHeader.Status::Released) AND (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) THEN BEGIN
            ArchiveManagement.ArchSalesDocumentNoConfirm(SalesHeader);
        END;
        // <<HEI.07
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnReopenOnBeforeSalesHeaderModify, '', false, false)]
    local procedure OnReopenOnBeforeSalesHeaderModify(var SalesHeader: Record "Sales Header")
    begin
        //HEI.12>>
        IF (SalesHeader.Status = SalesHeader.Status::Open) AND (SalesHeader."Approval Status FND" <> SalesHeader."Approval Status FND"::" ") THEN
            SalesHeader."Approval Status FND" := SalesHeader."Approval Status FND"::" ";
        //HEI.12<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforePerformManualRelease, '', false, false)]
    local procedure OnBeforePerformManualReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        //HEI.05>>
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) THEN
            IF SalesHeader."Requested Delivery Date" = 0D THEN BEGIN
                SalesHeader."Requested Delivery Date" := SalesHeader."Shipment Date";
                SalesHeader.MODIFY();
                SalesLine.RESET();
                SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                IF SalesLine.FINDFIRST() THEN
                    REPEAT
                        IF SalesLine."No." <> '' THEN BEGIN
                            SalesLine."Requested Delivery Date" := SalesHeader."Requested Delivery Date";
                            SalesLine.MODIFY();
                        END;
                    UNTIL SalesLine.NEXT() = 0;
            END;
        //HEI.05<<
    end;

    LOCAL procedure CheckPossibleReopen(SalesHeader2: Record "Sales Header")
    var
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        CantReopenOrderErr: TextConst ENU = 'You can not reopen an Order sent by %1.';
    begin
        //HEI.10>>
        // BC Upgrade SHUKLP03 << for APIs Orders

        If SourceSystemIdentifierAPI.Get(SalesHeader2."Source System Identifier FND") then begin
            If (SourceSystemIdentifierAPI."Automatic SO Posting") OR (SourceSystemIdentifierAPI."Post Diff to G/L Account") then begin
                AutomaticReopen := True;
                IF AutomaticReopen THEN
                    EXIT;
            end;
        end;
        // BC Upgrade SHUKLP03 >> for APIs Orders

        IF NOT SourceSystemIdentifierAPI.GET(SalesHeader2."Source System Identifier FND") THEN
            EXIT;

        IF NOT SourceSystemIdentifierAPI."Automatic SO Posting" THEN
            EXIT;

        IF SalesHeader2.Status = SalesHeader2.Status::Released THEN
            ERROR(CantReopenOrderErr, SalesHeader2."Source System Identifier FND");
        //HEI.10<<
    end;

    LOCAL procedure CheckCustomerCreditLimitExceeded(var SalesHeader: Record "Sales Header"): Decimal
    var
        UserSetup: Record "User Setup";
        Customer2: Record Customer;
        //CalcAddCreditLimits: Codeunit "Calculate Add.-Credit Limits"; // BC Upgrade SHUKLP03 << Blocked because DIT codeunit.
        TextAutoFormatAmount: Text[250];
        CustomerBalance: Decimal;
        CustomerBalanceOverdue: Decimal;
        CustAddCreditLimitLCY: Decimal;
        CustCreditLimitLCY: Decimal;
        ApprovalEntryPowerApp: Record "Approval Entry";
    //TranslationLocal: Text[80];  // BC Upgrade SHUKLP03 << 
    begin
        //HEI.13<<
        // {ApprovalEntryPowerApp.RESET;
        //         ApprovalEntryPowerApp.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Reference Line No.", "Sequence No.");
        //         ApprovalEntryPowerApp.SETRANGE("Table ID", DATABASE::"Sales Header");
        //         ApprovalEntryPowerApp.SETRANGE("Document Type", SalesHeader."Document Type");
        //         ApprovalEntryPowerApp.SETRANGE("Document No.", SalesHeader."No.");
        //         ApprovalEntryPowerApp.SETRANGE("Response Received", TRUE);
        //         IF ApprovalEntryPowerApp.FINDLAST AND (ApprovalEntryPowerApp.Status = ApprovalEntryPowerApp.Status::Approved) THEN
        //             UserSetup.GET(ApprovalEntryPowerApp."Approver ID")
        //         ELSE}
        //HEI.13>>
        //HEI.01>>
        UserSetup.GET(USERID);
        Customer2.GET(SalesHeader."Sell-to Customer No.");
        Customer2.CALCFIELDS("Balance (LCY)");
        SalesHeader.CALCFIELDS("Amount Including VAT");
        //TextAutoFormatAmount := cduAppMgt.AutoFormatTranslate(1, SalesHeader."Currency Code"); // BC Upgrade SHUKLP03 << This function is now moved in CU UI help Triggers and also this functions returned Text value but now a parameter is increased in the same function.

        cduAppMgt.AutoFormatTranslate(1, SalesHeader."Currency Code", TextAutoFormatAmount); // BC Upgrade SHUKLP03 << 
        //CustAddCreditLimitLCY := CalcAddCreditLimits.Calculate(SalesHeader."Sell-to Customer No.", WORKDATE); // BC Upgrade SHUKLP03 << Blocked because DIT codeunit CalcAddCreditLimits.

        IF Customer2.Blocked <> Customer2.Blocked::" " THEN
            //HEI.02>>
            //ERROR(CustomerBlockedErr,SalesHeader."No.",Customer2."No.");
            Customer2.CheckBlockedCustOnDocs2(Customer2, SalesHeader."Document Type", FALSE, FALSE, 0, FALSE, FALSE, FALSE);
        //HEI.02<<

        // BC Upgrade SHUKLP03 >> Blocked because dependency on DIT fields "Unlimited Cr. Limit Customer", "Credit Limit", Unlimited Overdue Approval
        // IF SalesSetup."Check Credit Limit on Release"
        //    AND NOT UserSetup."Unlimited Cr. Limit Customer"
        //    AND Customer2."Credit Limit"
        // THEN BEGIN
        //     CustCreditLimitLCY := Customer2."Credit Limit (LCY)" + UserSetup."Exceed Credit Limit Customer" + CustAddCreditLimitLCY;
        //     CustomerBalance := Customer2."Balance (LCY)" + GetOrderAmount(SalesHeader."Sell-to Customer No.");

        //     IF SalesSetup."Exclude Released Sales Orders" THEN
        //         CustomerBalance := CustomerBalance - GetReleasedOrderAmount(SalesHeader."Sell-to Customer No.");

        //     IF SalesSetup."Check only SO getting Released" THEN
        //         CustomerBalance := CustomerBalance - GetOrderAmount(SalesHeader."Sell-to Customer No.") + SalesHeader."Amount Including VAT";

        //     IF SalesSetup."Exclude Deposit" THEN
        //         CustomerBalance := CustomerBalance - GetDepositAmount(SalesHeader."Sell-to Customer No.");

        //     IF SalesSetup."Excl Fin Contract Entries" THEN
        //         CustomerBalance := CustomerBalance - GetFinancialContractAmount(SalesHeader."Sell-to Customer No.");

        //     IF SalesSetup."Exclude Finance Charge Memo" THEN
        //         CustomerBalance := CustomerBalance - GetFinanceChargeMemoAmount(SalesHeader."Sell-to Customer No.");

        //     IF SalesSetup."Exclude Reminders" THEN
        //         CustomerBalance := CustomerBalance - GetReminderAmount(SalesHeader."Sell-to Customer No.");

        //     IF NOT SalesSetup."Exclude Sales Return Orders" THEN
        //         CustomerBalance := CustomerBalance - GetReturnOrderAmount(SalesHeader."Sell-to Customer No.");

        //     IF NOT SalesSetup."Excl Sales Ret Receipt not Inv" THEN
        //         CustomerBalance := CustomerBalance - GetReturnReceiptsNotInvAmount(SalesHeader."Sell-to Customer No.");

        //     IF NOT SalesSetup."Exclude Sales Credit Memos" THEN
        //         CustomerBalance := CustomerBalance - GetCreditMemoAmount(SalesHeader."Sell-to Customer No.");

        //     IF NOT SalesSetup."Excl Sales Shipment not Inv" THEN
        //         CustomerBalance := CustomerBalance + GetShipmentNotInvAmount(SalesHeader."Sell-to Customer No.");

        //     IF NOT SalesSetup."Exclude Sales Invoices" THEN
        //         CustomerBalance := CustomerBalance + GetInvoiceAmount(SalesHeader."Sell-to Customer No.");

        //     IF CustCreditLimitLCY < CustomerBalance - CustCreditLimitLCY THEN
        //         ERROR(STRSUBSTNO(CreditLimitExceededErr, SalesHeader."No.", FORMAT(CustCreditLimitLCY, 0, TextAutoFormatAmount),
        //                           SalesHeader."Sell-to Customer No.", FORMAT(CustomerBalance - CustCreditLimitLCY, 0, TextAutoFormatAmount)));
        // END;

        // IF SalesSetup."Check Overdue Amts on Release"
        //    AND NOT UserSetup."Unlimited Overdue Approval"
        // THEN BEGIN
        //     CustomerBalanceOverdue := Customer2.CalcOverdueBalance;

        //     IF SalesSetup."Exclude Overdue Deposit" THEN
        //         CustomerBalanceOverdue := CustomerBalanceOverdue - GetOverdueDepositAmount(SalesHeader."Sell-to Customer No.");

        //     IF SalesSetup."Excl Overdue Fin Contr Entries" THEN
        //         CustomerBalanceOverdue := CustomerBalanceOverdue - GetOverdueFinancialContractAmount(SalesHeader."Sell-to Customer No.");

        //     IF SalesSetup."Excl Overdue Fin Charge Memo" THEN
        //         CustomerBalanceOverdue := CustomerBalanceOverdue - GetOverdueFinanceChargeMemoAmount(SalesHeader."Sell-to Customer No.");

        //     IF SalesSetup."Exclude Overdue Reminders" THEN
        //         CustomerBalanceOverdue := CustomerBalanceOverdue - GetOverdueReminderAmount(SalesHeader."Sell-to Customer No.");

        //     IF UserSetup."Overdue Amount Approval Limit" < CustomerBalanceOverdue - UserSetup."Overdue Amount Approval Limit" THEN
        //         ERROR(STRSUBSTNO(OverdueLimitExceededErr, SalesHeader."No.", UserSetup."Overdue Amount Approval Limit",
        //               SalesHeader."Sell-to Customer No.", FORMAT(CustomerBalanceOverdue - UserSetup."Overdue Amount Approval Limit", 0, TextAutoFormatAmount)));
        // END;
        // BC Upgrade SHUKLP03 << Blocked because dependency on DIT fields "Unlimited Cr. Limit Customer", "Credit Limit", Unlimited Overdue Approval

        //HEI.01<<
    end;

    LOCAL procedure GetDepositAmount(CustomerNo: Code[20]): Decimal
    var
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        CustomerDepositAmount: Decimal;
    begin
        //HEI.01>>
        CustomerLedgerEntry.SETRANGE("Customer No.", CustomerNo);
        //CustomerLedgerEntry.SETRANGE("Item Charge Type", CustomerLedgerEntry."Item Charge Type"::Deposit); // BC Upgrade SHUKLP03 << Blocked because of DIT Field "Item Charge Type".
        CustomerLedgerEntry.SETRANGE("CM Incl. EG. Lim. Warn APS", CustomerLedgerEntry."CM Incl. EG. Lim. Warn APS"::Deposit); //BC UPGRADE KUMARR78 Replacing Item Charge Type Field ++ 13-05-2026

        IF CustomerLedgerEntry.FINDSET() THEN
            REPEAT
                CustomerLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                CustomerDepositAmount += CustomerLedgerEntry."Remaining Amt. (LCY)";
            UNTIL CustomerLedgerEntry.NEXT() = 0;

        EXIT(CustomerDepositAmount);
        //HEI.01<<
    end;

    LOCAL procedure GetFinancialContractAmount(CustomerNo: Code[20]): Decimal
    var
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        FinancialContractAmount: Decimal;
    begin
        //HEI.01>>
        CustomerLedgerEntry.SETRANGE("Customer No.", CustomerNo);
        //CustomerLedgerEntry.SETFILTER("Document Type",'%1|%2',CustomerLedgerEntry."Document Type"::"Loan Pay Back",
        //                                                      CustomerLedgerEntry."Document Type"::"Loan Pay Out");
        //CustomerLedgerEntry.SETFILTER("Financial Contract No.", '<>%1', '');  // BC Upgrade SHUKLP03 << Blocked because of DIT fields
        IF CustomerLedgerEntry.FINDSET() THEN
            REPEAT
                CustomerLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                FinancialContractAmount += CustomerLedgerEntry."Remaining Amt. (LCY)";
            UNTIL CustomerLedgerEntry.NEXT() = 0;

        EXIT(FinancialContractAmount);
        //HEI.01<<
    end;

    LOCAL procedure GetFinanceChargeMemoAmount(CustomerNo: Code[20]): Decimal
    var
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        CustomerFinanceChargeMemoAmount: Decimal;
    begin
        //HEI.01>>
        CustomerLedgerEntry.SETRANGE("Customer No.", CustomerNo);
        CustomerLedgerEntry.SETRANGE("Document Type", CustomerLedgerEntry."Document Type"::"Finance Charge Memo");
        IF CustomerLedgerEntry.FINDSET() THEN
            REPEAT
                CustomerLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                CustomerFinanceChargeMemoAmount += CustomerLedgerEntry."Remaining Amt. (LCY)";
            UNTIL CustomerLedgerEntry.NEXT() = 0;

        EXIT(CustomerFinanceChargeMemoAmount);
        //HEI.01<<

    end;

    LOCAL procedure GetReminderAmount(CustomerNo: Code[20]): Decimal
    var
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        CustomerReminderAmount: Decimal;
    begin
        //HEI.01>>
        CustomerLedgerEntry.SETRANGE("Customer No.", CustomerNo);
        CustomerLedgerEntry.SETRANGE("Document Type", CustomerLedgerEntry."Document Type"::Reminder);
        IF CustomerLedgerEntry.FINDSET() THEN
            REPEAT
                CustomerLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                CustomerReminderAmount += CustomerLedgerEntry."Remaining Amt. (LCY)";
            UNTIL CustomerLedgerEntry.NEXT() = 0;

        EXIT(CustomerReminderAmount);
        //HEI.01<<
    end;

    LOCAL procedure GetCreditMemoAmount(CustomerNo: Code[20]): Decimal
    var
        SalesHeader2: Record "Sales Header";
        CustomerCreditMemoAmount: Decimal;
    begin
        //HEI.01>>
        SalesHeader2.SETRANGE("Sell-to Customer No.", CustomerNo);
        SalesHeader2.SETRANGE("Document Type", SalesHeader2."Document Type"::"Credit Memo");
        IF SalesHeader2.FINDSET() THEN
            REPEAT
                SalesHeader2.CALCFIELDS("Amount Including VAT");
                CustomerCreditMemoAmount += SalesHeader2."Amount Including VAT";
            UNTIL SalesHeader2.NEXT() = 0;

        EXIT(CustomerCreditMemoAmount);
        //HEI.01<<
    end;

    LOCAL procedure GetInvoiceAmount(CustomerNo: Code[20]): Decimal
    var
        SalesHeader2: Record "Sales Header";
        CustomerInvoiceAmount: Decimal;
    begin
        //HEI.01>>
        SalesHeader2.SETRANGE("Sell-to Customer No.", CustomerNo);
        SalesHeader2.SETRANGE("Document Type", SalesHeader2."Document Type"::Invoice);
        IF SalesHeader2.FINDSET() THEN
            REPEAT
                SalesHeader2.CALCFIELDS("Amount Including VAT");
                CustomerInvoiceAmount += SalesHeader2."Amount Including VAT";
            UNTIL SalesHeader2.NEXT() = 0;

        EXIT(CustomerInvoiceAmount);
        //HEI.01<<
    end;

    LOCAL procedure GetOrderAmount(CustomerNo: Code[20]): Decimal
    var
        SalesHeader2: Record "Sales Header";
        CustomerOrderAmount: Decimal;
    begin
        //HEI.01>>
        SalesHeader2.SETRANGE("Sell-to Customer No.", CustomerNo);
        SalesHeader2.SETRANGE("Document Type", SalesHeader2."Document Type"::Order);
        IF SalesHeader2.FINDSET() THEN
            REPEAT
                SalesHeader2.CALCFIELDS("Amount Including VAT");
                CustomerOrderAmount += SalesHeader2."Amount Including VAT";
            UNTIL SalesHeader2.NEXT() = 0;

        EXIT(CustomerOrderAmount);
        //HEI.01<<
    end;

    LOCAL procedure GetReturnOrderAmount(CustomerNo: Code[20]): Decimal
    var
        SalesHeader2: Record "Sales Header";
        CustomerReturnOrderAmount: Decimal;
    begin
        //HEI.01>>
        SalesHeader2.SETRANGE("Sell-to Customer No.", CustomerNo);
        SalesHeader2.SETRANGE("Document Type", SalesHeader2."Document Type"::"Return Order");
        IF SalesHeader2.FINDSET() THEN
            REPEAT
                SalesHeader2.CALCFIELDS("Amount Including VAT");
                CustomerReturnOrderAmount += SalesHeader2."Amount Including VAT";
            UNTIL SalesHeader2.NEXT() = 0;

        EXIT(CustomerReturnOrderAmount);
        //HEI.01<<
    end;

    LOCAL procedure GetReleasedOrderAmount(CustomerNo: Code[20]): Decimal
    var
        SalesHeader2: Record "Sales Header";
        CustomerReleasedOrderAmount: Decimal;
    begin
        //HEI.01>>
        SalesHeader2.SETRANGE("Sell-to Customer No.", CustomerNo);
        SalesHeader2.SETRANGE("Document Type", SalesHeader2."Document Type"::Order);
        SalesHeader2.SETRANGE(Status, SalesHeader2.Status::Released);
        IF SalesHeader2.FINDSET() THEN
            REPEAT
                SalesHeader2.CALCFIELDS("Amount Including VAT");
                CustomerReleasedOrderAmount += SalesHeader2."Amount Including VAT";
            UNTIL SalesHeader2.NEXT() = 0;

        EXIT(CustomerReleasedOrderAmount);
        //HEI.01<<
    end;

    LOCAL procedure GetReturnReceiptsNotInvAmount(CustomerNo: Code[20]): Decimal
    var
        ReturnReceiptLine: Record "Return Receipt Line";
        CustomerReturnReceiptsNotInvAmount: Decimal;
        VATAmount: Decimal;
    begin
        //HEI.01>>
        ReturnReceiptLine.SETRANGE("Sell-to Customer No.", CustomerNo);
        ReturnReceiptLine.SETFILTER("Return Qty. Rcd. Not Invd.", '<>%1', 0);
        IF ReturnReceiptLine.FINDSET() THEN
            REPEAT
                VATAmount := 0;
                IF ReturnReceiptLine."VAT %" <> 0 THEN
                    VATAmount := (ReturnReceiptLine."VAT %" / 100 * ReturnReceiptLine."Unit Price") * ReturnReceiptLine."Return Qty. Rcd. Not Invd.";
                CustomerReturnReceiptsNotInvAmount += (ReturnReceiptLine."Unit Price" * ReturnReceiptLine."Return Qty. Rcd. Not Invd.") + VATAmount;
            UNTIL ReturnReceiptLine.NEXT() = 0;

        EXIT(CustomerReturnReceiptsNotInvAmount);
        //HEI.01<<
    end;

    LOCAL procedure GetShipmentNotInvAmount(CustomerNo: Code[20]): Decimal
    var
        SalesShipmentLine: Record "Sales Shipment Line";
        CustomerShipmentNotInvAmount: Decimal;
        VATAmount: Decimal;
    begin
        //HEI.01>>
        SalesShipmentLine.SETRANGE("Sell-to Customer No.", CustomerNo);
        SalesShipmentLine.SETFILTER("Qty. Shipped Not Invoiced", '<>%1', 0);
        IF SalesShipmentLine.FINDSET() THEN
            REPEAT
                VATAmount := 0;
                IF SalesShipmentLine."VAT %" <> 0 THEN
                    VATAmount := (SalesShipmentLine."VAT %" / 100 * SalesShipmentLine."Unit Price") * SalesShipmentLine."Qty. Shipped Not Invoiced";
                CustomerShipmentNotInvAmount += (SalesShipmentLine."Unit Price" * SalesShipmentLine."Qty. Shipped Not Invoiced") + VATAmount;
            UNTIL SalesShipmentLine.NEXT() = 0;

        EXIT(CustomerShipmentNotInvAmount);
        //HEI.01<<
    end;

    LOCAL procedure GetOverdueDepositAmount(CustomerNo: Code[20]): Decimal
    var
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        CustomerDepositAmount: Decimal;
    begin
        //HEI.01>>
        CustomerLedgerEntry.SETRANGE("Customer No.", CustomerNo);
        //CustomerLedgerEntry.SETRANGE("Item Charge Type", CustomerLedgerEntry."Item Charge Type"::Deposit); // BC Upgrade SHUKLP03 << Blocked DIT Field.
        CustomerLedgerEntry.SETRANGE("CM Incl. EG. Lim. Warn APS", CustomerLedgerEntry."CM Incl. EG. Lim. Warn APS"::Deposit); //BC UPGRADE KUMARR78 ++ 13-05-2026
        CustomerLedgerEntry.SETFILTER("Remaining Amt. (LCY)", '<>%1', 0);
        CustomerLedgerEntry.SETFILTER("Due Date", '<%1', WORKDATE());
        IF CustomerLedgerEntry.FINDSET() THEN
            REPEAT
                CustomerLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                CustomerDepositAmount += CustomerLedgerEntry."Remaining Amt. (LCY)";
            UNTIL CustomerLedgerEntry.NEXT() = 0;

        EXIT(CustomerDepositAmount);
        //HEI.01<<
    end;

    LOCAL procedure GetOverdueFinancialContractAmount(CustomerNo: Code[20]): Decimal
    var
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        FinancialContractAmount: Decimal;
    begin
        //HEI.01>>
        CustomerLedgerEntry.SETRANGE("Customer No.", CustomerNo);
        //CustomerLedgerEntry.SETFILTER("Document Type",'%1|%2',CustomerLedgerEntry."Document Type"::"Loan Pay Back",
        //                                                      CustomerLedgerEntry."Document Type"::"Loan Pay Out");
        //CustomerLedgerEntry.SETFILTER("Financial Contract No.", '<>%1', ''); // BC Upgrade SHUKLP03 << Blocked DIT fields
        CustomerLedgerEntry.SETFILTER("Remaining Amt. (LCY)", '<>%1', 0);
        CustomerLedgerEntry.SETFILTER("Due Date", '<%1', WORKDATE());
        IF CustomerLedgerEntry.FINDSET() THEN
            REPEAT
                CustomerLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                FinancialContractAmount += CustomerLedgerEntry."Remaining Amt. (LCY)";
            UNTIL CustomerLedgerEntry.NEXT() = 0;

        EXIT(FinancialContractAmount);
        //HEI.01<<
    end;

    LOCAL procedure GetOverdueFinanceChargeMemoAmount(CustomerNo: Code[20]): Decimal
    var
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        CustomerFinanceChargeMemoAmount: Decimal;
    begin
        //HEI.01>>
        CustomerLedgerEntry.SETRANGE("Customer No.", CustomerNo);
        CustomerLedgerEntry.SETRANGE("Document Type", CustomerLedgerEntry."Document Type"::"Finance Charge Memo");
        CustomerLedgerEntry.SETFILTER("Remaining Amt. (LCY)", '<>%1', 0);
        CustomerLedgerEntry.SETFILTER("Due Date", '<%1', WORKDATE());
        IF CustomerLedgerEntry.FINDSET() THEN
            REPEAT
                CustomerLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                CustomerFinanceChargeMemoAmount += CustomerLedgerEntry."Remaining Amt. (LCY)";
            UNTIL CustomerLedgerEntry.NEXT() = 0;

        EXIT(CustomerFinanceChargeMemoAmount);
        //HEI.01<<
    end;

    LOCAL procedure GetOverdueReminderAmount(CustomerNo: Code[20]): Decimal
    var
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        CustomerReminderAmount: Decimal;
    begin
        //HEI.01>>
        CustomerLedgerEntry.SETRANGE("Customer No.", CustomerNo);
        CustomerLedgerEntry.SETRANGE("Document Type", CustomerLedgerEntry."Document Type"::Reminder);
        CustomerLedgerEntry.SETFILTER("Remaining Amt. (LCY)", '<>%1', 0);
        CustomerLedgerEntry.SETFILTER("Due Date", '<%1', WORKDATE());
        IF CustomerLedgerEntry.FINDSET() THEN
            REPEAT
                CustomerLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                CustomerReminderAmount += CustomerLedgerEntry."Remaining Amt. (LCY)";
            UNTIL CustomerLedgerEntry.NEXT() = 0;

        EXIT(CustomerReminderAmount);
        //HEI.01<<
    end;

    procedure IsAutomaticReopen(AutomaticReopen2: Boolean)
    begin
        //HEI.10>>
        AutomaticReopen := AutomaticReopen2;
        //HEI.10<<
    end;

    procedure SetHideValidationDialogWF4414(NewHideValidationDialogWF: Boolean)
    begin
        //HEI.14>>
        HideValidationDialogWF414 := NewHideValidationDialogWF;
    end;

    procedure SetShowNotificationDialogWF414(NewShowNotificationDialogWF: Boolean)
    begin
        //HEI.15>>
        ShowNotificationDialogWF414 := NewShowNotificationDialogWF;
    end;

    // BC Upgrade SHUKLP03 << codeunit 414 "Release Sales Document" 

    //BC Upgrade GUNREM01 - Codeunit 22 Item Jnl.-Post Line 22.02.26>>

    //     DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Tax Item Charges functionnalities
    //                                  function CalcExpectedCost() new arguments ExpectedTaxSalesAmt,ExpectedTaxPurchAmt
    //                                  function CollectItemChargeValueEntryRel();
    // DITW15.00.00.01 DDR 03/01/2008 Added Drink-it Deposit Item Charges functionnalities
    //                                  change CalcExpectedCost() new arguments ItemChargeType
    // DITW15.00.00.01 DDR 04/01/2008 added "Item DDeposit Group Code"
    // DITW15.00.00.01 DDR 07/01/2008 added field "Item Charge Quantity per"
    //                                added field "Tax Posted To G/L"
    //                                bugfix "Valued Quantity" for new item charges
    // DITW15.00.00.01 DDR 09/01/2008 added functions
    //                                  PostTaxToGL;SetCalledFromAdjustmentTax;InsertTaxPostValueEntryToGL;IsTaxPostToGL
    //                                added field "Due Tax","Expected Tax Posted to G/L"
    //                                purchase item charge (no cost amounts)
    // DITW15.00.00.01 DDR 10/01/2007 Added fields
    // DITW15.00.00.01 DDR 10/01/2007 Added field "Due Tax"
    // DITW15.00.00.01 DDR 21/12/2007 Added Drink-it Discount & Promotion Item Charges functionnalities
    // DITW15.00.00.01 DDR 20/02/2008 Added field2013785 Periodic Disc.-Promo Entry No.
    // DITW15.00.00.01 DDR 28/01/2008 Bugfix conflict to insert G/L Entry between PostInventoryToGL() and PostTaxToGL()
    // DITW15.00.00.01 DDR 14/03/2008 Added field2013767 Unit Volume HL (into Item Ledger Entry)
    //                                Added field2013786 Quantity in HL (into Item Ledger Entry)
    //                                Transfer Initial Entry Due Date into Value Entry
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.16 DDR 28/03/2008 Adapted Undo/Correction item journal functionnality
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.20 DDR 06/06/2008 Certification rules
    // DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008 BrewIt & Quality
    // DITW15.00.00.24 DDR 23/07/2008 Added fields "Item Ledger Entry Quantity HL","Invoiced Quantity in HL" into Value Entry
    //                     22/09/2008 Added function MoveItemToLedgEntry() to copy item Specification/Tariff values into Item ledger entry.
    //                     25/09/2008 Added Duty point to post attached tax item charges and change "posting date" of entries
    //                     01/10/2008 don't fill "Unit Volume HL" into Value Entry when "item charge no." exists
    //                                update function IsTaxPostToGL();InsertTaxPostValueEntryToGL()
    //                     07/10/2008 Added field "Duty Tax Type" to transfer into Value Entry
    // DITW15.00.00.25 DDR 15/10/2008 Change flow Duty point: Remove existing c/al
    //                     21/10/2008 Removed flow "Duty Tax Type"
    //                     22/10/2008 Bugfix initialisation variable blnTaxPostToGL
    //                     24/10/2008 Added rule to skip Transfer-to Charge lines
    //                                  if new location code is not specified
    //                                  if location = new location code
    //                     27/10/2008 Added new field "Opposite Amount Sign" for the Internal Tax amounts
    //                                  (only used with Item, BOM journals)
    // DITW15.00.00.26 DDR 17/11/2008 Bugfix missing "cost per unit" & "Cost Amount"
    //                                  when Value Entry with "Item Charge Type" is ShippingCost
    // DITW15.00.00.30 DDR 19/01/2009 Added/Bugfix transfer field
    //                                  "Source DTax Group Code";"Source Deposit Group Code"
    // DITW15.00.00.31-PRODW14.00.00.08.10 DLE 13/02/2009 License problem
    // DITW15.00.00.31 DDR 19/02/2009 Added to save "Last Price Calculated Date" into Item Ledger, Value entries
    //                                Added to allow variance,rounding value entry When not standard Item charges (Shipping costs)
    // DITW15.00.00.32 DDR 12/03/2009 Bugfix missing get/set the G/L Register while post the item costs (with Output journal)
    //                                Bugfix "Unit Volume HL" with qty per unit of measure
    //                     07/04/2009 Bugfix missing Variance entry for item charges with Purchases
    // PRODW14.00.00.08.12 DDR 14/05/2009
    //   CITQLT1.00 002 Bypass Lot No./Serial no checks for Phs. Inventory types jnl. lines
    // DITW15.00.00.33 DDR 15/05/2009 Bugfix to calculate the "Valued quantity in HL" into Value entry
    // DITW15.00.00.33 DDR 08/06/2009 Bugfix to reverse expected costs with discount & promotion item charges
    // DITW15.00.00.34 DDR 03/07/2009 Added field "Tax Formunla" into Value Entry
    //                                Added field "Tariff No." into Item Ledger Entry
    // DITW15.00.00.34 PRODW14.00.00.13 DDR 10/07/2009
    //                                Added Output entry type to check Quality Tracked items
    // DITW15.00.00.35 DDR 07/08/2009 issue 757 bugfix Transaction no. in G/L entry
    //                                  Remove function call function SetglReg()
    //                                issue 756 Undo item charges with correction item journal
    //                     10/08/2009 issue 759 bugfix skip checking Lot/Serial nos requirements with item charge journal lines
    //                                issue 760 bugfix calc internal tax amount with transfer/reclassif. journals
    // DITW15.00.00.35 DDR 17/08/2009 Added transfer fields to value entry & item ledger entry
    //                                  "Free Item Posting Type","Free Item","Free Calculation Type","Include Free Qty. in Minimum"
    //                     17/09/2009 Added Purchase service documents
    //                     09/10/2009 issue 781 Due Taxes with Free items
    //                                  Added parameter '"DocumentLineNo' for function CalcExpectedCost()
    // DITW15.00.00.36 DDR 06/11/2009 issue 942 Bugfix Reverse Expected costs (see issue 781)
    // DITW15.00.00.37 DDR 19/01/2010 issue 1038 Allowed the internal item charges within 'output'/'consumption' entry types
    //                     20/01/2010 issue 1020 Added transfer fields into item ledger entry
    //                                  "Location Group Code","Company Tax Registration No.","Physical Location Group Code"
    //                     29/01/2010 issue 1054 Added call function CreateAADOnItemJnlLine(),cduAADDocMgt.UpdateAADOnItemEntry()
    //                     17/02/2010 issue 1032 Bugfix calculation of Value quantity with discount item charge per order
    //                     01/03/2010 issue 1089 Bugfix Item application entries while undo a receipt document within item charges
    //                     14/04/2010 issue 1077 Bugfix to calculate the DIT item charge expected (shpt/rcpt) amounts to reverse
    //                                           Added parameter "ItemChargeNo" for function CalcExpectedCost()
    //                     30/04/2010 issue 1128 Bugfix skip to post Whse journal & insert capacity entry & update prod.order document
    //                                             while item charge line from production journal.
    //                                issue 1038 Added to calculate the expected internal taxes
    //                                           Added to post tax output journal lines directly
    //                     20/05/2010 issue 1081 Added transfer fields "New Location Group Code","New Phys. Location Group Code"
    //                     25/05/2010 issue 1037 Added to delete AAD Tracking Entry when item journal correction document (from undo)
    //                                           Added function UndoAADTrackingEntryFrom()
    //                                           Added text constant Text2013660
    //                     28/05/2010 issue 480 Allow item charges for transfer orders
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 22/06/2010 issue 1151 Added function ShowQualityTests()
    //                     24/06/2010 issue 1181 Bugfix to calculate the standard value entry fields Sales & Cost Amounts (Expected)
    // DITW15.00.00.37 DDR 18/01/2011 DIT-715 issue 48 (Merge Error) missing to reverse item charge expected costs
    // DITW15.00.00.38 DDR 05/07/2010 issue 1109 Added to split Due Taxes Item charge assignements by Lot/Serial tracking line
    //                                           Added function SetupChargeSplitJnlLine()
    //                     24/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                           Added function UndoLRNTrackingEntryFrom()
    //                                           Added to transfer all EMCS fields
    //                     30/09/2010            Bugfix to post and create AAD Tracking on Purchase orders & Return Receipts
    //                     12/10/2010            Bugfix functions UndoLRNTrackingEntryFrom()
    // DITW15.00.00.38 DDR 22/10/2010 issue 1139 SSCC Functionnalities
    //                                           Added check on SSCC no. and quantities (if required)
    //                                           Added 'Permissions' codeunit property for table 2035041 "SSCC Ledger Entry"
    //                                           Added text constants Text2035040,Text2035041,Text2035042,Text2035043,Text2035044,
    //                                             Text2035045
    //                                           Added functions InitSSCCLedgEntry(),InsertSSCCLedgEntry(),GetSSCCSetup(),
    //                                             SetupSplitJnlLineSSCC(),SplitJnlLineSSCC(),InsertTempTrkgSpecSSCC(),
    //                                             CollectTrackingSpecSSCC()
    //                     29/10/2010            Added functions
    //                                             SSCCQtyPosting(),ApplySSCCLedgEntry(),InsertTransferSSCCEntry(),AutoTrackSSCC(),
    //                                             CollectSSCCEntryRelation()
    //                                           Updated functions
    //                                             InitSSCCLedgEntry(),InsertSSCCLedgEntry() to transfer "Pallet No." field
    //                                             InsertTempTrkgSpecSSCC() to transfer (applied) sscc entry no.
    //                                           Modified workflow call SplitJnlLineSSCC()
    //                                           Added text constants Text2035046,Text2035047
    //                                           Added functions
    //                                             UpdateSSCCLedgEntry(),UpdateOutboundSSCCLedgEntry(),UpdateOldSSCCLedgEntry(),
    //                                             CheckSSCCTracking(),UndoSSCCQuantityPosting(),InitCorrSSCCLedgEntry(),
    //                                             UpdateOldSSCCLedgEntry(),SetUndoOldSSCCEntry()
    //                     18/11/2010 issue 1239 Bugfix to post the Inventory Adjustment item journals (from report 795)
    //                     22/11/2010 issue 1139 (DIT711 91)
    //                                             Updated functions for Production
    //                                             Added to save SSCC "Creation Date","Creation Time"
    //                     03/12/2010 issue 1229 Added to undo the posted due taxes
    //                     03/12/2010 issue 1139 (DIT711 95) Bugfix to undo SSCC Tracking reservation entries
    //                     09/12/2010 issue 1139 (DIT711 100) Added field "SSCC Company No."
    //                     10/12/2010 issue 1139 (DIT711 101) Removed double call to function UpdateOutboundSSCCLedgEntry()
    //                     14/12/2010 issue 1096 Modified function IsPostToGL() to allow the shipping costs (using report1002)
    //                     17/12/2010 issue 703 Added fields "Tax Item No."
    //                     18/01/2011 restore Navision source code into function InsertValueEntry() old DITW15.00.00.34 DDR 08/06/2009
    //                     26/01/2011 issue 703 Temp disable to copy item tax specifications with "tax item no." (see issue 1276)
    //                                          ! bug multi formula to be fixed with issue 1276
    //                     01/02/2011 issue 1229 Bugfix to undo tax value entry when Duty suspended
    // DITW15.00.00.38 PRODW14.00.00.08.17 DDR 09/02/2011 issue 1272 Bugfix function UpdateQualityTest() skip field "quantity (base)"
    // DITW15.00.00.38 DDR 11/02/2011 issue 1276 Bugfix Tax formula when using Tax item no.
    //                     11/03/2011 issue 703 Removed calculation within "Item Charge Quantity per"
    //                                          Added 'TaxItemNo' parameter function CalcExpectedCost()
    //                     16/03/2011 issue 1096 Modified function IsPostToGL() to allow the discount costs (using report1002)
    //                     18/03/2011 issue 703 Copy the "Source no." into "Tax Item no." following setup
    // DITW15.00.00.39 DDR 12/04/2011 issue 1296 Bugfix to create AAD (ARC) tracking entries with transfer inbound (receipt)
    // DITW15.00.00.39 DDR 29/04/2011 issue 1321 Bugfix Split item charge (item journal) when multi item tracking lines
    //                                              wrong item ledger entry no. into value entry
    //                     05/08/2011 issue 1230 Added to transfer field "Ship-to/Order Address code" into item ledger entry
    //                     19/08/2011 issue 1363 Added to transfer field "Tax Date" into Value Entry
    //                     21/09/2011 issue 1363 Bugfix to fill "Tax Date" into Value Entry
    //                     23/09/2011 issue 1258 FA Back on inventory (v2) from all positive journal lines & check item is back
    //                                           Added text constant Text2034840,Text2034841
    //                                           Skip Unit Cost per Unit when "Inventory Value Zero" into Value Entry
    //                                           Added function ItemInventoryValueZero()
    //                     26/09/2011 issue 1363 Added to transfer field "Tax Date" into Value Entry
    //                     06/10/2011 issue 1441 Added check if exists SSCC tracking lines and item tracking code is not set within SSCC
    //                     19/10/2011 issue 1363 Added to fill "Tax Date" with "Posting Date" if empty
    // DITW16.00.00.40 DDR 05/12/2011 issue DIT-715 183 Bugfix to check if item and service item is already sold or returned
    //                     05/01/2012 DIT-715 #172 Added fields "Allow VAT Calculation (Free)" into Value Entry
    // DITW16.00.00.40 DDR 13/01/2012 DIT-715 #178 Bugfix to post the Quantity into SSCC ledger entry with Qty.UOM <> 1
    //                                             Added functions CodeSSCC() to initialize the split SSCC journal like as LOT journal
    //                     06/02/2012 issue 1299 Bugfix to clear temporary split item charge lines for next item journal
    //                     28/02/2012 DIT-715 #252 Copy always the item description and if emtpy get from the item card.
    //                     08/03/2012 DIT-715 #275 Added all SSCC Mixed fields into SSCC Ledger Entries
    //                     03/05/2012 DIT-715 #292 Added "Bin Code" into SSCC Ledger Entries
    //                     21/05/2012 DIT-715 #182 Review item charge workflow when Purchase order linked to Prod. order (subcontract
    //                     24/05/2012 DIT-715 #312 Bugfix (hidden) to calculate expected deposit amounts
    //                     11/06/2012 DIT-715 #292 Bugfix to apply the SSCC ledger entries about Put-away/Picking Lines
    //                     12/06/2012 DIT-715 #304 Bugfix to copy the sscc expiration/warranty dates for transfer orders
    //                     18/06/2012 DIT-715 #292 Bugfix to check the sscc and availability bin codes
    // DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457 Added to fill "Work Order" field on the item ledger entry
    //                     14/11/2012 DIT-715 #507 Bugfix PostConsumption(),PostOutput() when item charge journal line (double value entrie
    // DITW16.00.00.42 DDR 12/02/2013 DIT-715 #561 Bugfix skip CalcExpectedCost() with standard Item Charges and not attached to items
    //                     01/03/2013 DIT-715 #563 Modified SSCC from Item Tracking Code Fields
    //                                             Added functions CheckSSCCTrackingInfo()
    //                     02/04/2013 DIT-715 #588 Bugfix when posting from Whse. Reclass/Phys. Journals
    // DITW16.00.00.43 DDR 03/05/2013 DIT-715 #634 Bugfix to update SSCC entry "Invoiced Quantity" field
    //                 DDR 14/06/2013 DIT-715 #676 Bugfix missing to reset filter on SCTempTrackingSpecification
    //                 DDR 18/06/2013 DIT-715 #680 Bugfix to show the right Lot No. while checking the quantities
    //                 DDR 25/09/2013 DIT-715 #519 Added Value Entry fields "Qty. per Unit of Measure","Unit of Measure Code"
    //                 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Bugfix function UpdateSSCCLedgEntry()
    //                 DDR 24/10/2013 DIT-715 #813 Bugfix to check SSCC is required
    //                 DDR 24/10/2013 DIT-715 #818 Modified function UpdateOutboundSSCCLedgEntry()
    //                 DDR 24/10/2013 DIT-715 #822 Bugfix SSCC Transfer (infinite loop in function TransferItemJnlToSSCCLedgEntry)
    //                                             Bugfix missing [New] Expiration date for the transit sscc ledger entries
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    //                                               NORRIQ owm - Online Warehouse Management
    //                                               Copyright 2008 by NORRIQ A/S, www.norriq.dk
    //                                               - Added code to OnRun
    //                 DDR 05/11/2013 DIT-715 #813 Removed call function GetSSCCTrackingCheckBalance()
    //                 DDR 06/11/2013 DIT-715 #801 Added using field "Use SSCC Avail. Inventory"
    //                                             Bugfix non-specific (free sscc tracking) and insert sscc entry
    //                 DDR 08/11/2013 DIT-715 #835 Bugfix to post Output/Consumption Journals within SSCC tracking
    //                 DDR 08/11/2013 DIT-715 #752 Bugfix wrong check SSCC with correction journals
    //                 DDR 12/11/2013 DIT-715 #752 Bugfix wrong test to skip the SSCC checking
    //                 DDR 13/11/2013 DIT-715 #775 Skip SSCC entry with Location "Directed Put-away and Pick"
    //                 DDR 28/11/2013 DIT-715 #830 Added fields "Force Trck. Ph.Inv. Non Specif" (SSCC Setup)
    //                 DDR 20/12/2013 DIT-715 #864 Bugfix/Added "Unit Volume HL" and "Valued Quantity in HL" with "Tax item no."
    //                                             Bugfix to calculate "Valued Quantity in HL" with Transfer orders
    //                 DDR 05/12/2013 DIT-715 #761 Bugfix extended sscc non-specific
    // DITW16.00.00.44 DDR 17/02/2014 DIT-715 #906 Bugfix to split item charges (giftbox) with item tracking lines
    //                 DDR 19/03/2014 DIT-715 #911 Bugfix to check quantity of any splitted item charges with item tracking
    //                 DDR 14/05/2014 DIT-715 #925 Bugfix missing get location in function SplitJnlLineSSCC()
    //                 DDR 04/06/2014 DIT-715 #926 Bugfix NAV Standard
    //                 DDR 23/06/2014 DIT-715 #920 Added to copy Tax Specification Ledger Entries while undo item jnl
    // DITW16.00.00.45 DDR 27/10/2014 DIT-715 #941 Bugfix Giftbox calc. "Unit Volume HL" with Transfer orders

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 03/05/2013 DIT-715 #634 merge
    //                  04/06/2013 DIT-770 #101 Modified to update "Last EDI Modified Date"
    //                                          Added field ItemJnlLine."Ship-to Country/Region Code" into Value entries
    //             DDR 14/06/2013 DIT-715 #676 merge
    //             DDR 18/06/2013 DIT-715 #680 merge
    //             DDR 04/07/2013 DIT-770 #99 Added field ItemJnlLine."GWC Country/Region Code" into Item Ledger Entries
    //                                        Modified functions Item application to filter per GWC country code
    //             DDR 05/07/2013 DIT-700 #99 Bugfix inverse item application
    //             DDR 24/07/2013 DIT-770 #101 Added fields ItemJnlLine "Cust/Vendor DTax Group Code" into Item Ledger Entries
    //             DDR 19/08/2013 DIT-770 #101 Remove double field ItemJnlLine "Cust/Vendor DTax Group Code"
    //             DDR 28/08/2013 DIT-770 #178 Remove DIT-770 #99 #101

    // DITW17.00.02 AT  24/09/2013 DIT-770 #132
    //                             Added Code to Flow Free Reason Code to Item Ledger Entry & Value Entry
    // DITW17.00.02 DDR 01/10/2013 DIT-715 #519 Merge
    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.00.02 DDR 24/10/2013 DIT-715 #813 Merge
    // DITW17.00.02 DDR 24/10/2013 DIT-715 #818 Merge
    // DITW17.00.02 DDR 25/10/2013 DIT-715 #822 Merge
    // DITW17.00.02 RPG 05/11/2013 DIT-770 #239 Added code to flow ILE Source No. to "Item Ledger Entry Source No." field in Value Entry
    // DITW17.00.02 DDR 05/11/2013 DIT-715 #813 Merge
    // DITW17.00.02 DDR 06/11/2013 DIT-715 #801 Merge
    // DITW17.00.02 DDR 08/11/2013 DIT-715 #835 Merge
    // DITW17.00.02 DDR 08/11/2013 DIT-715 #752 Merge
    // DITW17.00.02 DDR 08/11/2013 DIT-715 #752 Merge
    // DITW17.00.02 DDR 13/11/2013 DIT-715 #752 Merge
    // DITW17.00.02 DDR 13/11/2013 DIT-715 #775 Merge
    // DITW17.00.02 DDR 13/11/2013 DIT-770 #230 Added fields "DDiscount Level Position""DDiscount Include Tax","DDiscount Include Deposit"
    //                                            "DDiscount Include Discount"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //                                          ? SetupTempSplitItemJnlLine
    // DITW17.00.02 DDR 28/11/2013 DIT-715 #830 Merge
    // DITW17.00.02 DDR 20/12/2013 DIT-715 #864 merge
    // DITW17.00.02 DDR 14/01/2014 DIT-715 #761 Merge
    // DITW17.00.03 DDR 17/02/2014 DIT-715 #906 Merge
    // DITW17.00.03 DDR 17/03/2014 DIT-770 #553 OWM Scanning check Nav license
    // DITW17.00.03 DDR 17/03/2014 DIT-715 #911 Merge
    // DITW17.10.03 DDR 15/04/2014 DIT-770 #629 Bugfix function SetupSplitJnlLineSSCC()
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.03 MSF 28/05/2014 DIT-770 #715 Upgrade W1 Rollup 6 ChangeLog.W1.36366 file 474255
    // DITW17.10.03 DDR 04/06/2014 DIT-715 #926 Merge
    // DITW17.10.03 DDR 23/06/2014 DIT-715 #920 Merge
    // DITW17.10.05 DDR 05/08/2014 DIT-770 #849 Bugfix undo document (correction field) without SSCC mandatory
    // DITW17.10.05 DDR 19/08/2014 DIT-770 #776 Added Deposit point functionality
    // DITW17.10.05 DDR 25/08/2014 DIT-770 #776 Added field "Valued Quantity (Expected)"
    // DITW17.10.05 DDR 03/09/2014 DIT-770 #675 Added Tax Assembly Orders functionality
    // DITW17.10.05 DDR 29/10/2014 DIT-715 #941 merge
    // DITW17.10.05 MSF 14/11/2014 DIT-715 #812 : BugFix Transfertorder with LOT/SSCC - post shipment: warning on multiple expiration dates but same expiration dates in use
    //                                            Solution inspired by standard Tracking functionality
    // DITW17.10.05 DDR 20/01/2015 DIT-770 #581 Bugfix Calculate Expected Deposit Sales/Purch Amount with Item Charge Quantity Per
    // DITW17.10.05 DDR 29/01/2015 DIT-770 #1123 Bugfix function PostTaxToGL() while posting Prod.Order journals
    // DITW17.10.05 DDR 09/02/2015 DIT-770 #710 Bugfix split transfer internal tax ship/receipt per Item ledger entries (without LOT nos)
    //                                          Bugfix split any internal tax journal line per Lot tracking (merge error)
    // DITW18.00.06 DDR 10/04/2015 DIT-770 #1235 Bugfix (DIT-770 #675) Assembly Order & Adjust Cost Item Entries
    // DITW18.00.06 DDR 28/04/2015 DIT-770 #805 Bugfix License Quality Mgt.
    // DITW18.00.06 MSF 16/02/2015 DIT-770 #1185 Get "Indirect Cost %" From SKU card
    // DITW18.00.06 DDR 27/03/2015 DIT-770 #1317 Bugfix recalculate Internal tax amount with Transfer orders
    // DITW18.00.06 DDR 09/04/2015 DIT-770 #1317 Bugfix wrong sign tax amount (missing tax opposite sign)
    // DITW18.00.06 MSF 15/05/2015 DIT-770 #1237 Prod. order and posting consumption lines gives error when lot tracking without sscc setup
    // DITW18.00.06 MSF 27/05/2015 DIT-770 #805  Bugfix
    // DITW18.00.06 MSF 29/09/2015 DIT-770 #1237 "Lot Number is required for Item X" error message when you post a consumption journal with available stock and item tracking defined.
    //                                            Fix from Cumulative update 5
    // DITW18.00.06 MSF 20/10/2015 DIT-770 #805 Renumber CodeUnit ID  2035095 to 2035150
    // DITW18.00.06 DDR 19/10/2015 DIT-770 #1304 Bugfix Giftbox with "Quantity HL" in item ledger entries
    // DITW18.00.06 DDR 23/10/2015 DIT-770 #1667 Bugfix recalculate "Unit Volume HL" to item base unit of measure
    // DITW18.00.06 DDR 23/10/2015 DIT-770 #1395 Added Giftbox Other item posting
    // DITW18.00.06 DDR 04/11/2015 DIT-770 #1304 Added Giftbox "Unit Volume HL" in item ledger entries
    // DITW18.00.06 DDR 04/11/2015 DIT-770 #1667 Bugfix recalculate "Unit Volume HL" to item base unit of measure (output journal)
    // DITW18.00.06A DDR 15/12/2015 DIT-770 #1684 Bugfix Giftbox "Unit Volume HL" with sales/purchases
    // DITW18.00.07 DDR 04/02/2016 DIT-770 #1873 Bugfix SSCC posting with flush Production Orders
    //                                           Bugfix missing internal taxes on Flush consumption journal lines
    // DITW18.00.07 DAT 18/03/2016 DIT-770 #302 Bugfix missing filter when update Quality Test
    // DITW19.00.08 MVN 31/08/2016 BL#11248 (DIT-770 #2162) Merge SSCC changes
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields "Strength Spec. Code","Strength Spec. Value","Vol-Strength Spec. Code";"Vol-Strength Spec. Value"
    //                                                      Various bugfixes about unit volume HL, Scrap, Output & Brewing Quantities
    // DITW19.00.08 DDR 29/09/2016 BL#10443 Added fields "Scrap Code" in item ledger entry & value entry
    //                                      Redesign LossBreakdown posting
    //                                      Added functions SetSkipQualityTestCheck()
    //                                        RegisterLossBreakdownJnl(),InitLossBreakdownEntry(),InsertLossBreakdownEntry(),UpdateLossBreakdownEntry()
    // DITW19.00.08 DDR 17/10/2016 BL#10443 Bugfix RegisterLossBreakdownJnl when no scrap code and/or scrap quantity
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Modified function InsertLossBreakdownEntry()
    //                                      Added transfer "Vol-Strength Spec. Code","Vol-Srength Spec. Value" from tracking specification
    // DITW19.00.08 DDR 28/10/2016 BL#10443 Removed checking Transfer type in function CheckScrapCodeItemTaxGr()
    // DITW19.00.08 DDR 14/11/2016 BL#10443 Bugfix vol-strength calculation in function SetupTempSplitItemJnlLine()
    // DITW19.00.08 DDR 22/11/2016 BL#10443 Modified function InsertConsumpEntry() to recalculate quantity HL, strength values...
    // DITW19.00.08 DDR 02/12/2016 BL#10443 Added "Item Strength Spec. Value" in Item Ledger Entry table
    // DITW19.00.08 DDR 09/12/2016 BL#10443 Bugfix transfer values from Loss breakdown journal
    // DITW19.00.08 AKH 14/12/2016 BL#9745 (DIT-770 #2000) Adjusted code to prevent value entry posting for tax lines in reclassification journal (bin to bin)
    // DITW19.00.08 AKH 15/12/2016 BL#9745 (DIT-770 #2000) Removed redundant code to assign LastItemItemJnlLine
    // DITW19.00.08A VSC 23/12/2016 BL#10443 Set Value on new field 2013724 Reverse
    // DITW19.00.08A VSC 02/01/2017 BL#10443 TEST if Item No on Losses and Item Journal are the same.
    // DITW19.00.08A VSC 03/01/2017 BL#10443 New Function to update "Strength Spec. Value" on  existing reservation entries.
    // DITW19.00.08A VSC 06/01/2017 BL#10443 Post Losses as NegAjustment
    //                                       No Losses on Transfer just the Neg. Ajustment.

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 YHE 15/03/2017 NRQ#24111 merge DIT2016 W1 R8A
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.10 AKH 26/05/2017 NRQ#17909 Added "Item Ledger Entry Source Type" in Value entries
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 AKH 29/06/2017 NRQ#17909 Adjustments
    // DITW110.00.10 MSF 07/07/2017 NRQ#16224 Added Route planning No. to Item ledger Entries Table
    // DITW110.00.11 SFI 30/08/2017 BL#14417 Added changes for deposit valuation
    // DITW110.00.11 SFI 31/08/2017 BL#30569 Added changes for SKU blocking
    // DITW110.00.11 VSC 26/09/2017 NRQ#30577 Merge - QXL10.01 VSC 26/09/2017 NRQ#38341 : Multisite – Quality tracking per Location
    // DITW110.00.11 VSC 26/09/2017 NRQ#30577 Merge XL NRQ#38341
    // DITW110.00.11 VSC 03/10/2017 NRQ#30577 Merge XL NRQ#38341
    // DITW110.00.11 VSC 30/10/2017 NRQ#42348 Merge XL NRQ#43357
    // DITW110.00.11 MSF 06/11/2017 NRQ#43572 Return registration & Control û part 5
    //                                        Added Field Driver Code
    // DITW110.00.12 AKH 24/01/2018 NRQ#56347 Bugfix "Invoiced Quantity in HL" must be 0 when "Invoiced Quantity" = 0
    // QXL11.01 MTR 13/09/2018 NRQ#24975 : Added function CheckYourReference()
    //                                     Copied "YourReference" field to Item ledger entry
    // DITW114.00.15 DDR 01/06/2023 NRQ#247628 Fix CalcExpectedCost() filters + restore standard sorting key


    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt

    // HEI.02 FDDHNK-HeiliteBASE-GAPLOG002 IBM ISYED01 20/06/2017
    //   # added code to update item ledger entry with vendor No. and source type as vendor.
    // HEI.03 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    // # code added
    // HEI.04 PRDGAP038 IBM HORTO01 16.10.2017 - fill in "Quality status"
    // HEI.05 PRDGAP01 IBM POSTOI01 12.07.2018 -spare part conssumption journal
    //   # new code added to InitItemLedgEntry
    // HEI.06 FDD-BA-SLSGAP01 IBM NASTAA02 19.12.2018 # Counterpoint Interface
    //   # Added code to fill-in Fields "Interface Code" and Reference in function "InitItemLedgEntry"

    // HEI.07 CHG2001666 IBM.AB 31.01.2019
    //   # Code added to fix bug while posting Output and Consumption Journal
    // HEI.09 Defect 4892 IBM BULIMC01 28/11/2019 #error message 'Text017' changed so that it will also display the Item No.
    // HEI.10 IBM MATHEJ01 08.01.2020 - #CHG2037233: Corrections for Expiry Date Generation Functionality
    //   # Modified Function: CheckExpirationDate
    // HEI.12 CHG2065153 IBM KUMARN15 23.06.2020
    //   # Code added in function InitItemLedgEntry and InitValueEntry
    // HEI.13 HT1615 BULIMC01 IBM 16.09.2020 #modify functions "InitItemLedgEntry", "InitValueEntry" and "InsertPhysInventoryEntry"
    //     #2 fields updated: "Zone COde", "Bin code"
    // CHG2104608: DITW111.00.13 ISL 18/12/2018 NRQ#96024 Updated code (Deleted field "Prod. BOM Version Code")
    // HEI.14 CHG2100218 IBM SAXENA03 25.03.2021
    //   # Code written for Sales Post optimizaiton
    //   # Replace FINDSET with FINDSET(FALSE,FALSE) Function ApplyItemLedgEntry()
    //   # Replace FIND('-') with FINDFIRST in Function EnsureValueEntryLoaded()
    // NRQ#177003 DDR 29/03/2021 Add "Tax Due Posting to G/L" to post discount item charge like tax
    // NRQ195669.1 MVN 15/09/2021: merge DITW114.00.15 DDR 08/05/2020 NRQ#145254 Fix/Review (#14417) Deposit Value Amount (missing Item journals; Transfer; Partial Posting Expected Calc.; Undo & Correction)
    // HEI.15 CHG2138230 IBM.AK 27.12.21
    //   # Skip the Expiration Date error for Transfer Shipment and Transfer Receipt
    // HEI.16 CHG2131272 IBM.LS      04.01.2022
    //   # Added Code for Reporting Type
    // HEI.17 CHG2129985 SAHAL01      14.04.2022
    //   # Added Code to skip the error from batch Job
    // HEI.18 CHG2140470 SAHAL01 08.11.2022 # Added Code to assign values in Item Ledger Entry Additional
    // HEI.19 CHG2207590 SAHAL01 06.06.2023 Calculation in the Inventory valuation report - Urgent
    //   # Merged Code with Norriq Fix - DITW114.00.15 DDR 01/06/2023 NRQ#247628
    // HEI.20 CHG2187702 SAHAL01 26.09.2023 Revaluation journal items in error
    //   # Added Code

    //BC Upgrade GUNREM01 -HEI.17 Interface code added in INT Ext
    //BC Upgrade kamnay01 The event subscriber was deleted (rather than commented) to ensure it is fully removed from the extension metadata. In Business Central, commented code may still persist in the compiled version if the extension is not redeployed with a version change, causing the old subscriber to be triggered during debugging. Deletion guarantees clean removal.


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterInitItemLedgEntry, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnAfterInitItemLedgEntry"(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    begin
        //>>HEI.05
        NewItemLedgEntry."Project Code FND" := ItemJournalLine."Project Code FND";
        //<<HEI.05

        //HEI.06>>
        //BC Upgrade GUNREM01 -Code Moved to interface extension >>
        // NewItemLedgEntry."Interface Code" := ItemJournalLine."Interface Code";
        // NewItemLedgEntry."CP Vendor Invoice No." := ItemJournalLine."CP Vendor Invoice No.";
        //BC Upgrade GUNREM01 -Code Moved to interface extension <<
        //HEI.06<<


        //HEI.02>>
        CASE ItemJournalLine."Source Type" OF
            ItemJournalLine."Source Type"::Customer:
                BEGIN
                    NewItemLedgEntry."Source No." := ItemJournalLine."Source No.";
                    NewItemLedgEntry."Source Type" := NewItemLedgEntry."Source Type"::Customer;
                END;
            ItemJournalLine."Source Type"::Vendor:
                BEGIN
                    NewItemLedgEntry."Source No." := ItemJournalLine."Vendor No. FND";
                    NewItemLedgEntry."Source Type" := NewItemLedgEntry."Source Type"::Vendor;
                END;
            //>>HEI.07
            // {
            // ItemJournalLine."Source Type"::Item:BEGIN
            //             NewItemLedgEntry."Source No." := Item."No.";
            //             NewItemLedgEntry."Source Type" := NewItemLedgEntry."Source Type"::Item;
            //         END;
            // }
            ItemJournalLine."Source Type"::Item:
                BEGIN
                    Item.Get(ItemJournalLine."Item No.");
                    IF ItemJournalLine."Entry Type" <> ItemJournalLine."Entry Type"::Consumption THEN BEGIN
                        NewItemLedgEntry."Source No." := Item."No.";
                        NewItemLedgEntry."Source Type" := NewItemLedgEntry."Source Type"::Item;
                    END
                    ELSE BEGIN
                        NewItemLedgEntry."Source No." := ItemJournalLine."Source No.";
                        NewItemLedgEntry."Source Type" := NewItemLedgEntry."Source Type"::Item;
                    END;
                END;
        //<<HEI.07
        END;
        //HEI.02<<
        //HEI.03>>
        NewItemLedgEntry."RPM Solution FND" := ItemJournalLine."RPM Solution FND";
        NewItemLedgEntry."RPM Type FND" := ItemJournalLine."RPM Type FND";
        NewItemLedgEntry."Item Type FND" := ItemJournalLine."Item Type FND";
        //HEI.03<<
        //HEI.04>>
        //BC Upgrade GUNREM01 -Quality status field is DIT >>
        // IF LotNoInformation.GET(ItemJournalLine."Item No.", ItemJournalLine."Variant Code", ItemJournalLine."Lot No.") THEN
        //     NewItemLedgEntry."Quality Status" := LotNoInformation."Quality Status";
        //BC Upgrade GUNREM01 -Quality status field is DIT <<
        //HEI.04<<

        //HEI.13>>
        NewItemLedgEntry."Zone Code FND" := ItemJournalLine."Zone Code FND";
        //  NewItemLedgEntry."Bin Code" := ItemJournalLine."Bin Code"; //BC upgrade GUNREM01 - In Itemledger entry Bin code is DIT
        //HEI.13<<

        NewItemLedgEntry."Source System Identifier FND" := ItemJournalLine."Source System Identifier FND"; // HEI.12
        //HEI.16>>
        NewItemLedgEntry."Reporting Type FND" := ItemJournalLine."Reporting Type FND";
        //HEI.16<<
        WHSUTILS.OnAfterInitItemLedgEntry(NewItemLedgEntry, ItemJournalLine);//HEI.01 PRDGAP024
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnInitValueEntryOnBeforeSetDocumentLineNo, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnInitValueEntryOnBeforeSetDocumentLineNo"(ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry"; var ValueEntry: Record "Value Entry")
    begin
        //HEI.03>>
        ValueEntry."RPM Solution FND" := ItemJnlLine."RPM Solution FND";
        ValueEntry."RPM Type FND" := ItemJnlLine."RPM Type FND";
        ValueEntry."Item Type FND" := ItemJnlLine."Item Type FND";
        //HEI.03<<
    end;

    //BC Upgrade kamnay01 The event subscriber was deleted (rather than commented) to ensure it is fully removed from the extension metadata. In Business Central, commented code may still persist in the compiled version if the extension is not redeployed with a version change, causing the old subscriber to be triggered during debugging. Deletion guarantees clean removal.

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeInsertValueEntry, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnBeforeInsertValueEntry"(var ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry"; var ValueEntryNo: Integer; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; CalledFromAdjustment: Boolean; var OldItemLedgEntry: Record "Item Ledger Entry"; var Item: Record Item; TransferItem: Boolean; var GlobalValueEntry: Record "Value Entry")
    begin

        //HEI.03>>
        ValueEntry."RPM Solution FND" := ItemJournalLine."RPM Solution FND";
        ValueEntry."RPM Type FND" := ItemJournalLine."RPM Type FND";
        ValueEntry."Item Type FND" := ItemJournalLine."Item Type FND";
        //HEI.03<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeCheckPostingDateWithExpirationDate, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnBeforeCheckPostingDateWithExpirationDate"(var ItemLedgEntry: Record "Item Ledger Entry"; ItemTrackingCode: Record "Item Tracking Code"; OldItemLedgEntry: Record "Item Ledger Entry"; var IsHandled: Boolean; var ItemJnlLine: Record "Item Journal Line")
    begin
        IF ItemTrackingCode."Strict Expiration Posting" AND (OldItemLedgEntry."Expiration Date" <> 0D) AND
       NOT ItemLedgEntry.Correction AND
       NOT (ItemLedgEntry."Document Type" IN
            [ItemLedgEntry."Document Type"::"Purchase Return Shipment", ItemLedgEntry."Document Type"::"Purchase Credit Memo"
            , ItemLedgEntry."Document Type"::"Transfer Shipment", ItemLedgEntry."Document Type"::"Transfer Receipt"]) //HEI.15
    THEN
            IF ItemLedgEntry."Posting Date" > OldItemLedgEntry."Expiration Date" THEN
                IF (ItemLedgEntry."Entry Type" <> ItemLedgEntry."Entry Type"::"Negative Adjmt.") AND
                   NOT ItemJnlLine.IsReclass(ItemJnlLine)
                THEN
                    // OldItemLedgEntry.FIELDERROR("Expiration Date",Text017); //commented HEI.09
                    ERROR(Text017_CU22, OldItemLedgEntry."Expiration Date", OldItemLedgEntry."Item No."); //HEI.09
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeCheckExpirationDate, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnBeforeCheckExpirationDate"(var ItemJournalLine: Record "Item Journal Line"; var TrackingSpecification: Record "Tracking Specification"; SignFactor: Integer; CalcExpirationDate: Date; var ExpirationDateChecked: Boolean; var IsHandled: Boolean)
    begin
        Itemjournalline_CU22 := ItemJournalLine;
        CalcExpirationDate_CU22 := CalcExpirationDate;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnCheckExpirationDateOnBeforeAssignExpirationDate, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnCheckExpirationDateOnBeforeAssignExpirationDate"(var TempTrackingSpecification: Record "Tracking Specification" temporary; ExistingExpirationDate: Date; var IsHandled: Boolean)
    begin
        if Itemjournalline_CU22."Entry Type" = Itemjournalline_CU22."Entry Type"::Transfer then
            if TempTrackingSpecification."Expiration Date" = 0D then
                TempTrackingSpecification."Expiration Date" := ExistingExpirationDate;
        //HEI.10>>
        IF (ExistingExpirationDate = 0D) AND (CalcExpirationDate_CU22 <> 0D) AND (Itemjournalline_CU22."Entry Type" <> Itemjournalline_CU22."Entry Type"::Output) THEN
            CalcExpirationDate_CU22 := 0D;
        //HEI.10<<
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnInitValueEntryOnAfterNotAdjustmentCheckClearCostAmount, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnInitValueEntryOnAfterNotAdjustmentCheckClearCostAmount"(var ValueEntry: Record "Value Entry"; var ItemJnlLine: Record "Item Journal Line")
    begin
        ValueEntry."Source System Identifier FND" := ItemJnlLine."Source System Identifier FND";  // HEI.12

        //HEI.13>>
        ValueEntry."Zone Code FND" := ItemJnlLine."Zone Code FND";
        ValueEntry."Bin Code FND" := ItemJnlLine."Bin Code";
        //HEI.13<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeInsertPhysInvtLedgEntry, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnBeforeInsertPhysInvtLedgEntry"(var PhysInventoryLedgerEntry: Record "Phys. Inventory Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; LastSplitItemJournalLine: Record "Item Journal Line")
    begin
        //HEI.13<<
        PhysInventoryLedgerEntry."Zone Code FND" := ItemJournalLine."Zone Code FND";
        PhysInventoryLedgerEntry."Bin Code FND" := ItemJournalLine."Bin Code";
        //HEI.13>>
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeCheckItemTrackingIsEmpty, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnBeforeCheckItemTrackingIsEmpty"(ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    var
        ItemJnlLine2: Record "Item Journal Line";
    begin
        //HEI.17>>
        IF GUIALLOWED THEN
            //HEI.17<<

            //HEI.18>>
            IF NOT ItemJnlLine2."Consumption Suggested FND" THEN begin
                ItemJnlLine.CheckTrackingIsEmpty();//BC Upgrade GUNREM01 - called existing function.
            end;
        //HEI.18<<
        ItemJnlLine.CheckNewTrackingIsEmpty();
        IsHandled := true;
        //HEI.18<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterInsertItemLedgEntry, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnAfterInsertItemLedgEntry"(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer; var ValueEntryNo: Integer; var ItemApplnEntryNo: Integer; GlobalValueEntry: Record "Value Entry"; TransferItem: Boolean; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; var OldItemLedgerEntry: Record "Item Ledger Entry")
    begin
        //HEI.18>>
        IF ItemJournalLine."Consumption Suggested FND" AND ItemJournalLine."Consumption Allocated FND" THEN
            InsertILEAdditional(ItemLedgerEntry."Entry No.", ItemJournalLine);//Kamnay01 added ItemJournalLine as parameter
        //HEI.18<<

    end;

    LOCAL procedure InsertILEAdditional(VAR ItemLedgEntryNo: Integer; VAR ItemJnlLine1: Record "Item Journal Line")//Kamnay01 added parameter
    var
        ILEAdditionalL: Record "Item Ledger Entry Add FND";
    begin
        //HEI.18>>
        ILEAdditionalL.INIT();
        ILEAdditionalL."Item Ledger Entry No." := ItemLedgEntryNo;
        ILEAdditionalL."Journal Template Name" := ItemJnlLine1."Journal Template Name";
        ILEAdditionalL."Journal Batch Name" := ItemJnlLine1."Journal Batch Name";
        ILEAdditionalL."Actual Posted Consumption" := ItemJnlLine1."Actual Posted Consumption FND";
        ILEAdditionalL."Actual Posted Lot No." := ItemJnlLine1."Actual Posted Lot No. FND";
        ILEAdditionalL."Consumption Suggested" := ItemJnlLine1."Consumption Suggested FND";
        ILEAdditionalL."Consumption Allocated" := ItemJnlLine1."Consumption Allocated FND";
        ILEAdditionalL."Quantity Allocated" := ItemJnlLine1."Quantity Allocated FND";
        ILEAdditionalL.INSERT(FALSE);
    end;
    //HEI.18<<

    //  GetItemJnlLine(VAR ItemJournalLine : Record "Item Journal Line") //BC Upgrade GUNREM01 - Moved to procedure below
    //BC Upgrade kamnay01 The event subscriber was deleted (rather than commented) to ensure it is fully removed from the extension metadata. In Business Central, commented code may still persist in the compiled version if the extension is not redeployed with a version change, causing the old subscriber to be triggered during debugging. Deletion guarantees clean removal.


    //BC Upgrade GUNREM01 - Codeunit 22 Item Jnl.-Post Line 22.02.26<<

    var
        // BC Upgrade SHUKLP03 >> codeunit 414 "Release Sales Document" 
        SalesSetup: Record "Sales & Receivables Setup";
        //cduAppMgt: Codeunit ApplicationManagement; // BC Upgrade SHUKLP03 << replaced with "UI Helper Triggers"
        cduAppMgt: Codeunit "UI Helper Triggers"; // BC Upgrade SHUKLP03 <<
        OldLocationCode: Code[10];
        OldStatus: ENUM "Sales Document Status";
        AutomaticReopen: Boolean;
        HideValidationDialogWF414: Boolean; // BC Upgra
        ShowNotificationDialogWF414: Boolean;
        WhseSalesRelease: Codeunit "Whse.-Sales Release";
        // BC Upgrade SHUKLP03 << codeunit 414 "Release Sales Document" 

        //BC Upgrade GUNREM01 - Codeunit 22 Item Jnl.-Post Line var >>
        Text041: label 'The %1 does not exist. Identification fields and values: %2 - %3 and %4 - %5.';
        GenPostingSetup: Record "General Posting Setup";
        InventorySetupL: Record "Inventory Setup";
        ItemJnlTemplateL: Record "Item Journal Template";

        Itemjournalline_CU22: record "Item Journal Line";
        CalcExpirationDate_CU22: Date;
        ItemLedgEntry: record "Item Ledger Entry";
        LotNoInformation: record "Lot No. Information";
        Item: Record Item;
        WHSUTILS: Codeunit "WHS-UTILS";
        Text017_CU22: Label ' is before the posting date.';
        CADAmount: Decimal;
        VATPostingSetup2: Record "VAT Posting Setup";
        CADAmount1: Decimal;
    //BC Upgrade GUNREM01 codeunit 22 Item Jnl.-Post Line var <<

    //BC UPGRADE SIVA Codeunit 17 "Gen. Jnl.-Post Reverse" SubscriptionsEvents >>
    //      HEI.01 Defect #2304 IBM POSTOI 31.07.2018
    //     # for General Journal reverse transactions Open should be make FALSE
    //   HEI.02 FDD-CHG0246362 IBM ISYED01 09/14/2018
    //     #update the posting date of G/L entry while Reversion.
    //   HEI.03 FDD-ET-HT695 IBM NASTAA02 05.08.2019 # RPM Payment Reconciliation and Offset
    //     # "Deposit Quantity" should have opposite sign when reversing Cust. Ledg. Entries
    //   HEI.04 DEFECT 5029 IBM BULIMC01 10/02/2020 #code changed to update the Reversal Posting Date of Vendor Ledger Entries, Customer Ledger Entries and BankAccLedgEntry
    //   HEI.05 CHG2070961/CHG2088483 IBM POENAB02 31.07.2020 Panama -  Suspense account issue related to BI
    //    # Modified function Reverse
    //   HEI.06 CHG2091935 IBM SURYAS01 28.12.2020-  To provide the solution for Auto reversal issue.
    //    # Modified function Reverse
    //*******************************************//
    //1.HEI.01 Subscribe the OnReverseGLEntryOnBeforeInsertGLEntry event for General Journal reverse transactions Open should be make FALSE.
    //2.HEI.02 Subscribe the OnReverseOnBeforeStartPosting event for update the posting date of G/L entry while Reversion.
    //3.HEI.03 Subscribe the OnReverseCustLedgEntryOnBeforeModifyCustLedgerEntry event for "Deposit Quantity" should have opposite sign when reversing Cust. Ledg. Entries
    //4.HEI.04 Subcribe the OnReverseCustLedgEntryOnBeforeInsertCustLedgEntry update the Reversal Posting Date of  Customer Ledger Entries.
    //         Subcribe the OnReverseVendLedgEntryOnBeforeInsertVendLedgEntry update the Reversal Posting Date of  Vendor Ledger Entries.
    //         Subcribe the OnReverseBankAccLedgEntryOnBeforeInsert update the Reversal Posting Date of  Bank Ledger Entries.     
    //5.HEI.05 Subscribe the OnReverseGLEntryOnBeforeInsertGLEntry for Suspense account issue related to BI
    //6.HEI.06 Subscribe the To provide the solution for Auto reversal issue.
    // Created SetReverseEntryNo Procedure in HeinenkenGlobal Codeunit Single insatce codeunti for set Reversal entry no dynamically 
    // Which BC Standard events not able to support.Following Procedure GetReverseEntryNo will get Revesal Entry no.  
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseGLEntryOnBeforeInsertGLEntry, '', false, false)]
    // local procedure OnReverseGLEntryOnBeforeInsertGLEntry(var GLEntry: Record "G/L Entry"; GLEntry2: Record "G/L Entry")
    // var
    //     SourceCodeSetup: Record "Source Code Setup";
    //     ReversedGLEntry: Record "G/L Entry";
    //     FinancialUtils: Codeunit "Financial-Utils";
    // begin
    //     ReversedGLEntry.Get(GLEntry2."Reversed Entry No.");
    //     //>>HEI.01
    //     IF (SourceCodeSetup."General Journal" = GLEntry."Source Code") OR
    //       (SourceCodeSetup.Reversal = GLEntry."Source Code") THEN
    //         GLEntry.Open := FALSE;
    //     //<<HEI.01
    //     //>>HEI.01
    //     IF (SourceCodeSetup."General Journal" = ReversedGLEntry."Source Code") OR
    //       (SourceCodeSetup.Reversal = ReversedGLEntry."Source Code") THEN
    //         ReversedGLEntry.Open := TRUE;
    //     //<<HEI.01
    //     //>>HEI.01
    //     IF (SourceCodeSetup."General Journal" = GLEntry2."Source Code") OR
    //        (SourceCodeSetup.Reversal = GLEntry2."Source Code") THEN
    //         GLEntry2.Open := FALSE;
    //     FinancialUtils.ReverseDetailedAdjmt(GLEntry2);
    //     //<<HEI.01
    //     //HEI.05>>
    //     IF GLEntry."Reversed Entry No." = 0 THEN
    //         GLEntry."Reversed by Entry No." := GLEntry2."Entry No.";
    //     GLEntry."Remaining Amount" := 0;
    //     IF GLEntry."Reversed Entry No." <> 0 THEN
    //         GLEntry."Closed by Entry No." := GLEntry."Reversed Entry No.";
    //     IF GLEntry."Reversed by Entry No." <> 0 THEN
    //         GLEntry."Closed by Entry No." := GLEntry."Reversed by Entry No.";
    //     GLEntry."Closed at Date" := TODAY;
    //     GLEntry."Entries Posted By" := USERID;
    //     GLEntry.Open := FALSE;

    //     GLEntry2."Entries Posted By" := USERID;
    //     GLEntry2.Open := FALSE;
    //     GLEntry2."Remaining Amount" := 0;
    //     IF GLEntry2."Reversed by Entry No." <> 0 THEN
    //         GLEntry2."Closed by Entry No." := GLEntry2."Reversed by Entry No.";
    //     IF GLEntry2."Reversed Entry No." <> 0 THEN
    //         GLEntry2."Closed by Entry No." := GLEntry2."Reversed Entry No.";
    //     GLEntry2."Closed at Date" := TODAY;
    //     //HEI.05<<

    //     //>>HEI.06
    //     GLEntry."Source Currency Amount" := -GLEntry."Source Currency Amount";
    //     GLEntry."Remaining Amount" := -GLEntry."Remaining Amount";
    //     //>>HEI.06
    // end;/BC SHARMP16-- GAPFitchanges 10March26-- shifted to CU50287

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseOnBeforeStartPosting, '', false, false)]
    // local procedure OnReverseOnBeforeStartPosting(var GLEntry: Record "G/L Entry"; var ReversalEntry: Record "Reversal Entry")
    // begin
    //     //HEI.02>>
    //     GLEntry."Posting Date" := ReversalEntry."Posting Date";
    //     //HEI.02<<
    // end;/BC SHARMP16-- GAPFitchanges 10March26-- shifted to CU50287

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnBeforeReverse, '', false, false)]
    local procedure OnBeforeReverse(var ReversalEntry2: Record "Reversal Entry"; var ReversalEntry: Record "Reversal Entry")
    var
        lGLEntry: Record "G/l Entry";
    begin
        //HEI.05>>
        IF ReversalEntry2."Entry Type" = ReversalEntry2."Entry Type"::"G/L Account" THEN
            IF lGLEntry.GET(ReversalEntry2."Entry No.") THEN
                IF lGLEntry.Reversed = TRUE THEN
                    ERROR(ReverseTransErr);
        //HEI.05<<
        ReversalEntry2."Posting Date" := ReversalEntry."Posting Date"; //HEI.04
        HeniKenBCGlobal.SetReverseEntryNo(ReversalEntry2."Entry No.");//BC UPGRADE SIVA

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseCustLedgEntryOnBeforeModifyCustLedgerEntry, '', false, false)]
    local procedure OnReverseCustLedgEntryOnBeforeModifyCustLedgerEntry(var CustLedgerEntry: Record "Cust. Ledger Entry"; NewCustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        NewCustLedgerEntry."Deposit Quantity FND" := -CustLedgerEntry."Deposit Quantity FND"; //HEI.03

    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseVendLedgEntryOnBeforeInsertVendLedgEntry, '', false, false)]
    // local procedure OnReverseVendLedgEntryOnBeforeInsertVendLedgEntry(var NewVendLedgEntry: Record "Vendor Ledger Entry")
    // Var
    //     ReversalEntry: Record "Reversal Entry";
    // begin
    //     //HEI.04>>
    //     if ReversalEntry.Get(HeniKenBCGlobal.GetReverseEntryNo()) then
    //         NewVendLedgEntry."Posting Date" := ReversalEntry."Posting Date";
    //     //HEI.04<<
    // end;    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseVendLedgEntryOnBeforeInsertVendLedgEntry, '', false, false)]
    // local procedure OnReverseVendLedgEntryOnBeforeInsertVendLedgEntry(var NewVendLedgEntry: Record "Vendor Ledger Entry")
    // Var
    //     ReversalEntry: Record "Reversal Entry";
    // begin
    //     //HEI.04>>
    //     if ReversalEntry.Get(HeniKenBCGlobal.GetReverseEntryNo()) then
    //         NewVendLedgEntry."Posting Date" := ReversalEntry."Posting Date";
    //     //HEI.04<<
    // end;//BC SHARMP16-- GAPFitchanges 10March26-- shifted to CU50287

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseCustLedgEntryOnBeforeInsertCustLedgEntry, '', false, false)]
    local procedure OnReverseCustLedgEntryOnBeforeInsertCustLedgEntry(var NewCustLedgerEntry: Record "Cust. Ledger Entry")
    Var
        ReversalEntry: Record "Reversal Entry";
    begin
        //HEI.04>>
        if ReversalEntry.Get(HeniKenBCGlobal.GetReverseEntryNo()) then
            NewCustLedgerEntry."Posting Date" := ReversalEntry."Posting Date";
        //HEI.04<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseBankAccLedgEntryOnBeforeInsert, '', false, false)]
    local procedure OnReverseBankAccLedgEntryOnBeforeInsert(var NewBankAccLedgEntry: Record "Bank Account Ledger Entry")
    Var
        ReversalEntry: Record "Reversal Entry";
    begin
        //HEI.04>>
        if ReversalEntry.Get(HeniKenBCGlobal.GetReverseEntryNo()) then
            NewBankAccLedgEntry."Posting Date" := ReversalEntry."Posting Date";
        //HEI.04<<
    end;

    //BC UPGRADE SIVA Codeunit 17 "Gen. Jnl.-Post Reverse" SubscriptionsEvents <<
    //--------------------------------------------------BC Upgrade SHARMP16 Table VAT AMount LINE BEGIN>><<------------------------------------------
    //    DITW18.00.07 VSC 18/05/2016 DIT-770 #1972 Merge FINXL EDI Interface
    // IPLXL9.00.001 IMI 06/08/2015: Added function fctInsertLineEDI

    // FINXL10.0 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New functions created: 'UpdateCADAmount', 'GetTotalCADAmount'
    //   # Code added on function "UpdateLines"
    // HEI.02 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //   # Code added
    //BC Upgrade SHARMP16--HEI.01-No event found for CalcVATFields to write VAT Amount Code Require one Integration event with Ishandled
    //BC Upgrade SHARMP16--HEI.02-CalcVATFields same as HEI.01 need events
    //BC Upgrade SHARMP16--HEI.02-Need Event UpdateLines just before modify in last
    //=====================================================================================================================//
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", OnUpdateLinesOnAfterCalcAmountIncludingVATNormalVAT, '', false, false)]
    local procedure OnUpdateLinesOnAfterCalcAmountIncludingVATNormalVAT(PrevVATAmountLine: Record "VAT Amount Line"; PricesIncludingVAT: Boolean; var Currency: Record Currency; var VATAmountLine: Record "VAT Amount Line"; VATBaseDiscountPerc: Decimal)
    begin
        //HEI.01>>
        //HEI.02>>
        IF VATAmountLine."Operation Type FND" <> VATAmountLine."Operation Type FND"::Sales THEN
            VATAmountLine."Amount Including VAT" := VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount" + VATAmountLine."VAT Amount"
        ELSE
            //HEI.02<<
              VATAmountLine."Amount Including VAT" := VATAmountLine."Line Amount" - VATAmountLine."Invoice Discount Amount" + VATAmountLine."VAT Amount" + VATAmountLine."CAD Amount FND";
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", OnAfterCopyFromSalesInvLine, '', false, false)]
    local procedure OnAfterCopyFromSalesInvLine(SalesInvoiceLine: Record "Sales Invoice Line"; var VATAmountLine: Record "VAT Amount Line")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //HEI.01>>
        GeneralLedgerSetup.GET();
        IF GeneralLedgerSetup."Enable CAD FND" THEN
            VATAmountLine."CAD Amount FND" := SalesInvoiceLine."CAD Amount FND";
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", OnAfterCopyFromSalesCrMemoLine, '', false, false)]
    local procedure OnAfterCopyFromSalesCrMemoLine(SalesCrMemoLine: Record "Sales Cr.Memo Line"; var VATAmountLine: Record "VAT Amount Line")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //HEI.01>>
        //HEI.01>>
        GeneralLedgerSetup.GET();
        IF GeneralLedgerSetup."Enable CAD FND" THEN
            VATAmountLine."CAD Amount FND" := SalesCrMemoLine."CAD Amount FND";
        //HEI.01<<

    end;

    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", OnInsertLineOnBeforeInsert, '', false, false)]
    local procedure OnInsertLineOnBeforeInsert(var FromVATAmountLine: Record "VAT Amount Line"; var VATAmountLine: Record "VAT Amount Line")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //HEI.02>>
        IF VATAmountLine."Operation Type FND" = VATAmountLine."Operation Type FND"::Sales THEN
            VATAmountLine."VAT Amount" := VATAmountLine."Amount Including VAT" - VATAmountLine."VAT Base" - VATAmountLine."CAD Amount FND"

        //HEI.02<<

    end;

    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", OnAfterCopyFromPurchInvLine, '', false, false)]
    local procedure OnAfterCopyFromPurchInvLine(PurchInvLine: Record "Purch. Inv. Line"; var VATAmountLine: Record "VAT Amount Line")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //HEI.02>>
        GeneralLedgerSetup.GET();
        IF GeneralLedgerSetup."Enable CAD FND" THEN
            VATAmountLine."CAD Amount FND" := PurchInvLine."CAD Amount FND";
        //HEI.02<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", OnAfterCopyFromPurchCrMemoLine, '', false, false)]
    local procedure OnAfterCopyFromPurchCrMemoLine(PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var VATAmountLine: Record "VAT Amount Line")
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //HEI.02>>
        GeneralLedgerSetup.GET();
        IF GeneralLedgerSetup."Enable CAD FND" THEN
            VATAmountLine."CAD Amount FND" := PurchCrMemoLine."CAD Amount FND";
        //HEI.02<<
    end;
    //=====================================================================================================================//

    // BC Upgrade SHUKLP03 >> Codeunit 393 "Reminder-Issue"

    //     HEI.01 FDD-HNK-HeiliteBASE-OTCGAP030 IBM ISYED01 05/07/2017
    //   # Update table Issued Reminder Line with data for Disputed and Disputed Reason Code.
    // HEI.02 RFC-CHG2000416 IBM.AB 17/07/2019
    //   # Reminder Mail issue
    // HEI.03 FDD-HT1203 IBM KUMARN15 03.06.2020
    //   # Not to run custome email sent logic on Skip Custom Reminder Logic

    // Subscribed event OnBeforeIssuedReminderLineInsert, OnRunOnBeforeReminderLineDeleteAll to add HEI.01, HEI.02 and HEI.03 code.
    // procedure SendMailIssueReminder() is added.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reminder-Issue", OnBeforeIssuedReminderLineInsert, '', false, false)]
    local procedure OnBeforeIssuedReminderLineInsert(ReminderLine: Record "Reminder Line"; var IssuedReminderLine: Record "Issued Reminder Line")
    begin
        //HEI.01>>
        IssuedReminderLine."Disputed FND" := ReminderLine."Disputed FND";
        IssuedReminderLine."Disputed Reason code FND" := ReminderLine."Disputed Reason code FND";
        //HEI.01>>
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reminder-Issue", OnRunOnBeforeReminderLineDeleteAll, '', false, false)]
    local procedure OnRunOnBeforeReminderLineDeleteAll()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        //<<HEI.03
        SalesReceivablesSetup.GET();
        IF NOT SalesReceivablesSetup."Skip Custom Reminder Logic FND" THEN
            //>>HEI.03
            SendMailIssueReminder();
        //HEI.02<<
    end;

    procedure SendMailIssueReminder()
    var
        LIssuedReminder: Record "Issued Reminder Header";
        IssuedReminderHd: Record "Issued Reminder Header";
        SendEmailCU: Codeunit "Follow Email pattern";
        ReminderIssueCU: Codeunit "Reminder-Issue";
    begin
        //HEI.02>>
        CLEAR(SendEmailCU);
        ReminderIssueCU.GetIssuedReminder(IssuedReminderHd);
        LIssuedReminder.RESET();
        LIssuedReminder.SETRANGE("No.", IssuedReminderHd."No.");
        LIssuedReminder.SETRANGE("Mail Sent FND", FALSE);
        IF LIssuedReminder.FINDFIRST() THEN BEGIN
            SendEmailCU.SendEmail(LIssuedReminder);
            LIssuedReminder."Mail Sent FND" := TRUE;
            LIssuedReminder.MODIFY();
        END;
        //HEI.02<<
    end;
    // BC Upgrade SHUKLP03 << Codeunit 393 "Reminder-Issue"

    //Bc Upgrade YADAVM09 Codeunit 448 Job Queue Dispatcher>>
    // HEI.01 CHG2026642 IBM KUMARN15 13.08.2019
    //     #Code Fix for Interface Error
    // HEI.02 CHG2010375 IBM.LS 23.01.2020
    //   # Code added.
    // HEI.03 CHG2188870 DEBUSD01 03.02.2023 Sales Order API Interface log to re-process posting entries
    // HEI.04 CHG2188870 DEBUSD01 06.02.2023 Sales Order API Interface log to re-process posting entries
    //   # Remove call
    // HEI.05 CHG2202438 SAMANR01 26.04.2023 NAS Task scheduler is not stop session after the Reset of the job
    //         # Add code for kill the SQL session if in progress job put on-hold
    // HEI.06 CHG2202438 SAMANR01 05.05.2023 NAS Task scheduler is not stop session after the Reset of the job
    //         # Add code for kill the SQL session if in progress job put on-hold with powershell runner
    // HEI.07 IBM COSTES04 13.01.2025 CHG2279679-HB4118-Automatic restart of deadlock errors for auto billing
    //   # reset No. of Attempts to Reset

    //Bc Upgrade YADAVM09 HEI.05 Code is already there in base code.
    //Bc Upgrade YADAVM09 HEI.06 Code is written on the event OnBeforeHandleRequest.
    //Bc Upgrade YADAVM09 HEI.01 Code is written on the event OnAfterSuccessExecuteJob.
    //Bc Upgrade YADAVM09 HEI.02 Code of Function Handlerequest not added due to missing event.
    //Bc Upgrade YADAVM09 HEI.07 Code of Function Handlerequest not added due to missing event.
    //Bc Upgrade YADAVM09 HEI.02 of function inserlogentry is added in event OnBeforeInsertLogEntry.
    //Bc Upgrade YADAVM09 OnBeforeInsertLogEntry change to name OnBeforeInsertLogEntry2 as this event is already subscribed in Heineken Bc Upgrade.


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Queue Dispatcher", OnBeforeHandleRequest, '', false, false)]
    local procedure OnBeforeHandleRequest(var JobQueueEntry: Record "Job Queue Entry")
    var
        //recServerInstance: Record "Server Instance"; // BC Upgrade YADAVM09 - Blocked as this table is not applicable in SaaS
        ActiveSession: Record "Active Session";  // BC Upgrade YADAVM09 - Added
    begin
        //HEI.06>>
        JobQueueEntry."JOB TenantID FND" := TENANTID();
        //IF recServerInstance.GET(SERVICEINSTANCEID) THEN BEGIN  // BC Upgrade YADAVM09 - Blocked
        if ActiveSession.Get(Database.ServiceInstanceId(), Database.SessionId()) then begin  // BC Upgrade YADAVM09 - Added
            // JobQueueEntry."JOB ServiceInstanceName" := recServerInstance."Server Instance Name"; // BC Upgrade YADAVM09 - Blocked
            // JobQueueEntry."JOB Server Name" := recServerInstance."Server Computer Name"; // BC Upgrade YADAVM09 - Blocked
            JobQueueEntry."JOB ServiceInstanceName FND" := ActiveSession."Server Instance Name"; // BC Upgrade YADAVM09 - Added
            JobQueueEntry."JOB Server Name FND" := ActiveSession."Server Computer Name"; // BC Upgrade YADAVM09 - Added
        END;
        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Queue Dispatcher", OnAfterSuccessExecuteJob, '', false, false)]
    local procedure OnAfterSuccessExecuteJob(var JobQueueEntry: Record "Job Queue Entry")
    var
    begin
        //<< HEI.01
        if JobQueueEntry.Status = JobQueueEntry.Status::Error then // BC Upgrade YADAVM09 - Added
                                                                   //IF NOT WasSuccess THEN // BC Upgrade YADAVM09 - Blocked
            MESSAGE('%1 - %2', JobQueueEntry.Description, GETLASTERRORCALLSTACK);
        //>> HEI.01
    end;

    [EventSubscriber(ObjectType::Table, database::"Job Queue Entry", OnBeforeInsertLogEntry, '', false, false)]
    local procedure OnBeforeInsertLogEntry2(var JobQueueLogEntry: Record "Job Queue Log Entry"; var JobQueueEntry: Record "Job Queue Entry")
    var
        SalesReceivablesSetupL: Record "Sales & Receivables Setup";
        SalesHeaderL: Record "Sales Header";
        AutomationUtilityL: codeunit "Automation Utility";
    begin
        //HEI.02>>
        SalesReceivablesSetupL.GET();
        IF SalesReceivablesSetupL."Enable OTC Billing Auto. FND" THEN BEGIN
            IF (JobQueueLogEntry."Object Type to Run" = JobQueueLogEntry."Object Type to Run"::Codeunit) AND
              (JobQueueLogEntry."Object ID to Run" = CODEUNIT::"Sales Post via Job Queue") THEN BEGIN
                SalesReceivablesSetupL.TESTFIELD("Post with Job Queue", FALSE);
                JobQueueLogEntry."Send Document FND" := JobQueueEntry."Send Document FND";
                JobQueueLogEntry."Document Type FND" := JobQueueEntry."Document Type FND";
                JobQueueLogEntry."Document No. FND" := JobQueueEntry."Document No. FND";
                JobQueueLogEntry."JQ Posted FND" := JobQueueEntry."JQ Posted FND";
                JobQueueLogEntry."JQ Mail Sent FND" := JobQueueEntry."JQ Mail Sent FND";
                JobQueueLogEntry."JQ Printed FND" := JobQueueEntry."JQ Printed FND";
                JobQueueLogEntry."Posted Document No. FND" := JobQueueEntry."Posted Document No. FND";
                JobQueueLogEntry."JQ Logistics Mail Sent FND" := JobQueueEntry."JQ Logistics Mail Sent FND";
            END;
        END;
        //HEI.02<<
        IF JobQueueEntry.Status = JobQueueEntry.Status::Error THEN BEGIN
            JobQueueLogEntry.Status := JobQueueLogEntry.Status::Error;
            //JobQueueLogEntry.SetErrorMessage(JobQueueEntry.GetErrorMessage);//Bc Upgrade YADAVM09<<
            JobQueueLogEntry."Error Message" := GetLastErrorText();//Bc Upgrade YADAVM09<<
            //HEI.02>>
            //END ELSE
        END ELSE BEGIN
            //HEI.02<<
            JobQueueLogEntry.Status := JobQueueLogEntry.Status::Success;
            //HEI.02>>
            SalesReceivablesSetupL.GET();
            IF SalesReceivablesSetupL."Enable OTC Billing Auto. FND" THEN BEGIN
                IF (JobQueueLogEntry."Object Type to Run" = JobQueueLogEntry."Object Type to Run"::Codeunit) AND
                  (JobQueueLogEntry."Object ID to Run" = CODEUNIT::"Sales Post via Job Queue") THEN BEGIN
                    SalesReceivablesSetupL.TESTFIELD("Post with Job Queue", FALSE);
                    CLEAR(AutomationUtilityL);
                    IF JobQueueEntry."JQ Posted FND" THEN BEGIN
                        JobQueueLogEntry."JQ Posted FND" := JobQueueEntry."JQ Posted FND";
                        JobQueueLogEntry."JQ Logistics Mail Sent FND" := JobQueueEntry."JQ Logistics Mail Sent FND"; // BC Upgrade SHUKLP03 << OTC008
                        SalesHeaderL.SETRANGE("Document Type", JobQueueEntry."Document Type FND");
                        SalesHeaderL.SETRANGE("No.", JobQueueEntry."Document No. FND");
                        IF SalesHeaderL.ISEMPTY THEN BEGIN
                            IF (JobQueueLogEntry."Posted Document No. FND" = '') AND JobQueueEntry."JQ Posted FND" THEN
                                JobQueueLogEntry."Posted Document No. FND" :=
                                  AutomationUtilityL.GetPostedDocumentNoForUpdate(JobQueueEntry."Document Type FND",
                                                                                  JobQueueEntry."Document No. FND"
                                                                                  );
                        END;
                    END;
                END;
            END;
        END;
        //HEI.02<<
        //HEI.02<<
        JobQueueLogEntry."Job Queue Category Code" := JobQueueEntry."Job Queue Category Code";
        //JobQueueLogEntry."Processed by User ID" := USERID;//Bc Upgrade YADAVM09<<
        JobQueueLogEntry."User ID" := USERID;//Bc Upgrade YADAVM09<<
        //HEI.03 //HEI.04
    end;

    //BC UPGRADE KUMARR78 >> Adding SEPA DD-Fill Export Buffer Codeunit Event.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"SEPA DD-Fill Export Buffer", OnBeforeInsertPaymentExportData, '', false, false)]
    local procedure OnBeforeInsertPaymentExportData(var PaymentExportData: Record "Payment Export Data"; var TempDirectDebitCollectionEntry: Record "Direct Debit Collection Entry" temporary)
    var
        CompanyInformation: Record "Company Information";
        lCLE: Record "Cust. Ledger Entry";
        lCLETMP: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        i: Integer;
        lValueToExport: Text;
    begin
        Customer.Get(TempDirectDebitCollectionEntry."Customer No.");

        //HEI.01>>
        //"End-to-End ID" := TempDirectDebitCollectionEntry."Transaction ID";
        if (CompanyInformation."Enable French Localization FND" = false) then
            PaymentExportData."End-to-End ID" := TempDirectDebitCollectionEntry."Transaction ID";
        if CompanyInformation."Enable French Localization FND" then
            //HEI.02>>
            //"End-to-End ID":= TempDirectDebitCollectionEntry."Applies-to Entry Document No.";
            lValueToExport := '';
        lCLETMP.DeleteAll();
        lCLE.Reset();
        i := 1;
        lCLE.SetCurrentKey("Customer No.", Open, Positive);
        lCLE.SetRange("Customer No.", Customer."No.");
        lCLE.SetRange(Open, true);
        lCLE.SetRange("Applies-to ID", PaymentExportData."Message ID");
        //lCLE.SETFILTER("Document Type",'%1|%2',lCLE."Document Type"::Invoice,lCLE."Document Type"::"Credit Memo");
        if lCLE.FindFirst() then
            repeat
                lCLETMP.TransferFields(lCLE);
                if lCLETMP.Insert() then;
            until lCLE.Next() = 0;
        lCLETMP.Reset();
        if lCLETMP.FindFirst() then
            repeat
                if i < 3 then
                    lValueToExport += lCLETMP."Document No." + '; ';
                i += 1;
            until lCLETMP.Next() = 0;
        PaymentExportData."End-to-End ID" := CopyStr(lValueToExport, 1, 50);
        //HEI.02<<
        //HEI.03>>
        if PaymentExportData."End-to-End ID" = '' then
            PaymentExportData."End-to-End ID" := TempDirectDebitCollectionEntry."Transaction ID";
        //HEI.03<<
        //HEI.01<<
    end;
    //BC UPGRADE KUMARR78 << Adding SEPA DD-Fill Export Buffer Codeunit Event.

    //Bc Upgrade YADAVM09 Codeunit 448 Job Queue Dispatcher<<


    //BC SHARMP16-- GAPFitchanges 11March26<<
    /*[EventSubscriber(ObjectType::Page, Page::"Reverse Transaction Entries", OnBeforePost, '', false, false)]
    local procedure OnBeforePost(var TempReversalEntry: Record "Reversal Entry" temporary)
    var
        HeinekenGlobal: Codeunit "Heineken Global";
        ConfirmDialog: Page ConfirmDialog;
        GLEntry: Record "G/L Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        ReversalEntry: Record "Reversal Entry";
        Text50000: Label 'You cannot reverse G/L entry No. %1 because the entry has already been applied. Undo the application for the G/L entry No. %1 first.';
        Text50001: Label 'You cannot reverse Vendor Ledger Entry No. %1 because the entry has already been applied. Undo the application for the Vendor Ledger Entry No. %1 first.';
        Text50002: Label 'You cannot reverse Cust. Ledger Entry No. %1 because the entry has already been applied. Undo the application for the Cust. Ledger Entry No. %1 first.';
    begin
        //HEI.03<<
        GLEntry.RESET;
        GLEntry.SETCURRENTKEY("Transaction No.");
        GLEntry.SETRANGE("Transaction No.", TempReversalEntry."Transaction No.");
        IF GLEntry.FINDSET THEN
            REPEAT
                IF ((GLEntry."Remaining Amount" <> 0) AND (GLEntry."Remaining Amount" <> GLEntry.Amount)) OR ((GLEntry."Remaining Amount" = 0) AND (NOT GLEntry.Open)) THEN
                    ERROR(Text50000, GLEntry."Entry No.");
            UNTIL GLEntry.NEXT = 0;
        //HEI.03>>

        //HEI.04<<
        VendorLedgerEntry.RESET;
        VendorLedgerEntry.SETCURRENTKEY("Transaction No.");
        VendorLedgerEntry.SETRANGE("Transaction No.", TempReversalEntry."Transaction No.");
        IF VendorLedgerEntry.FINDSET THEN
            REPEAT
                IF ((VendorLedgerEntry."Remaining Amount" <> 0) AND (VendorLedgerEntry."Remaining Amount" <> VendorLedgerEntry.Amount)) OR ((VendorLedgerEntry."Remaining Amount" = 0) AND (NOT VendorLedgerEntry.Open)) THEN
                    ERROR(Text50001, VendorLedgerEntry."Entry No.");
            UNTIL VendorLedgerEntry.NEXT = 0;

        CustLedgerEntry.RESET;
        CustLedgerEntry.SETCURRENTKEY("Transaction No.");
        CustLedgerEntry.SETRANGE("Transaction No.", TempReversalEntry."Transaction No.");
        IF CustLedgerEntry.FINDSET THEN
            REPEAT
                IF ((CustLedgerEntry."Remaining Amount" <> 0) AND (CustLedgerEntry."Remaining Amount" <> CustLedgerEntry.Amount)) OR ((CustLedgerEntry."Remaining Amount" = 0) AND (NOT CustLedgerEntry.Open)) THEN
                    ERROR(Text50002, CustLedgerEntry."Entry No.");
            UNTIL CustLedgerEntry.NEXT = 0;
        //HEI.04>>
    end;*/ //RD03
    //BC SHARMP16-- GAPFitchanges 11March26>>

    // BC UPGRADE KAIRAR01 codeunit 7150 "Update Item Analysis View" >>
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Update Item Analysis View", OnAfterInitializeTempItemAnalysisViewEntry, '', false, false)]
    // local procedure OnAfterInitializeTempItemAnalysisViewEntry(var TempItemAnalysisViewEntry: Record "Item Analysis View Entry" temporary; ItemAnalysisView: Record "Item Analysis View"; var ItemAnalysisViewSource: Query "Item Analysis View Source"; var ValueEntry: Record "Value Entry"; var IsHandled: Boolean)
    // var
    //     ItemLedgerEntry: Record "Item Ledger Entry";
    //     Lrec_itemanalview: Record "Item Analysis View";
    //     lrec_defdim: Record "Default Dimension";
    //     lrec_cust: Record Customer;
    //     Lrec_Gbpg: Record "Gen. Business Posting Group";
    //     Lrec_item: Record Item;
    // begin
    //     //HEI.05
    //     IF ItemLedgerEntry.GET(ItemAnalysisViewSource.ItemLedgerEntryNo) THEN
    //         TempItemAnalysisViewEntry."Reporting Type" := ItemLedgerEntry."Reporting Type";
    //     //HEI.05
    //     //HEI.01>>
    //     //EDD072 WSA
    //     IF TempItemAnalysisViewEntry."Source Type" = TempItemAnalysisViewEntry."Source Type"::Customer THEN BEGIN
    //         IF Lrec_itemanalview.GET(TempItemAnalysisViewEntry."Analysis Area", TempItemAnalysisViewEntry."Analysis View Code") THEN BEGIN
    //             IF Lrec_itemanalview."Include Market Type" THEN
    //                 IF lrec_cust.GET(TempItemAnalysisViewEntry."Source No.") THEN
    //                     IF Lrec_Gbpg.GET(lrec_cust."Gen. Bus. Posting Group") THEN
    //                         TempItemAnalysisViewEntry."Add. Market type (BPG)" := Lrec_Gbpg."Market Type";

    //             IF Lrec_itemanalview."Include Addit. Cust. Dim.1" THEN
    //                 IF Lrec_itemanalview."Add. Cust. Dim.1 Code" <> '' THEN
    //                     IF lrec_defdim.GET(18, TempItemAnalysisViewEntry."Source No.", Lrec_itemanalview."Add. Cust. Dim.1 Code") THEN
    //                         IF lrec_defdim."Dimension Value Code" <> '' THEN
    //                             TempItemAnalysisViewEntry."Add. Cust. Dim.1" := lrec_defdim."Dimension Value Code";

    //             IF Lrec_itemanalview."Include Addit. Cust. Dim.2" THEN
    //                 IF Lrec_itemanalview."Add. Cust. Dim.2 Code" <> '' THEN BEGIN
    //                     IF lrec_defdim.GET(18, TempItemAnalysisViewEntry."Source No.", Lrec_itemanalview."Add. Cust. Dim.2 Code") THEN
    //                         IF lrec_defdim."Dimension Value Code" <> '' THEN
    //                             TempItemAnalysisViewEntry."Add. Cust. Dim.2" := lrec_defdim."Dimension Value Code";
    //                 END ELSE BEGIN
    //                     IF Lrec_itemanalview."Use Alt. Country Customer" AND lrec_cust.GET(TempItemAnalysisViewEntry."Source No.") THEN
    //                         TempItemAnalysisViewEntry."Add. Cust. Dim.2" := lrec_cust."Country/Region Code"
    //                 END;
    //         END;
    //     END;

    //     IF Lrec_itemanalview.GET(TempItemAnalysisViewEntry."Analysis Area", TempItemAnalysisViewEntry."Analysis View Code") THEN BEGIN
    //         IF Lrec_itemanalview."Include Product Type" THEN BEGIN
    //             IF Lrec_item.GET(TempItemAnalysisViewEntry."Item No.") THEN
    //                 TempItemAnalysisViewEntry."Add. Product type (PPG)" := Lrec_item."Product Group Code";
    //             //HEI.02>>
    //         END ELSE BEGIN
    //             IF Lrec_itemanalview."Product Type Dimension Code" <> '' THEN
    //                 IF lrec_defdim.GET(27, TempItemAnalysisViewEntry."Item No.", Lrec_itemanalview."Product Type Dimension Code") THEN
    //                     IF lrec_defdim."Dimension Value Code" <> '' THEN
    //                         TempItemAnalysisViewEntry."Add. Product type (PPG)" := lrec_defdim."Dimension Value Code";
    //         END;
    //         //HEI.02<<

    //         IF Lrec_itemanalview."Include Product Type R1" THEN BEGIN
    //             IF Lrec_item.GET(TempItemAnalysisViewEntry."Item No.") THEN
    //                 TempItemAnalysisViewEntry."Add. Product type R1 (PPG)" := Lrec_item."Product Group Code R1";
    //             //HEI.03>>
    //         END ELSE BEGIN
    //             IF Lrec_itemanalview."Product Type Dimension Code" <> '' THEN
    //                 IF lrec_defdim.GET(27, TempItemAnalysisViewEntry."Item No.", Lrec_itemanalview."Product Type Dimension Code") THEN
    //                     IF lrec_defdim."Dimension Value Code" <> '' THEN
    //                         TempItemAnalysisViewEntry."Add. Product type R1 (PPG)" := lrec_defdim."Dimension Value Code";
    //         END;
    //         //HEI.03<<

    //         IF Lrec_itemanalview."Line Extension Dimension Code" <> '' THEN
    //             IF lrec_defdim.GET(27, TempItemAnalysisViewEntry."Item No.", Lrec_itemanalview."Line Extension Dimension Code") THEN
    //                 IF lrec_defdim."Dimension Value Code" <> '' THEN
    //                     TempItemAnalysisViewEntry."Line Extension Dim. Value Code" := lrec_defdim."Dimension Value Code";
    //     END;
    //     //EDD072 WSA
    //     //HEI.01<<
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Update Item Analysis View", OnUpdateAnalysisViewBudgetEntryOnAfterInitTempItemAnalysisViewBudgEntry, '', false, false)]
    // local procedure OnUpdateAnalysisViewBudgetEntryOnAfterInitTempItemAnalysisViewBudgEntry(var ItemAnalysisViewBudgEntry: Record "Item Analysis View Budg. Entry"; var ItemBudgetEntry: Record "Item Budget Entry"; var ItemAnalysisView: Record "Item Analysis View")
    // var
    //     Lrec_itemanalview: Record "Item Analysis View";
    //     lrec_cust: Record Customer;
    //     Lrec_Gbpg: Record "Gen. Business Posting Group";
    //     lrec_defdim: Record "Default Dimension";
    //     Lrec_item: Record Item;
    // begin
    //     //HEI.01>>
    //     //EDD072 WSA
    //     IF ItemAnalysisViewBudgEntry."Source Type" = ItemAnalysisViewBudgEntry."Source Type"::Customer THEN BEGIN
    //         IF Lrec_itemanalview.GET(ItemAnalysisViewBudgEntry."Analysis Area", ItemAnalysisViewBudgEntry."Analysis View Code") THEN BEGIN
    //             IF Lrec_itemanalview."Include Market Type" THEN
    //                 IF lrec_cust.GET(ItemAnalysisViewBudgEntry."Source No.") THEN
    //                     IF Lrec_Gbpg.GET(lrec_cust."Gen. Bus. Posting Group") THEN
    //                         ItemAnalysisViewBudgEntry."Add. Market type (BPG)" := Lrec_Gbpg."Market Type";

    //             IF Lrec_itemanalview."Include Addit. Cust. Dim.1" THEN
    //                 IF Lrec_itemanalview."Add. Cust. Dim.1 Code" <> '' THEN
    //                     IF lrec_defdim.GET(18, ItemAnalysisViewBudgEntry."Source No.", Lrec_itemanalview."Add. Cust. Dim.1 Code") THEN
    //                         IF lrec_defdim."Dimension Value Code" <> '' THEN
    //                             ItemAnalysisViewBudgEntry."Add. Cust. Dim.1" := lrec_defdim."Dimension Value Code";

    //             IF Lrec_itemanalview."Include Addit. Cust. Dim.2" THEN
    //                 IF Lrec_itemanalview."Add. Cust. Dim.2 Code" <> '' THEN BEGIN
    //                     IF lrec_defdim.GET(18, ItemAnalysisViewBudgEntry."Source No.", Lrec_itemanalview."Add. Cust. Dim.2 Code") THEN
    //                         IF lrec_defdim."Dimension Value Code" <> '' THEN
    //                             ItemAnalysisViewBudgEntry."Add. Cust. Dim.2" := lrec_defdim."Dimension Value Code";
    //                 END ELSE BEGIN
    //                     IF Lrec_itemanalview."Use Alt. Country Customer" AND lrec_cust.GET(ItemAnalysisViewBudgEntry."Source No.") THEN
    //                         ItemAnalysisViewBudgEntry."Add. Cust. Dim.2" := lrec_cust."Country/Region Code"
    //                 END;
    //         END;
    //     END;

    //     IF Lrec_itemanalview.GET(ItemAnalysisViewBudgEntry."Analysis Area", ItemAnalysisViewBudgEntry."Analysis View Code") THEN BEGIN
    //         IF Lrec_itemanalview."Include Product Type" THEN BEGIN
    //             IF Lrec_item.GET(ItemAnalysisViewBudgEntry."Item No.") THEN;
    //             // TempItemAnalysisViewEntry."Add. Product type (PPG)" := Lrec_item."Product Group Code";
    //             //HEI.02>>
    //         END ELSE BEGIN
    //             IF Lrec_itemanalview."Product Type Dimension Code" <> '' THEN
    //                 IF lrec_defdim.GET(27, ItemAnalysisViewBudgEntry."Item No.", Lrec_itemanalview."Product Type Dimension Code") THEN
    //                     IF lrec_defdim."Dimension Value Code" <> '' THEN
    //                         ItemAnalysisViewBudgEntry."Add. Product type (PPG)" := lrec_defdim."Dimension Value Code";
    //         END;
    //         //HEI.02<<

    //         IF Lrec_itemanalview."Include Product Type R1" THEN BEGIN
    //             IF Lrec_item.GET(ItemAnalysisViewBudgEntry."Item No.") THEN
    //                 ItemAnalysisViewBudgEntry."Add. Product type R1 (PPG)" := Lrec_item."Product Group Code R1";
    //             //HEI.03>>
    //         END ELSE BEGIN
    //             IF Lrec_itemanalview."Product Type Dimension Code" <> '' THEN
    //                 IF lrec_defdim.GET(27, ItemAnalysisViewBudgEntry."Item No.", Lrec_itemanalview."Product Type Dimension Code") THEN
    //                     IF lrec_defdim."Dimension Value Code" <> '' THEN
    //                         ItemAnalysisViewBudgEntry."Add. Product type R1 (PPG)" := lrec_defdim."Dimension Value Code";
    //         END;
    //         //HEI.03<<

    //         IF Lrec_itemanalview."Line Extension Dimension Code" <> '' THEN
    //             IF lrec_defdim.GET(27, ItemAnalysisViewBudgEntry."Item No.", Lrec_itemanalview."Line Extension Dimension Code") THEN
    //                 IF lrec_defdim."Dimension Value Code" <> '' THEN
    //                     ItemAnalysisViewBudgEntry."Line Extension Dim. Value Code" := lrec_defdim."Dimension Value Code";
    //     END;
    //     //EDD072 WSA
    //     //HEI.01<<
    // end;
    // // BC UPGRADE KAIRAR01 codeunit 7150 "Update Item Analysis View" <<//Bc Upgrade YADAVM09 Bloced as codeunit is redesign due to some missing events.


    //BC UPGRADE PATHAA02- 09.03.26 CU99000773-Calcualte Prod. Order; FDD-LineSpeed, LineSpeedUoM, Showon ProdOrder DIT code is moved>>
    //HEI.02>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Prod. Order", OnAfterTransferRoutingLine, '', false, false)]
    local procedure CalculateProdOrder_OnAfterTransferRoutingLine(var ProdOrderLine: Record "Prod. Order Line"; var RoutingLine: Record "Routing Line"; var ProdOrderRoutingLine: Record "Prod. Order Routing Line")
    begin
        ProdOrderRoutingLine."Show on Production Order FND" := RoutingLine."Show on Production Order FND";
        ProdOrderRoutingLine."Line Speed FND" := RoutingLine."Line Speed FND";
    end;
    //HEI.02<< 
    //BC UPGRADE PATHAA02- 09.03.26 CU99000773-Calcualte Prod. Order; FDD-LineSpeed, LineSpeedUoM, Showon ProdOrder DIT code is moved<<



    // //BC UPGRADE PATHAA02-10.03.26 #"Production Jnl Flushing" functionality is added >>
    // //T83-NRQ#51782 Added function UpdateConsumptionLine() called from "Output Quantity"OnValidate-->(Quantity-OnAfterValidateEvent in BC)>>
    // //HEI.48>>
    // [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterValidateEvent', 'Quantity', false, false)]
    // local procedure ItemJournalLine_OnAfterValidateQuantity(
    //     var Rec: Record "Item Journal Line";
    //     var xRec: Record "Item Journal Line";
    //     CurrFieldNo: Integer)
    // begin
    //     if Rec."Entry Type" = Rec."Entry Type"::Output then begin
    //         if Rec.Quantity <> xRec.Quantity then
    //             UpdateConsumptionLine(Rec);
    //     end;
    // end;

    // local procedure UpdateConsumptionLine(var ItemJournalLine: Record "Item Journal Line")
    // var
    //     ConsumptionjnlLine: Record "Item Journal Line";
    //     OutputjnlLine: Record "Item Journal Line";
    //     ReservationEntry: Record "Reservation Entry";
    //     ItemJnlLineReserve: Codeunit "Item Jnl. Line-Reserve";
    //     ConsumptionQty: Decimal;
    //     CostCalculationManagement: Codeunit "Cost Calculation Management";
    //     ProdOrderComponent: Record "Prod. Order Component";
    //     ProdOrderLine: Record "Prod. Order Line";
    //     Item: Record "Item";
    //     UomMgt: Codeunit "Unit of Measure Management";
    //     RecItemUOM: Record "Item Unit of Measure";
    // //MfgCostCalculationManagement: Codeunit "Mfg. Cost Calculation Mgt."; //BC UPGRADE PATHAA02
    // begin
    //     //<<DITW110.00.12A HBA 07/06/2018 NRQ#51782
    //     OutputjnlLine.RESET;
    //     //OutputjnlLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Document No.", "Entry Type", "Flushing Method", "Item Charge Type");//BC UPGRADE-ItemChargeType is DIT-removed
    //     OutputjnlLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Document No.", "Entry Type", "Flushing Method");
    //     OutputjnlLine.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
    //     OutputjnlLine.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
    //     OutputjnlLine.SETRANGE("Document No.", ItemJournalLine."Document No.");
    //     OutputjnlLine.SETRANGE("Entry Type", OutputjnlLine."Entry Type"::Output);
    //     //OutputjnlLine.SETRANGE("Flushing Method", OutputjnlLine."Flushing Method"::Manual);//BC UPGRADE PATHAA02-Manual is marked for removal.
    //     OutputjnlLine.SETRANGE("Flushing Method", OutputjnlLine."Flushing Method"::"Pick + Manual"); //BC UPGRADE PATHAA02
    //     //OutputjnlLine.SETRANGE("Has Item Charge", OutputjnlLine."Has Item Charge"); //BC UPGRADE PATHAA02-DIT, TBD
    //     IF OutputjnlLine.FINDLAST THEN BEGIN
    //         IF OutputjnlLine."Line No." = ItemJournalLine."Line No." THEN BEGIN
    //             ConsumptionjnlLine.RESET;
    //             ConsumptionjnlLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Document No.", "Entry Type", "Flushing Method", "Production jnl. flushing");
    //             ConsumptionjnlLine.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
    //             ConsumptionjnlLine.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
    //             ConsumptionjnlLine.SETRANGE("Document No.", ItemJournalLine."Document No.");
    //             ConsumptionjnlLine.SETRANGE("Entry Type", ConsumptionjnlLine."Entry Type"::Consumption);
    //             //ConsumptionjnlLine.SETRANGE("Flushing Method", ConsumptionjnlLine."Flushing Method"::Manual);//BC UPGRADE PATHAA02-Manual is marked for removal.
    //             ConsumptionjnlLine.SETRANGE("Flushing Method", ConsumptionjnlLine."Flushing Method"::"Pick + Manual"); //BC UPGRADE PATHAA02
    //             ConsumptionjnlLine.SETRANGE("Production jnl. flushing", TRUE);
    //             IF ConsumptionjnlLine.FINDSET THEN
    //                 REPEAT
    //                     CLEAR(ConsumptionQty);
    //                     ProdOrderComponent.RESET;
    //                     ProdOrderComponent.SetFilterByReleasedOrderNo(ItemJournalLine."Order No.");
    //                     ProdOrderComponent.SETRANGE("Item No.", ConsumptionjnlLine."Item No.");
    //                     ProdOrderLine.SetFilterByReleasedOrderNo(ItemJournalLine."Order No.");
    //                     ProdOrderLine.SETRANGE("Item No.", ItemJournalLine."Item No.");
    //                     Item.RESET;
    //                     Item.GET(ItemJournalLine."Item No.");
    //                     IF ProdOrderLine.FINDFIRST THEN;
    //                     IF ProdOrderComponent.FINDFIRST THEN BEGIN
    //                         // ConsumptionQty := CostCalculationManagement.CalcQtyAdjdForBOMScrap("Output Quantity (Base)" * (ProdOrderComponent."Quantity (Base)" / ProdOrderLine."Qty. per Unit of Measure"), ProdOrderComponent."Scrap %"); //BC UPGRADE PATHAA02-O/P quantity base is not in BC
    //                         //ConsumptionQty := CostCalculationManagement.CalcQtyAdjdForBOMScrap(ItemJournalLine."Quantity (Base)" * (ProdOrderComponent."Quantity (Base)" / ProdOrderLine."Qty. per Unit of Measure"), ProdOrderComponent."Scrap %"); //BC UPGRADE PATHAA02-CalcQtyAdjdForBOMScrap is marked for removal
    //                         ConsumptionQty := CostCalculationManagement.CalcQtyAdjdForBOMScrap(ItemJournalLine."Quantity (Base)" * (ProdOrderComponent."Quantity (Base)" / ProdOrderLine."Qty. per Unit of Measure"), ProdOrderComponent."Scrap %"); //BC UPGRADE PATHAA02

    //                         IF RecItemUOM.GET(ConsumptionjnlLine."Item No.", ConsumptionjnlLine."Unit of Measure Code") THEN
    //                             ConsumptionQty := UomMgt.CalcQtyFromBase(ConsumptionQty, RecItemUOM."Qty. per Unit of Measure");

    //                         ConsumptionjnlLine.VALIDATE(Quantity, ConsumptionQty);
    //                         IF ConsumptionQty <> 0 THEN
    //                             IF Item."Rounding Precision" > 0 THEN
    //                                 ConsumptionjnlLine.VALIDATE(Quantity, ROUND(ConsumptionQty, Item."Rounding Precision", '>'))
    //                             ELSE
    //                                 ConsumptionjnlLine.VALIDATE(Quantity, ROUND(ConsumptionQty, 0.00001));
    //                         ConsumptionjnlLine.MODIFY;
    //                     END;
    //                 UNTIL ConsumptionjnlLine.NEXT = 0;
    //         END;
    //     END;
    // end;
    // //HEI.48<<
    // //BC UPGRADE PATHAA02-10.03.26 #"Production Jnl Flushing" functionality is added <<


    //BC UPGRADE PATHAA02-13.03.26 #InventoryUOM Functionality is added; Table 27(Gen-->TableExt50033) Event subscribed for Base Unit of Measure field of Item table>>
    //HEI.28>>

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Base Unit of Measure', false, false)]
    local procedure ItemBaseUOMOnAfterValidate(var Rec: Record Item; var xRec: Record Item)
    begin
        if Rec."Base Unit of Measure" <> xRec."Base Unit of Measure" then begin
            // Rec."Production Unit of Measure" := Rec."Base Unit of Measure";
            Rec."Inventory Unit of Measure FND" := Rec."Base Unit of Measure";
        end;
    end;
    //HEI.28<<
    //BC UPGRADE PATHAA02-13.03.26 #InventoryUOM Functionality is added; Table 27(Gen-->TableExt50033) Event subscribed for Base Unit of Measure field of Item table<<


    //BC UPGRADE PATHAA02-13.03.26; T5741-Transfer Line #InventoryUOM Functionality is added; Event subscribed for "Unit of Measure Code" field of Transfer Line table>>

    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", OnAfterAssignItemValues, '', false, false)]
    local procedure TransferLine_OnAfterAssignItemValues(var TransferLine: Record "Transfer Line"; Item: Record Item; TransferHeader: Record "Transfer Header")
    begin
        if Item."Inventory Unit of Measure FND" <> '' then
            TransferLine.Validate("Unit of Measure Code", Item."Inventory Unit of Measure FND");
    end;
    //BC UPGRADE PATHAA02-13.03.26;T5741-TransferLine #InventoryUOM Functionality is added; Event subscribed for "Unit of Measure Code" field of Transfer Line table<<


    //BC UPGRADE PATHAA02-13.03.26;T5767-Warehouse Activity Line #InventoryUOM Functionality is added; Event subscribed for Unit of Measure Code field of Warehouse Activity Line table>>

    [EventSubscriber(ObjectType::Table, Database::"Warehouse Activity Line", 'OnAfterValidateEvent', 'Unit of Measure Code', false, false)]
    local procedure HEI02_OnAfterValidateUOM(var Rec: Record "Warehouse Activity Line"; var xRec: Record "Warehouse Activity Line"; CurrFieldNo: Integer)
    var
        Item: Record Item;
    begin
        if Rec."Item No." = '' then
            exit;

        Item.Get(Rec."Item No.");

        //if (Item."Production Unit of Measure" <> '') and (Rec."Activity Type" = Rec."Activity Type"::Movement) then //YASH FDD
        if Rec."Unit of Measure Code" <> Item."Inventory Unit of Measure FND" then
            Rec.Validate("Unit of Measure Code", Item."Inventory Unit of Measure FND");
    end;
    //BC UPGRADE PATHAA02-13.03.26;T5767-Warehouse Activity Line #InventoryUOM Functionality is added; Event subscribed for Unit of Measure Code field of Warehouse Activity Line table<<

    //BC UPGRADE KUMARR78 >> Adding Check Managment Event and Functions

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CheckManagement, OnBeforeVoidCheck, '', false, false)]

    local procedure OnBeforeVoidCheck(var GenJnlLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    var
        Currency: Record Currency;
        CheckLedgEntry2: Record "Check Ledger Entry";
        CheckAmountLCY: Decimal;
    begin
        GenJnlLine.TestField("Bank Payment Type", GenJnlLine2."Bank Payment Type"::"Computer Check");
        GenJnlLine.TestField("Check Printed", true);
        GenJnlLine.TestField("Document No.");
        if GenJnlLine."Bal. Account No." = '' then begin
            GenJnlLine."Check Printed" := false;
            GenJnlLine.Delete(true);
        end;
        CheckAmountLCY := GenJnlLine."Amount (LCY)";

        if GenJnlLine."Currency Code" <> '' then
            Currency.Get(GenJnlLine."Currency Code");

        GenJnlLine2.Reset();
        GenJnlLine2.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
        GenJnlLine2.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
        GenJnlLine2.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
        GenJnlLine2.SetRange("Posting Date", GenJnlLine."Posting Date");
        GenJnlLine2.SetRange("Document No.", GenJnlLine."Document No.");
        if GenJnlLine2.Find('-') then
            repeat
                if (GenJnlLine2."Line No." > GenJnlLine."Line No.") and
                   (CheckAmountLCY = -GenJnlLine2."Amount (LCY)") and
                   (GenJnlLine2."Currency Code" = '') and (GenJnlLine."Currency Code" <> '') and
                   (GenJnlLine2."Account Type" = GenJnlLine2."Account Type"::"G/L Account") and
                   (GenJnlLine2."Account No." in
                    [Currency."Conv. LCY Rndg. Debit Acc.", Currency."Conv. LCY Rndg. Credit Acc."]) and
                   (GenJnlLine2."Bal. Account No." = '') and not GenJnlLine2."Check Printed"
                then
                    GenJnlLine2.Delete() // Rounding correction line
                else begin
                    if GenJnlLine."Bal. Account No." = '' then begin
                        if GenJnlLine2."Account No." = '' then begin
                            GenJnlLine2."Account Type" := GenJnlLine2."Account Type"::"Bank Account";
                            GenJnlLine2."Account No." := GenJnlLine."Account No.";
                        end else begin
                            GenJnlLine2."Bal. Account Type" := GenJnlLine2."Account Type"::"Bank Account";
                            GenJnlLine2."Bal. Account No." := GenJnlLine."Account No.";
                        end;
                        GenJnlLine2.Validate(Amount);
                        GenJnlLine2."Bank Payment Type" := GenJnlLine."Bank Payment Type";
                    end;
                    if GenJnlLine."Bal. Account No." <> '' then
                        // GenJnlLine2."Document No." := ''; HEI.02 commented
                        GenJnlLine2."HNK Check No. FND" := ''; //HEI.02
                    GenJnlLine2."Document Date" := 0D;
                    GenJnlLine2."Check Printed" := false;
                    GenJnlLine2.UpdateSource();
                    // OnBeforeVoidCheckGenJnlLine2Modify(GenJnlLine2, GenJnlLine);
                    GenJnlLine2.Modify();
                    // OnVoidCheckOnAfterGenJnlLine2Modify(GenJnlLine2, GenJnlLine);
                end;
            until GenJnlLine2.Next() = 0;
        CheckLedgEntry2.Reset();
        CheckLedgEntry2.SetCurrentKey("Bank Account No.", "Entry Status", "Check No.");
        if GenJnlLine.Amount <= 0 then
            //HEI.01
  IF GenJnlLine."HNK Bank Account FND" = '' THEN
                CheckLedgEntry2.SETRANGE("Bank Account No.", GenJnlLine."Account No.")
            ELSE
                CheckLedgEntry2.SETRANGE("Bank Account No.", GenJnlLine."HNK Bank Account FND")
        ELSE
            IF GenJnlLine."HNK Bank Account FND" = '' THEN
                CheckLedgEntry2.SETRANGE("Bank Account No.", GenJnlLine."Bal. Account No.")
            ELSE
                CheckLedgEntry2.SETRANGE("Bank Account No.", GenJnlLine."HNK Bank Account FND");
        CheckLedgEntry2.SETRANGE("Entry Status", CheckLedgEntry2."Entry Status"::Printed);

        IF GenJnlLine."HNK Bank Account FND" = '' THEN
            CheckLedgEntry2.SETRANGE("Check No.", GenJnlLine."Document No.")

        ELSE
            CheckLedgEntry2.SETRANGE("Check No.", GenJnlLine."HNK Check No. FND");

        //HEI.01

        // OnVoidCheckOnAfterCheckLedgEntry2SetFilters(CheckLedgEntry2, GenJnlLine);

        CheckLedgEntry2.FindFirst();
        CheckLedgEntry2."Original Entry Status" := CheckLedgEntry2."Entry Status";
        CheckLedgEntry2."Entry Status" := CheckLedgEntry2."Entry Status"::Voided;
        CheckLedgEntry2."Positive Pay Exported" := false;
        CheckLedgEntry2.Open := false;
        CheckLedgEntry2.Modify();
        IsHandled := true;
        // OnAfterVoidCheck(GenJnlLine, CheckLedgEntry2);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CheckManagement, OnBeforeFinancialVoidCheck, '', false, false)]
    local procedure OnBeforeFinancialVoidCheck(var CheckLedgerEntry: Record "Check Ledger Entry"; var IsHandled: Boolean)
    var
        ConfirmFinancialVoid: Page "Confirm Financial Void";
        AmountToVoid: Decimal;
        CheckAmountLCY: Decimal;
        BalanceAmountLCY: Decimal;
    begin
        FinancialVoidCheckPreValidation(CheckLedgerEntry);
        Clear(ConfirmFinancialVoid);
        IsHandled := false;
        // OnFinancialVoidCheckOnBeforeConfirmFinancialVoid(CheckLedgerEntry, IsHandled);
        if not IsHandled then begin
            ConfirmFinancialVoid.SetCheckLedgerEntry(CheckLedgerEntry);
            if ConfirmFinancialVoid.RunModal() <> ACTION::Yes then
                exit;
        end;

        AmountToVoid := CalcAmountToVoid(CheckLedgerEntry);

        InitGenJnlLine(
          GenJnlLine2, CheckLedgerEntry."Document Type", CheckLedgerEntry."Document No.", ConfirmFinancialVoid.GetVoidDate(),
          GenJnlLine2."Account Type"::"Bank Account", CheckLedgerEntry."Bank Account No.",
          StrSubstNo(VoidingCheckMsg, CheckLedgerEntry."Check No."));
        GenJnlLine2.Validate(Amount, AmountToVoid);
        CheckAmountLCY := GenJnlLine2."Amount (LCY)";
        BalanceAmountLCY := 0;
        GenJnlLine2."Shortcut Dimension 1 Code" := BankAccLedgEntry2."Global Dimension 1 Code";
        GenJnlLine2."Shortcut Dimension 2 Code" := BankAccLedgEntry2."Global Dimension 2 Code";
        GenJnlLine2."Dimension Set ID" := BankAccLedgEntry2."Dimension Set ID";
        GenJnlLine2."Allow Zero-Amount Posting" := true;
        GenJnlLine2."Journal Template Name" := BankAccLedgEntry2."Journal Templ. Name";
        GenJnlLine2."Journal Batch Name" := BankAccLedgEntry2."Journal Batch Name";
        // OnFinancialVoidCheckOnBeforePostVoidCheckLine(GenJnlLine2, CheckLedgerEntry, BankAccLedgEntry2);
        GenJnlPostLine.RunWithCheck(GenJnlLine2);
        // OnFinancialVoidCheckOnAfterPostVoidCheckLine(GenJnlLine2, GenJnlPostLine);
        // Mark newly posted entry as cleared for bank reconciliation purposes.
        if ConfirmFinancialVoid.GetVoidDate() = CheckLedgerEntry."Check Date" then
            ClearBankLedgerEntry(BankAccLedgEntry3);
        InitGenJnlLine(
          GenJnlLine2, CheckLedgerEntry."Document Type", CheckLedgerEntry."Document No.", ConfirmFinancialVoid.GetVoidDate(),
          CheckLedgerEntry."Bal. Account Type", CheckLedgerEntry."Bal. Account No.",
          StrSubstNo(VoidingCheckMsg, CheckLedgerEntry."Check No."));
        GenJnlLine2.Validate("Currency Code", BankAcc."Currency Code");
        GenJnlLine2."Allow Zero-Amount Posting" := true;
        // OnFinancialVoidCheckOnBeforeCheckBalAccountType(GenJnlLine2, CheckLedgerEntry, BankAccLedgEntry3);
        case CheckLedgerEntry."Bal. Account Type" of
            CheckLedgerEntry."Bal. Account Type"::"G/L Account":
                FinancialVoidPostGLAccount(GenJnlLine2, BankAccLedgEntry2, CheckLedgerEntry, BalanceAmountLCY);
            CheckLedgerEntry."Bal. Account Type"::Customer:
                begin
                    if ConfirmFinancialVoid.GetVoidType() = 0 then   // Unapply entry
                        if UnApplyCustInvoices(CheckLedgerEntry, ConfirmFinancialVoid.GetVoidDate()) then
                            GenJnlLine2."Applies-to ID" := CheckLedgerEntry."Document No.";
                    CustLedgEntry.SetCurrentKey("Transaction No.");
                    CustLedgEntry.SetRange("Transaction No.", BankAccLedgEntry2."Transaction No.");
                    CustLedgEntry.SetRange("Document No.", BankAccLedgEntry2."Document No.");
                    CustLedgEntry.SetRange("Posting Date", BankAccLedgEntry2."Posting Date");
                    if CustLedgEntry.FindSet() then
                        repeat
                            // OnFinancialVoidCheckOnBeforePostCust(GenJnlLine2, CustLedgEntry, BalanceAmountLCY);
                            CustLedgEntry.CalcFields("Original Amount");
                            SetGenJnlLine(
                              GenJnlLine2, -CustLedgEntry."Original Amount", CustLedgEntry."Currency Code", CheckLedgerEntry."Document No.",
                              CustLedgEntry."Global Dimension 1 Code", CustLedgEntry."Global Dimension 2 Code", CustLedgEntry."Dimension Set ID");
                            BalanceAmountLCY := BalanceAmountLCY + GenJnlLine2."Amount (LCY)";
                            GenJnlLine2."Journal Template Name" := BankAccLedgEntry2."Journal Templ. Name";
                            GenJnlLine2."Journal Batch Name" := BankAccLedgEntry2."Journal Batch Name";
                            // OnFinancialVoidCheckOnBeforePostBalAccLine(GenJnlLine2, CheckLedgerEntry);
                            GenJnlPostLine.RunWithCheck(GenJnlLine2);
                        // OnFinancialVoidCheckOnAfterPostBalAccLine(GenJnlLine2, CheckLedgerEntry, GenJnlPostLine);
                        until CustLedgEntry.Next() = 0;
                end;
            CheckLedgerEntry."Bal. Account Type"::Vendor:
                begin
                    if ConfirmFinancialVoid.GetVoidType() = 0 then // Unapply entry
                        if UnApplyVendInvoices(CheckLedgerEntry, ConfirmFinancialVoid.GetVoidDate()) then
                            GenJnlLine2."Applies-to ID" := CheckLedgerEntry."Document No.";
                    VendorLedgEntry.SetCurrentKey("Transaction No.");
                    VendorLedgEntry.SetRange("Transaction No.", BankAccLedgEntry2."Transaction No.");
                    VendorLedgEntry.SetRange("Document No.", BankAccLedgEntry2."Document No.");
                    VendorLedgEntry.SetRange("Posting Date", BankAccLedgEntry2."Posting Date");
                    // OnFinancialVoidCheckOnAfterVendorLedgEntrySetFilters(VendorLedgEntry, BankAccLedgEntry2);
                    if VendorLedgEntry.FindSet() then
                        repeat
                            // OnFinancialVoidCheckOnBeforePostVend(GenJnlLine2, VendorLedgEntry, BalanceAmountLCY);
                            VendorLedgEntry.CalcFields("Original Amount");
                            SetGenJnlLine(
                              GenJnlLine2, -VendorLedgEntry."Original Amount", VendorLedgEntry."Currency Code", CheckLedgerEntry."Document No.",
                              VendorLedgEntry."Global Dimension 1 Code", VendorLedgEntry."Global Dimension 2 Code", VendorLedgEntry."Dimension Set ID");
                            BalanceAmountLCY := BalanceAmountLCY + GenJnlLine2."Amount (LCY)";
                            GenJnlLine2."Journal Template Name" := BankAccLedgEntry2."Journal Templ. Name";
                            GenJnlLine2."Journal Batch Name" := BankAccLedgEntry2."Journal Batch Name";
                            if GenJnlLine2."Posting Group" <> VendorLedgEntry."Vendor Posting Group" then
                                GenJnlLine2."Posting Group" := VendorLedgEntry."Vendor Posting Group";
                            // OnFinancialVoidCheckOnBeforePostBalAccLine(GenJnlLine2, CheckLedgerEntry);
                            GenJnlPostLine.RunWithCheck(GenJnlLine2);
                        // OnFinancialVoidCheckOnAfterPostBalAccLine(GenJnlLine2, CheckLedgerEntry, GenJnlPostLine);
                        until VendorLedgEntry.Next() = 0;

                end;
            CheckLedgerEntry."Bal. Account Type"::"Bank Account":
                begin
                    BankAccLedgEntry3.SetCurrentKey("Transaction No.");
                    BankAccLedgEntry3.SetRange("Transaction No.", BankAccLedgEntry2."Transaction No.");
                    BankAccLedgEntry3.SetRange("Document No.", BankAccLedgEntry2."Document No.");
                    BankAccLedgEntry3.SetRange("Posting Date", BankAccLedgEntry2."Posting Date");
                    BankAccLedgEntry3.SetFilter("Entry No.", '<>%1', BankAccLedgEntry2."Entry No.");
                    if BankAccLedgEntry3.FindSet() then
                        repeat
                            // OnFinancialVoidCheckOnBeforePostBankAccount(GenJnlLine2, BankAccLedgEntry3);
                            GenJnlLine2.Validate(Amount, -BankAccLedgEntry3.Amount);
                            BalanceAmountLCY := BalanceAmountLCY + GenJnlLine2."Amount (LCY)";
                            GenJnlLine2."Shortcut Dimension 1 Code" := BankAccLedgEntry3."Global Dimension 1 Code";
                            GenJnlLine2."Shortcut Dimension 2 Code" := BankAccLedgEntry3."Global Dimension 2 Code";
                            GenJnlLine2."Dimension Set ID" := BankAccLedgEntry3."Dimension Set ID";
                            GenJnlLine2."Journal Template Name" := BankAccLedgEntry2."Journal Templ. Name";
                            GenJnlLine2."Journal Batch Name" := BankAccLedgEntry2."Journal Batch Name";
                            // OnFinancialVoidCheckOnBeforePostBalAccLine(GenJnlLine2, CheckLedgerEntry);
                            GenJnlPostLine.RunWithCheck(GenJnlLine2);
                        // OnFinancialVoidCheckOnAfterPostBalAccLine(GenJnlLine2, CheckLedgerEntry, GenJnlPostLine);
                        until BankAccLedgEntry3.Next() = 0;
                end;
            CheckLedgerEntry."Bal. Account Type"::"Fixed Asset":
                begin
                    FALedgEntry.SetCurrentKey("Transaction No.");
                    FALedgEntry.SetRange("Transaction No.", BankAccLedgEntry2."Transaction No.");
                    FALedgEntry.SetRange("Document No.", BankAccLedgEntry2."Document No.");
                    FALedgEntry.SetRange("Posting Date", BankAccLedgEntry2."Posting Date");
                    if FALedgEntry.FindSet() then
                        repeat
                            // OnFinancialVoidCheckOnBeforePostFixedAsset(GenJnlLine2, FALedgEntry);
                            GenJnlLine2.Validate(Amount, -FALedgEntry.Amount);
                            BalanceAmountLCY := BalanceAmountLCY + GenJnlLine2."Amount (LCY)";
                            GenJnlLine2."Shortcut Dimension 1 Code" := FALedgEntry."Global Dimension 1 Code";
                            GenJnlLine2."Shortcut Dimension 2 Code" := FALedgEntry."Global Dimension 2 Code";
                            GenJnlLine2."Dimension Set ID" := FALedgEntry."Dimension Set ID";
                            GenJnlLine2."Journal Template Name" := BankAccLedgEntry2."Journal Templ. Name";
                            GenJnlLine2."Journal Batch Name" := BankAccLedgEntry2."Journal Batch Name";
                            // OnFinancialVoidCheckOnBeforePostBalAccLine(GenJnlLine2, CheckLedgerEntry);
                            GenJnlPostLine.RunWithCheck(GenJnlLine2);
                        // OnFinancialVoidCheckOnAfterPostBalAccLine(GenJnlLine2, CheckLedgerEntry, GenJnlPostLine);
                        until FALedgEntry.Next() = 0;
                end;
            CheckLedgerEntry."Bal. Account Type"::Employee:
                begin
                    if ConfirmFinancialVoid.GetVoidType() = 0 then // Unapply entry
                        if UnApplyEmpInvoices(CheckLedgerEntry, ConfirmFinancialVoid.GetVoidDate()) then
                            GenJnlLine2."Applies-to ID" := CheckLedgerEntry."Document No.";
                    EmployeeLedgerEntry.SetCurrentKey("Transaction No.");
                    EmployeeLedgerEntry.SetRange("Transaction No.", BankAccLedgEntry2."Transaction No.");
                    EmployeeLedgerEntry.SetRange("Document No.", BankAccLedgEntry2."Document No.");
                    EmployeeLedgerEntry.SetRange("Posting Date", BankAccLedgEntry2."Posting Date");
                    if EmployeeLedgerEntry.FindSet() then
                        repeat
                            // OnFinancialVoidCheckOnBeforePostEmp(GenJnlLine2, EmployeeLedgerEntry);
                            EmployeeLedgerEntry.CalcFields("Original Amount");
                            SetGenJnlLine(
                              GenJnlLine2, -EmployeeLedgerEntry."Original Amount", EmployeeLedgerEntry."Currency Code", CheckLedgerEntry."Document No.",
                              EmployeeLedgerEntry."Global Dimension 1 Code", EmployeeLedgerEntry."Global Dimension 2 Code", EmployeeLedgerEntry."Dimension Set ID");
                            BalanceAmountLCY := BalanceAmountLCY + GenJnlLine2."Amount (LCY)";
                            // OnFinancialVoidCheckOnBeforePostBalAccLine(GenJnlLine2, CheckLedgerEntry);
                            GenJnlLine2."Journal Template Name" := BankAccLedgEntry2."Journal Templ. Name";
                            GenJnlLine2."Journal Batch Name" := BankAccLedgEntry2."Journal Batch Name";
                            GenJnlPostLine.RunWithCheck(GenJnlLine2);
                        // OnFinancialVoidCheckOnAfterPostBalAccLine(GenJnlLine2, CheckLedgerEntry, GenJnlPostLine);
                        until EmployeeLedgerEntry.Next() = 0;
                end;
            else begin
                GenJnlLine2."Bal. Account Type" := CheckLedgerEntry."Bal. Account Type";
                GenJnlLine2.Validate("Bal. Account No.", CheckLedgerEntry."Bal. Account No.");
                GenJnlLine2."Shortcut Dimension 1 Code" := '';
                GenJnlLine2."Shortcut Dimension 2 Code" := '';
                GenJnlLine2."Dimension Set ID" := 0;
                GenJnlLine2."Journal Template Name" := BankAccLedgEntry2."Journal Templ. Name";
                GenJnlLine2."Journal Batch Name" := BankAccLedgEntry2."Journal Batch Name";
                // OnFinancialVoidCheckOnBeforePostBalAccLine(GenJnlLine2, CheckLedgerEntry);
                GenJnlPostLine.RunWithCheck(GenJnlLine2);
                // OnFinancialVoidCheckOnAfterPostBalAccLine(GenJnlLine2, CheckLedgerEntry, GenJnlPostLine);
            end;
        end;
        if ConfirmFinancialVoid.GetVoidDate() = CheckLedgerEntry."Check Date" then begin
            BankAccLedgEntry2.Open := false;
            BankAccLedgEntry2."Remaining Amount" := 0;
            BankAccLedgEntry2."Statement Status" := BankAccLedgEntry2."Statement Status"::Closed;
            //>>HEI.03
            // BankAccLedgEntry2.Modify();
            if BankAccLedgEntry2.Modify() then;
            //<<HEI.03
        end;
        // rounding error from currency conversion
        if CheckAmountLCY + BalanceAmountLCY <> 0 then
            PostRoundingAmount(BankAcc, CheckLedgerEntry, ConfirmFinancialVoid.GetVoidDate(), -(CheckAmountLCY + BalanceAmountLCY));
        MarkCheckEntriesVoid(CheckLedgerEntry, ConfirmFinancialVoid.GetVoidDate());
        Commit();
        UpdateAnalysisView.UpdateAll(0, true);
        // OnAfterFinancialVoidCheck(CheckLedgerEntry);
        IsHandled := true;
    end;

    local procedure FinancialVoidCheckPreValidation(var CheckLedgEntry: Record "Check Ledger Entry")
    var
        TransactionBalance: Decimal;
        CheckLedgerEntries: page "Check Ledger Entries";
    begin
        CheckLedgEntry.TestField("Entry Status", CheckLedgEntry."Entry Status"::Posted);
        CheckLedgEntry.TestField("Statement Status", CheckLedgEntry."Statement Status"::Open);
        CheckLedgEntry.TestField("Bal. Account No.");
        BankAcc.Get(CheckLedgEntry."Bank Account No.");
        //>>HEI.03
        // BankAccLedgEntry2.Get(CheckLedgEntry."Bank Account Ledger Entry No.");
        if BankAccLedgEntry2.Get(CheckLedgEntry."Bank Account Ledger Entry No.") then;
        //<<HEI.03
        SourceCodeSetup.Get();
        GLEntry.SetCurrentKey("Transaction No.");
        GLEntry.SetRange("Transaction No.", BankAccLedgEntry2."Transaction No.");
        GLEntry.SetRange("Document No.", BankAccLedgEntry2."Document No.");
        GLEntry.CalcSums(Amount);
        TransactionBalance := GLEntry.Amount;
        if TransactionBalance <> 0 then
            Error(VoidingCheckErr);
        // OnAfterFinancialVoidCheckPreValidation(CheckLedgEntry, BankAccLedgEntry2);
    end;

    local procedure InitGenJnlLine(var GenJnlLine: Record "Gen. Journal Line"; DocumentType: Enum "Gen. Journal Document Type"; DocumentNo: Code[20];
                                                                                                 PostingDate: Date;
                                                                                                 AccountType: Enum "Gen. Journal Account Type";
                                                                                                 AccountNo: Code[20];
                                                                                                 Description: Text[50])
    begin
        GenJnlLine.Init();
        GenJnlLine."System-Created Entry" := true;
        GenJnlLine."Financial Void" := true;
        GenJnlLine."Document Type" := DocumentType;
        GenJnlLine."Document No." := DocumentNo;
        GenJnlLine."Account Type" := AccountType;
        GenJnlLine."Posting Date" := PostingDate;
        GenJnlLine."VAT Reporting Date" := PostingDate;
        GenJnlLine.Validate("Account No.", AccountNo);
        GenJnlLine.Description := Description;
        GenJnlLine."Source Code" := SourceCodeSetup."Financially Voided Check";
    end;

    local procedure ClearBankLedgerEntry(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    begin
        BankAccountLedgerEntry.Reset();
        BankAccountLedgerEntry.FindLast();
        BankAccountLedgerEntry.Open := false;
        BankAccountLedgerEntry."Remaining Amount" := 0;
        BankAccountLedgerEntry."Statement Status" := BankAccLedgEntry2."Statement Status"::Closed;
        BankAccountLedgerEntry.Modify();
    end;

    local procedure CalcAmountToVoid(CheckLedgEntry: Record "Check Ledger Entry") AmountToVoid: Decimal
    var
        CheckLedgEntry2: Record "Check Ledger Entry";
    begin
        CheckLedgEntry2.Reset();
        CheckLedgEntry2.SetRange("Bank Account No.", CheckLedgEntry."Bank Account No.");
        CheckLedgEntry2.SetRange("Entry Status", CheckLedgEntry."Entry Status"::Posted);
        CheckLedgEntry2.SetRange("Statement Status", CheckLedgEntry."Statement Status"::Open);
        CheckLedgEntry2.SetRange("Check No.", CheckLedgEntry."Check No.");
        CheckLedgEntry2.SetRange("Check Date", CheckLedgEntry."Check Date");
        CheckLedgEntry2.CalcSums(Amount);
        AmountToVoid := CheckLedgEntry2.Amount;
        // OnAfterCalcAmountToVoid(CheckLedgEntry, AmountToVoid);
    end;

    local procedure FinancialVoidPostGLAccount(var GenJnlLine: Record "Gen. Journal Line"; BankAccLedgEntry2: Record "Bank Account Ledger Entry"; CheckLedgEntry: Record "Check Ledger Entry"; var BalanceAmountLCY: Decimal)
    var
        GLEntry: Record "G/L Entry";
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        GLEntry.SetCurrentKey("Transaction No.");
        GLEntry.SetRange("Transaction No.", BankAccLedgEntry2."Transaction No.");
        GLEntry.SetRange("Document No.", BankAccLedgEntry2."Document No.");
        GLEntry.SetRange("Posting Date", BankAccLedgEntry2."Posting Date");
        GLEntry.SetFilter("Entry No.", '<>%1', BankAccLedgEntry2."Entry No.");
        GLEntry.SetRange("G/L Account No.", CheckLedgEntry."Bal. Account No.");
        if GLEntry.FindSet() then
            repeat
                // OnFinancialVoidPostGLAccountOnBeforeGLEntryLoop(GLEntry, CheckLedgEntry);
                GenJnlLine.Validate("Account No.", GLEntry."G/L Account No.");
                GenJnlLine.Description := StrSubstNo(VoidingCheckMsg, CheckLedgEntry."Check No.");
                GenJnlLine.Validate(Amount, -GLEntry.Amount - GLEntry."VAT Amount");
                BalanceAmountLCY := BalanceAmountLCY + GenJnlLine."Amount (LCY)";
                GenJnlLine."Shortcut Dimension 1 Code" := GLEntry."Global Dimension 1 Code";
                GenJnlLine."Shortcut Dimension 2 Code" := GLEntry."Global Dimension 2 Code";
                GenJnlLine."Dimension Set ID" := GLEntry."Dimension Set ID";
                GenJnlLine."Gen. Posting Type" := GLEntry."Gen. Posting Type";
                GenJnlLine."Gen. Bus. Posting Group" := GLEntry."Gen. Bus. Posting Group";
                GenJnlLine."Gen. Prod. Posting Group" := GLEntry."Gen. Prod. Posting Group";
                GenJnlLine."VAT Bus. Posting Group" := GLEntry."VAT Bus. Posting Group";
                GenJnlLine."VAT Prod. Posting Group" := GLEntry."VAT Prod. Posting Group";
                if VATPostingSetup.Get(GLEntry."VAT Bus. Posting Group", GLEntry."VAT Prod. Posting Group") then
                    GenJnlLine."VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
                GenJnlLine."Journal Template Name" := BankAccLedgEntry2."Journal Templ. Name";
                GenJnlLine."Journal Batch Name" := BankAccLedgEntry2."Journal Batch Name";
                // OnFinancialVoidCheckOnBeforePostBalAccLine(GenJnlLine, CheckLedgEntry);
                GenJnlPostLine.RunWithCheck(GenJnlLine);
            // OnFinancialVoidCheckOnAfterPostBalAccLine(GenJnlLine, CheckLedgEntry, GenJnlPostLine);
            until GLEntry.Next() = 0;
    end;

    local procedure UnApplyCustInvoices(var CheckLedgEntry: Record "Check Ledger Entry"; VoidDate: Date): Boolean
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        OrigPaymentCustLedgerEntry: Record "Cust. Ledger Entry";
        PayDetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        GenJournalLine3: Record "Gen. Journal Line";
        AppliesID: Code[50];
    begin
        // first, find first original payment line, if any
        BankAccountLedgerEntry.Get(CheckLedgEntry."Bank Account Ledger Entry No.");
        if CheckLedgEntry."Bal. Account Type" = CheckLedgEntry."Bal. Account Type"::Customer then begin
            OrigPaymentCustLedgerEntry.SetCurrentKey("Transaction No.");
            OrigPaymentCustLedgerEntry.SetRange("Transaction No.", BankAccountLedgerEntry."Transaction No.");
            OrigPaymentCustLedgerEntry.SetRange("Document No.", BankAccountLedgerEntry."Document No.");
            OrigPaymentCustLedgerEntry.SetRange("Posting Date", BankAccountLedgerEntry."Posting Date");
            if not OrigPaymentCustLedgerEntry.FindFirst() then
                exit(false);
        end
        else
            exit(false);
        AppliesID := CheckLedgEntry."Document No.";
        PayDetailedCustLedgEntry.SetCurrentKey("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
        PayDetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", OrigPaymentCustLedgerEntry."Entry No.");
        PayDetailedCustLedgEntry.SetRange(Unapplied, false);
        PayDetailedCustLedgEntry.SetFilter("Applied Cust. Ledger Entry No.", '<>%1', 0);
        PayDetailedCustLedgEntry.SetRange("Entry Type", PayDetailedCustLedgEntry."Entry Type"::Application);
        if not PayDetailedCustLedgEntry.FindSet() then
            Error(NoAppliedEntryErr);
        repeat
            GenJournalLine3.CopyFromPaymentCustLedgEntry(OrigPaymentCustLedgerEntry);
            GenJournalLine3."Posting Date" := VoidDate;
            GenJournalLine3.Description := StrSubstNo(VoidingCheckMsg, CheckLedgEntry."Check No.");
            GenJournalLine3."Source Code" := SourceCodeSetup."Financially Voided Check";
            // OnUnApplyCustInvoicesOnBeforePost(GenJournalLine3, CustLedgEntry, PayDetailedCustLedgEntry);
            GenJnlPostLine.UnapplyCustLedgEntry(GenJournalLine3, PayDetailedCustLedgEntry);
        until PayDetailedCustLedgEntry.Next() = 0;

        OrigPaymentCustLedgerEntry.FindSet(true);
        // re-get the now-modified payment entry.
        repeat
            // set up to be applied by upcoming voiding entry.
            MakeAppliesID(AppliesID, CheckLedgEntry."Document No.");
            OrigPaymentCustLedgerEntry."Applies-to ID" := AppliesID;
            OrigPaymentCustLedgerEntry.CalcFields("Remaining Amount");
            // OnUnApplyCustInvoicesOnAfterCalcRemainingAmount(OrigPaymentCustLedgerEntry);
            OrigPaymentCustLedgerEntry."Amount to Apply" := OrigPaymentCustLedgerEntry."Remaining Amount";
            OrigPaymentCustLedgerEntry."Accepted Pmt. Disc. Tolerance" := false;
            OrigPaymentCustLedgerEntry."Accepted Payment Tolerance" := 0;
            OrigPaymentCustLedgerEntry.Modify();
        until OrigPaymentCustLedgerEntry.Next() = 0;
        exit(true);
    end;

    local procedure MakeAppliesID(var AppliesID: Code[50]; CheckDocNo: Code[20])
    begin
        if AppliesID = '' then
            exit;

        if AppliesID = CheckDocNo then
            AppliesIDCounter := 0;

        AppliesIDCounter := AppliesIDCounter + 1;

        AppliesID :=

          CopyStr(Format(AppliesIDCounter) + CheckDocNo, 1, MaxStrLen(AppliesID));

    end;



    local procedure SetGenJnlLine(var GenJnlLine: Record "Gen. Journal Line"; OriginalAmount: Decimal; CurrencyCode: Code[10]; DocumentNo: Code[20]; Dim1Code: Code[20]; Dim2Code: Code[20]; DimSetID: Integer)
    var
        IsHandled: Boolean;
    begin
        // IsHandled := false;
        // OnBeforeSetGenJnlLine(GenJnlLine, IsHandled);
        // if IsHandled then
        //     exit;
        GenJnlLine.Validate(Amount, OriginalAmount);
        GenJnlLine.Validate("Currency Code", CurrencyCode);
        MakeAppliesID(GenJnlLine."Applies-to ID", DocumentNo);
        GenJnlLine."Shortcut Dimension 1 Code" := Dim1Code;
        GenJnlLine."Shortcut Dimension 2 Code" := Dim2Code;
        GenJnlLine."Dimension Set ID" := DimSetID;
        GenJnlLine."Source Currency Code" := CurrencyCode;
        // OnAfterSetGenJnlLine(GenJnlLine);
    end;



    local procedure UnApplyVendInvoices(var CheckLedgEntry: Record "Check Ledger Entry"; VoidDate: Date): Boolean
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        OrigPaymentVendorLedgerEntry: Record "Vendor Ledger Entry";
        PayDetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        GenJournalLine3: Record "Gen. Journal Line";
        AppliesID: Code[50];
        IsHandled: Boolean;
        Result: Boolean;
    begin
        // IsHandled := false;
        // OnBeforeUnApplyVendInvoices(CheckLedgEntry, VoidDate, IsHandled, Result);
        // if IsHandled then
        //     exit(Result);
        // first, find first original payment line, if any
        //>>HEI.03
        // BankAccountLedgerEntry.Get(CheckLedgEntry."Bank Account Ledger Entry No.");
        if BankAccountLedgerEntry.Get(CheckLedgEntry."Bank Account Ledger Entry No.") then;
        //<<HEI.03
        if CheckLedgEntry."Bal. Account Type" = CheckLedgEntry."Bal. Account Type"::Vendor then begin
            OrigPaymentVendorLedgerEntry.SetCurrentKey("Transaction No.");
            OrigPaymentVendorLedgerEntry.SetRange("Transaction No.", BankAccountLedgerEntry."Transaction No.");
            OrigPaymentVendorLedgerEntry.SetRange("Document No.", BankAccountLedgerEntry."Document No.");
            OrigPaymentVendorLedgerEntry.SetRange("Posting Date", BankAccountLedgerEntry."Posting Date");
            if not OrigPaymentVendorLedgerEntry.FindFirst() then
                exit(false);
        end
        else
            exit(false);
        AppliesID := CheckLedgEntry."Document No.";
        PayDetailedVendorLedgEntry.SetCurrentKey("Vendor Ledger Entry No.", "Entry Type", "Posting Date");
        PayDetailedVendorLedgEntry.SetRange("Vendor Ledger Entry No.", OrigPaymentVendorLedgerEntry."Entry No.");
        PayDetailedVendorLedgEntry.SetRange(Unapplied, false);
        PayDetailedVendorLedgEntry.SetFilter("Applied Vend. Ledger Entry No.", '<>%1', 0);
        PayDetailedVendorLedgEntry.SetRange("Entry Type", PayDetailedVendorLedgEntry."Entry Type"::Application);
        if not PayDetailedVendorLedgEntry.FindSet() then begin
            IsHandled := false;
            // OnUnApplyVendInvoicesOnBeforeErrorNoAppliedEntry(BankAccountLedgerEntry, GenJnlLine2, IsHandled);
            if not IsHandled then
                Error(NoAppliedEntryErr);
        end;
        repeat
            GenJournalLine3.CopyFromPaymentVendLedgEntry(OrigPaymentVendorLedgerEntry);
            GenJournalLine3."Posting Date" := VoidDate;
            GenJournalLine3.Description := StrSubstNo(VoidingCheckMsg, CheckLedgEntry."Check No.");
            GenJournalLine3."Source Code" := SourceCodeSetup."Financially Voided Check";
            // OnUnApplyVendInvoicesOnBeforePost(GenJournalLine3, VendorLedgEntry, PayDetailedVendorLedgEntry);
            // IBM
            GenJnlPostLine.UnapplyVendLedgEntry(GenJournalLine3, PayDetailedVendorLedgEntry);
        // GenJnlPostLine.UnapplyVendLedgEntry(GenJournalLine3, PayDetailedVendorLedgEntry, false);
        // IBM
        until PayDetailedVendorLedgEntry.Next() = 0;
        OrigPaymentVendorLedgerEntry.FindSet(true);
        // re-get the now-modified payment entry.
        repeat
            // set up to be applied by upcoming voiding entry.
            MakeAppliesID(AppliesID, CheckLedgEntry."Document No.");
            OrigPaymentVendorLedgerEntry."Applies-to ID" := AppliesID;
            OrigPaymentVendorLedgerEntry.CalcFields("Remaining Amount");
            // OnUnApplyVendInvoicesOnAfterCalcRemainingAmount(OrigPaymentVendorLedgerEntry);
            OrigPaymentVendorLedgerEntry."Amount to Apply" := OrigPaymentVendorLedgerEntry."Remaining Amount";
            OrigPaymentVendorLedgerEntry."Accepted Pmt. Disc. Tolerance" := false;
            OrigPaymentVendorLedgerEntry."Accepted Payment Tolerance" := 0;
            OrigPaymentVendorLedgerEntry.Modify();
        until OrigPaymentVendorLedgerEntry.Next() = 0;
        exit(true);
    end;

    local procedure UnApplyEmpInvoices(var CheckLedgEntry: Record "Check Ledger Entry"; VoidDate: Date): Boolean
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        OrigPaymentEmployeeLedgerEntry: Record "Employee Ledger Entry";
        PayDetailedEmployeeLedgEntry: Record "Detailed Employee Ledger Entry";
        GenJournalLine3: Record "Gen. Journal Line";
        AppliesID: Code[50];
    begin
        // first, find first original payment line, if any
        BankAccountLedgerEntry.Get(CheckLedgEntry."Bank Account Ledger Entry No.");
        if CheckLedgEntry."Bal. Account Type" <> CheckLedgEntry."Bal. Account Type"::Employee then
            exit(false);
        OrigPaymentEmployeeLedgerEntry.SetCurrentKey("Transaction No.");
        OrigPaymentEmployeeLedgerEntry.SetRange("Transaction No.", BankAccountLedgerEntry."Transaction No.");
        OrigPaymentEmployeeLedgerEntry.SetRange("Document No.", BankAccountLedgerEntry."Document No.");
        OrigPaymentEmployeeLedgerEntry.SetRange("Posting Date", BankAccountLedgerEntry."Posting Date");
        if not OrigPaymentEmployeeLedgerEntry.FindFirst() then
            exit(false);
        AppliesID := CheckLedgEntry."Document No.";
        PayDetailedEmployeeLedgEntry.SetCurrentKey("Employee Ledger Entry No.", "Entry Type", "Posting Date");
        PayDetailedEmployeeLedgEntry.SetRange("Employee Ledger Entry No.", OrigPaymentEmployeeLedgerEntry."Entry No.");
        PayDetailedEmployeeLedgEntry.SetRange(Unapplied, false);
        PayDetailedEmployeeLedgEntry.SetFilter("Applied Empl. Ledger Entry No.", '<>%1', 0);
        PayDetailedEmployeeLedgEntry.SetRange("Entry Type", PayDetailedEmployeeLedgEntry."Entry Type"::Application);
        if not PayDetailedEmployeeLedgEntry.FindSet() then
            Error(NoAppliedEntryErr);
        repeat
            GenJournalLine3.CopyFromPaymentEmpLedgEntry(OrigPaymentEmployeeLedgerEntry);
            GenJournalLine3."Posting Date" := VoidDate;
            GenJournalLine3.Description := StrSubstNo(VoidingCheckMsg, CheckLedgEntry."Check No.");
            GenJournalLine3."Source Code" := SourceCodeSetup."Financially Voided Check";
            GenJnlPostLine.UnapplyEmplLedgEntry(GenJournalLine3, PayDetailedEmployeeLedgEntry);
        until PayDetailedEmployeeLedgEntry.Next() = 0;
        OrigPaymentEmployeeLedgerEntry.FindSet(true);
        // re-get the now-modified payment entry.
        repeat
            // set up to be applied by upcoming voiding entry.
            MakeAppliesID(AppliesID, CheckLedgEntry."Document No.");
            OrigPaymentEmployeeLedgerEntry."Applies-to ID" := AppliesID;
            OrigPaymentEmployeeLedgerEntry.CalcFields("Remaining Amount");
            OrigPaymentEmployeeLedgerEntry."Amount to Apply" := OrigPaymentEmployeeLedgerEntry."Remaining Amount";
            OrigPaymentEmployeeLedgerEntry.Modify();
        until OrigPaymentEmployeeLedgerEntry.Next() = 0;
        exit(true);

    end;

    local procedure PostRoundingAmount(BankAcc: Record "Bank Account"; CheckLedgEntry: Record "Check Ledger Entry"; PostingDate: Date; RoundingAmount: Decimal)
    var
        GenJnlLine2: Record "Gen. Journal Line";
        Currency: Record Currency;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforePostRoundingAmount(BankAcc, CheckLedgEntry, BankAccLedgEntry2, PostingDate, RoundingAmount, IsHandled);
        if IsHandled then
            exit;
        Currency.Get(BankAcc."Currency Code");
        GenJnlLine2.Init();
        GenJnlLine2."System-Created Entry" := true;
        GenJnlLine2."Financial Void" := true;
        GenJnlLine2."Document No." := CheckLedgEntry."Document No.";
        GenJnlLine2."Account Type" := GenJnlLine2."Account Type"::"G/L Account";
        GenJnlLine2."Posting Date" := PostingDate;
        if RoundingAmount > 0 then
            GenJnlLine2.Validate("Account No.", Currency.GetConvLCYRoundingDebitAccount())

        else
            GenJnlLine2.Validate("Account No.", Currency.GetConvLCYRoundingCreditAccount());
        GenJnlLine2.Validate("Currency Code", BankAcc."Currency Code");
        GenJnlLine2.Description := StrSubstNo(VoidingCheckMsg, CheckLedgEntry."Check No.");
        GenJnlLine2."Source Code" := SourceCodeSetup."Financially Voided Check";
        GenJnlLine2."Allow Zero-Amount Posting" := true;
        GenJnlLine2.Validate(Amount, 0);
        GenJnlLine2."Amount (LCY)" := RoundingAmount;
        GenJnlLine2."Shortcut Dimension 1 Code" := BankAccLedgEntry2."Global Dimension 1 Code";
        GenJnlLine2."Shortcut Dimension 2 Code" := BankAccLedgEntry2."Global Dimension 2 Code";
        GenJnlLine2."Dimension Set ID" := BankAccLedgEntry2."Dimension Set ID";
        GenJnlLine2."Journal Template Name" := BankAccLedgEntry2."Journal Templ. Name";
        GenJnlLine2."Journal Batch Name" := BankAccLedgEntry2."Journal Batch Name";
        // OnPostRoundingAmountOnBeforeGenJnlPostLine(GenJnlLine2, CheckLedgEntry, BankAccLedgEntry2);
        GenJnlPostLine.RunWithCheck(GenJnlLine2);
        // OnPostRoundingAmountOnAfterGenJnlPostLine(GenJnlLine2, CheckLedgEntry, GenJnlPostLine);
    end;

    local procedure MarkCheckEntriesVoid(var OriginalCheckLedgerEntry: Record "Check Ledger Entry"; VoidDate: Date)
    var
        RelatedCheckLedgerEntry: Record "Check Ledger Entry";
        RelatedCheckLedgerEntry2: Record "Check Ledger Entry";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeMarkCheckEntriesVoid(OriginalCheckLedgerEntry, VoidDate, IsHandled);
        if IsHandled then
            exit;
        RelatedCheckLedgerEntry.Reset();
        RelatedCheckLedgerEntry.SetCurrentKey("Bank Account No.", "Entry Status", "Check No.");
        RelatedCheckLedgerEntry.SetRange("Bank Account No.", OriginalCheckLedgerEntry."Bank Account No.");
        RelatedCheckLedgerEntry.SetRange("Entry Status", OriginalCheckLedgerEntry."Entry Status"::Posted);
        RelatedCheckLedgerEntry.SetRange("Statement Status", OriginalCheckLedgerEntry."Statement Status"::Open);
        RelatedCheckLedgerEntry.SetRange("Check No.", OriginalCheckLedgerEntry."Check No.");
        RelatedCheckLedgerEntry.SetRange("Check Date", OriginalCheckLedgerEntry."Check Date");
        RelatedCheckLedgerEntry.SetFilter("Entry No.", '<>%1', OriginalCheckLedgerEntry."Entry No.");
        if RelatedCheckLedgerEntry.FindSet() then
            repeat
                RelatedCheckLedgerEntry2 := RelatedCheckLedgerEntry;
                RelatedCheckLedgerEntry2."Original Entry Status" := RelatedCheckLedgerEntry."Entry Status";
                RelatedCheckLedgerEntry2."Entry Status" := RelatedCheckLedgerEntry."Entry Status"::"Financially Voided";
                RelatedCheckLedgerEntry2."Positive Pay Exported" := false;
                if VoidDate = OriginalCheckLedgerEntry."Check Date" then begin
                    RelatedCheckLedgerEntry2.Open := false;
                    RelatedCheckLedgerEntry2."Statement Status" := RelatedCheckLedgerEntry2."Statement Status"::Closed;
                end;
                // OnMarkCheckEntriesVoidOnBeforeRelatedCheckLedgerEntry2Modify(RelatedCheckLedgerEntry2, VoidDate);
                RelatedCheckLedgerEntry2.Modify();
            until RelatedCheckLedgerEntry.Next() = 0;
        OriginalCheckLedgerEntry."Original Entry Status" := OriginalCheckLedgerEntry."Entry Status";
        OriginalCheckLedgerEntry."Entry Status" := OriginalCheckLedgerEntry."Entry Status"::"Financially Voided";
        OriginalCheckLedgerEntry."Positive Pay Exported" := false;
        if VoidDate = OriginalCheckLedgerEntry."Check Date" then begin
            OriginalCheckLedgerEntry.Open := false;
            OriginalCheckLedgerEntry."Statement Status" := OriginalCheckLedgerEntry."Statement Status"::Closed;
        end;
        // OnMarkCheckEntriesVoidOnBeforeOriginalCheckLedgerEntryModify(OriginalCheckLedgerEntry, VoidDate);
        OriginalCheckLedgerEntry.Modify();
    end;

    var
        BankAccLedgEntry3: Record "Bank Account Ledger Entry";
        NoAppliedEntryErr: Label 'Cannot find an applied entry within the specified filter.';
        AppliesIDCounter: Integer;
        FALedgEntry: Record "FA Ledger Entry";
        BankAcc: Record "Bank Account";
        BankAccLedgEntry2: Record "Bank Account Ledger Entry";
        SourceCodeSetup: Record "Source Code Setup";
        VendorLedgEntry: Record "Vendor Ledger Entry";
        GLEntry: Record "G/L Entry";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        CheckManagement: Codeunit CheckManagement;
        CustLedgEntry: Record "Cust. Ledger Entry";
        UpdateAnalysisView: Codeunit "Update Analysis View";
        VoidingCheckErr: Label 'You cannot Financially Void checks posted in a non-balancing transaction.';
        VoidingCheckMsg: Label 'Voiding check %1.', Comment = '%1=The check number being voided.';
        EmployeeLedgerEntry: Record "Employee Ledger Entry";
        NextCheckEntryNo: Integer;
        NextEntryNo: Integer;
        NextTransactionNo: Integer;
    //BC UPGRADE KUMARR78 << Adding Check Managment Event and Functions

    // BC Upgrade BHARDA11 >>
    // BC Upgrade BHARDA11 >> ---This code is written PostGLAcc function in Codeunit 12 in navision
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", OnAfterPostGLAcc, '', false, false)]
    local procedure OnAfterPostGLAcc(var GenJnlLine: Record "Gen. Journal Line"; var TempGLEntryBuf: Record "G/L Entry" temporary; var NextEntryNo: Integer; var NextTransactionNo: Integer; Balancing: Boolean; var GLEntry: Record "G/L Entry"; VATPostingSetup: Record "VAT Posting Setup"; var TempGLEntryVATEntryLink: Record "G/L Entry - VAT Entry Link" temporary)
    var
        CheckLedgEntry2: Record "Check Ledger Entry";
        CheckLedgEntry: Record "Check Ledger Entry";
        SuggestVendHEI: Report "Suggest Vendor Payments Hei";
    begin
        //>>HEI.20
        SourceCodeSetup.GET();
        IF GenJnlLine."Source Code" = SourceCodeSetup."Payment Journal Tree FND" THEN BEGIN
            IF ((GenJnlLine.Amount <= 0) AND (GenJnlLine."Bank Payment Type" = "Bank Payment Type"::"Computer Check") AND GenJnlLine."Check Printed") OR
               ((GenJnlLine.Amount < 0) AND (GenJnlLine."Bank Payment Type" = "Bank Payment Type"::"Manual Check"))
            THEN BEGIN
                CASE GenJnlLine."Bank Payment Type" OF
                    "Bank Payment Type"::"Computer Check":
                        BEGIN
                            GenJnlLine.TESTFIELD("Check Printed", TRUE);
                            CheckLedgEntry.LOCKTABLE();
                            CheckLedgEntry.RESET();
                            CheckLedgEntry.SETCURRENTKEY("Bank Account No.", "Entry Status", "Check No.");
                            IF GenJnlLine.Amount <= 0 THEN
                                IF GenJnlLine."HNK Bank Account FND" = '' THEN
                                    CheckLedgEntry.SETRANGE("Bank Account No.", GenJnlLine."Account No.")
                                ELSE
                                    CheckLedgEntry.SETRANGE("Bank Account No.", GenJnlLine."HNK Bank Account FND")
                            ELSE
                                IF GenJnlLine."HNK Bank Account FND" = '' THEN
                                    CheckLedgEntry.SETRANGE("Bank Account No.", GenJnlLine."Bal. Account No.")
                                ELSE
                                    CheckLedgEntry.SETRANGE("Bank Account No.", GenJnlLine."HNK Bank Account FND");
                            CheckLedgEntry.SETRANGE("Entry Status", CheckLedgEntry."Entry Status"::Printed);
                            //CheckLedgEntry.SETRANGE("Check No.","Document No.");
                            IF GenJnlLine."HNK Bank Account FND" = '' THEN
                                CheckLedgEntry.SETRANGE("Check No.", GenJnlLine."Document No.")
                            ELSE
                                CheckLedgEntry.SETRANGE("Check No.", GenJnlLine."HNK Check No. FND");
                            IF CheckLedgEntry.FINDSET() THEN
                                REPEAT
                                    CheckLedgEntry2 := CheckLedgEntry;
                                    CheckLedgEntry2."Entry Status" := CheckLedgEntry2."Entry Status"::Posted;
                                    //CheckLedgEntry2."Bank Account Ledger Entry No." := BankAccLedgEntry."Entry No.";
                                    CheckLedgEntry2.MODIFY();
                                UNTIL CheckLedgEntry.NEXT() = 0;
                        END;
                END;
            END
        END;//<<HEI.20
    end;
    // BC Upgrade BHARDA11 << ---This code is written PostGLAcc function in Codeunit 12 in navision
    // BC Upgrade BHARDA11 >> ----Thos code is Written in PostBankAcc function In 12 codeunit
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", OnPostBankAccOnAfterCheckLedgEntrySetFilters, '', false, false)]
    local procedure OnPostBankAccOnAfterCheckLedgEntrySetFilters(var CheckLedgEntry: Record "Check Ledger Entry"; GenJnlLine: Record "Gen. Journal Line")
    begin
        CheckLedgEntry.Reset();
        CheckLedgEntry.SetCurrentKey("Bank Account No.", "Entry Status", "Check No.");
        if GenJnlLine.Amount <= 0 then
            IF GenJnlLine."HNK Bank Account FND" = '' THEN
                CheckLedgEntry.SETRANGE("Bank Account No.", GenJnlLine."Account No.")
            ELSE
                CheckLedgEntry.SETRANGE("Bank Account No.", GenJnlLine."HNK Bank Account FND")
        ELSE
            IF GenJnlLine."HNK Bank Account FND" = '' THEN
                CheckLedgEntry.SETRANGE("Bank Account No.", GenJnlLine."Bal. Account No.")
            ELSE
                CheckLedgEntry.SETRANGE("Bank Account No.", GenJnlLine."HNK Bank Account FND");
        // CheckLedgEntry.SetRange("Bank Account No.", GenJnlLine."Account No.");
        CheckLedgEntry.SetRange("Entry Status", CheckLedgEntry."Entry Status"::Printed);
        // CheckLedgEntry.SetRange("Check No.", GenJnlLine."Document No.");
        IF GenJnlLine."HNK Bank Account FND" = '' THEN
            CheckLedgEntry.SETRANGE("Check No.", GenJnlLine."Document No.")
        ELSE
            CheckLedgEntry.SETRANGE("Check No.", GenJnlLine."HNK Check No. FND"); //<<HEI.20

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", OnPostBankAccOnBeforeModifyCheckLedgerEntry, '', false, false)]

    local procedure OnPostBankAccOnBeforeModifyCheckLedgerEntry(var GenJournalLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
        //HEI.07>>
        SourceCodeSetup.GET();
        IF GenJournalLine."Source Code" <> SourceCodeSetup."Payment Journal Tree FND" THEN BEGIN //HEI.07<<
        end else
            //HEI.07>>
            IF GenJournalLine."Bank Payment Type" = "Bank Payment Type"::"Computer Check" THEN
                GenJournalLine.TESTFIELD("Check Printed", TRUE);
        //HEI.07<<

    end;
    // BC Upgrade BHARDA11 <<
    // BC Upgrade BHARDA11 >> ---These events are use for workflow
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnAddWorkflowResponsePredecessorsToLibrary, '', false, false)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        workflowevent: Codeunit "Workflow Response Handling";
        CU50019: Codeunit "Cust/Vendor Bank Acc. Workflow";
    begin
        case ResponseFunctionName of
            workflowevent.SetStatusToPendingApprovalCode():
                begin
                    //SP HEI.05>>
                    workflowevent.AddResponsePredecessor(workflowevent.SetStatusToPendingApprovalCode(), CU50019.RunWorkflowOnSendVoidCheckfromCheckLedgerEntryCode());
                    //HEI.05<<
                end;
            workflowevent.CreateApprovalRequestsCode():
                begin
                    //HEI.05>>
                    workflowevent.AddResponsePredecessor(workflowevent.CreateApprovalRequestsCode(), CU50019.RunWorkflowOnSendVoidCheckfromCheckLedgerEntryCode());
                    //HEI.05<<
                end;
            workflowevent.SendApprovalRequestForApprovalCode():
                begin
                    //HEI.05>>
                    workflowevent.AddResponsePredecessor(workflowevent.SendApprovalRequestForApprovalCode(), CU50019.RunWorkflowOnSendVoidCheckfromCheckLedgerEntryCode());
                    //HEI.05<<
                end;
        end;
    end;
    // This Event is Used for Check Ledger Entry Approvals and update status
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnReleaseDocument, '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        CheckLEntry: Record "Check Ledger Entry";
    begin
        //>>HEI.05
        case RecRef.Number of
            Database::"Check Ledger Entry":
                begin
                    RecRef.SETTABLE(CheckLEntry);
                    IF CheckLEntry."Approval Status FND" = CheckLEntry."Approval Status FND"::"Awaiting approval" THEN BEGIN
                        CheckLEntry."Approval Status FND" := CheckLEntry."Approval Status FND"::Approved;
                        CheckLEntry.MODIFY(TRUE);
                        Handled := true;
                    END;
                end;
        //<<HEI.05
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnOpenDocument, '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        CLEntry: Record "Check Ledger Entry";
    begin
        //>>HEI.05
        case RecRef.Number of
            Database::"Check Ledger Entry":
                begin
                    RecRef.SETTABLE(CLEntry);
                    IF CLEntry."Approval Status FND" = CLEntry."Approval Status FND"::"Awaiting approval" THEN BEGIN
                        CLEntry."Approval Status FND" := CLEntry."Approval Status FND"::Rejected;
                        CLEntry.MODIFY(TRUE);
                    END;
                end;
        //<<HEI.05
        end;
        Handled := true;
    end;
    // Workflow

    //Bc Upgrade YADAVM09 Codeunit 7150-Update Item Analysis View Starts>>
    //     DITW15.00.00.01 DDR 12/03/2008 Added Drink-It Item Charges functionnalities
    //                                added fields "Valued Quantity in HL","Quantity in HL"
    //                                "Sales Tax Amount (Actual)","Purchase Tax Amount (Actual)"
    //                                "Sales Deposit Amount (Actual)","Purchase Deposit Amt. (Actual)"
    //                                "Sales Tax Amount (Expected)","Purchase Tax Amount (Expected)"
    //                                "Sales Deposit Amount (Actual)","Purchase Deposit Amt. (Actual)"
    //                                "Discount Amount",
    //                                "Item Charge Type","Empty Goods Item No."
    //                                !! bugfix Standard Navision into function FlushAnalysisViewBudgetEntry()
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.20 DDR 11/06/2008 Bugfix: Quantity in HL not filed when calculate Tax Analyze entry line
    // DITW15.00.00.23 DDR 23/07/2008 Added fields "Item Charge No." from "Item Analysis View Entry"
    //                                Check if "Last Entry No." from table "Analysis View" if logic
    // DITW15.00.00.25 DDR 10/10/2008 Remove field "Valued Quantity HL"
    //                                Added fields "Internal Tax Amount (Actual)","Internal Tax Amount (Exp)"
    // DITW15.00.00.38 DDR 17/12/2010 issue 703 Added fields "Tax Item No."
    // DITW17.10.03 MSF 03/04/2014 DIT-770 #328  :HL Volume not updated well in Item analysis view entries
    //                                            Modify all DIT fields for replacing "Value Entry".
    // DITW17.10.03 MSF 10/04/2014 DIT-770 #240 : Use the Value Entry - Item Ledger Entrys Source No for analysis, deposits,..
    //                                             Added field "Item Ledger Entry source No." -->ItemLedgerEntrySourceNo
    // DITW17.10.03 MSF 16/05/2014 DIT-770 #328
    // DITW17.10.03 MSF 04/06/2014 DIT-770 #328   Fix Invoiced Quantity HL
    //                  05/06/2014 DIT-770 #328   Fix Quantity HL
    // DITW17.10.03 MSF 12/06/2014 DIT-770 #737   Quantity HL Calculated Double

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7

    // HEI.01 Defect #1328 #1329 IBM NASTAA02 19.12.2017 # Missing fields in file creation
    //   # Added code to populate fields in Table 7154 - Item Analysis View Entry

    // HEI.02 Defect #1328 #1329 IBM NASTAA02 22.12.2017 # Missing fields in file creation
    //   # "Add. Product Type (PPG)" is filled-in depindeing on the setup

    // HEI.03 Defect #1329 IBM NASTAA02 25.01.2018 # Missing fields in file creation
    //   # "Add. Product Type (PPG) R1" is filled-in depending on the setup
    // HEI.04 FDD-HB1425 BULIMC01 IBM 03.06.2020 #new fields updated:  "Shortcut 1 Code", "Shortcut 2 Code"
    // HEI.05 IBM YADAVM09 12/10/23 CHG2218600_HB3954 DRC Interredional transfer exclusion from WIS MSV
    // #Code added in Function UpdateAnalysisViewEntry to update field Reporting Type
    //BC Upgrade YADAVM09 – Custom code previously existed in the function LOCAL UpdateEntries(), but this function does not include any event with IsHandled. Therefore, I traced where the function was being called, subscribed to the OnBeforeUpdateOne event, and moved the required custom code into local functions to ensure it compiles and works correctly with the event.
    //BC Upgrade YADAVM09 - The function UpdateAnalysisViewEntry has two additional parameters in NAV. Since this function is local, I have updated it here by including the required custom parameters and add mulitple local procedures to complie this.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Update Item Analysis View", OnBeforeUpdateOne, '', false, false)]
    local procedure OnBeforeUpdateOne(var NewItemAnalysisView: Record "Item Analysis View"; var ItemAnalysisView: Record "Item Analysis View"; Which: Option "Ledger Entries","Budget Entries",Both; var ShowWindow: Boolean; var LastValueEntryEntryNo: Integer; var LastItemBudgetEntryNo: Integer; var IsHandled: Boolean)
    var
        Updated: Boolean;
    begin
        ItemAnalysisView := NewItemAnalysisView;
        ItemAnalysisView.TestField(Blocked, false);
        ShowProgressWindow := ShowWindow;
        if ShowProgressWindow then
            InitWindow();

        if Which in [Which::"Ledger Entries", Which::Both] then
            if LastValueEntryEntryNo > ItemAnalysisView."Last Entry No." then begin
                if ShowProgressWindow then
                    UpdateWindowHeader(DATABASE::"Item Analysis View Entry", ValueEntry."Entry No.", ItemAnalysisView);
                UpdateEntries(ItemAnalysisView, LastValueEntryEntryNo);
                ItemAnalysisView."Last Entry No." := LastValueEntryEntryNo;
                Updated := true;
            end;

        if (Which in [Which::"Budget Entries", Which::Both]) and
           ItemAnalysisView."Include Budgets"
        then
            if LastItemBudgetEntryNo > ItemAnalysisView."Last Budget Entry No." then begin
                if ShowProgressWindow then
                    UpdateWindowHeader(DATABASE::"Item Analysis View Budg. Entry", ItemBudgetEntry."Entry No.", ItemAnalysisView);
                ItemBudgetEntry.Reset();
                ItemBudgetEntry.SetRange("Analysis Area", ItemAnalysisView."Analysis Area");
                ItemBudgetEntry.SetRange("Entry No.", ItemAnalysisView."Last Budget Entry No." + 1, LastItemBudgetEntryNo);
                UpdateBudgetEntries(ItemAnalysisView."Last Budget Entry No." + 1, ItemAnalysisView);
                ItemAnalysisView."Last Budget Entry No." := LastItemBudgetEntryNo;
                Updated := true;
            end;

        if Updated then begin
            ItemAnalysisView."Last Date Updated" := Today;
            ItemAnalysisView.Modify();
        end;
        if ShowProgressWindow then
            Window.Close();

        IsHandled := true;
    end;

    local procedure UpdateEntries(ItemAnalysisView: Record "Item Analysis View"; LastValueEntryNo: Integer)
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ProgressIndicator: Integer;
        GLSetup: Record "General Ledger Setup";
        FilterIsInitialized: Boolean;
    begin
        GLSetup.Get();
        FilterIsInitialized := false;
        ItemAnalysisViewSource.SetRange(AnalysisArea, ItemAnalysisView."Analysis Area");
        ItemAnalysisViewSource.SetRange(AnalysisViewCode, ItemAnalysisView.Code);
        ItemAnalysisViewSource.SetRange(EntryNo, ItemAnalysisView."Last Entry No." + 1, LastValueEntryNo);
        if ItemAnalysisView."Item Filter" <> '' then
            ItemAnalysisViewSource.SetFilter(ItemNo, ItemAnalysisView."Item Filter");
        if ItemAnalysisView."Location Filter" <> '' then
            ItemAnalysisViewSource.SetFilter(LocationCode, ItemAnalysisView."Location Filter");
        OnUpdateEntriesOnAfterSetFilters(ItemAnalysisView);
        ItemAnalysisViewSource.Open();

        while ItemAnalysisViewSource.Read() do begin
            ProgressIndicator := ProgressIndicator + 1;
            if UpdateItemAnalysisViewCU.DimSetIDInFilter(ItemAnalysisViewSource.DimensionSetID, ItemAnalysisView) then begin
                //  UpdateAnalysisViewEntry(ItemAnalysisViewSource.DimVal1, ItemAnalysisViewSource.DimVal2, ItemAnalysisViewSource.DimVal3, ItemAnalysisViewSource.ItemLedgerEntryType, ItemAnalysisView);//BC Upgrade YADAVM09 Code commented.
                UpdateAnalysisViewEntry(ItemAnalysisViewSource.DimVal1, ItemAnalysisViewSource.DimVal2, ItemAnalysisViewSource.DimVal3, ItemAnalysisViewSource.DimVal4, ItemAnalysisViewSource.DimVal5, ItemAnalysisViewSource.ItemLedgerEntryType, ItemAnalysisView);  //HEI.04 //BC Upgrade YADAVM09 Code added.
                if (ItemAnalysisView."Analysis Area" = ItemAnalysisView."Analysis Area"::Sales) and
                   (ItemAnalysisViewSource.ItemLedgerEntryType = ItemAnalysisViewSource.ItemLedgerEntryType::Purchase) and
                   (ItemAnalysisViewSource.CostAmountNonInvtbl <> 0) and
                   (ItemAnalysisViewSource.ItemChargeNo <> '')
                then begin
                    // purchase invoice for item charge can belong to sales - Cost Amount (Non-Invtbl.)
                    ItemLedgerEntry.Get(ItemAnalysisViewSource.ItemLedgerEntryNo);
                    if ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Sale then
                        //UpdateAnalysisViewEntry(ItemAnalysisViewSource.DimVal1, ItemAnalysisViewSource.DimVal2, ItemAnalysisViewSource.DimVal3, ItemAnalysisViewSource.ItemLedgerEntryType::Sale, ItemAnalysisView);//BC Upgrade YADAVM09 Code commented
                    UpdateAnalysisViewEntry(ItemAnalysisViewSource.DimVal1, ItemAnalysisViewSource.DimVal2, ItemAnalysisViewSource.DimVal3, ItemAnalysisViewSource.DimVal4, ItemAnalysisViewSource.DimVal5, ItemAnalysisViewSource.ItemLedgerEntryType::Sale, ItemAnalysisView); //HEI.04
                end;
            end;
            if ShowProgressWindow then
                UpdateWindowCounter(ProgressIndicator);
        end;
        ItemAnalysisViewSource.Close();

        if ShowProgressWindow then
            UpdateWindowCounter(ProgressIndicator);
        FlushAnalysisViewEntry(ItemAnalysisView);
    end;

    // local procedure UpdateAnalysisViewEntry(DimValue1: Code[20]; DimValue2: Code[20]; DimValue3: Code[20]; EntryType: Enum "Item Ledger Entry Type"; ItemAnalysisView: Record "Item Analysis View") BC Upgrade YADAVM09 Code commented.
    local procedure UpdateAnalysisViewEntry(DimValue1: Code[20]; DimValue2: Code[20]; DimValue3: Code[20]; DimValue4: Code[20]; DimValue5: Code[20]; EntryType: Enum "Item Ledger Entry Type"; ItemAnalysisView: Record "Item Analysis View")//BC Upgrade YADAVM09 new two parameters are added.

    var
        PostingDate: Date;
        EntryNo: Integer;
        IsHandled: Boolean;
        ItemLedgerEntry: Record "Item Ledger Entry";
        Lrec_itemanalview: Record "Item Analysis View";
        lrec_defdim: Record "Default Dimension";
        lrec_cust: Record Customer;
        Lrec_Gbpg: Record "Gen. Business Posting Group";
        Lrec_item: Record Item;
    begin
        PostingDate := ItemAnalysisViewSource.PostingDate;
        if PostingDate < ItemAnalysisView."Starting Date" then begin
            PostingDate := ItemAnalysisView."Starting Date" - 1;
            EntryNo := 0;
        end else begin
            PostingDate := CalculatePeriodStart(PostingDate, ItemAnalysisView."Date Compression", ItemAnalysisView);
            if PostingDate < ItemAnalysisView."Starting Date" then
                PostingDate := ItemAnalysisView."Starting Date";
            if ItemAnalysisView."Date Compression" <> ItemAnalysisView."Date Compression"::None then
                EntryNo := 0;
        end;
        TempItemAnalysisViewEntry.Init();
        TempItemAnalysisViewEntry."Analysis Area" := ItemAnalysisView."Analysis Area";
        TempItemAnalysisViewEntry."Analysis View Code" := ItemAnalysisView.Code;
        TempItemAnalysisViewEntry."Item No." := ItemAnalysisViewSource.ItemNo;
        TempItemAnalysisViewEntry."Source Type" := ItemAnalysisViewSource.SourceType;
        TempItemAnalysisViewEntry."Source No." := ItemAnalysisViewSource.SourceNo;
        TempItemAnalysisViewEntry."Entry Type" := ItemAnalysisViewSource.EntryType;
        TempItemAnalysisViewEntry."Item Ledger Entry Type" := EntryType;

        TempItemAnalysisViewEntry."Location Code" := ItemAnalysisViewSource.LocationCode;
        TempItemAnalysisViewEntry."Posting Date" := PostingDate;
        TempItemAnalysisViewEntry."Dimension 1 Value Code" := DimValue1;
        TempItemAnalysisViewEntry."Dimension 2 Value Code" := DimValue2;
        TempItemAnalysisViewEntry."Dimension 3 Value Code" := DimValue3;
        //HEI.04<<
        TempItemAnalysisViewEntry."Shortcut 1 Value Code FND" := DimValue4;
        TempItemAnalysisViewEntry."Shortcut 2 Value Code FND" := DimValue5;
        //HEI.04>>
        TempItemAnalysisViewEntry."Entry No." := EntryNo;

        //OnAfterInitializeTempItemAnalysisViewEntry(TempItemAnalysisViewEntry, ItemAnalysisView, ItemAnalysisViewSource, ValueEntry, IsHandled);
        //if IsHandled then
        //   exit;
        //BC Upgrade YADAVM09 Code commented unable to add custom query in the base event.
        //HEI.05
        IF ItemLedgerEntry.GET(ItemAnalysisViewSource.ItemLedgerEntryNo) THEN
            TempItemAnalysisViewEntry."Reporting Type FND" := ItemLedgerEntry."Reporting Type FND";
        //HEI.05

        //HEI.01>>
        //EDD072 WSA
        IF TempItemAnalysisViewEntry."Source Type" = TempItemAnalysisViewEntry."Source Type"::Customer THEN BEGIN
            IF Lrec_itemanalview.GET(TempItemAnalysisViewEntry."Analysis Area", TempItemAnalysisViewEntry."Analysis View Code") THEN BEGIN
                IF Lrec_itemanalview."Include Market Type FND" THEN
                    IF lrec_cust.GET(TempItemAnalysisViewEntry."Source No.") THEN
                        IF Lrec_Gbpg.GET(lrec_cust."Gen. Bus. Posting Group") THEN
                            TempItemAnalysisViewEntry."Add. Market type (BPG) FND" := Lrec_Gbpg."Market Type FND";

                IF Lrec_itemanalview."Include Addit. Cust. Dim.1 FND" THEN
                    IF Lrec_itemanalview."Add. Cust. Dim.1 Code FND" <> '' THEN
                        IF lrec_defdim.GET(18, TempItemAnalysisViewEntry."Source No.", Lrec_itemanalview."Add. Cust. Dim.1 Code FND") THEN
                            IF lrec_defdim."Dimension Value Code" <> '' THEN
                                TempItemAnalysisViewEntry."Add. Cust. Dim.1 FND" := lrec_defdim."Dimension Value Code";

                IF Lrec_itemanalview."Include Addit. Cust. Dim.2 FND" THEN
                    IF Lrec_itemanalview."Add. Cust. Dim.2 Code FND" <> '' THEN BEGIN
                        IF lrec_defdim.GET(18, TempItemAnalysisViewEntry."Source No.", Lrec_itemanalview."Add. Cust. Dim.2 Code FND") THEN
                            IF lrec_defdim."Dimension Value Code" <> '' THEN
                                TempItemAnalysisViewEntry."Add. Cust. Dim.2 FND" := lrec_defdim."Dimension Value Code";
                    END ELSE BEGIN
                        IF Lrec_itemanalview."Use Alt. Country Customer FND" AND lrec_cust.GET(TempItemAnalysisViewEntry."Source No.") THEN
                            TempItemAnalysisViewEntry."Add. Cust. Dim.2 FND" := lrec_cust."Country/Region Code"
                    END;
            END;
        END;

        IF Lrec_itemanalview.GET(TempItemAnalysisViewEntry."Analysis Area", TempItemAnalysisViewEntry."Analysis View Code") THEN BEGIN
            IF Lrec_itemanalview."Include Product Type FND" THEN BEGIN
                IF Lrec_item.GET(TempItemAnalysisViewEntry."Item No.") THEN
                    TempItemAnalysisViewEntry."Add. Product type (PPG) FND" := Lrec_item."Product Group Code FND";
                //HEI.02>>
            END ELSE BEGIN
                IF Lrec_itemanalview."Product Type Dimen. Code FND" <> '' THEN
                    IF lrec_defdim.GET(27, TempItemAnalysisViewEntry."Item No.", Lrec_itemanalview."Product Type Dimen. Code FND") THEN
                        IF lrec_defdim."Dimension Value Code" <> '' THEN
                            TempItemAnalysisViewEntry."Add. Product type (PPG) FND" := lrec_defdim."Dimension Value Code";
            END;
            //HEI.02<<

            IF Lrec_itemanalview."Include Product Type R1 FND" THEN BEGIN
                IF Lrec_item.GET(TempItemAnalysisViewEntry."Item No.") THEN
                    TempItemAnalysisViewEntry."Add. Product type R1 (PPG) FND" := Lrec_item."Product Group Code R1 FND";
                //HEI.03>>
            END ELSE BEGIN
                IF Lrec_itemanalview."Product Type Dimen. Code FND" <> '' THEN
                    IF lrec_defdim.GET(27, TempItemAnalysisViewEntry."Item No.", Lrec_itemanalview."Product Type Dimen. Code FND") THEN
                        IF lrec_defdim."Dimension Value Code" <> '' THEN
                            TempItemAnalysisViewEntry."Add. Product type R1 (PPG) FND" := lrec_defdim."Dimension Value Code";
            END;
            //HEI.03<<

            IF Lrec_itemanalview."Line Ext. Dimension Code FND" <> '' THEN
                IF lrec_defdim.GET(27, TempItemAnalysisViewEntry."Item No.", Lrec_itemanalview."Line Ext. Dimension Code FND") THEN
                    IF lrec_defdim."Dimension Value Code" <> '' THEN
                        TempItemAnalysisViewEntry."Line Ext. Dim. Value Code FND" := lrec_defdim."Dimension Value Code";
        END;
        //EDD072 WSA
        //HEI.01<<

        if TempItemAnalysisViewEntry.Find() then begin
            if (ItemAnalysisViewSource.EntryType = ItemAnalysisViewSource.EntryType::"Direct Cost") and
               (ItemAnalysisViewSource.ItemChargeNo = '')
            then
                AddValue(TempItemAnalysisViewEntry.Quantity, ItemAnalysisViewSource.ILEQuantity);
            //Bc Upgrade YADAVM09 BCUP0-167>>
            AddValue(TempItemAnalysisViewEntry."Volume 1 101FDW", ItemAnalysisViewSource.Volume1);
            AddValue(TempItemAnalysisViewEntry."Volume 2 101FDW", ItemAnalysisViewSource.Volume2);
            AddValue(TempItemAnalysisViewEntry."Net Weight 1 101FDW", ItemAnalysisViewSource.Net_Weight_1_101FDW);
            AddValue(TempItemAnalysisViewEntry."Net Weight 2 101FDW", ItemAnalysisViewSource.Net_Weight_2_101FDW);
            AddValue(TempItemAnalysisViewEntry."Gross Weight 1 101FDW", ItemAnalysisViewSource.Gross_Weight_1_101FDW);
            AddValue(TempItemAnalysisViewEntry."Gross Weight 2 101FDW", ItemAnalysisViewSource.Gross_Weight_2_101FDW);
            //Bc Upgrade YADAVM09 BCUP0-167<<
            AddValue(TempItemAnalysisViewEntry."Invoiced Quantity", ItemAnalysisViewSource.InvoicedQuantity);

            AddValue(TempItemAnalysisViewEntry."Sales Amount (Actual)", ItemAnalysisViewSource.SalesAmountActual);
            AddValue(TempItemAnalysisViewEntry."Cost Amount (Actual)", ItemAnalysisViewSource.CostAmountActual);
            AddValue(TempItemAnalysisViewEntry."Cost Amount (Non-Invtbl.)", ItemAnalysisViewSource.CostAmountNonInvtbl);

            AddValue(TempItemAnalysisViewEntry."Sales Amount (Expected)", ItemAnalysisViewSource.SalesAmountExpected);
            AddValue(TempItemAnalysisViewEntry."Cost Amount (Expected)", ItemAnalysisViewSource.CostAmountExpected);
            // OnUpdateAnalysisViewEntryOnBeforeModifyTempItemAnalysisViewEntry(TempItemAnalysisViewEntry, ItemAnalysisViewSource, ValueEntry, ItemAnalysisView); //BC Upgrade YADAVM09 Code commented unable to add custom query in the base event.
            TempItemAnalysisViewEntry.Modify();
        end else begin
            if (ItemAnalysisViewSource.EntryType = ItemAnalysisViewSource.EntryType::"Direct Cost") and
               (ItemAnalysisViewSource.ItemChargeNo = '')
            then
                TempItemAnalysisViewEntry.Quantity := ItemAnalysisViewSource.ILEQuantity;
            TempItemAnalysisViewEntry."Invoiced Quantity" := ItemAnalysisViewSource.InvoicedQuantity;

            TempItemAnalysisViewEntry."Sales Amount (Actual)" := ItemAnalysisViewSource.SalesAmountActual;
            TempItemAnalysisViewEntry."Cost Amount (Actual)" := ItemAnalysisViewSource.CostAmountActual;
            TempItemAnalysisViewEntry."Cost Amount (Non-Invtbl.)" := ItemAnalysisViewSource.CostAmountNonInvtbl;

            TempItemAnalysisViewEntry."Sales Amount (Expected)" := ItemAnalysisViewSource.SalesAmountExpected;
            TempItemAnalysisViewEntry."Cost Amount (Expected)" := ItemAnalysisViewSource.CostAmountExpected;
            //   OnUpdateAnalysisViewEntryOnBeforeInsertTempItemAnalysisViewEntry(TempItemAnalysisViewEntry, ItemAnalysisViewSource, ValueEntry, ItemAnalysisView); //BC Upgrade YADAVM09 Code commented unable to add custom query in the base event.
            TempItemAnalysisViewEntry.Insert();
            NoOfEntries := NoOfEntries + 1;
        end;
        if NoOfEntries >= 10000 then
            FlushAnalysisViewEntry(ItemAnalysisView);
    end;

    local procedure FlushAnalysisViewEntry(ItemAnalysisView: Record "Item Analysis View")
    begin
        if ShowProgressWindow then
            Window.Update(6, Text011);
        if TempItemAnalysisViewEntry.FindSet() then
            repeat
                ItemAnalysisViewEntry.Init();
                ItemAnalysisViewEntry := TempItemAnalysisViewEntry;

                if ((ItemAnalysisView."Analysis Area" = ItemAnalysisView."Analysis Area"::Sales) and
                    ((ItemAnalysisViewEntry."Item Ledger Entry Type" <> ItemAnalysisViewEntry."Item Ledger Entry Type"::Sale) or
                     (ItemAnalysisViewEntry."Entry Type" = ItemAnalysisViewEntry."Entry Type"::Revaluation))) or
                   ((ItemAnalysisView."Analysis Area" = ItemAnalysisView."Analysis Area"::Purchase) and
                    (ItemAnalysisViewEntry."Item Ledger Entry Type" <> ItemAnalysisViewEntry."Item Ledger Entry Type"::Purchase)) or
                   ((ItemAnalysisView."Analysis Area" = ItemAnalysisView."Analysis Area"::Inventory) and
                    (ItemAnalysisViewEntry."Item Ledger Entry Type" = ItemAnalysisViewEntry."Item Ledger Entry Type"::" "))
                then begin
                    if ItemAnalysisViewEntry.Find() then
                        ItemAnalysisViewEntry.Delete();
                end else
                    if not ItemAnalysisViewEntry.Insert() then begin
                        ItemAnalysisViewEntry.Find();
                        AddValue(ItemAnalysisViewEntry.Quantity, TempItemAnalysisViewEntry.Quantity);
                        AddValue(ItemAnalysisViewEntry."Invoiced Quantity", TempItemAnalysisViewEntry."Invoiced Quantity");

                        AddValue(ItemAnalysisViewEntry."Sales Amount (Actual)", TempItemAnalysisViewEntry."Sales Amount (Actual)");
                        AddValue(ItemAnalysisViewEntry."Cost Amount (Actual)", TempItemAnalysisViewEntry."Cost Amount (Actual)");
                        AddValue(ItemAnalysisViewEntry."Cost Amount (Non-Invtbl.)", TempItemAnalysisViewEntry."Cost Amount (Non-Invtbl.)");

                        AddValue(ItemAnalysisViewEntry."Sales Amount (Expected)", TempItemAnalysisViewEntry."Sales Amount (Expected)");
                        AddValue(ItemAnalysisViewEntry."Cost Amount (Expected)", TempItemAnalysisViewEntry."Cost Amount (Expected)");
                        AddValue(ItemAnalysisViewEntry."Cost Amount (Non-Invtbl.)", TempItemAnalysisViewEntry."Cost Amount (Non-Invtbl.)"); //HEI.01
                        OnFlushAnalysisViewEntryOnBeforeModifyItemAnalysisViewEntry(ItemAnalysisViewEntry, TempItemAnalysisViewEntry);
                        ItemAnalysisViewEntry.Modify();
                    end;
            until TempItemAnalysisViewEntry.Next() = 0;
        TempItemAnalysisViewEntry.DeleteAll();
        NoOfEntries := 0;
        if ShowProgressWindow then
            Window.Update(6, Text010);
    end;

    local procedure UpdateBudgetEntries(DeleteFromEntry: Integer; ItemAnalysisView: Record "Item Analysis View")
    var
        ItemAnalysisViewBudgetEntry: Record "Item Analysis View Budg. Entry";
    begin
        ItemAnalysisViewBudgetEntry.SetRange("Analysis Area", ItemAnalysisView."Analysis Area");
        ItemAnalysisViewBudgetEntry.SetRange("Analysis View Code", ItemAnalysisView.Code);
        ItemAnalysisViewBudgetEntry.SetFilter("Entry No.", '>%1', DeleteFromEntry);
        ItemAnalysisViewBudgetEntry.DeleteAll();
        ItemAnalysisViewBudgetEntry.Reset();

        if ItemAnalysisView."Item Filter" <> '' then
            ItemBudgetEntry.SetFilter("Item No.", ItemAnalysisView."Item Filter");
        if ItemAnalysisView."Location Filter" <> '' then
            ItemBudgetEntry.SetFilter("Location Code", ItemAnalysisView."Location Filter");
        if ItemBudgetEntry.IsEmpty() then
            exit;
        ItemBudgetEntry.FindSet(true);

        repeat
            if UpdateItemAnalysisViewCU.DimSetIDInFilter(ItemBudgetEntry."Dimension Set ID", ItemAnalysisView) then
                UpdateAnalysisViewBudgetEntry(
                  GetDimVal(ItemAnalysisView."Dimension 1 Code", ItemBudgetEntry."Dimension Set ID"),
                  GetDimVal(ItemAnalysisView."Dimension 2 Code", ItemBudgetEntry."Dimension Set ID"),
                  GetDimVal(ItemAnalysisView."Dimension 3 Code", ItemBudgetEntry."Dimension Set ID"), ItemAnalysisView);
            if ShowProgressWindow then
                UpdateWindowCounter(ItemBudgetEntry."Entry No.");
        until ItemBudgetEntry.Next() = 0;
        if ShowProgressWindow then
            UpdateWindowCounter(ItemBudgetEntry."Entry No.");
        FlushAnalysisViewBudgetEntry();
    end;

    local procedure FlushAnalysisViewBudgetEntry()
    var
        IsHandled: Boolean;
        Text011: Label 'Updating Database';
    begin
        OnBeforeFlushAnalysisViewBudgetEntry(TempItemAnalysisViewBudgEntry, ShowProgressWindow, IsHandled);
        if IsHandled then
            exit;

        if ShowProgressWindow then
            Window.Update(6, Text011);
        if TempItemAnalysisViewBudgEntry.FindSet() then
            repeat
                ItemAnalysisViewBudgetEntry.Init();
                ItemAnalysisViewBudgetEntry := TempItemAnalysisViewBudgEntry;
                if not ItemAnalysisViewBudgetEntry.Insert() then begin
                    ItemAnalysisViewBudgetEntry.Find();
                    AddValue(ItemAnalysisViewBudgetEntry."Sales Amount", TempItemAnalysisViewBudgEntry."Sales Amount");
                    AddValue(ItemAnalysisViewBudgetEntry."Sales Amount", TempItemAnalysisViewBudgEntry."Cost Amount");
                    AddValue(ItemAnalysisViewBudgetEntry."Sales Amount", TempItemAnalysisViewBudgEntry.Quantity);
                    ItemAnalysisViewBudgetEntry.Modify();
                end;
            until TempItemAnalysisViewBudgEntry.Next() = 0;
        TempItemAnalysisViewBudgEntry.DeleteAll();
        NoOfEntries := 0;
        if ShowProgressWindow then
            Window.Update(6, Text010);
    end;

    local procedure AddValue(var ToValue: Decimal; FromValue: Decimal)
    begin
        ToValue := ToValue + FromValue;
    end;

    local procedure UpdateWindowCounter(EntryNo: Integer)
    begin
        WinUpdateCounter := WinUpdateCounter + 1;
        WinTime2 := Time;
        if (WinTime2 > WinTime1 + 1000) or (EntryNo = WinLastEntryNo) then begin
            if WinLastEntryNo <> 0 then
                Window.Update(3, Round(EntryNo / WinLastEntryNo * 10000, 1));
            WinTotalCounter := WinTotalCounter + WinUpdateCounter;
            if WinTime2 <> WinTime1 then
                Window.Update(4, Round(WinUpdateCounter * (1000 / (WinTime2 - WinTime1)), 1));
            if WinTime2 <> WinTime0 then
                Window.Update(5, Round(WinTotalCounter * (1000 / (WinTime2 - WinTime0)), 1));
            WinTime1 := WinTime2;
            WinUpdateCounter := 0;
        end;
    end;

    local procedure GetDimVal(DimCode: Code[20]; DimSetID: Integer): Code[20]
    begin
        if TempDimSetEntry.Get(DimSetID, DimCode) then
            exit(TempDimSetEntry."Dimension Value Code");
        if DimSetEntry.Get(DimSetID, DimCode) then
            TempDimSetEntry := DimSetEntry
        else begin
            TempDimSetEntry."Dimension Set ID" := DimSetID;
            TempDimSetEntry."Dimension Code" := DimCode;
            TempDimSetEntry."Dimension Value Code" := '';
        end;
        TempDimSetEntry.Insert();
        exit(TempDimSetEntry."Dimension Value Code");
    end;


    local procedure UpdateAnalysisViewBudgetEntry(DimValue1: Code[20]; DimValue2: Code[20]; DimValue3: Code[20]; ItemAnalysisView: Record "Item Analysis View")
    var
        Lrec_itemanalview: Record "Item Analysis View";
        lrec_cust: Record Customer;
        Lrec_Gbpg: Record "Gen. Business Posting Group";
        lrec_defdim: Record "Default Dimension";
        Lrec_item: Record Item;
    begin
        TempItemAnalysisViewBudgEntry."Analysis Area" := ItemAnalysisView."Analysis Area";
        TempItemAnalysisViewBudgEntry."Analysis View Code" := ItemAnalysisView.Code;
        TempItemAnalysisViewBudgEntry."Budget Name" := ItemBudgetEntry."Budget Name";
        TempItemAnalysisViewBudgEntry."Location Code" := ItemBudgetEntry."Location Code";
        TempItemAnalysisViewBudgEntry."Item No." := ItemBudgetEntry."Item No.";
        TempItemAnalysisViewBudgEntry."Source Type" := ItemBudgetEntry."Source Type";
        TempItemAnalysisViewBudgEntry."Source No." := ItemBudgetEntry."Source No.";

        if ItemBudgetEntry.Date < ItemAnalysisView."Starting Date" then
            TempItemAnalysisViewBudgEntry."Posting Date" := ItemAnalysisView."Starting Date" - 1
        else begin
            TempItemAnalysisViewBudgEntry."Posting Date" :=
              CalculatePeriodStart(ItemBudgetEntry.Date, ItemAnalysisView."Date Compression", ItemAnalysisView);
            if TempItemAnalysisViewBudgEntry."Posting Date" < ItemAnalysisView."Starting Date" then
                TempItemAnalysisViewBudgEntry."Posting Date" := ItemAnalysisView."Starting Date";
        end;
        TempItemAnalysisViewBudgEntry."Dimension 1 Value Code" := DimValue1;
        TempItemAnalysisViewBudgEntry."Dimension 2 Value Code" := DimValue2;
        TempItemAnalysisViewBudgEntry."Dimension 3 Value Code" := DimValue3;
        TempItemAnalysisViewBudgEntry."Entry No." := ItemBudgetEntry."Entry No.";
        //  OnUpdateAnalysisViewBudgetEntryOnAfterInitTempItemAnalysisViewBudgEntry(TempItemAnalysisViewBudgEntry, ItemBudgetEntry, ItemAnalysisView);
        //HEI.01>>
        //EDD072 WSA
        IF TempItemAnalysisViewBudgEntry."Source Type" = TempItemAnalysisViewBudgEntry."Source Type"::Customer THEN BEGIN
            IF Lrec_itemanalview.GET(TempItemAnalysisViewBudgEntry."Analysis Area", TempItemAnalysisViewBudgEntry."Analysis View Code") THEN BEGIN
                IF Lrec_itemanalview."Include Market Type FND" THEN
                    IF lrec_cust.GET(TempItemAnalysisViewBudgEntry."Source No.") THEN
                        IF Lrec_Gbpg.GET(lrec_cust."Gen. Bus. Posting Group") THEN
                            TempItemAnalysisViewBudgEntry."Add. Market type (BPG) FND" := Lrec_Gbpg."Market Type FND";

                IF Lrec_itemanalview."Include Addit. Cust. Dim.1 FND" THEN
                    IF Lrec_itemanalview."Add. Cust. Dim.1 Code FND" <> '' THEN
                        IF lrec_defdim.GET(18, TempItemAnalysisViewBudgEntry."Source No.", Lrec_itemanalview."Add. Cust. Dim.1 Code FND") THEN
                            IF lrec_defdim."Dimension Value Code" <> '' THEN
                                TempItemAnalysisViewBudgEntry."Add. Cust. Dim.1 FND" := lrec_defdim."Dimension Value Code";

                IF Lrec_itemanalview."Include Addit. Cust. Dim.2 FND" THEN
                    IF Lrec_itemanalview."Add. Cust. Dim.2 Code FND" <> '' THEN BEGIN
                        IF lrec_defdim.GET(18, TempItemAnalysisViewBudgEntry."Source No.", Lrec_itemanalview."Add. Cust. Dim.2 Code FND") THEN
                            IF lrec_defdim."Dimension Value Code" <> '' THEN
                                TempItemAnalysisViewBudgEntry."Add. Cust. Dim.2 FND" := lrec_defdim."Dimension Value Code";
                    END ELSE BEGIN
                        IF Lrec_itemanalview."Use Alt. Country Customer FND" AND lrec_cust.GET(TempItemAnalysisViewBudgEntry."Source No.") THEN
                            TempItemAnalysisViewBudgEntry."Add. Cust. Dim.2 FND" := lrec_cust."Country/Region Code"
                    END;
            END;
        END;

        IF Lrec_itemanalview.GET(TempItemAnalysisViewBudgEntry."Analysis Area", TempItemAnalysisViewBudgEntry."Analysis View Code") THEN BEGIN
            IF Lrec_itemanalview."Include Product Type FND" THEN BEGIN
                IF Lrec_item.GET(TempItemAnalysisViewBudgEntry."Item No.") THEN
                    TempItemAnalysisViewEntry."Add. Product type (PPG) FND" := Lrec_item."Product Group Code FND";
                //HEI.02>>
            END ELSE BEGIN
                IF Lrec_itemanalview."Product Type Dimen. Code FND" <> '' THEN
                    IF lrec_defdim.GET(27, TempItemAnalysisViewBudgEntry."Item No.", Lrec_itemanalview."Product Type Dimen. Code FND") THEN
                        IF lrec_defdim."Dimension Value Code" <> '' THEN
                            TempItemAnalysisViewBudgEntry."Add. Product type (PPG) FND" := lrec_defdim."Dimension Value Code";
            END;
            //HEI.02<<

            IF Lrec_itemanalview."Include Product Type R1 FND" THEN BEGIN
                IF Lrec_item.GET(TempItemAnalysisViewBudgEntry."Item No.") THEN
                    TempItemAnalysisViewBudgEntry."Add. Product type R1 (PPG) FND" := Lrec_item."Product Group Code R1 FND";
                //HEI.03>>
            END ELSE BEGIN
                IF Lrec_itemanalview."Product Type Dimen. Code FND" <> '' THEN
                    IF lrec_defdim.GET(27, TempItemAnalysisViewBudgEntry."Item No.", Lrec_itemanalview."Product Type Dimen. Code FND") THEN
                        IF lrec_defdim."Dimension Value Code" <> '' THEN
                            TempItemAnalysisViewBudgEntry."Add. Product type R1 (PPG) FND" := lrec_defdim."Dimension Value Code";
            END;
            //HEI.03<<

            IF Lrec_itemanalview."Line Ext. Dimension Code FND" <> '' THEN
                IF lrec_defdim.GET(27, TempItemAnalysisViewBudgEntry."Item No.", Lrec_itemanalview."Line Ext. Dimension Code FND") THEN
                    IF lrec_defdim."Dimension Value Code" <> '' THEN
                        TempItemAnalysisViewBudgEntry."Line Ext. Dim. Val. Code FND" := lrec_defdim."Dimension Value Code";
        END;
        //EDD072 WSA
        //HEI.01<<

        if TempItemAnalysisViewBudgEntry.Find() then begin
            AddValue(TempItemAnalysisViewBudgEntry."Sales Amount", ItemBudgetEntry."Sales Amount");
            AddValue(TempItemAnalysisViewBudgEntry."Cost Amount", ItemBudgetEntry."Cost Amount");
            AddValue(TempItemAnalysisViewBudgEntry.Quantity, ItemBudgetEntry.Quantity);
            TempItemAnalysisViewBudgEntry.Modify();
        end else begin
            TempItemAnalysisViewBudgEntry."Sales Amount" := ItemBudgetEntry."Sales Amount";
            TempItemAnalysisViewBudgEntry."Cost Amount" := ItemBudgetEntry."Cost Amount";
            TempItemAnalysisViewBudgEntry.Quantity := ItemBudgetEntry.Quantity;
            TempItemAnalysisViewBudgEntry.Insert();
            NoOfEntries := NoOfEntries + 1;
        end;
        if NoOfEntries >= 10000 then
            FlushAnalysisViewBudgetEntry();
    end;

    local procedure UpdateWindowHeader(TableID: Integer; EntryNo: Integer; ItemAnalysisView: Record "Item Analysis View")
    var
        AllObj: Record AllObj;
    begin

        WinLastEntryNo := EntryNo;
        WinTotalCounter := 0;
        AllObj.Get(AllObj."Object Type"::Table, TableID);
        Window.Update(1, ItemAnalysisView.Code);
        Window.Update(2, AllObj."Object Name");
        Window.Update(3, 0);
        Window.Update(4, 0);
        Window.Update(5, 0);
        WinTime0 := Time;
        WinTime1 := WinTime0;
        WinTime2 := WinTime0;

    end;

    local procedure InitWindow()
    var
        Text005: Label 'Analysis View     #1############################\\';
        Text006: Label 'Updating table    #2############################\';
        Text009: Label '#6############### @3@@@@@@@@@@@@@@@@@@@@@@@@@@@@\\';
        Text010: Label 'Summarizing';
        Text007: Label 'Speed: (Entries/s)#4########\';
        Text008: Label 'Average Speed     #5########';
    begin
        Window.Open(
          Text005 +
          Text006 +
          Text009 +
          Text007 +
          Text008);
        Window.Update(6, Text010);
    end;

    local procedure CalculatePeriodStart(PostingDate: Date; DateCompression: Integer; ItemAnalysisView: Record "Item Analysis View"): Date
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        if PostingDate = ClosingDate(PostingDate) then
            exit(PostingDate);

        case DateCompression of
            ItemAnalysisView."Date Compression"::Week:
                PostingDate := CalcDate('<CW+1D-1W>', PostingDate);
            ItemAnalysisView."Date Compression"::Month:
                PostingDate := CalcDate('<CM+1D-1M>', PostingDate);
            ItemAnalysisView."Date Compression"::Quarter:
                PostingDate := CalcDate('<CQ+1D-1Q>', PostingDate);
            ItemAnalysisView."Date Compression"::Year:
                PostingDate := CalcDate('<CY+1D-1Y>', PostingDate);
            ItemAnalysisView."Date Compression"::Period:
                begin
                    if PostingDate <> PrevPostingDate then begin
                        PrevPostingDate := PostingDate;
                        AccountingPeriod.SetRange("Starting Date", 0D, PostingDate);
                        if AccountingPeriod.FindLast() then
                            PrevCalculatedPostingDate := AccountingPeriod."Starting Date"
                        else
                            PrevCalculatedPostingDate := PostingDate;
                    end;
                    PostingDate := PrevCalculatedPostingDate;
                end;
        end;
        exit(PostingDate);
    end;

    var
        WinLastEntryNo: Integer;
        WinUpdateCounter: Integer;
        WinTotalCounter: Integer;
        ItemBudgetEntry: Record "Item Budget Entry";
        ShowProgressWindow: Boolean;
        ValueEntry: Record "Value Entry";
        TempItemAnalysisViewBudgEntry: Record "Item Analysis View Budg. Entry" temporary;
        ItemAnalysisViewBudgetEntry: Record "Item Analysis View Budg. Entry";
        NoOfEntries: Integer;
        WinTime2: Time;
        WinTime1: Time;
        WinTime0: Time;
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        DimSetEntry: Record "Dimension Set Entry";
        PrevPostingDate: Date;
        PrevCalculatedPostingDate: Date;
        UpdateItemAnalysisViewCU: Codeunit "Update Item Analysis View";
        // ItemAnalysisViewSource: Query "Item Analysis View Source";// BC Upgrade YADAVM09 commented as New Query is created.
        ItemAnalysisViewSource: Query "Item Analysis View Source Cust";
        TempItemAnalysisViewEntry: Record "Item Analysis View Entry" temporary;
        ItemAnalysisViewEntry: Record "Item Analysis View Entry";

    [IntegrationEvent(false, false)]
    local procedure OnBeforeFlushAnalysisViewBudgetEntry(var TempItemAnalysisViewBudgEntry: Record "Item Analysis View Budg. Entry" temporary; ShowProgressWindow: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnUpdateAnalysisViewBudgetEntryOnAfterInitTempItemAnalysisViewBudgEntry(var ItemAnalysisViewBudgEntry: Record "Item Analysis View Budg. Entry"; var ItemBudgetEntry: Record "Item Budget Entry"; var ItemAnalysisView: Record "Item Analysis View")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnUpdateEntriesOnAfterSetFilters(var ItemAnalysisView: Record "Item Analysis View")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInitializeTempItemAnalysisViewEntry(var TempItemAnalysisViewEntry: Record "Item Analysis View Entry" temporary; ItemAnalysisView: Record "Item Analysis View"; var ItemAnalysisViewSource: Query "Item Analysis View Source"; var ValueEntry: Record "Value Entry"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnUpdateAnalysisViewEntryOnBeforeModifyTempItemAnalysisViewEntry(var TempItemAnalysisViewEntry: Record "Item Analysis View Entry" temporary; var ItemAnalysisViewSource: Query "Item Analysis View Source"; var ValueEntry: Record "Value Entry"; var ItemAnalysisView: Record "Item Analysis View")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnUpdateAnalysisViewEntryOnBeforeInsertTempItemAnalysisViewEntry(var TempItemAnalysisViewEntry: Record "Item Analysis View Entry" temporary; var ItemAnalysisViewSource: Query "Item Analysis View Source"; var ValueEntry: Record "Value Entry"; var ItemAnalysisView: Record "Item Analysis View")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnFlushAnalysisViewEntryOnBeforeModifyItemAnalysisViewEntry(var ItemAnalysisViewEntry: Record "Item Analysis View Entry"; var TempItemAnalysisViewEntry: Record "Item Analysis View Entry" temporary)
    begin
    end;
    //Bc Upgrade YADAVM09 Codeunit 7150-Update Item Analysis View<<

    // BC UPGRADE SHIKHD02 >>
    // Migrated HEI.01 from NAV CU 240 "ItemJnlManagement" to BC by subscribing to OnOpenJnlBatchOnBeforeCaseSelectItemJnlTemplate
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ItemJnlManagement, 'OnOpenJnlBatchOnBeforeCaseSelectItemJnlTemplate', '', false, false)]
    local procedure OnOpenJnlBatchOnBeforeCaseSelectItemJnlTemplate(var ItemJnlTemplate: Record "Item Journal Template"; var ItemJnlBatch: Record "Item Journal Batch")
    var
        UserJournalTemplate: Record "User Gen. Journal Setup FND";
    begin
        //HEI.01>>Syed Fix
        UserJournalTemplate.CheckUserTemplateSetup(UserJournalTemplate."Journal Type"::Item, ItemJnlTemplate.Name);
        //HEI.01<< Syed Fix
    end;
    // BC UPGRADE SHIKHD02 <<

    // BC UPGRADE SHIKHD02 >>
    // Migrated HEI.02 from NAV CU 240 "ItemJnlManagement" to BC by subscribing to OnBeforeOnOpenPage
    [EventSubscriber(ObjectType::Page, Page::"Item Journal Batches", OnBeforeOnOpenPage, '', false, false)]
    local procedure OnBeforeOnOpenPage(var ItemJournalBatch: Record "Item Journal Batch"; var IsHandled: Boolean)
    begin
        OpenJnlBatchForPhysInventory(ItemJournalBatch);
        IsHandled := true;
    end;

    local procedure OpenJnlBatchForPhysInventory(var ItemJnlBatch: Record "Item Journal Batch")
    var
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlLine: Record "Item Journal Line";
        ToTemplateType: Enum "Item Journal Template Type";
        JnlSelected: Boolean;
        ItemJnlManagement: Codeunit ItemJnlManagement;
        UserJournalTemplate: Record "User Gen. Journal Setup FND";
    begin
        IF ItemJnlBatch.GETFILTER("Journal Template Name") <> '' THEN
            EXIT;
        ItemJnlBatch.FILTERGROUP(2);
        IF ItemJnlBatch.GETFILTER("Journal Template Name") <> '' THEN BEGIN
            ItemJnlBatch.FILTERGROUP(0);
            EXIT;
        END;
        ItemJnlBatch.FILTERGROUP(0);

        IF NOT ItemJnlBatch.FIND('-') THEN
            FOR ItemJnlTemplate.Type := ItemJnlTemplate.Type::Item TO ItemJnlTemplate.Type::"Prod. Order" DO BEGIN
                ItemJnlTemplate.SETRANGE(Type, ItemJnlTemplate.Type);
                IF NOT ItemJnlTemplate.FINDFIRST() THEN
                    ItemJnlManagement.TemplateSelection(0, ItemJnlTemplate.Type.AsInteger(), FALSE, ItemJnlLine, JnlSelected);
                IF ItemJnlTemplate.FINDFIRST() THEN
                    ItemJnlManagement.CheckTemplateName(ItemJnlTemplate.Name, ItemJnlBatch.Name);
                IF ItemJnlTemplate.Type = ItemJnlTemplate.Type::"Phys. Inventory"
                //HEI.02<<
                THEN BEGIN
                    ItemJnlTemplate.SETRANGE(Recurring, TRUE);
                    IF NOT ItemJnlTemplate.FINDFIRST() THEN
                        ItemJnlManagement.TemplateSelection(0, ItemJnlTemplate.Type.AsInteger(), TRUE, ItemJnlLine, JnlSelected);
                    IF ItemJnlTemplate.FINDFIRST() THEN
                        ItemJnlManagement.CheckTemplateName(ItemJnlTemplate.Name, ItemJnlBatch.Name);
                    ItemJnlTemplate.SETRANGE(Recurring);
                END;
            END;

        ItemJnlBatch.FIND('-');
        JnlSelected := TRUE;
        ItemJnlBatch.CALCFIELDS("Template Type", Recurring);
        ItemJnlTemplate.SETRANGE(Recurring, ItemJnlBatch.Recurring);
        IF NOT ItemJnlBatch.Recurring THEN
            ItemJnlTemplate.SETRANGE(Type, ItemJnlBatch."Template Type");
        IF ItemJnlBatch.GETFILTER("Journal Template Name") <> '' THEN
            ItemJnlTemplate.SETRANGE(Name, ItemJnlBatch.GETFILTER("Journal Template Name"));
        CASE ItemJnlTemplate.COUNT OF
            1:
                ItemJnlTemplate.FINDFIRST();
            ELSE
                JnlSelected := PAGE.RUNMODAL(0, ItemJnlTemplate) = ACTION::LookupOK;
        END;
        IF NOT JnlSelected THEN
            ERROR('');
        IF JnlSelected THEN BEGIN
            UserJournalTemplate.CheckUserTemplateSetup(UserJournalTemplate."Journal Type"::Item, ItemJnlTemplate.Name);
            ItemJnlBatch.FILTERGROUP(2);
            ItemJnlBatch.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
            ItemJnlBatch.FILTERGROUP(0);
        END;
    end;
    // BC UPGRADE SHIKHD02 <<

    // BC Upgrade VAMSIU01 Codeunit 82 "Sales-Post + Print" >>

    // # The logic written in the PrintReceive procedure in Navision has been implemented using the OnBeforePrintReceive Event.
    // # The logic written in the PrintInvoice procedure in Navision has been implemented using the OnPrintInvoiceOnAfterSetSalesInvHeaderFilter Event.
    // # The logic written in the PrintShip procedure in Navision has been implemented using the OnBeforePrintShip Event.
    // # The logic written in the PrintCrMemo procedure in Navision has been implemented using the OnBeforePrintCrMemo Event.

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", OnBeforePrintReceive, '', false, false)]
    local procedure "Sales-Post+Print_OnBeforePrintReceive"(var SalesHeader: Record "Sales Header"; SendReportAsEmail: Boolean; var IsHandled: Boolean)
    var
        ReturnRcptHeader: Record "Return Receipt Header";
    begin
        // Skip base logic
        IsHandled := true;

        // Recreate base logic
        ReturnRcptHeader."No." := SalesHeader."Last Return Receipt No.";
        if ReturnRcptHeader.Find() then;

        ReturnRcptHeader.SetRecFilter();

        // NAV customization
        ReturnRcptHeader."Document Subtype Code FND" := SalesHeader."Document Subtype Code FND";

        // Continue base logic
        if SendReportAsEmail then
            ReturnRcptHeader.EmailRecords(true)
        else
            ReturnRcptHeader.PrintRecords(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", OnPrintInvoiceOnAfterSetSalesInvHeaderFilter, '', false, false)]
    local procedure "Sales-Post+Print_OnPrintInvoiceOnAfterSetSalesInvHeaderFilter"(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; SendReportAsEmail: Boolean)
    begin
        SalesInvoiceHeader."Document Subtype Code FND" := SalesHeader."Document Subtype Code FND";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", OnBeforePrintShip, '', false, false)]
    local procedure "Sales-Post+Print_OnBeforePrintShip"(var SalesHeader: Record "Sales Header"; SendReportAsEmail: Boolean; var IsHandled: Boolean)
    var
        SalesShptHeader: Record "Sales Shipment Header";
    begin
        IsHandled := true;

        SalesShptHeader."No." := SalesHeader."Last Shipping No.";
        if SalesShptHeader.Find() then;
        SalesShptHeader.SetRecFilter();

        SalesShptHeader."Document Subtype Code FND" := SalesHeader."Document Subtype Code FND";

        if SendReportAsEmail then
            SalesShptHeader.EmailRecords(true)
        else
            SalesShptHeader.PrintRecords(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", OnBeforePrintCrMemo, '', false, false)]
    local procedure "Sales-Post+ Print_OnBeforePrintCrMemo"(var SalesHeader: Record "Sales Header"; SendReportAsEmail: Boolean; var IsHandled: Boolean)
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        IsHandled := true;

        if SalesHeader."Last Posting No." = '' then
            SalesCrMemoHeader."No." := SalesHeader."No."
        else
            SalesCrMemoHeader."No." := SalesHeader."Last Posting No.";
        SalesCrMemoHeader.Find();
        SalesCrMemoHeader.SetRecFilter();

        SalesCrMemoHeader."Document Subtype Code FND" := SalesHeader."Document Subtype Code FND";

        if SendReportAsEmail then
            SalesCrMemoHeader.EmailRecords(true)
        else
            SalesCrMemoHeader.PrintRecords(false);

    end;

    // BC Upgrade VAMSIU01 Codeunit 82 "Sales-Post + Print" <<

    // BC Upgrade VAMSIU01 Codeunit 226 "CustEntry-Apply Posted Entries" >>
    // # The logic written in the CustPostApplyCustLedgEntry procedure in Navision has been implemented using the OnBeforePostApplyCustLedgEntry Event.
    // # The logic written in the PostUnApplyCustomerCommit procedure in Navision has been implemented using the OnBeforePostUnapplyCustLedgEntry Event.

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CustEntry-Apply Posted Entries", OnBeforePostApplyCustLedgEntry, '', false, false)]
    local procedure "CustEntry-Apply Posted Entries_OnBeforePostApplyCustLedgEntry"(var GenJournalLine: Record "Gen. Journal Line"; CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; ApplyUnapplyParameters: Record "Apply Unapply Parameters" temporary)
    begin
        GenJournalLine."Document Subtype Code FND" := CustLedgerEntry."Document Subtype Code FND";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CustEntry-Apply Posted Entries", OnBeforePostUnapplyCustLedgEntry, '', false, false)]
    local procedure "CustEntry-Apply Posted Entries_OnBeforePostUnapplyCustLedgEntry"(var GenJournalLine: Record "Gen. Journal Line"; CustLedgerEntry: Record "Cust. Ledger Entry"; DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; ApplyUnapplyParameters: Record "Apply Unapply Parameters" temporary)
    begin
        GenJournalLine."Document Subtype Code FND" := CustLedgerEntry."Document Subtype Code FND";
    end;

    //BC Upgrade VAMSIU01 Codeunit 226 "CustEntry-Apply Posted Entries" <<

    // BC Upgrade VAMSIU01 Codeunit 227 "VendEntry-Apply Posted Entries" >>
    // # The logic written in the VendPostApplyVendLedgEntry procedure in Navision has been implemented using the OnBeforePostApplyVendLedgEntry Event.
    // # The logic written in the PostUnApplyVendor procedure in Navision has been implemented using the OnBeforePostUnapplyVendLedgEntry Event.

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"VendEntry-Apply Posted Entries", OnBeforePostApplyVendLedgEntry, '', false, false)]
    local procedure "VendEntry-Apply Posted Entries_OnBeforePostApplyVendLedgEntry"(var GenJournalLine: Record "Gen. Journal Line"; VendorLedgerEntry: Record "Vendor Ledger Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; ApplyUnapplyParameters: Record "Apply Unapply Parameters" temporary)
    begin
        GenJournalLine."Document Subtype Code FND" := VendorLedgerEntry."Document Subtype Code FND";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"VendEntry-Apply Posted Entries", OnBeforePostUnapplyVendLedgEntry, '', false, false)]
    local procedure "VendEntry-Apply Posted Entries_OnBeforePostUnapplyVendLedgEntry"(var GenJournalLine: Record "Gen. Journal Line"; VendorLedgerEntry: Record "Vendor Ledger Entry"; DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; ApplyUnapplyParameters: Record "Apply Unapply Parameters" temporary)
    begin
        GenJournalLine."Document Subtype Code FND" := VendorLedgerEntry."Document Subtype Code FND";
    end;
    // BC Upgrade VAMSIU01 Codeunit 227 "VendEntry-Apply Posted Entries" <<
    // BC Upgrade BHARDA11 >> --FDD STP 003
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInitPostingNoSeries', '', false, false)]
    local procedure OnAfterInitPostingNoSeries(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header")
    var
        PurchPaySetup: Record "Purchases & Payables Setup";
    begin
        PurchPaySetup.Get();
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then
            PurchaseHeader."Document Subtype Code FND" := PurchPaySetup."PO Subtype Code FND";
    end;
    // BC Upgrade BHARAD11 << --FDD STP 003
    //BC UPGRADE ATHUKUS01 FDDSTP_007>> 
    [EventSubscriber(ObjectType::Table, Database::"Vendor Bank Account", OnBeforeDeleteEvent, '', false, false)]
    local procedure OnBeforeDeleteVendorBankAccount(var Rec: Record "Vendor Bank Account"; RunTrigger: Boolean)
    var
        Vendor: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
        RemainingBankAcc: Record "Vendor Bank Account";
        cnt: Integer;
        Cu5: Codeunit 50007;
    begin
        if RunTrigger = false then
            exit;

        // Count remaining bank accounts (excluding the one being deleted)
        VendBankAcc.Reset();
        VendBankAcc.SetRange("Vendor No.", Rec."Vendor No.");
        VendBankAcc.SetFilter(Code, '<>%1', Rec.Code);

        cnt := 0;
        if VendBankAcc.FindSet() then
            repeat
                cnt := cnt + 1;
            until VendBankAcc.Next() = 0;

        // Now update Vendor's Preferred Bank Account
        if Vendor.Get(Rec."Vendor No.") then begin
            if cnt = 1 then begin
                // Exactly 1 remaining → set that as preferred
                VendBankAcc.Reset();
                VendBankAcc.SetRange("Vendor No.", Rec."Vendor No.");
                VendBankAcc.SetFilter(Code, '<>%1', Rec.Code);
                if VendBankAcc.FindFirst() then
                    Vendor."Preferred Bank Account Code" := VendBankAcc.Code;
            end else begin
                // 0 or more than 1 remaining → blank it
                Vendor."Preferred Bank Account Code" := '';
            end;
            Vendor.Modify();
            Vendor.Validate("Payment Method Code");
        end;
    end;

    [EventSubscriber(ObjectType::codeunit, codeunit::ArchiveManagement, OnBeforePurchHeaderArchiveInsert, '', false, false)]
    local procedure OnBeforePurchHeaderArchiveInsert(var PurchaseHeaderArchive: Record "Purchase Header Archive"; PurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeaderArchive."Document Subtype Code FND" := PurchaseHeader."Document Subtype Code FND";
    end;
    //BC UPGRADE ATHUKUS01 FDDSTP_007<<


    //BC Upgrade - RD03 ---------------------------------------------------->>

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", OnInsertWorkflowTemplates, '', false, false)]
    local procedure OnInsertWorkflowTemplates()
    begin
        InsertItemJournalBatchApprovalWorkflowTemplate();
        InsertItemJournalLineApprovalWorkflowTemplate();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", OnAddWorkflowCategoriesToLibrary, '', false, false)]
    local procedure OnAddWorkflowCategoriesToLibrary()
    var
        WorkFlowSetup: Codeunit "Workflow Setup";
    begin
        WorkFlowSetup.InsertWorkflowCategory(FinItemCategoryTxt, FinItemCategoryDescTxt);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", OnAfterInsertApprovalsTableRelations, '', false, false)]
    local procedure OnAfterInsertApprovalsTableRelations()
    var
        WorkFlowSetup: Codeunit "Workflow Setup";
        ApprovalEntry: Record "Approval Entry";
    begin
        WorkFlowSetup.InsertTableRelation(DATABASE::"Item Journal Line", 0,
          DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
        WorkFlowSetup.InsertTableRelation(DATABASE::"Item Journal Batch", 0,
          DATABASE::"Approval Entry", ApprovalEntry.FIELDNO("Record ID to Approve"));
    end;

    local procedure InsertItemJournalBatchApprovalWorkflowTemplate()
    var
        WorkFlowSetup: Codeunit "Workflow Setup";
        Workflow: Record Workflow;
    begin
        //HEI.01>>
        //WorkFlowSetup.insertw
        WorkFlowSetup.InsertWorkflowTemplate(Workflow, ItemJournalBatchApprWorkflowCodeTxt, ItemJournalBatchApprWorkflowDescTxt, FinItemCategoryTxt);
        InsertItemJournalBatchApprovalWorkflowDetails(Workflow);
        WorkFlowSetup.MarkWorkflowAsTemplate(Workflow);
        //HEI.01<<
    end;

    local procedure InsertItemJournalBatchApprovalWorkflowDetails(VAR Workflow: Record Workflow)
    var
        WorkFlowSetup: Codeunit "Workflow Setup";
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkFlowSetup.InitWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver,
        WorkflowStepArgument."Approver Limit Type"::"Direct Approver", 0, '', BlankDateFormula, TRUE);
        InsertItemJnlBatchApprovalWorkflowSteps(Workflow, BuildItemJournalBatchTypeConditions(),
          Heineken_WorkflowEventHandling.RunWorkflowOnSendItemJournalBatchForApprovalRequestCode(),
          WorkflowResponseHandling.CreateApprovalRequestsCode(),
          WorkflowResponseHandling.SendApprovalRequestForApprovalCode(),
          Heineken_WorkflowEventHandling.RunWorkflowOnCancelItemJournalBatchApprovalRequestCode(),
          WorkflowStepArgument, TRUE);
        //HEI.01<<
    end;

    local procedure InsertItemJournalLineApprovalWorkflowTemplate()
    var
        WorkFlowSetup: Codeunit "Workflow Setup";
        Workflow: Record Workflow;
    begin
        WorkFlowSetup.InsertWorkflowTemplate(Workflow, ItemJournalLineApprWorkflowCodeTxt,
          ItemJournalLineApprWorkflowDescTxt, FinItemCategoryTxt);
        InsertItemJournalLineApprovalWorkflowDetails(Workflow);
        WorkFlowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertItemJournalLineApprovalWorkflowDetails(var Workflow: Record Workflow)
    var
        WorkFlowSetup: Codeunit "Workflow Setup";
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        ItemJournalLine: Record "Item Journal Line";
    begin
        WorkFlowSetup.InitWorkflowStepArgument(WorkflowStepArgument,
         WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
         0, '', BlankDateFormula, FALSE);

        ItemJournalLine.INIT();
        WorkFlowSetup.InsertRecApprovalWorkflowSteps(Workflow, BuildItemJournalLineTypeConditions(ItemJournalLine),
          Heineken_WorkflowEventHandling.RunWorkflowOnSendItemJournalLineForApprovalRequestCode(),
          WorkflowResponseHandling.CreateApprovalRequestsCode(),
          WorkflowResponseHandling.SendApprovalRequestForApprovalCode(),
          Heineken_WorkflowEventHandling.RunWorkflowOnCancelItemJournalLineApprovalRequestCode(), WorkflowStepArgument, FALSE, FALSE);
        //HEI.01<<
    end;

    procedure InsertItemJnlBatchApprovalWorkflowSteps(Workflow: Record Workflow; ConditionString: Text; RecSendForApprovalEventCode: Code[128]; RecCreateApprovalRequestsCode: Code[128]; RecSendApprovalRequestForApprovalCode: Code[128]; RecCanceledEventCode: Code[128]; WorkflowStepArgument: Record "Workflow Step Argument"; ShowConfirmationMessage: Boolean)
    var
        WorkFlowSetup: Codeunit "Workflow Setup";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        Heineken_WorkflowResponseHandling: Codeunit "Heineken BC Upgrade";
        SentForApprovalEventID: Integer;
        CheckBatchBalanceResponseID: Integer;
        OnBatchIsBalancedEventID: Integer;
        OnBatchIsNotBalancedEventID: Integer;
        CreateApprovalRequestResponseID: Integer;
        SendApprovalRequestResponseID: Integer;
        OnAllRequestsApprovedEventID: Integer;
        OnRequestApprovedEventID: Integer;
        SendApprovalRequestResponseID2: Integer;
        OnRequestRejectedEventID: Integer;
        RejectAllApprovalsResponseID: Integer;
        OnRequestCanceledEventID: Integer;
        CancelAllApprovalsResponseID: Integer;
        OnRequestDelegatedEventID: Integer;
        SentApprovalRequestResponseID3: Integer;
        ShowMessageResponseID: Integer;
        RestrictUsageResponseID: Integer;
    begin
        //HEI.01>>
        SentForApprovalEventID := WorkFlowSetup.InsertEntryPointEventStep(Workflow, RecSendForApprovalEventCode);
        WorkFlowSetup.InsertEventArgument(SentForApprovalEventID, ConditionString);

        CheckBatchBalanceResponseID := WorkFlowSetup.InsertResponseStep(Workflow, Heineken_WorkflowResponseHandling.CheckItemJournalBatchBalanceCode(),
            SentForApprovalEventID);

        OnBatchIsBalancedEventID := WorkFlowSetup.InsertEventStep(Workflow, Heineken_WorkflowEventHandling.RunWorkflowOnItemJournalBatchBalancedCode(),
            CheckBatchBalanceResponseID);

        RestrictUsageResponseID := WorkFlowSetup.InsertResponseStep(Workflow, WorkflowResponseHandling.RestrictRecordUsageCode(),
            OnBatchIsBalancedEventID);
        CreateApprovalRequestResponseID := WorkFlowSetup.InsertResponseStep(Workflow, RecCreateApprovalRequestsCode,
            RestrictUsageResponseID);
        WorkFlowSetup.InsertApprovalArgument(CreateApprovalRequestResponseID,
          WorkflowStepArgument."Approver Type", WorkflowStepArgument."Approver Limit Type",
          WorkflowStepArgument."Workflow User Group Code", WorkflowStepArgument."Approver User ID",
          WorkflowStepArgument."Due Date Formula", ShowConfirmationMessage);
        SendApprovalRequestResponseID := WorkFlowSetup.InsertResponseStep(Workflow, RecSendApprovalRequestForApprovalCode,
            CreateApprovalRequestResponseID);
        WorkFlowSetup.InsertNotificationArgument(SendApprovalRequestResponseID, true, '', 0, ''); //BC Upgrade RD03 an additional standard parameter has been introduced in Business Central 'InsertNotificationArgument'. 

        OnAllRequestsApprovedEventID := WorkFlowSetup.InsertEventStep(Workflow, WEH.RunWorkflowOnApproveApprovalRequestCode(),
            SendApprovalRequestResponseID);
        WorkFlowSetup.InsertEventArgument(OnAllRequestsApprovedEventID, BuildNoPendingApprovalsConditions());
        WorkFlowSetup.InsertResponseStep(Workflow, WorkflowResponseHandling.AllowRecordUsageCode(), OnAllRequestsApprovedEventID);

        OnRequestApprovedEventID := WorkFlowSetup.InsertEventStep(Workflow, WEH.RunWorkflowOnApproveApprovalRequestCode(),
            SendApprovalRequestResponseID);
        WorkFlowSetup.InsertEventArgument(OnRequestApprovedEventID, BuildPendingApprovalsConditions());
        SendApprovalRequestResponseID2 := WorkFlowSetup.InsertResponseStep(Workflow, WorkflowResponseHandling.SendApprovalRequestForApprovalCode(),
            OnRequestApprovedEventID);

        WorkFlowSetup.SetNextStep(Workflow, SendApprovalRequestResponseID2, SendApprovalRequestResponseID);

        OnRequestRejectedEventID := WorkFlowSetup.InsertEventStep(Workflow, WEH.RunWorkflowOnRejectApprovalRequestCode(),
            SendApprovalRequestResponseID);
        RejectAllApprovalsResponseID := WorkFlowSetup.InsertResponseStep(Workflow, WorkflowResponseHandling.RejectAllApprovalRequestsCode(),
            OnRequestRejectedEventID);
        WorkFlowSetup.InsertNotificationArgument(RejectAllApprovalsResponseID, true, '', WorkflowStepArgument."Link Target Page", '');//BC Upgrade RD03 an additional standard parameter has been introduced in Business Central 'InsertNotificationArgument'. 

        OnRequestCanceledEventID := WorkFlowSetup.InsertEventStep(Workflow, RecCanceledEventCode, SendApprovalRequestResponseID);
        CancelAllApprovalsResponseID := WorkFlowSetup.InsertResponseStep(Workflow, WorkflowResponseHandling.CancelAllApprovalRequestsCode(),
            OnRequestCanceledEventID);
        WorkFlowSetup.InsertNotificationArgument(CancelAllApprovalsResponseID, true, '', WorkflowStepArgument."Link Target Page", '');//BC Upgrade RD03 an additional standard parameter has been introduced in Business Central 'InsertNotificationArgument'. 
        ShowMessageResponseID := WorkFlowSetup.InsertResponseStep(Workflow, WorkflowResponseHandling.ShowMessageCode(), CancelAllApprovalsResponseID);
        WorkFlowSetup.InsertMessageArgument(ShowMessageResponseID, ApprovalRequestCanceledMsg);

        OnRequestDelegatedEventID := WorkFlowSetup.InsertEventStep(Workflow, WEH.RunWorkflowOnDelegateApprovalRequestCode(),
            SendApprovalRequestResponseID);
        SentApprovalRequestResponseID3 := WorkFlowSetup.InsertResponseStep(Workflow, WorkflowResponseHandling.SendApprovalRequestForApprovalCode(),
            OnRequestDelegatedEventID);

        WorkFlowSetup.SetNextStep(Workflow, SentApprovalRequestResponseID3, SendApprovalRequestResponseID);

        OnBatchIsNotBalancedEventID := WorkFlowSetup.InsertEventStep(Workflow, Heineken_WorkflowEventHandling.RunWorkflowOnItemJournalBatchNotBalancedCode(),
            CheckBatchBalanceResponseID);

        ShowMessageResponseID := WorkFlowSetup.InsertResponseStep(Workflow, WorkflowResponseHandling.ShowMessageCode(), OnBatchIsNotBalancedEventID);
        WorkFlowSetup.InsertMessageArgument(ShowMessageResponseID, ItemJournalBatchIsNotBalancedMsg);
        //HEI.01<<
    end;
    // Changed type of ApproverType, LimitType from option to enum to remove warning.
    procedure InsertItemJnlLineApprovalWorkflow(var Workflow: Record Workflow; EventConditions: Text; ApproverType: Enum "Workflow Approver Type"; LimitType: Enum "Workflow Approval Type"; WorkflowUserGroupCode: Code[20]; SpecificApprover: Code[50]; DueDateFormula: DateFormula)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        WorkFlowSetup: Codeunit "Workflow Setup";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        //HEI.01>>
        WorkFlowSetup.InitWorkflowStepArgument(WorkflowStepArgument, ApproverType, LimitType, 0,
          WorkflowUserGroupCode, DueDateFormula, TRUE);
        WorkflowStepArgument."Approver User ID" := SpecificApprover;
        WorkFlowSetup.InsertRecApprovalWorkflowSteps(Workflow, EventConditions,
          Heineken_WorkflowEventHandling.RunWorkflowOnSendItemJournalLineForApprovalRequestCode(),
          WorkflowResponseHandling.CreateApprovalRequestsCode(),
          WorkflowResponseHandling.SendApprovalRequestForApprovalCode(),
          Heineken_WorkflowEventHandling.RunWorkflowOnCancelItemJournalLineApprovalRequestCode(),
          WorkflowStepArgument,
          FALSE, FALSE);
        //HEI.01<<
    end;

    procedure BuildItemJournalBatchTypeConditions(): Text
    var
        ItemJournalBatch: Record "Item Journal Batch";
    begin
        //HEI.01>>
        EXIT(BuildItemJournalBatchTypeConditionsFromRec(ItemJournalBatch));
        //HEI.01<<
    end;

    procedure CheckItemJournalBatchBalanceCode(): Code[128]
    begin
        //HEI.07>>
        EXIT(UPPERCASE('CheckItemJournalBatchBalance'));
        //HEI.07<<
    end;

    procedure BuildItemJournalBatchTypeConditionsFromRec(var ItemJournalBatch: Record "Item Journal Batch"): Text
    begin
        //HEI.01>>
        EXIT(STRSUBSTNO(ItemJournalBatchTypeCondnTxt, Encode(ItemJournalBatch.GETVIEW(FALSE))));
        //HEI.01<<
    end;

    procedure BuildItemJournalLineTypeConditions(var ItemJournalLine: Record "Item Journal Line"): Text
    begin
        //HEI.01>>
        EXIT(STRSUBSTNO(ItemJournalLineTypeCondnTxt, Encode(ItemJournalLine.GETVIEW(FALSE))));
        //HEI.01<<
    end;

    procedure ItemJournalBatchApprovalWorkflowCode(): Code[17]
    begin
        //HEI.01>>
        EXIT(ItemJournalBatchApprWorkflowCodeTxt);
        //HEI.01<<
    end;

    procedure ItemJournalLineApprovalWorkflowCode(): Code[17]
    begin
        //HEI.01>>
        EXIT(ItemJournalLineApprWorkflowCodeTxt);
        //HEI.01<<
    end;

    procedure RunWorkflowOnCancelItemJournalLineApprovalRequestCode(): Code[128]
    begin
        //HEI.01>>
        //EXIT(UPPERCASE('RunWorkflowOnCancelItemJournalLineApprovalReq'));
        //HEI.01<<
    end;

    local procedure BuildNoPendingApprovalsConditions(): Text
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SETRANGE("Pending Approvals", 0);
        EXIT(STRSUBSTNO(PendingApprovalsCondnTxt, Encode(ApprovalEntry.GETVIEW(FALSE))));
    end;

    local procedure BuildPendingApprovalsConditions(): Text
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.SETFILTER("Pending Approvals", '>%1', 0);
        EXIT(STRSUBSTNO(PendingApprovalsCondnTxt, Encode(ApprovalEntry.GETVIEW(FALSE))));
    end;

    local procedure Encode(Text: Text): Text
    var
        XMLDOMManagement: Codeunit "XML DOM Management";
    begin
        EXIT(XMLDOMManagement.XMLEscape(Text));
    end;

    var

        CreatereserveInsertReservEntry2: Record "Reservation Entry";//BC Upgrade Kamnay01 07/04/2026 FDD DTW-011  this variale is created becuse to store the value of InsertReservEntry2 from CU 99000830 
        ItemJournalBatchApprWorkflowCodeTxt: Label 'PIJBAPW';
        ItemJournalBatchApprWorkflowDescTxt: Label 'Phys. Inv. Journal Batch Approval Workflow';
        ItemJournalLineApprWorkflowCodeTxt: Label 'PIJLAPW';
        ItemJournalLineApprWorkflowDescTxt: Label 'Phys. Inv. Journal Line Approval Workflow';
        FinItemCategoryTxt: Label 'FIN-DTW';
        FinItemCategoryDescTxt: Label 'Finance-DTW';
        ItemJournalBatchIsNotBalancedMsg: Label 'The selected Phys. Inv. journal batch is not balanced and cannot be sent for approval.';
        ApprovalRequestCanceledMsg: Label 'The approval request for the record has been canceled.';
        PendingApprovalsCondnTxt: Label '<?xml version="1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name="Approval Entry">%1</DataItem></DataItems></ReportParameters>', Locked = true;
        ItemJournalBatchTypeCondnTxt: Label '<?xml version="1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name="Item Journal Batch">%1</DataItem></DataItems></ReportParameters>', Locked = true;
        ItemJournalLineTypeCondnTxt: Label '<?xml version="1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name="Item Journal Line">%1</DataItem></DataItems></ReportParameters>', Locked = true;
        //BC Upgrade GUNREM01 - Item availability by BOM level >>
        InHeinekenBOMProcessing: Boolean;
        EnableHeinekenBOMTrace: Boolean;
        MaxBOMDepth: Integer;
        CurrentBOMDepth: Integer;
        ItemM: Code[20];
    //BC Upgrade GUNREM01 - Item availability by BOM level <<
    //BC Upgrade - RD03 ---------------------------------------------------<<
    // BC Upgrade BHARAD11 >> -- FDD STP 004
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeValidateShortcutDimCode', '', false, false)]
    local procedure OnBeforeValidateShortcutDimCode(var PurchaseLine: Record "Purchase Line"; var xPurchaseLine: Record "Purchase Line"; FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    begin
        PurchaseLine.TestStatusOpen();
    end;
    // BC Upgrade BHARDA11 << --FDD STP 004
    // BC UPGRADE KAIRAR01 table 83 "Item Journal Line" PID-520 FDD-RTR-006 >>
    // BC UPgrade BHARAD11 >> --- Comment this event because This code has been commented out because it was preventing Dimensions from updating correctly on the Item Journal. It was updating the Bin dimensions in every case. 
    // [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnBeforeVerifyReservedQty, '', false, false)]
    // local procedure OnBeforeVerifyReservedQty(var ItemJournalLine: Record "Item Journal Line"; xItemJournalLine: Record "Item Journal Line"; CalledByFieldNo: Integer)
    // begin
    //     if ((not (ItemJournalLine."Order Type" in [ItemJournalLine."Order Type"::Production, ItemJournalLine."Order Type"::Assembly]))
    //     or (ItemJournalLine."Order No." = '')) and not ItemJournalLine."Phys. Inventory" then
    //         ItemJournalLine.UpdateCCCfromBinCode(); //HEI.24
    // end;
    // BC UPgrade BHARAD11 << --- Comment this event because This code has been commented out because it was preventing Dimensions from updating correctly on the Item Journal. It was updating the Bin dimensions in every case. 

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterValidateEvent, 'Location Code', false, false)]
    local procedure OnAfterValidate_LocationCode(var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line"; CurrFieldNo: Integer)
    begin
        if (Rec."Line No." <> 0) AND ((Rec."Order Type" <> Rec."Order Type"::Production) OR (Rec."Order No." = '')) then
            Rec.UpdateCCCfromBinCode(); //HEI.24
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterValidateEvent, 'Salespers./Purch. Code', false, false)]
    local procedure OnAfterValidate_SalesPersPurchCode(var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line"; CurrFieldNo: Integer)
    begin
        if (Rec."Order Type" <> Rec."Order Type"::Production) OR (Rec."Order No." = '') then
            Rec.UpdateCCCfromBinCode(); //HEI.24
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterValidateEvent, 'Bin Code', false, false)]
    local procedure OnAfterValidate_BinCode(var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line"; CurrFieldNo: Integer)
    begin
        if (Rec."Line No." <> 0) AND ((Rec."Order Type" <> Rec."Order Type"::Production) OR (Rec."Order No." = '')) then Begin
            Rec.CreateDimFromDefaultDim(Rec.FieldNo("Item No.")); //BC Upgrade Kamnay01 CCC Dimension Bug fix 
            Rec.UpdateCCCfromBinCode(); //HEI.24
        end
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterValidateEvent, 'Item Charge No.', false, false)]
    local procedure OnAfterValidate_ItemChargeNo(var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line"; CurrFieldNo: Integer)
    begin
        if (Rec."Line No." <> 0) AND ((Rec."Order Type" <> Rec."Order Type"::Production) OR (Rec."Order No." = '')) then
            Rec.UpdateCCCfromBinCode(); //HEI.24
    end;
    // BC UPGRADE KAIRAR01 table 83 "Item Journal Line" PID-520 FDD-RTR-006 <<


    //PATHAA02 01.04.26 #FDD-Unit Volume HL-Assembly Orders[FDD PID-750, PID-826, PID-76, PID-801, FDD DtW 017, IBM GAP DTW 76]>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterInitItemLedgEntry, '', false, false)]
    local procedure ItemJnlPostLine_OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    var
        Item: Record Item;
    begin
        Item.Get(ItemJournalLine."Item No.");
        NewItemLedgEntry."Unit Volume HL FND" := Item."Unit Volume";
        // NewItemLedgEntry."Quantity in HL" := ItemJournalLine."Quantity (Base)" * Item."Unit Volume";
    end;

    //New field- "Volume 1" is similar field to DIT field in NAV- "Quantity HL". This field is added now by Aptean in ILE but not in VE with the same name-Volume 1.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterInitValueEntry, '', false, false)]
    local procedure OnAfterInitValueEntry(var ValueEntry: Record "Value Entry"; var ItemJournalLine: Record "Item Journal Line"; var ValueEntryNo: Integer; var ItemLedgEntry: Record "Item Ledger Entry")
    var
        Item: Record Item;
    begin
        Item.Get(ItemJournalLine."Item No.");
        ValueEntry."Unit Volume HL FND" := Item."Unit Volume";
        //Assembly Orders>>
        IF ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::"Assembly Output" THEN //Postive Value
            ValueEntry."Volume 1 FND" := ItemJournalLine."Quantity (Base)" * Item."Unit Volume";
        IF ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::"Assembly Consumption" THEN //Negative Value
            ValueEntry."Volume 1 FND" := -1 * ItemJournalLine."Quantity (Base)" * Item."Unit Volume";
        //Assembly Orders<<   
    end;
    //PATHAA02 01.04.26 #FDD-Unit Volume HL-Assembly Orders[FDD PID-750, PID-826, PID-76, PID-801, FDD DtW 017, IBM GAP DTW 76] <<


    //PATHAA02-05.04.26 #FDD-COGS-[PID803,FDD-DTW-022,IBM GAP DTW54]>>

    [EventSubscriber(ObjectType::Table, Database::"Value Entry", OnBeforeInsertEvent, '', false, false)]
    local procedure CalcHLQuantity(var Rec: Record "Value Entry")
    var
        Item: Record Item;
    begin
        if Item.Get(Rec."Item No.") then begin
            Rec."Invoiced Quantity HL FND" := Rec."Invoiced Quantity" * Item."Unit Volume";
        end;
    end;
    //PATHAA02-05.04.26 #FDD-COGS-[PID803,FDD-DTW-022,IBM GAP DTW54]<<
    // BC Upgrade BHARDA11 >>  ---These Event is used to Store "Qty. to Receive" value in "Qty. to Reveive Heilite" and then vice-versa
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnValidateQtyToReceiveOnAfterCalcShouldCheckLocationRequireReceive, '', false, false)]
    local procedure OnValidateQtyToReceiveOnAfterCalcShouldCheckLocationRequireReceive(var PurchaseLine: Record "Purchase Line"; var ShouldCheckLocationRequireReceive: Boolean)
    begin
        if PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Blanket Order" then begin
            PurchaseLine."Qty. to Receive" := 0;
            ShouldCheckLocationRequireReceive := false;
            PurchaseLine."Qty. to Receive" := PurchaseLine."Qty. to Reveive Heilite FND";
        end;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeInitQtyToReceive, '', false, false)]
    local procedure OnBeforeInitQtyToReceive(var PurchaseLine: Record "Purchase Line"; CurrFieldNo: Integer; var IsHandled: Boolean)
    begin
        if PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Blanket Order" then begin
            IsHandled := true;
            PurchaseLine.InitQtyToInvoice();
            PurchaseLine."Qty. to Reveive Heilite FND" := PurchaseLine."Qty. to Receive";
        end;

    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeMaxQtyToInvoice, '', false, false)]
    local procedure OnBeforeMaxQtyToInvoice(PurchaseLine: Record "Purchase Line"; var MaxQty: Decimal; var IsHandled: Boolean)
    begin
        if PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Blanket Order" then begin
            if PurchaseLine."Prepayment Line" then begin
                MaxQty := 1;
            end;
            // exit(1);

            if PurchaseLine.IsCreditDocType() then
                MaxQty := PurchaseLine."Return Qty. Shipped" + PurchaseLine."Return Qty. to Ship" - PurchaseLine."Quantity Invoiced";
            // if PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Blanket Order" then
            //     MaxQty := PurchaseLine.Quantity - PurchaseLine."Quantity Invoiced";
            MaxQty := PurchaseLine."Quantity Received" + PurchaseLine."Qty. to Receive" - PurchaseLine."Quantity Invoiced";
            IsHandled := true;
        end;
    end;
    // BC Upgrade BHARDA11 <<  ---These Event is used to Store "Qty. to Receive" value in "Qty. to Reveive Heilite" and then vice-versa

    // BC Upgrade BHARDA11 >> 
    // [EventSubscriber(ObjectType::Codeunit, codeunit::"Blanket Purch. Order to Order", 'OnAfterPurchOrderLineInsert', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Blanket Purch. Order to Order", 'OnRunOnAfterInitPurchOrderLineFromBlanketOrderLine', '', false, false)]
    local procedure OnRunOnAfterInitPurchOrderLineFromBlanketOrderLine(var PurchaseOrderLine: Record "Purchase Line"; var BlanketOrderPurchaseLine: Record "Purchase Line")
    // local procedure C97OnAfterInitPurchLine(var BlanketOrderPurchLine: Record "Purchase Line"; var PurchaseLine: Record "Purchase Line");
    // local procedure OnAfterPurchOrderLineInsert(var PurchaseLine: Record "Purchase Line"; var BlanketOrderPurchLine: Record "Purchase Line")
    begin
        //HEI.04>>
        if BlanketOrderPurchaseLine."Document Type" <> BlanketOrderPurchaseLine."Document Type"::"Blanket Order" then
            exit;

        if BlanketOrderPurchaseLine."SRM Contract No. FND" = '' then
            exit;

        BlanketOrderPurchaseLine.TESTFIELD("Consumption Location Code FND");
        PurchaseOrderLine."Location Code" := BlanketOrderPurchaseLine."Consumption Location Code FND"; // BC Upgrade BHARDA11 --11April2026
        PurchaseOrderLine."Initial Quantity FND" := BlanketOrderPurchaseLine."Qty. to Receive";
        //HEI.04<<
    end;
    // BC Upgrade BHARAD11 <<

    // BC Upgrade BHARAD11 >> --There are some base code commented in Blanket Order Line No. Field onvalidate trigger  so we suscribe this event for the same
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeValidateBlanketOrderLineNo, '', false, false)]
    local procedure OnBeforeValidateBlanketOrderLineNo(var PurchaseLine: Record "Purchase Line"; var InHandled: Boolean);
    var
        PurchLine2: Record "Purchase Line";
    begin
        PurchaseLine.TestField("Quantity Received", 0);
        if PurchaseLine."Blanket Order Line No." <> 0 then begin
            PurchLine2.Get(PurchaseLine."Document Type"::"Blanket Order", PurchaseLine."Blanket Order No.", PurchaseLine."Blanket Order Line No.");
            //HEI.26>>
            // PurchLine2.TestField(Type, PurchaseLine.Type);
            // PurchLine2.TestField("No.", PurchaseLine."No.");
            //HEI.26<<
            PurchLine2.TestField("Pay-to Vendor No.", PurchaseLine."Pay-to Vendor No.");
            PurchLine2.TestField("Buy-from Vendor No.", PurchaseLine."Buy-from Vendor No.");
            //HEI.26>>
            // if "Drop Shipment" or "Special Order" then begin
            //     PurchLine2.TestField("Variant Code", "Variant Code");
            //     PurchLine2.TestField("Location Code", "Location Code");
            //     PurchLine2.TestField("Unit of Measure Code", "Unit of Measure Code");
            // end else begin
            //     Validate("Variant Code", PurchLine2."Variant Code");
            //     Validate("Location Code", PurchLine2."Location Code");
            //     Validate("Unit of Measure Code", PurchLine2."Unit of Measure Code");
            // end;
            // Validate("Direct Unit Cost", PurchLine2."Direct Unit Cost");
            // Validate("Line Discount %", PurchLine2."Line Discount %");
            //HEI.26<<
            InHandled := true;
        end;
    end;

    // BC Upgrade BHARAD11 <<  --There are some base code commented in Blanket Order Line No. Field onvalidate trigger  so we suscribe this event for the same
    //BC Upgrade GUNREM01 Blocked SKU GAP12_DTW >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnPostItemOnAfterGetSKU, '', false, false)]

    local procedure "Item Jnl.-Post Line_OnPostItemOnAfterGetSKU"(var ItemJnlLine: Record "Item Journal Line"; var SKUExists: Boolean; var IsHandled: Boolean)
    var
        Item: Record Item;
        pob: Record "Production BOM Line";
    begin
        IF Item.GET(ItemJnlLine."Item No.") THEN BEGIN
            //IF NOT CalledFromAdjustment THEN
            Item.BlockedSKU(ItemJnlLine."Location Code", ItemJnlLine."Variant Code", TRUE);
        end;

        //DITW110.00.11 SFI BL#30569
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Production Journal Mgt", OnInsertConsumptionJnlLineOnBeforeCheck, '', false, false)]
    local procedure "Production Journal Mgt_OnInsertConsumptionJnlLineOnBeforeCheck"(ProdOrderComponent: Record "Prod. Order Component"; ProdOrderLine: Record "Prod. Order Line"; Item: Record Item; var IsHandled: Boolean)
    var
        BlockedMsg: Label '%2 %1 is blocked and therefore, no journal line is created for this %2.', Comment = '%1 - Entity No, %2 - Table caption';

    begin
        // 
        IF Item.BlockedSKU(ProdOrderComponent."Location Code", ProdOrderComponent."Variant Code", FALSE) THEN BEGIN
            MESSAGE(BlockedMsg, ProdOrderComponent."Item No.");
            EXIT;
        END;

        //  DITW110.00.11 SFI BL#30569
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnCheckTransLine, '', false, false)]
    local procedure "TransferOrder-Post Shipment_OnCheckTransLine"(TransferLine: Record "Transfer Line"; TransferHeader: Record "Transfer Header"; Location: Record Location; WhseShip: Boolean; TransShptLine: Record "Transfer Shipment Line"; InvtPickPutaway: Boolean; var WhsePosting: Boolean)
    var
        Rec_Item: Record Item;
    begin
        IF TransferLine."Item No." <> '' THEN BEGIN
            Rec_Item.GET(TransferLine."Item No.");
            Rec_Item.TESTFIELD(Blocked, FALSE);
            // 
            Rec_Item.BlockedSKU(TransferLine."Transfer-from Code", TransferLine."Variant Code", TRUE);
            Rec_Item.BlockedSKU(TransferLine."Transfer-to Code", TransferLine."Variant Code", TRUE);

            //  DITW110.00.11 SFI BL#30569
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnCheckTransLine, '', false, false)]
    local procedure "TransferOrder-Post Receipt_OnCheckTransLine"(TransferLine: Record "Transfer Line"; TransferHeader: Record "Transfer Header"; Location: Record Location; WhseReceive: Boolean)
    var
        Rec_Item: Record Item;
    begin
        IF TransferLine."Item No." <> '' THEN BEGIN
            Rec_Item.GET(TransferLine."Item No.");
            Rec_Item.TESTFIELD(Blocked, FALSE);
            // 
            Rec_Item.BlockedSKU(TransferLine."Transfer-from Code", TransferLine."Variant Code", TRUE);
            Rec_Item.BlockedSKU(TransferLine."Transfer-to Code", TransferLine."Variant Code", TRUE);

            //  DITW110.00.11 SFI BL#30569
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnBeforeDisplayErrorIfItemIsBlocked, '', false, false)]
    local procedure "Item Journal Line_OnBeforeDisplayErrorIfItemIsBlocked"(var Item: Record Item; var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    begin
        // 
        Item.BlockedSKU(ItemJournalLine."Location Code", ItemJournalLine."Variant Code", TRUE);

        // DITW110.00.11 SFI BL#30569
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Production Order", OnBeforeAssignItemNo, '', false, false)]
    // local procedure "Production Order_OnBeforeAssignItemNo"(var ProdOrder: Record "Production Order"; xProdOrder: Record "Production Order"; var Item: Record Item; CallingFieldNo: Integer)
    // begin
    //     // 
    //     Item.BlockedSKU(ProdOrder."Location Code", '', TRUE);

    //     //  DITW110.00.11 SFI BL#30569
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Line", OnValidateItemNoOnAfterAssignItemValues, '', false, false)]
    local procedure "Prod. Order Line_OnValidateItemNoOnAfterAssignItemValues"(var ProdOrderLine: Record "Prod. Order Line"; Item: Record Item; xProdOrderLine: Record "Prod. Order Line"; var IsHandled: Boolean)
    begin
        // 
        Item.BlockedSKU(ProdOrderLine."Location Code", ProdOrderLine."Variant Code", TRUE);

        //   DITW110.00.11 SFI BL#30569
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Line", OnBeforeGetUpdateFromSKU, '', false, false)]
    local procedure "Prod. Order Line_OnBeforeGetUpdateFromSKU"(var ProdOrderLine: Record "Prod. Order Line"; var SKU: Record "Stockkeeping Unit"; var Item: Record Item; var IsHandled: Boolean)
    begin
        // 
        Item.BlockedSKU(ProdOrderLine."Location Code", ProdOrderLine."Variant Code", TRUE);

        //  DITW110.00.11 SFI BL#30569

    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Component", OnBeforeGetUpdateFromSKU, '', false, false)]
    local procedure "Prod. Order Component_OnBeforeGetUpdateFromSKU"(var ProdOrderComponent: Record "Prod. Order Component"; var IsHandled: Boolean)
    var
        Item: Record Item;
    begin
        item.Get(ProdOrderComponent."Item No.");
        // 
        item.BlockedSKU(ProdOrderComponent."Location Code", ProdOrderComponent."Variant Code", TRUE);

        //  DITW110.00.11 SFI BL#30569
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", OnAfterAssignItemValues, '', false, false)]
    local procedure "Transfer Line_OnAfterAssignItemValues"(var TransferLine: Record "Transfer Line"; Item: Record Item; TransferHeader: Record "Transfer Header")
    begin
        // 
        // TODO SF: Check if also "Transfer-to Code" should be checked
        Item.BlockedSKU(TransferLine."Transfer-from Code", TransferLine."Variant Code", TRUE);
        Item.BlockedSKU(TransferLine."Transfer-to Code", TransferLine."Variant Code", TRUE);

        //   DITW110.00.11 SFI BL#30569
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", OnValidateTransferFromCodeOnBeforeCheckItemAvailable, '', false, false)]
    local procedure "Transfer Line_OnValidateTransferFromCodeOnBeforeCheckItemAvailable"(var TransferLine: Record "Transfer Line")
    var
        Item: Record Item;
    begin
        // TODO SF: Check if also "Transfer-to Code" should be checked
        //GetItem;
        Item.BlockedSKU(TransferLine."Transfer-from Code", TransferLine."Variant Code", TRUE);
        Item.BlockedSKU(TransferLine."Transfer-to Code", TransferLine."Variant Code", TRUE)
        //  DITW110.00.11 SFI BL#30569
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnBeforeCopyFromItem, '', false, false)]
    local procedure "Sales Line_OnBeforeCopyFromItem"(var SalesLine: Record "Sales Line"; Item: Record Item; var IsHandled: Boolean)
    begin
        // 
        Item.BlockedSKU(SalesLine."Location Code", SalesLine."Variant Code", TRUE);

        //   DITW110.00.11 SFI BL#30569
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnValidateLocationCodeOnAfterSetOutboundWhseHandlingTime, '', false, false)]
    local procedure "Sales Line_OnValidateLocationCodeOnAfterSetOutboundWhseHandlingTime"(var SalesLine: Record "Sales Line")
    var
        Item: Record Item;
    begin
        // 
        IF (SalesLine.Type = SalesLine.Type::Item) THEN BEGIN
            SalesLine.GetItem();
            Item.BlockedSKU(SalesLine."Location Code", SalesLine."Variant Code", TRUE);
        END;

        // DITW110.00.11 SFI BL#30569
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnBeforeUpdateItemReference, '', false, false)]
    local procedure "Sales Line_OnBeforeUpdateItemReference"(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CalledByFieldNo: Integer; var IsHandled: Boolean)
    var
        Item: Record Item;
    begin
        // 
        IF (SalesLine.Type = SalesLine.Type::Item) THEN BEGIN
            SalesLine.GetItem();
            Item.BlockedSKU(SalesLine."Location Code", SalesLine."Variant Code", TRUE);
        END;
        //  DITW110.00.11 SFI BL#30569
    end;


    // BC Upgrade SHUKLP03 >> Codeunit 88 "Sales Post via Job Queue"
    // Added OTC008 Testscript changes.
    // Subscribed event OnRunOnAfterRunSalesPost to add HEI.01 an HEI.03 code.
    // Subscribed event OnBeforeSetJobQueueStatus to add HEI.01 code.
    // Subscribed event OnEnqueueJobEntryOnBeforeEnqueue to add HEI.01 and HEI.04 code.

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Post via Job Queue", OnRunOnAfterRunSalesPost, '', false, false)]
    local procedure OnRunOnAfterRunSalesPost(var SalesHeader: Record "Sales Header")
    var
        SalesReceivablesSetupL: Record "Sales & Receivables Setup";
        NewAutomationL: Codeunit "Automation Utility";
    begin
        //HEI.01>>
        //END;
        If SalesHeader."Job Queue Status" <> SalesHeader."Job Queue Status"::Error Then BEGIN
            SalesReceivablesSetupL.GET;
            IF SalesReceivablesSetupL."Enable OTC Billing Auto. FND" THEN BEGIN
                SalesReceivablesSetupL.TESTFIELD("Post with Job Queue", FALSE);
                IF (SalesHeader."Document Subtype Code FND" = SalesReceivablesSetupL."Excl.Inv/CM forEMail/Print FND") AND
                  (SalesReceivablesSetupL."Excl.Inv/CM forEMail/Print FND" <> '') THEN
                    NewAutomationL.UpdateJQLogEntry(SalesHeader, TRUE, FALSE, FALSE, FALSE)
                ELSE BEGIN
                    CASE SalesHeader."Send Document FND" OF
                        SalesHeader."Send Document FND"::" ":
                            BEGIN
                                SalesHeader.TESTFIELD("Print Posted Documents", FALSE);
                                //HEI.03>>
                                //NewAutomationL.AutoEmailAndOrPrint(SalesHeader,FALSE,FALSE,TRUE);
                                NewAutomationL.AutoEmailAndOrPrint(SalesHeader, FALSE, FALSE, NOT SalesReceivablesSetupL."Email not to sent to Log. FND");
                                //HEI.03<<
                            END;
                        SalesHeader."Send Document FND"::Mail:
                            BEGIN
                                SalesHeader.TESTFIELD("Print Posted Documents", FALSE);
                                //HEI.03>>
                                //NewAutomationL.AutoEmailAndOrPrint(SalesHeader,TRUE,FALSE,TRUE);
                                NewAutomationL.AutoEmailAndOrPrint(SalesHeader, TRUE, FALSE, NOT SalesReceivablesSetupL."Email not to sent to Log. FND");
                                //HEI.03<<
                            END;
                        SalesHeader."Send Document FND"::"Mail & Print":
                            BEGIN
                                SalesHeader.TESTFIELD("Print Posted Documents", TRUE);
                                //HEI.03>>
                                //NewAutomationL.AutoEmailAndOrPrint(SalesHeader,TRUE,TRUE,TRUE);
                                NewAutomationL.AutoEmailAndOrPrint(SalesHeader, TRUE, TRUE, NOT SalesReceivablesSetupL."Email not to sent to Log. FND");
                                //HEI.03<<
                            END;
                        SalesHeader."Send Document FND"::Print:
                            BEGIN
                                SalesHeader.TESTFIELD("Print Posted Documents", TRUE);
                                //HEI.03>>
                                //NewAutomationL.AutoEmailAndOrPrint(SalesHeader,FALSE,TRUE,TRUE);
                                NewAutomationL.AutoEmailAndOrPrint(SalesHeader, FALSE, TRUE, NOT SalesReceivablesSetupL."Email not to sent to Log. FND");
                                //HEI.03<<
                            END;
                    END;
                END;
                SalesHeader."Print Posted Documents" := false;
            END;
        end;
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Post via Job Queue", OnBeforeSetJobQueueStatus, '', false, false)]
    local procedure OnBeforeSetJobQueueStatus(JobQueueEntry: Record "Job Queue Entry"; NewJobQueueStatus: Option; SalesHeader: Record "Sales Header")
    var
        SalesReceivablesSetupL: Record "Sales & Receivables Setup";
        NewAutomationL: Codeunit "Automation Utility";
        DocumentSubtypeCode: Code[20];
    begin
        //HEI.01>>
        If JobQueueEntry."JQ Posted FND" then BEGIN
            SalesReceivablesSetupL.GET;
            IF SalesReceivablesSetupL."Enable OTC Billing Auto. FND" THEN BEGIN
                SalesReceivablesSetupL.TESTFIELD("Post with Job Queue", FALSE);
                JobQueueEntry.TESTFIELD("Document Type FND");
                JobQueueEntry.TESTFIELD("Document No. FND");
                JobQueueEntry.TESTFIELD("Posted Document No. FND");
                IF SalesReceivablesSetupL."Excl.Inv/CM forEMail/Print FND" <> '' THEN
                    DocumentSubtypeCode := NewAutomationL.GetPostedDocumentSubtypeCode(JobQueueEntry."Document Type FND", JobQueueEntry."Document No. FND", JobQueueEntry."Posted Document No. FND");
                IF ((DocumentSubtypeCode <> SalesReceivablesSetupL."Excl.Inv/CM forEMail/Print FND") AND
                  (SalesReceivablesSetupL."Excl.Inv/CM forEMail/Print FND" <> '')) OR (SalesReceivablesSetupL."Excl.Inv/CM forEMail/Print FND" = '') THEN BEGIN
                    IF NOT JobQueueEntry."JQ Logistics Mail Sent FND" THEN BEGIN
                        CLEAR(NewAutomationL);
                        NewAutomationL.AutoEmailAndOrPrintFromBlockedChain(JobQueueEntry, JobQueueEntry."Document Type FND", JobQueueEntry."Posted Document No. FND", FALSE, FALSE, TRUE);
                    END;
                    CASE JobQueueEntry."Send Document FND" OF
                        JobQueueEntry."Send Document FND"::Mail:
                            BEGIN
                                IF NOT JobQueueEntry."JQ Mail Sent FND" THEN BEGIN
                                    CLEAR(NewAutomationL);
                                    NewAutomationL.AutoEmailAndOrPrintFromBlockedChain(JobQueueEntry, JobQueueEntry."Document Type FND", JobQueueEntry."Posted Document No. FND", TRUE, FALSE, TRUE);
                                END;
                            END;
                        JobQueueEntry."Send Document FND"::Print:
                            BEGIN
                                IF NOT JobQueueEntry."JQ Printed FND" THEN BEGIN
                                    CLEAR(NewAutomationL);
                                    NewAutomationL.AutoEmailAndOrPrintFromBlockedChain(JobQueueEntry, JobQueueEntry."Document Type FND", JobQueueEntry."Posted Document No. FND", FALSE, TRUE, TRUE);
                                END;
                            END;
                        JobQueueEntry."Send Document FND"::"Mail & Print":
                            BEGIN
                                IF NOT JobQueueEntry."JQ Mail Sent FND" THEN BEGIN
                                    CLEAR(NewAutomationL);
                                    NewAutomationL.AutoEmailAndOrPrintFromBlockedChain(JobQueueEntry, JobQueueEntry."Document Type FND", JobQueueEntry."Posted Document No. FND", TRUE, FALSE, TRUE);
                                END;
                                IF NOT JobQueueEntry."JQ Printed FND" THEN BEGIN
                                    CLEAR(NewAutomationL);
                                    NewAutomationL.AutoEmailAndOrPrintFromBlockedChain(JobQueueEntry, JobQueueEntry."Document Type FND", JobQueueEntry."Posted Document No. FND", FALSE, TRUE, TRUE);
                                END;
                            END;
                    END;
                END;
            END;
        end;
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Post via Job Queue", OnEnqueueJobEntryOnBeforeEnqueue, '', false, false)]
    local procedure OnEnqueueJobEntryOnBeforeEnqueue(SalesHeader: Record "Sales Header"; var JobQueueEntry: Record "Job Queue Entry")
    var
        SalesReceivablesSetupL: Record "Sales & Receivables Setup";
    begin
        //HEI.01>>
        SalesReceivablesSetupL.GET;
        IF SalesReceivablesSetupL."Enable OTC Billing Auto. FND" THEN BEGIN
            SalesReceivablesSetupL.TESTFIELD("Post with Job Queue", FALSE);
            JobQueueEntry."Send Document FND" := SalesHeader."Send Document FND";
            JobQueueEntry."Document Type FND" := SalesHeader."Document Type";
            JobQueueEntry."Document No. FND" := SalesHeader."No.";
            //HEI.04>>
            IF SalesReceivablesSetupL."Autobilling JQ Restart FND" THEN BEGIN
                JobQueueEntry."No. of Min. To Force Reset FND" := SalesReceivablesSetupL."AutobillingJQMin.ToRestart FND";
                JobQueueEntry."No. of Minutes To Notify FND" := SalesReceivablesSetupL."Autobilling JQMin.ToNotify FND";
            END;
            //HEI.04<<
        END;
        //HEI.01<<
    end;

    // BC Upgrade SHUKLP03 << Codeunit 88 "Sales Post via Job Queue"

    // BC Upgrade SHUKLP03 >> Codeunit 5752 "Get Source Doc. Outbound"

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Source Doc. Outbound", OnBeforeCreateFromSalesOrder, '', false, false)]
    local procedure OnBeforeCreateFromSalesOrder(var IsHandled: Boolean; var SalesHeader: Record "Sales Header")
    VAR
        // SalesHeader: Record "Sales Header";
        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
        WhseShipmentCreated: Boolean;
        GetSourceDocuments: Report "Get Source Documents";
    begin

        If SalesHeader."Source System Identifier FND" <> '' then begin // BC Upgrade SHUKLP03 << Added condition to check sales ordr is create from API or no
            WhseShipmentCreated := GetSourceDocOutbound.CreateFromSalesOrderHideDialog(SalesHeader);
            if WhseShipmentCreated then begin
                OnAfterCreateWhseShipment(SalesHeader);
                IsHandled := true;
            end;
        end;

    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreateWhseShipment(VAR SalesHeader: Record "Sales Header")
    begin
    end;
    // BC Upgrade SHUKLP03 << Codeunit 5752 "Get Source Doc. Outbound"

    //BC Upgrade SHARMP16 BEGIN<< --- Bug Fixing 
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeletePurchaseHeader(var Rec: Record "Purchase Header"; RunTrigger: Boolean)
    var
        PurchHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        if Rec.IsTemporary then
            exit;

        if PurchHeaderAdditional.Get(Rec."Document Type", Rec."No.") then
            PurchHeaderAdditional.Delete();
    end;
    //BC Upgrade SHARMP16 END>> --- Bug Fixing 
    //BC Upgrade kamnay01 DTW FDD 002>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Production Journal Mgt", OnInsertOutputItemJnlLineOnAfterCopyItemTracking, '', false, false)]
    local procedure "Production Journal Mgt_OnInsertOutputItemJnlLineOnAfterCopyItemTracking"(var ItemJnlLine: Record "Item Journal Line"; ProdOrderRtngLine: Record "Prod. Order Routing Line"; var NextLineNo: Integer)
    var
        recManufacturingSetup: Record "Manufacturing Setup";

    begin
        recManufacturingSetup.get();
        IF UpdateTimes(ItemJnlLine) AND (recManufacturingSetup."Prod. Jnl. Flushing (Time) FND") THEN
            ItemJnlLine.MODIFY;

    end;

    procedure UpdateTimes(var ItemJnlLine: Record "Item Journal Line"): Boolean
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        CapacityLedgerEntry: Record "Capacity Ledger Entry";

    begin

        IF ProdOrderRoutingLine.GET(ProdOrderRoutingLine.Status::Released, ItemJnlLine."Order No.", ItemJnlLine."Routing Reference No.", ItemJnlLine."Routing No.", ItemJnlLine."Operation No.") THEN BEGIN

            ItemJnlLine.VALIDATE("Run Time", (ItemJnlLine."Output Quantity (Base)" + ItemJnlLine."Scrap Quantity") * ProdOrderRoutingLine."Run Time");
            CapacityLedgerEntry.SETRANGE("Order No.", ItemJnlLine."Order No.");
            CapacityLedgerEntry.SETRANGE("Order Line No.", ItemJnlLine."Order Line No.");
            CapacityLedgerEntry.SETRANGE("Routing No.", ItemJnlLine."Routing No.");
            CapacityLedgerEntry.SETRANGE("Routing Reference No.", ItemJnlLine."Routing Reference No.");
            CapacityLedgerEntry.SETRANGE("Operation No.", ItemJnlLine."Operation No.");
            IF CapacityLedgerEntry.FINDFIRST THEN
                ItemJnlLine.VALIDATE("Setup Time", 0)
            ELSE
                ItemJnlLine.VALIDATE("Setup Time", ProdOrderRoutingLine."Setup Time");
            EXIT(TRUE);
        END ELSE
            EXIT(FALSE);

    end;
    //BC Upgrade kamnay01 DTW FDD 002<<
    //BC Upgrade SHARMP16 BEGIN<<-Open Points
    [EventSubscriber(ObjectType::Table, Database::"Vendor Bank Account", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeDeleteVendorBankAccountApproval(var Rec: Record "Vendor Bank Account"; RunTrigger: Boolean)
    var
        ApprovalEntry: Record "Approval Entry";
        ApprovalEntryTest: Record "Approval Entry";
        VendorBankAcc: Record "Vendor Bank Account";
        Vendor: Record Vendor;
        ApprovalFound: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if Rec.IsTemporary() then
            exit;

        ApprovalFound := false;

        // Delete approval entries for current record
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordId);
        ApprovalEntry.SetFilter(Status, '%1|%2',
            ApprovalEntry.Status::Created,
            ApprovalEntry.Status::Open);

        if not ApprovalEntry.IsEmpty() then begin
            ApprovalEntry.DeleteAll(true);
            ApprovalsMgmt.DeleteApprovalCommentLines(Rec.RecordId);
        end;

        // Check other vendor bank accounts (excluding current)
        VendorBankAcc.Reset();
        VendorBankAcc.SetRange("Vendor No.", Rec."Vendor No.");
        //  VendorBankAcc.SetRange(Code,Rec.Code);

        if VendorBankAcc.FindFirst() then begin
            repeat
                ApprovalEntryTest.Reset();
                ApprovalEntryTest.SetRange("Record ID to Approve", VendorBankAcc.RecordId);
                ApprovalEntryTest.SetFilter(Status, '%1|%2',
                    ApprovalEntryTest.Status::Created,
                    ApprovalEntryTest.Status::Open);

                if ApprovalEntryTest.FindFirst() then begin
                    ApprovalFound := true;
                    exit; // stop early
                end;
            until VendorBankAcc.Next() = 0;
        end;

        // If no approvals found, update vendor
        if not ApprovalFound then begin
            if Vendor.Get(Rec."Vendor No.") then begin
                Vendor.Validate("Sensitive Payment Block FND", false);
                Vendor.Validate("Sensitive Workflow Block FND", false);
                Vendor.Modify();
            end;
        end;
    end;
    //BC Upgrade SHARMP16 END>>--Open Points
    //BC UPGRADE GUPTAK03 WHT Reversal Entry -->>
    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", OnBeforeCheckEntries, '', false, false)]
    local procedure OnBeforeCheckEntries(ReversalEntry: Record "Reversal Entry"; TableID: Integer; var SkipCheck: Boolean)
    var
        WHTEntry: Record "WHT Entry FND";
    begin
        WHTEntry.LockTable();
        // RD03 - added setrange -- >>
        WHTEntry.Reset();
        WHTEntry.SetRange("Document No.", ReversalEntry."Document No.");
        // RD03 - added setrange -- <<
        if WHTEntry.Find('-') then
            REPEAT
                ReversalEntry.CheckWHT(WHTEntry);
            UNTIL WHTEntry.NEXT = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", OnAfterInsertReversalEntry, '', false, false)]
    local procedure OnAfterInsertReversalEntry(Number: Integer; RevType: Option; sender: Record "Reversal Entry"; var NextLineNo: Integer; var TempReversalEntry: Record "Reversal Entry" temporary; var TempRevertTransactionNo: Record Integer)
    begin
        sender.InsertFromWHTEntry(TempRevertTransactionNo, Number, RevType, NextLineNo);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", OnAfterSetReverseFilter, '', false, false)]
    local procedure OnAfterSetReverseFilter(Number: Integer; GLRegister: Record "G/L Register"; RevType: Option Transaction,Register; var ReversalEntry: Record "Reversal Entry")
    var
        WHTEntry: Record "WHT Entry FND";
    begin
        WHTEntry.SetCurrentKey(Closed);
        if RevType = RevType::Transaction then
            WHTEntry.SETRANGE("Transaction No.", Number)
        else
            WHTEntry.SETRANGE("Entry No.", GLRegister."From WHT Entry No. FND", GLRegister."To WHT Entry No. FND");

    end;

    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", OnAfterCaption, '', false, false)]
    local procedure OnAfterCaption(ReversalEntry: Record "Reversal Entry"; var NewCaption: Text)
    var
        WHTEntry: Record "WHT Entry FND";
    begin
        if ReversalEntry."Entry Type" = ReversalEntry."Entry Type"::WHT then
            NewCaption := STRSUBSTNO('%1', WHTEntry.TABLECAPTION);
    end;
    // BC UPGRADE GUPTAK03 WHT Reversal Entry -- <<
}