namespace fivetran.fivetran;

using Microsoft.Finance.GeneralLedger.Journal;

page 90077 "Gen. Journal Template API"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'General Journal Template API';
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityName = 'genJournalTemplate';
    EntitySetName = 'genJournalTemplates';
    PageType = API;
    SourceTable = "Gen. Journal Template";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(testReportID; Rec."Test Report ID")
                {
                    Caption = 'Test Report ID';
                }
                field(pageID; Rec."Page ID")
                {
                    Caption = 'Page ID';
                }
                field(postingReportID; Rec."Posting Report ID")
                {
                    Caption = 'Posting Report ID';
                }
                field(forcePostingReport; Rec."Force Posting Report")
                {
                    Caption = 'Force Posting Report';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(sourceCode; Rec."Source Code")
                {
                    Caption = 'Source Code';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(recurring; Rec.Recurring)
                {
                    Caption = 'Recurring';
                }
                field(forceDocBalance; Rec."Force Doc. Balance")
                {
                    Caption = 'Force Doc. Balance';
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                }
                field(balAccountNo; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(postingNoSeries; Rec."Posting No. Series")
                {
                    Caption = 'Posting No. Series';
                }
                field(copyVATSetupToJnlLines; Rec."Copy VAT Setup to Jnl. Lines")
                {
                    Caption = 'Copy VAT Setup to Jnl. Lines';
                }
                field(allowVATDifference; Rec."Allow VAT Difference")
                {
                    Caption = 'Allow VAT Difference';
                }
                field(custReceiptReportID; Rec."Cust. Receipt Report ID")
                {
                    Caption = 'Cust. Receipt Report ID';
                }
                field(vendorReceiptReportID; Rec."Vendor Receipt Report ID")
                {
                    Caption = 'Vendor Receipt Report ID';
                }
                field(extDocNoMandatoryFND; Rec."Ext. Doc. No. Mandatory FND")
                {
                    Caption = 'Ext. Doc. No. Mandatory';
                }
                field(saveBatchFND; Rec."Save Batch FND")
                {
                    Caption = 'Save Batch';
                }
                field(customerMandateFND; Rec."Customer Mandate FND")
                {
                    Caption = 'Customer Mandate';
                }
                field(rpmPaymentFND; Rec."RPM Payment FND")
                {
                    Caption = 'RPM Payment';
                }
                field(restrictDplctExtrnDocFND; Rec."Restrct Dplct. Extrn Doc FND")
                {
                    Caption = 'Restrct Dplct. Extrn Doc';
                }
                field(soCashApplicationFND; Rec."SO Cash Application FND")
                {
                    Caption = 'SO Cash Application';
                }
                field(payrollFND; Rec."Payroll FND")
                {
                    Caption = 'Payroll';
                }
                field(drcShowPayMethodFND; Rec."DRC - Show Pay. Method FND")
                {
                    Caption = 'DRC - Show Pay. Method';
                }
                field(blockedFND; Rec."Blocked FND")
                {
                    Caption = 'Blocked';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
