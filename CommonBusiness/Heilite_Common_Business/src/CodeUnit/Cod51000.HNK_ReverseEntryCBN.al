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
using Microsoft.Manufacturing.Routing;
using Microsoft.HumanResources.Employee;
using Microsoft.CRM.Campaign;
using Microsoft.CRM.Team;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Intercompany.BankAccount;
using Microsoft.Intercompany.GLAccount;
using Microsoft.Intercompany.Partner;
using Microsoft.Finance.ReceivablesPayables;
using Microsoft.Purchases.Posting;
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
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Purchases.Setup;
using Microsoft.Finance.VAT.Calculation;

//Bc Upgrade YADAVM09 Drink it dependency event Blocked OnAfterSetBookValueFiltersOnFALedgerEntry,OnAfterCreateTypes for table (FA Matrix Posting Type),OnMATRIX_OnDrillDownOnCaseElse.
//Bc Upgrade YADAVM09 Code blocked in event OnAfterCreateTypes and Function SuggestAssgnt3.
//BC Upgrade SHARMP16 event blocked OnAfterUpdateAmounts and restructured the code using the event OnBeforeUpdateLineAmount

codeunit 51000 "HNK_ReverseEntry CBN"

//HEI YADAVM09 codeunit 179 Reversal Post>>
//     HEI.01 PTPGAP083 IBM NASTAA02 13.06.2018 # Mark Reversed Rejected Payments
//   # Created function "MarkReversedRejectedPayment"
//   # Field "Reversed" from "Gen. Journal Line Archive" should be ticked when a transaction is reversed
// HEI.02 DEFECT 5029 IBM BULIMC01 13/12/2019 #code changed to check the new Reversal Posting Date
//   #new functions created: CheckReversalPostingDate(), DateNotAllowed()
//Bc Upgrade YADAVM09 code added to fix bug BCUP0-33.

{
    SingleInstance = true;
    Permissions = tabledata "G/L Entry" = m;//Bc upgrade YADAVM09<<
    trigger OnRun()
    var
        myInt: Integer;
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reversal-Post", 'OnRunOnBeforeCheckEntries', '', true, true)]
    local procedure OnRunOnBeforeCheckEntries(var ReversalEntry: Record "Reversal Entry")
    var
        ErrorReversalPostingDate: Label 'Reversal Posting Date %1 is not within your range of allowed posting dates.';
        Text011: Label 'Please provide a reversal posting date!';
        Rec: Record "Reversal Entry";
        Number: Integer;
        GenJnlTemplate: Record "Gen. Journal Template";
        Text003: Label 'The entries were successfully reversed.';
        GenJnlPostReverse: Codeunit "Gen. Jnl.-Post Reverse";
        GLReg: Record "G/L Register";
        PostedDeferralHeader: Record "Posted Deferral Header";
        Text008: Label 'Changes have been made to posted entries after the window was "Open"ed.\Close and re"Open" the window to continue.';
    begin
        // Rec := ReversalEntry;
        // if Rec."Reversal Type" = Rec."Reversal Type"::Transaction then
        //     ReversalEntry.SetReverseFilter(Rec."Transaction No.", Rec."Reversal Type")
        // else
        //     ReversalEntry.SetReverseFilter(Rec."G/L Register No.", Rec."Reversal Type");
        //HEI.02>>//BC SHARMP16-- GAPFitchanges 10March26
        IF CheckReversalPostingDate() THEN BEGIN
            IF InputReversalPostingDate <> 0D THEN BEGIN
                ReversalEntry.Validate("Posting Date", InputReversalPostingDate);
                ReversalEntry.Modify();
                IF DateNotAllowed(InputReversalPostingDate) THEN
                    ERROR(ErrorReversalPostingDate, InputReversalPostingDate)
            END ELSE
                ERROR(Text011);
        END;
        // ELSE//BC SHARMP16-- GAPFitchanges 10March26
        //  ReversalEntry.CheckEntries();
        //HEI.02<<
        // Rec.Get(1);
        // if Rec."Reversal Type" = Rec."Reversal Type"::Register then
        //     Number := Rec."G/L Register No."
        // else
        //     Number := Rec."Transaction No.";
        // if not ReversalEntry.VerifyReversalEntries(Rec, Number, Rec."Reversal Type") then
        //     Error(Text008);
        // GenJnlPostReverse.Reverse(ReversalEntry, Rec);
        // if PrintRegister then begin
        //     GenJnlTemplate.Validate(Type);
        //     if GenJnlTemplate."Posting Report ID" <> 0 then
        //         if GLReg.FindLast() then begin
        //             GLReg.SetRecFilter();
        //             //OnBeforeGLRegPostingReportPrint(GenJnlTemplate."Posting Report ID", false, false, GLReg, Handled);
        //             if not Handled then
        //                 REPORT.Run(GenJnlTemplate."Posting Report ID", false, false, GLReg);
        //         end;
        // end;
        // // OnRunOnBeforeDeleteAll(Rec, Number);
        // MarkReversedRejectedPayment(ReversalEntry); //HEI.01
        // Rec.DeleteAll();
        // PostedDeferralHeader.DeleteForDoc("Deferral Document Type"::"G/L".AsInteger(), ReversalEntry."Document No.", '', 0, '');
        // if not HideDialog then
        //     Message(Text003);

        // Handled := true;//BC SHARMP16-- GAPFitchanges 10March26
    end;
    //BC Upgrade SHARMP16>> Begin

    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", OnBeforeCheckEntries, '', false, false)]
    local procedure OnBeforeCheckEntries(ReversalEntry: Record "Reversal Entry"; TableID: Integer; var SkipCheck: Boolean)
    begin
        if InputReversalPostingDate <> 0D then begin

            if TableID in
               [Database::"G/L Entry",
                Database::"Cust. Ledger Entry",
                Database::"Vendor Ledger Entry",
                Database::"Bank Account Ledger Entry",
                Database::"FA Ledger Entry"]
            then
                SkipCheck := true;
        end;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reversal-Post", OnRunOnBeforeDeleteAll, '', false, false)]
    local procedure OnRunOnBeforeDeleteAll(Number: Integer; var ReversalEntry: Record "Reversal Entry")
    begin
        MarkReversedRejectedPayment(ReversalEntry); //HEI.01
    end;

    procedure CheckReversalPostingDate(): Boolean
    var
        ConfirmDialog: Page "ConfirmDialog CBN";
    begin
        //HEI.02>>

        ConfirmDialog.LOOKUPMODE(TRUE);
        IF ConfirmDialog.RUNMODAL() = ACTION::Yes THEN BEGIN
            InputReversalPostingDate := ConfirmDialog.ReturnEnteredNumber();
            EXIT(TRUE);

        END ELSE begin
            EXIT(FALSE);
        end;
        //HEI.02<<
    end;

    procedure DateNotAllowed(PostingDate: Date): Boolean
    var
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        UserSetup: Record "User Setup";
        GLSetup: Record "General Ledger Setup";
    begin
        //HEI.02>>
        IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
            IF USERID <> '' THEN
                IF UserSetup.GET(USERID) THEN BEGIN
                    AllowPostingFrom := UserSetup."Allow Posting From";
                    AllowPostingTo := UserSetup."Allow Posting To";
                END;
            IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
                GLSetup.GET();
                AllowPostingFrom := GLSetup."Allow Posting From";
                AllowPostingTo := GLSetup."Allow Posting To";
            END;
            IF AllowPostingTo = 0D THEN
                AllowPostingTo := DMY2DATE(31, 12, 9999);
        END;
        EXIT((PostingDate < AllowPostingFrom) OR (PostingDate > AllowPostingTo));
        //HEI.02
    end;

    LOCAL procedure MarkReversedRejectedPayment(ReversalEntry: Record "Reversal Entry")
    var
        GenJournalLineArchive: Record "Gen. Journal Line Archive FND";
    begin
        //HEI.01>>
        GenJournalLineArchive.SETRANGE("Document Type", ReversalEntry."Document Type");
        GenJournalLineArchive.SETRANGE("Document No.", ReversalEntry."Document No.");
        GenJournalLineArchive.SETRANGE("Posting Date", ReversalEntry."Posting Date");
        GenJournalLineArchive.SETRANGE("Account No.", ReversalEntry."Account No.");
        IF GenJournalLineArchive.FINDSET() THEN
            REPEAT
                GenJournalLineArchive.Reversed := TRUE;
                GenJournalLineArchive.MODIFY();
            UNTIL GenJournalLineArchive.NEXT() = 0;
        //HEI.01<<
    end;
    //HEI YADAVM09 codeunit 179 Reversal Post>> 

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse",
    // 'OnReverseVendLedgEntryOnAfterInsertVendLedgEntry', '', false, false)]
    //     local procedure OnReverseVendLedgEntryOnAfterInsertVendLedgEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry")
    //     begin
    //         VendorLedgerEntry."Posting Date" := InputReversalPostingDate;
    //     end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse",
    // 'OnReverseBankAccLedgEntryOnBeforeInsert', '', false, false)]
    //     local procedure OnReverseBankAccLedgEntryOnBeforeInsert(BankAccLedgEntry: Record "Bank Account Ledger Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var NewBankAccLedgEntry: Record "Bank Account Ledger Entry")
    //     begin

    //         NewBankAccLedgEntry."Posting Date" := InputReversalPostingDate;
    //     end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse",
  'OnReverseVendLedgEntryOnBeforeInsertVendLedgEntry', '', false, false)]
    local procedure OnReverseVendLedgEntryOnBeforeInsertVendLedgEntry(
      var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
      var NewVendLedgEntry: Record "Vendor Ledger Entry";
      VendLedgEntry: Record "Vendor Ledger Entry")
    var
        ReversalEntry: Record "Reversal Entry";
        HeniKenBCGlobal: Codeunit "Heineken Global";
    begin
        if InputReversalPostingDate <> 0D then
            NewVendLedgEntry."Posting Date" := InputReversalPostingDate;
    end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse",
    // 'OnReverseOnBeforeStartPosting', '', false, false)]
    //     local procedure OnReverseOnBeforeStartPosting(var GLEntry: Record "G/L Entry"; var ReversalEntry: Record "Reversal Entry")
    //     begin
    //         // Ensure GL Entry gets reversal posting date
    //         if InputReversalPostingDate <> 0D then
    //             GLEntry."Posting Date" := InputReversalPostingDate;
    //     end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseGLEntryOnBeforeInsertGLEntry, '', false, false)]
    local procedure OnReverseGLEntryOnBeforeInsertGLEntry(var GLEntry: Record "G/L Entry"; GLEntry2: Record "G/L Entry")
    var
        SourceCodeSetup: Record "Source Code Setup";
        ReversedGLEntry: Record "G/L Entry";
        FinancialUtils: Codeunit "Financial-Utils";
    begin
        SourceCodeSetup.Get();//BC SHARMP16-- GAPFitchanges 10March26

        //>>HEI.01
        IF (SourceCodeSetup."General Journal" = GLEntry."Source Code") OR
          (SourceCodeSetup.Reversal = GLEntry."Source Code") THEN
            GLEntry."Open FND" := FALSE;
        //<<HEI.01////BC SHARMP16-- GAPFitchanges 10March26
        if GLEntry2."Reversed Entry No." <> 0 then begin
            ReversedGLEntry.Get(GLEntry2."Reversed Entry No.");
            //>>HEI.01
            IF (SourceCodeSetup."General Journal" = ReversedGLEntry."Source Code") OR
              (SourceCodeSetup.Reversal = ReversedGLEntry."Source Code") THEN
                ReversedGLEntry."Open FND" := TRUE;
            //<<HEI.01
        end;//BC SHARMP16-- GAPFitchanges 10March26
        //>>HEI.01
        IF (SourceCodeSetup."General Journal" = GLEntry2."Source Code") OR
           (SourceCodeSetup.Reversal = GLEntry2."Source Code") THEN
            GLEntry2."Open FND" := FALSE;
        FinancialUtils.ReverseDetailedAdjmt(GLEntry2);
        //<<HEI.01
        //HEI.05>>
        IF GLEntry."Reversed Entry No." = 0 THEN
            GLEntry."Reversed by Entry No." := GLEntry2."Entry No.";
        GLEntry."Remaining Amount FND" := 0;
        IF GLEntry."Reversed Entry No." <> 0 THEN
            GLEntry."Closed by Entry No. FND" := GLEntry."Reversed Entry No.";
        IF GLEntry."Reversed by Entry No." <> 0 THEN
            GLEntry."Closed by Entry No. FND" := GLEntry."Reversed by Entry No.";
        GLEntry."Closed at Date FND" := TODAY;
        GLEntry."Entries Posted By FND" := USERID;
        GLEntry."Open FND" := FALSE;

        GLEntry2."Entries Posted By FND" := USERID;
        GLEntry2."Open FND" := FALSE;
        GLEntry2."Remaining Amount FND" := 0;
        IF GLEntry2."Reversed by Entry No." <> 0 THEN
            GLEntry2."Closed by Entry No. FND" := GLEntry2."Reversed by Entry No.";
        IF GLEntry2."Reversed Entry No." <> 0 THEN
            GLEntry2."Closed by Entry No. FND" := GLEntry2."Reversed Entry No.";
        GLEntry2."Closed at Date FND" := TODAY;
        GLEntry2.modify();//Bc Upgrade YADAVM09 Bug fix BCUP0-33<<
        //HEI.05<<

        //>>HEI.06
        GLEntry."Source Currency Amount" := -GLEntry."Source Currency Amount";
        GLEntry."Remaining Amount FND" := -GLEntry."Remaining Amount FND";
        if InputReversalPostingDate <> 0D then
            GLEntry."Posting Date" := InputReversalPostingDate;
        //>>HEI.06
    end;

    //BC Upgrade VAMSIU01 - Adding Code to update Reversal Entry posting Update in Customer ledger Entry>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", OnReverseCustLedgEntryOnBeforeInsertCustLedgEntry, '', false, false)]
    local procedure OnReverseCustLedgEntryOnBeforeInsertCustLedgEntry(var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var NewCustLedgerEntry: Record "Cust. Ledger Entry"; CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        if InputReversalPostingDate <> 0D then
            NewCustLedgerEntry."Posting Date" := InputReversalPostingDate;
    end;
    //BC Upgrade VAMSIU01 - Adding Code to update Reversal Entry posting Update in Customer ledger Entry<<
    //BC Upgrade SHARMP16 BEGIN<< -- FA Reversal Date issue
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"FA Insert Ledger Entry",
      'OnInsertReverseEntryOnBeforeInsertTempFALedgEntry', '', false, false)]
    local procedure OnInsertReverseEntryOnBeforeInsertTempFALedgEntry(var FALedgerEntry3: Record "FA Ledger Entry"; var IsHandled: Boolean)
    var
    begin
        if InputReversalPostingDate <> 0D then
            FALedgerEntry3."Posting Date" := InputReversalPostingDate;
    end;
    //BC Upgrade SHARMP16 END>> -- FA Reversal Date issue

    ////BC Upgrade SHARMP16--Testscriptchanges140326 BEGIN>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnBeforeArchivePurchDocument', '', false, false)]
    local procedure OnBeforeArchivePurchDocument(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        //ConfirmManagement: Codeunit "Confirm Management";
        gRecUserSetUp: Record "User Setup";
        UnAuthorisedArchive: Label 'You are not allowed to Archive this Document';
        Text007: Label 'Archive %1 no.: %2?';
        Text001: Label 'Document %1 has been archived.';
        ArchiveManagement: Codeunit ArchiveManagement;
    begin
        //>>HEI.05
        IF NOT PurchaseHeader.ISTEMPORARY THEN BEGIN
            IF PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Quote THEN BEGIN//HEi.06
                IF gRecUserSetUp.GET(USERID) THEN BEGIN
                    IF NOT gRecUserSetUp."Allow Delete/Arc PO/Return FND" THEN
                        ERROR(UnAuthorisedArchive);
                END;
            END;//HEI.06
        END;
        //<<HEI.05

        IF NOT DontShowMsg THEN BEGIN //HEI.07
            IF CONFIRM(
                 Text007, TRUE, PurchaseHeader."Document Type",
                 PurchaseHeader."No.")
            THEN BEGIN
                ArchiveManagement.StorePurchDocument(PurchaseHeader, FALSE);
                MESSAGE(Text001, PurchaseHeader."No.");
                //  END; //HEI.07
                //>>HEI.07
            END;
        END ELSE BEGIN
            ArchiveManagement.StorePurchDocument(PurchaseHeader, FALSE);
        END;
        //<<HEI.07
        IsHandled := true;
    end;
    //BC SHARMP16-- GAPFitchanges 10March26
    procedure ArchivingViaDeletionPOProCustom(LPDontShowMsg: Boolean)
    begin
        //>>HEI.07
        DontShowMsg := LPDontShowMsg;
        //<<HEI.07
    end;
    //BC SHARMP16-- GAPFitchanges 10March26

    procedure SetSkipStatusCheck(NewValue: Boolean)
    begin
        SkipStatusCheck := NewValue;
    end;

    procedure GetSkipStatusCheck(): Boolean
    begin
        exit(SkipStatusCheck);
    end;

    var
        DontShowMsg: Boolean;
        SkipStatusCheck: Boolean;
        //BC Upgrade SHARMP16--Testscriptchanges140326 END<<


        InputReversalPostingDate: Date;
        InputReversalBoolean: Boolean;
}