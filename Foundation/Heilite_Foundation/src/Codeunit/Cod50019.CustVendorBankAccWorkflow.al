namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;
using System.Automation;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Company;
using Microsoft.Sales.Setup;
using Microsoft.Foundation.NoSeries;
using ALProject.ALProject;
using Microsoft.Purchases.Setup;
using Microsoft.Bank.Check;
using Microsoft.Purchases.Vendor;

codeunit 50019 "Cust/Vendor Bank Acc. Workflow"
{
    // BC Upgrade 50019 Codeunit >>

    // HEI.01 FDD-PTPGAP002 IBM HORTOC01 17.08.2017
    // # New workflows for Cust/Vendor Bank Accounts
    // HEI.02 Defect #1066 IBM NASTAA02 13.12.2017 # Bank sensitive details change
    // # Field "Sensitive Block" should be changed based on the workflow
    // # When rejecting an Approval Request the Bank Account should be modified with the old value
    // HEI.03 FDD PTPGAP084 IBM POSTOI01 19.04.2018
    // # add new fields 50001->50003
    // # add new code onvalidate for the following fields : Bank Account No., Banl Branch No., IBAN
    // OnApproveApprovalRequestCust
    // OnRejectApprovalRequestCust
    // BlockCustomer
    // OnApproveApprovalRequestVend
    // OnRejectApprovalRequestVend
    // BlockVendor
    // HEI.07 FDD- HB383 IBM NASTAA02 23.07.2019 # Masterdata Workflow in Helite
    // HEI.08 HLP-93 CHG2003450 IBM.SAXENS01 13.01.2020
    // Hei.10 HLP-314 CHG2003450 IBM SHANKJ03   03.09.2020
    // # new event added for workflow
    // HEI.11 CHG2036764 IBM SHANKJ03 05.05.2020
    // # T288OnAfterInsertVendorBankAccount added for defect id 5534
    // HEI.12 CHG2052196 IBM.PANDES01 08.06.2020
    // # Added Code for check ledger entry workflow.
    // HEI.13 CHG2003450 IBM SHANKJ03
    // # Added new function T23OnAfterModifyVendor to restrict vendor modification
    // HEI.14 CHG2003450 IBM.GUNERE01 17.02.2021 # AddMyWorkflowEventsToLibrary, AddWorkflowEventHierarchiesToLibrary,
    //                                             OnApproveApprovalRequestVend, BlockVendor, RunWorkflowOnAfterModifyBankAccVendBankAcc,
    //                                             RunWorkflowOnAfterModifyBankBranVendBankAcc, RunWorkflowOnAfterModifyIBANVendBankAcc,
    //                                             funcs. modified
    //                                             CheckOpenApprovalVendAccEntries, VendBankAccIBANChangedWorkflowEventCode,
    //                                             VendBankAccBranchNoChangedWorkflowEventCode, VendBankAccAccNoChangedWorkflowEventCode
    //                                             funcs. created
    // HEI.15 CHG2107657 IBM.GUNERE01 05.04.2021 # OnRejectApprovalRequestVend func. modified


    var
        CompanyInfo: Record "Company Information";
        SessionGlobals: Codeunit "Session Globals";
        WorkFlowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        CustBankCategoryDescTxt: TextConst ENU = 'Banks';
        CustBankCategoryTxt: TextConst ENU = 'BANKS', Comment = '{Locked}';
        DocStatusChangedMsg: TextConst Comment = 'Order 1001 has been automatically approved. The status has been changed to Released.', FRA = 'Le/la %1 %2 a ËÇÜtËÇÜ automatiquement approuvËÇÜ(e). Le statut a ËÇÜtËÇÜ remplacËÇÜ par %3.', ENU = '%1 %2 has been automatically approved. The status has been changed to %3.';
        IBANNotValidErr: TextConst FRA = 'Une demande dapprobation a ËÇÜtËÇÜ envoyËÇÜe.', ENU = 'The number that you entered is not a valid International Bank Account Number (IBAN).';
        NoWorkflowEnabledErr: TextConst FRA = 'Aucun flux de travail dapprobation pour ce type denregistrement nest activËÇÜ.', ENU = 'No approval workflow for this record type is enabled.';
        PendingApprovalMsg: TextConst ENU = 'An approval request has been sent.';

    procedure CustBankWorkflowEventCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCustomerBankAccChangedCode'));
    end;

    procedure VendBankWorkflowEventCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnVendorBankAccChangedCode'));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, OnAddWorkflowEventsToLibrary, '', false, false)]
    local procedure AddMyWorkflowEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(CustBankWorkflowEventCode(), DATABASE::"Customer Bank Account", 'A customer bank account is changed', 0, TRUE);
        WorkflowEventHandling.AddEventToLibrary(VendBankWorkflowEventCode(), DATABASE::"Vendor Bank Account", 'A vendor bank account is changed', 0, TRUE);
        //HEI.10 >>
        WorkflowEventHandling.AddEventToLibrary(VendBankInsertWorkflowEventCode(), DATABASE::"Vendor Bank Account", 'A vendor bank account is Inserted', 0, TRUE);
        //HEI.10 <<
        //>> HEI.14
        WorkflowEventHandling.AddEventToLibrary(VendBankAccAccNoChangedWorkflowEventCode(), DATABASE::"Vendor Bank Account", 'A vendor bank account Account No. is changed', 0, TRUE);
        WorkflowEventHandling.AddEventToLibrary(VendBankAccBranchNoChangedWorkflowEventCode(), DATABASE::"Vendor Bank Account", 'A vendor bank account Branch No. is changed', 0, TRUE);
        WorkflowEventHandling.AddEventToLibrary(VendBankAccIBANChangedWorkflowEventCode(), DATABASE::"Vendor Bank Account", 'A vendor bank account IBAN No. is changed', 0, TRUE);
        //<< HEI.14
    end;

    [EventSubscriber(ObjectType::Table, 287, OnAfterModifyEvent, '', false, false)]
    local procedure RunWorkflowOnAfterModifyCustBankAcc(var Rec: Record "Customer Bank Account"; var xRec: Record "Customer Bank Account")
    begin
        IF FORMAT(xRec) <> FORMAT(Rec) THEN BEGIN
            WorkflowManagement.HandleEventWithxRec(CustBankWorkflowEventCode(), Rec, xRec);
        end;

    end;

    [EventSubscriber(ObjectType::Table, 288, OnAfterModifyEvent, '', false, false)]
    local procedure RunWorkflowOnAfterModifyVendBankAcc(var Rec: Record "Vendor Bank Account"; var xRec: Record "Vendor Bank Account")
    var
        CustomerBankAccount: Record "Customer Bank Account";
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        // HEI.09 >>
        IF SessionGlobals.GetSimulateModeGlobal() = FALSE THEN
            IF ((xRec."Bank Branch No." <> Rec."Bank Branch No.") OR (xRec."Bank Account No." <> Rec."Bank Account No.") OR (xRec.IBAN <> Rec.IBAN)) AND (NOT Rec."Marked for Deletion FND") THEN BEGIN //HEI.15

                IF (Rec."Old IBAN FND" <> '') OR (Rec."Old Bank Branch No. FND" <> '') OR (Rec."Old Bank Account No. FND" <> '')
                   THEN BEGIN //HEI.06

                    //HEI.06>>
                    Vendor.GET(Rec."Vendor No.");
                    IF NOT Vendor."Sensitive Workflow Block FND" THEN BEGIN
                        xRec."Bank Branch No." := Rec."Old Bank Branch No. FND";
                        xRec."Bank Account No." := Rec."Old Bank Account No. FND";
                        xRec.IBAN := Rec."Old IBAN FND";
                        COMMIT();
                        WorkflowManagement.HandleEventWithxRec(VendBankWorkflowEventCode(), Rec, xRec);
                    end;
                end;
                //HEI.06
            end;
        //HEI.09 <<

    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, OnAddWorkflowEventPredecessorsToLibrary, '', false, false)]
    local procedure AddWorkflowEventHierarchiesToLibrary(EventFunctionName: Code[128])
    begin
        CASE EventFunctionName OF
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode():
                BEGIN
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode(), CustBankWorkflowEventCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode(), VendBankWorkflowEventCode());
                    //HEI.10 >>
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode(), VendBankInsertWorkflowEventCode());
                    //HEI.10 <<
                    //>> HEI.14
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode(), VendBankAccAccNoChangedWorkflowEventCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode(), VendBankAccBranchNoChangedWorkflowEventCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode(), VendBankAccIBANChangedWorkflowEventCode());
                    //<< HEI.14
                end;
            WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode():
                BEGIN
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode(), CustBankWorkflowEventCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode(), VendBankWorkflowEventCode());
                    //HEI.10 >>
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode(), VendBankInsertWorkflowEventCode());
                    //HEI.10 <<
                    //>> HEI.14
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode(), VendBankAccAccNoChangedWorkflowEventCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode(), VendBankAccBranchNoChangedWorkflowEventCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode(), VendBankAccIBANChangedWorkflowEventCode());
                    //<< HEI.14
                end;

            WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode():
                BEGIN
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode(), CustBankWorkflowEventCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode(), VendBankWorkflowEventCode());
                    //HEi.10 >>
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode(), VendBankInsertWorkflowEventCode());
                    //HEI.10 <<
                    //>> HEI.14
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode(), VendBankAccAccNoChangedWorkflowEventCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode(), VendBankAccBranchNoChangedWorkflowEventCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode(), VendBankAccIBANChangedWorkflowEventCode());
                    //<< HEI.14
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, OnAddWorkflowTableRelationsToLibrary, '', false, false)]
    local procedure AddWorkflowTableRelationsToLibrary()
    var
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Customer Bank Account", 1, DATABASE::"Approval Entry", 2);
        WorkflowSetup.InsertTableRelation(DATABASE::"Vendor Bank Account", 1, DATABASE::"Approval Entry", 2);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1502, OnAddWorkflowCategoriesToLibrary, '', false, false)]
    local procedure AddMyWorkflowCategory()
    var
        WorkflowCategory: Record "Workflow Category";
        WorkflowSetup: Codeunit "Workflow Setup";
    begin
        WorkflowCategory.INIT();
        WorkflowCategory.Code := CustBankCategoryTxt;
        WorkflowCategory.Description := CustBankCategoryDescTxt;
        IF WorkflowCategory.INSERT() THEN;
    end;

    procedure OnApproveApprovalRequestCust(VAR ApprovalEntry: Record "Approval Entry")
    var
        Customer: Record Customer;
        CustomerBankAccount: Record "Customer Bank Account";
        WorkflowRule: Record "Workflow Rule";
        RecID: RecordID;
        RecRef: RecordRef;
        // CustNo: FieldRef;
        CustomerNumber: Code[20];
        CustomerCode: Code[20];
    begin
        RecID := ApprovalEntry."Record ID to Approve";
        IF RecID.TABLENO = DATABASE::"Customer Bank Account" THEN BEGIN
            RecRef := RecID.GETRECORD();
            clear(CustomerNumber);
            clear(CustomerCode);
            CustomerNumber := RecRef.FIELD(1).Value;
            CustomerCode := RecRef.FIELD(2).Value;
            IF Customer.GET(CustomerNumber) THEN BEGIN
                //HEI.02>>
                //Customer.Blocked := Customer.Blocked::" ";
                //Customer."Blocked Reason Code" := '';
                Customer."Sensitive Payment Block FND" := FALSE;
                //HEI.03>>
                Customer."Sensitive Workflow Block FND" := FALSE;
                //HEI.03<<
                CustomerBankAccount.GET(CustomerNumber, CustomerCode);
                WorkflowRule.SETRANGE("Workflow Step Instance ID", ApprovalEntry."Workflow Step Instance ID");
                IF WorkflowRule.FINDFIRST() THEN
                    IF (WorkflowRule."Field No." = CustomerBankAccount.FIELDNO("Bank Account No.")) AND (CustomerBankAccount."Old Bank Account No. FND" <> '') THEN
                        CustomerBankAccount."Old Bank Account No. FND" := ''
                    else IF (WorkflowRule."Field No." = CustomerBankAccount.FIELDNO("Bank Branch No.")) AND (CustomerBankAccount."Old Bank Branch No. FND" <> '') THEN
                        CustomerBankAccount."Old Bank Branch No. FND" := ''
                    else IF (WorkflowRule."Field No." = CustomerBankAccount.FIELDNO(IBAN)) AND (CustomerBankAccount."Old IBAN FND" <> '') THEN
                        CustomerBankAccount."Old IBAN FND" := '';
                CustomerBankAccount.MODIFY();
                //HEI.02<<
                Customer.MODIFY();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Heineken BC Upgrade", OnAfterHandleEventWithxRec, '', false, false)]
    local procedure BlockCustomer(Variant: Variant; xVariant: Variant)
    var
        Customer: Record Customer;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        RecRef: RecordRef;
        // CustNo: FieldRef;
        CustomerNumber: Code[20];
    begin
        RecRef.GETTABLE(Variant);
        IF RecRef.NUMBER = DATABASE::"Customer Bank Account" THEN BEGIN
            //HEI.02>>
            //SalesReceivablesSetup.GET;
            //SalesReceivablesSetup.TESTFIELD(SalesReceivablesSetup."Reason Code Block Customer");
            Clear(CustomerNumber);
            CustomerNumber := RecRef.FIELD(1).Value;
            Customer.GET(CustomerNumber);
            //Customer.Blocked:=Customer.Blocked::Payment;
            //Customer."Blocked Reason Code" := SalesReceivablesSetup."Reason Code Block Customer";
            Customer."Sensitive Payment Block FND" := TRUE;
            //>>HEI.03
            Customer."Sensitive Workflow Block FND" := TRUE;
            //<<HEI.03
            //HEI.02<<
            Customer.MODIFY();
        end;
    end;

    procedure OnRejectApprovalRequestCust(ApprovalEntry: Record "Approval Entry")
    var
        ApprovalEntry2: Record "Approval Entry";
        Customer: Record Customer;
        CustomerBankAccount: Record "Customer Bank Account";
        WorkflowRule: Record "Workflow Rule";
        RecID: RecordID;
        RecRef: RecordRef;
        // CustNo: FieldRef;
        CustomerNumber: Code[20];
        CustomerCode: Code[20];
    begin
        RecID := ApprovalEntry."Record ID to Approve";
        IF RecID.TABLENO = DATABASE::"Customer Bank Account" THEN BEGIN
            RecRef := RecID.GETRECORD();
            Clear(CustomerNumber);
            Clear(CustomerCode);
            CustomerNumber := RecRef.FIELD(1).Value;
            CustomerCode := RecRef.FIELD(2).Value;
            IF Customer.GET(CustomerNumber) THEN BEGIN
                //HEI.02>>
                //Customer.Blocked := Customer.Blocked::" ";
                //Customer."Blocked Reason Code" := '';
                Customer."Sensitive Payment Block FND" := TRUE;
                //HEI.03>>
                Customer."Sensitive Workflow Block FND" := FALSE;
                //HEI.03<<
                CustomerBankAccount.GET(CustomerNumber, CustomerCode);
                WorkflowRule.SETRANGE("Workflow Step Instance ID", ApprovalEntry."Workflow Step Instance ID");
                IF WorkflowRule.FINDFIRST() THEN
                    IF WorkflowRule."Field No." = CustomerBankAccount.FIELDNO("Bank Account No.") THEN BEGIN
                        //HEI.03 "Bank Account No." := "Old Bank Account No. FND";
                        CustomerBankAccount."Old Bank Account No. FND" := '';
                    end else IF WorkflowRule."Field No." = CustomerBankAccount.FIELDNO("Bank Branch No.") THEN BEGIN
                        //HEI.03 "Bank Branch No." := "Old Bank Branch No. FND";
                        CustomerBankAccount."Old Bank Branch No. FND" := '';
                    end else IF WorkflowRule."Field No." = CustomerBankAccount.FIELDNO(IBAN) THEN BEGIN
                        //HEI.03 IBAN := "Old IBAN FND";
                        CustomerBankAccount."Old IBAN FND" := '';
                    end;
                CustomerBankAccount.MODIFY();
                //HEI.02<<
                Customer.MODIFY();
                COMMIT();
            end;
        end;
    end;
    //BC upgrade SHARMP16 CU id change because previous logic bypass the standard
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnApproveApprovalRequest, '', false, false)]
    local procedure OnApproveApprovalRequestVend(var ApprovalEntry: Record "Approval Entry")
    var
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        VendorBankAccountRec: Record "Vendor Bank Account";
        WorkflowRule: Record "Workflow Rule";
        RecID: RecordID;
        RecRef: RecordRef;
        // VendNo: FieldRef;
        VendorNumber: Code[20];
        VendorCode: Code[20];
        Modified: Boolean;
    begin
        //HEI.03>>
        RecID := ApprovalEntry."Record ID to Approve";
        IF RecID.TABLENO = DATABASE::"Vendor Bank Account" THEN BEGIN
            RecRef := RecID.GETRECORD();
            Clear(VendorNumber);
            Clear(VendorCode);
            VendorNumber := RecRef.FIELD(1).Value;
            VendorCode := RecRef.FIELD(2).Value;
            IF Vendor.GET(VendorNumber) THEN BEGIN
                IF NOT CheckOpenApprovalVendAccEntries(Vendor."No.") THEN BEGIN // HEI.14
                    Vendor."Sensitive Payment Block FND" := FALSE;
                    Vendor."Sensitive Workflow Block FND" := FALSE;
                end;
                // HEI.14
                VendorBankAccount.GET(VendorNumber, VendorCode);
                WorkflowRule.SETRANGE("Workflow Step Instance ID", ApprovalEntry."Workflow Step Instance ID");
                IF WorkflowRule.FINDFIRST() THEN
                    IF (WorkflowRule."Field No." = VendorBankAccount.FIELDNO("Bank Account No.")) AND (VendorBankAccount."Old Bank Account No. FND" <> '') THEN
                        VendorBankAccount."Old Bank Account No. FND" := ''
                    else IF (WorkflowRule."Field No." = VendorBankAccount.FIELDNO("Bank Branch No.")) AND (VendorBankAccount."Old Bank Branch No. FND" <> '') THEN
                        VendorBankAccount."Old Bank Branch No. FND" := ''
                    else IF (WorkflowRule."Field No." = VendorBankAccount.FIELDNO(IBAN)) AND (VendorBankAccount."Old IBAN FND" <> '') THEN
                        VendorBankAccount."Old IBAN FND" := '';
                VendorBankAccount.MODIFY();
                //HEI.13>>
                VendorBankAccountRec.RESET();
                VendorBankAccountRec.SETRANGE("Vendor No.", Vendor."No.");
                IF VendorBankAccountRec.findset() THEN BEGIN
                    REPEAT
                        IF (VendorBankAccountRec."Old Bank Account No. FND" <> '') OR (VendorBankAccountRec."Old Bank Branch No. FND" <> '') OR (VendorBankAccountRec."Old IBAN FND" <> '') THEN BEGIN
                            VendorBankAccountRec."Old Bank Account No. FND" := '';
                            VendorBankAccountRec."Old Bank Branch No. FND" := '';
                            VendorBankAccountRec."Old IBAN FND" := '';
                            VendorBankAccountRec.MODIFY();
                        end;
                    UNTIL VendorBankAccountRec.NEXT() = 0;
                end;
                //HEI.13<<
                Vendor.MODIFY();
            end;
            //HEI.11 >>
        end else BEGIN
            IF RecID.TABLENO = DATABASE::Vendor THEN BEGIN
                RecRef := RecID.GETRECORD();
                Clear(VendorNumber);
                VendorNumber := RecRef.FIELD(1).Value;
                IF Vendor.GET(VendorNumber) THEN BEGIN
                    Vendor."Sensitive Payment Block FND" := FALSE;
                    Vendor."Sensitive Workflow Block FND" := FALSE;
                    Vendor.MODIFY();
                    COMMIT();

                end;
            end;

        end;
        //HEI.11 <<
        //HEI.03<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Heineken BC Upgrade", OnAfterHandleEventWithxRec, '', false, false)]
    local procedure BlockVendor(Variant: Variant; xVariant: Variant)
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Vendor: Record Vendor;
        RecRef: RecordRef;
        // VendNo: FieldRef;
        VendorNumber: Code[20];
    begin
        //HEI.03>>
        RecRef.GETTABLE(Variant);
        IF RecRef.NUMBER = DATABASE::"Vendor Bank Account" THEN BEGIN
            Clear(VendorNumber);
            VendorNumber := RecRef.FIELD(1).Value;
            Vendor.GET(VendorNumber);
            IF CheckOpenApprovalVendAccEntries(Vendor."No.") THEN BEGIN // HEI.14
                Vendor."Sensitive Payment Block FND" := TRUE;
                Vendor."Sensitive Workflow Block FND" := TRUE;
                Vendor.MODIFY();
                COMMIT();
            end; // HEI.14
        end;
        //HEI.03<<
    end;



    procedure OnRejectApprovalRequestVend(ApprovalEntry: Record "Approval Entry")
    var
        ApprovalEntry2: Record "Approval Entry";
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        WorkflowRule: Record "Workflow Rule";
        RecID: RecordID;
        RecRef: RecordRef;
        // VendNo: FieldRef;
        VendorNumber: Code[20];
        VendorCode: Code[20];
    begin
        //HEI.03>>
        RecID := ApprovalEntry."Record ID to Approve";
        IF RecID.TABLENO = DATABASE::"Vendor Bank Account" THEN BEGIN
            RecRef := RecID.GETRECORD();
            Clear(VendorNumber);
            Clear(VendorCode);
            VendorNumber := RecRef.FIELD(1).Value;
            VendorCode := RecRef.FIELD(2).Value;
            IF Vendor.GET(VendorNumber) THEN BEGIN
                Vendor."Sensitive Payment Block FND" := TRUE;
                Vendor."Sensitive Workflow Block FND" := FALSE;
                VendorBankAccount.GET(VendorNumber, VendorCode);
                WorkflowRule.SETRANGE("Workflow Step Instance ID", ApprovalEntry."Workflow Step Instance ID");
                IF WorkflowRule.FINDFIRST() THEN
                    //<< HEI.08
                    IF VendorBankAccount."Old Bank Account No. FND" <> '' THEN BEGIN
                        IF VendorBankAccount."Bank Account No." <> '' THEN BEGIN
                            VendorBankAccount."Bank Account No." := VendorBankAccount."Old Bank Account No. FND";
                            VendorBankAccount."Old Bank Account No. FND" := '';
                        end else BEGIN
                            VendorBankAccount."Bank Account No." := '';
                            VendorBankAccount."Old Bank Account No. FND" := '';
                        end;
                    end;
                IF VendorBankAccount."Old Bank Branch No. FND" <> '' THEN BEGIN
                    //HEI.13
                    IF VendorBankAccount."Bank Branch No." <> '' THEN BEGIN
                        VendorBankAccount."Bank Branch No." := VendorBankAccount."Old Bank Branch No. FND";
                        VendorBankAccount."Old Bank Branch No. FND" := '';
                    end else BEGIN
                        VendorBankAccount."Bank Branch No." := '';
                        VendorBankAccount."Old Bank Branch No. FND" := '';
                    end;
                end;
                IF VendorBankAccount."Old IBAN FND" <> '' THEN BEGIN
                    //HEI.13
                    IF VendorBankAccount.IBAN <> '' THEN BEGIN
                        VendorBankAccount.IBAN := VendorBankAccount."Old IBAN FND";
                        VendorBankAccount."Old IBAN FND" := '';
                    end else BEGIN
                        VendorBankAccount.IBAN := '';
                        VendorBankAccount."Old IBAN FND" := '';
                    end;
                end;
                //>>HEI.08
                VendorBankAccount.MODIFY();
                Vendor.MODIFY();
                COMMIT();
            end;
            Vendor.MODIFY(); //HEI.15
        end;
        //HEI.03<<
    end;

    [EventSubscriber(ObjectType::Table, 288, OnAfterValidateEvent, "Bank Account No.", false, false)]
    local procedure RunWorkflowOnAfterModifyBankAccVendBankAcc(var Rec: Record "Vendor Bank Account"; var xRec: Record "Vendor Bank Account")
    var
        CustomerBankAccount: Record "Customer Bank Account";
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        IF SessionGlobals.GetSimulateModeGlobal() = FALSE THEN BEGIN
            VendorBankAccount.RESET();
            IF VendorBankAccount.GET(Rec."Vendor No.", Rec.Code) THEN
                // HEI.09 >>
                IF (xRec."Bank Account No." <> Rec."Bank Account No.") AND ((Rec."Bank Account No." <> '') OR (Rec."Bank Account No." = '')) AND (NOT Rec."Marked for Deletion FND") THEN BEGIN // HEI.15

                    //HEI.06>>
                    Vendor.GET(Rec."Vendor No.");
                    IF NOT Vendor."Sensitive Workflow Block FND" THEN BEGIN
                        //>> HEI.14
                        //xRec."Bank Branch No." := Rec."Old Bank Branch No. FND";
                        xRec."Bank Account No." := Rec."Old Bank Account No. FND";
                        //xRec.IBAN := Rec."Old IBAN FND";
                        //CompanyInfo.CheckIBAN(Rec.IBAN);
                        //WorkflowManagement.HandleEventWithxRec(VendBankWorkflowEventCode,Rec,xRec);
                        WorkflowManagement.HandleEventWithxRec(VendBankAccAccNoChangedWorkflowEventCode(), Rec, xRec);
                        //<< HEI.14
                    end;
                end;
            //HEI.06
        end;
        //HEI.09 <<
    end;

    [EventSubscriber(ObjectType::Table, 288, OnAfterValidateEvent, "Bank Branch No.", false, false)]
    local procedure RunWorkflowOnAfterModifyBankBranVendBankAcc(var Rec: Record "Vendor Bank Account"; var xRec: Record "Vendor Bank Account")
    var
        CustomerBankAccount: Record "Customer Bank Account";
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        // HEI.09 >>
        IF SessionGlobals.GetSimulateModeGlobal() = FALSE THEN BEGIN
            IF (xRec."Bank Branch No." <> Rec."Bank Branch No.") AND ((Rec."Bank Branch No." <> '') OR (Rec."Bank Branch No." = '')) AND (NOT Rec."Marked for Deletion FND") THEN BEGIN // HEI.15

                //HEI.06>>
                Vendor.GET(Rec."Vendor No.");

                IF NOT Vendor."Sensitive Workflow Block FND" THEN BEGIN
                    //>> HEI.14
                    xRec."Bank Branch No." := Rec."Old Bank Branch No. FND";
                    //xRec."Bank Account No." := Rec."Old Bank Account No. FND";
                    //xRec.IBAN := Rec."Old IBAN FND";
                    //CompanyInfo.CheckIBAN(Rec.IBAN);
                    //WorkflowManagement.HandleEventWithxRec(VendBankWorkflowEventCode,Rec,xRec);
                    WorkflowManagement.HandleEventWithxRec(VendBankAccBranchNoChangedWorkflowEventCode(), Rec, xRec);
                    //<< HEI.14
                end;
            end;
            //HEI.06
        end;
        //HEI.09 <<
    end;

    [EventSubscriber(ObjectType::Table, 288, OnAfterValidateEvent, IBAN, FALSE, FALSE)]
    local procedure RunWorkflowOnAfterModifyIBANVendBankAcc(var Rec: Record "Vendor Bank Account"; var xRec: Record "Vendor Bank Account")
    var
        CustomerBankAccount: Record "Customer Bank Account";
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        // HEI.09 >>
        IF SessionGlobals.GetSimulateModeGlobal() = FALSE THEN BEGIN
            IF (xRec.IBAN <> Rec.IBAN) AND ((Rec.IBAN <> '') OR (Rec.IBAN = '')) AND (NOT Rec."Marked for Deletion FND") THEN BEGIN // HEI.15


                //HEI.06>>
                Vendor.GET(Rec."Vendor No.");
                IF NOT Vendor."Sensitive Workflow Block FND" THEN BEGIN
                    //>> HEI.14
                    //xRec."Bank Branch No." := Rec."Old Bank Branch No. FND";
                    //xRec."Bank Account No." := Rec."Old Bank Account No. FND";
                    xRec.IBAN := Rec."Old IBAN FND";
                    CompanyInfo.CheckIBAN(Rec.IBAN);
                    //WorkflowManagement.HandleEventWithxRec(VendBankWorkflowEventCode,Rec,xRec);
                    WorkflowManagement.HandleEventWithxRec(VendBankAccIBANChangedWorkflowEventCode(), Rec, xRec);
                    //<< HEI.14
                end;
            end;
            //HEI.06
        end;
        //HEI.09 <<
    end;

    LOCAL procedure CheckOpenApprovalVendAccEntries(VendNo: Code[20]): Boolean
    var
        locApprovalEntry: Record "Approval Entry";
        RecID: RecordID;
        locRecRef: RecordRef;
        locVendNo: FieldRef;
        isOpen: Boolean;
    begin
        //>> HEI.14
        isOpen := FALSE;
        locApprovalEntry.SETRANGE("Table ID", DATABASE::"Vendor Bank Account");
        locApprovalEntry.SETRANGE(Status, locApprovalEntry.Status::Open);
        IF locApprovalEntry.findset() THEN BEGIN
            REPEAT
                RecID := locApprovalEntry."Record ID to Approve";
                locRecRef := RecID.GETRECORD();
                locVendNo := locRecRef.FIELD(1);
                IF FORMAT(locVendNo.VALUE) = VendNo THEN BEGIN
                    isOpen := TRUE;
                    EXIT(isOpen);
                end;
            UNTIL locApprovalEntry.NEXT() = 0;
        end;
        //<< HEI.14
    end;

    procedure VendBankAccIBANChangedWorkflowEventCode(): Code[128]
    begin
        //>> HEI.14
        EXIT(UPPERCASE('RunWorkflowOnVendorBankAccIBANChangedCode'));
        //<< HEI.14
    end;

    procedure VendBankAccBranchNoChangedWorkflowEventCode(): Code[128]
    begin
        //>> HEI.14
        EXIT(UPPERCASE('RunWorkflowOnVendorBankAccBrachNoChangedCode'));
        //<< HEI.14
    end;

    procedure VendBankAccAccNoChangedWorkflowEventCode(): Code[128]
    begin
        //>> HEI.14
        EXIT(UPPERCASE('RunWorkflowOnVendorBankAccAccNoChangedCode'));
        //<< HEI.14
    end;

    procedure VendBankInsertWorkflowEventCode(): Code[128]
    begin
        // HEI.10 >>
        COMMIT();
        EXIT(UPPERCASE('RunWorkflowOnAfterInsertVendBankAcc'));
        // HEI.10 <<
    end;

    [EventSubscriber(ObjectType::Table, 288, OnAfterInsertEvent, '', false, false)]
    local procedure RunWorkflowOnAfterInsertVendBankAcc(var Rec: Record "Vendor Bank Account")
    begin
        //HEI.10 >>
        IF SessionGlobals.GetSimulateModeGlobal() = FALSE THEN
            IF (Rec.Code <> '') AND (Rec."Vendor No." <> '') AND (NOT Rec."Marked for Deletion FND") THEN BEGIN //HEI.15
                                                                                                            // CompanyInfo.CheckIBAN(Rec.IBAN);
                WorkflowManagement.HandleEvent(VendBankInsertWorkflowEventCode(), Rec);
            end;
        //HEI.10 <<


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Heineken BC Upgrade", OnSendCheckLedgerInt, '', false, false)]
    local procedure RunWorkflowOnSendVoidCheckLedgerForApproval(var CheckLedgerRec: Record "Check Ledger Entry")
    begin
        //HEI.12
        WorkflowManagement.HandleEvent(RunWorkflowOnSendVoidCheckfromCheckLedgerEntryCode(), CheckLedgerRec);
        //HEI.12
    end;



    procedure RunWorkflowOnSendVoidCheckfromCheckLedgerEntryCode(): Code[128]
    begin
        //HEI.12
        EXIT(UPPERCASE('RunWorkflowOnSendVoidCheckLedgerForApproval'));
        //HEI.12
    end;

    [EventSubscriber(ObjectType::Codeunit, 1520, OnAddWorkflowEventsToLibrary, '', false, false)]
    local procedure AddEventToLibrary()
    begin
        //HEI.12
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendVoidCheckfromCheckLedgerEntryCode(), DATABASE::"Check Ledger Entry", 'Void A Check from Check ledger Entry Approval request', 0, TRUE);
        //HEI.12
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCanelVendorBankForApprovalCode(), DATABASE::"Vendor Bank Account", 'Vendor Bank Account request is cancelled', 0, TRUE);
    end;

    procedure RunWorkflowOnCanelVendorBankForApprovalCode(): Code[128]
    begin
        EXIT(UPPERCASE('RunWorkflowOnCanelVendorBankForApprovalCode'));
    end;

    // BC Upgrade 50019 Codeunit <<
}
