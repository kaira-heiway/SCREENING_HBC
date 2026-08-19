page 90011 "Gen. Journal Batch"
{
    PageType = API;
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'Gen. Journal Batch';
    EntitySetCaption = 'Gen. Journal Batches';
    DelayedInsert = true;
    EntityName = 'generalJournalBatch';
    EntitySetName = 'generalJournalBatches';
    ODataKeyFields = SystemId;
    SourceTable = "Gen. Journal Batch";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(allowPaymentExport; Rec."Allow Payment Export")
                {
                    Caption = 'Allow Payment Export';
                }
                field(allowVATDifference; Rec."Allow VAT Difference")
                {
                    Caption = 'Allow VAT Difference';
                }
                field(balAccountNo; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                }
                field(balAccountId; Rec.BalAccountId)
                {
                    Caption = 'BalAccountId';
                }
                field(bankStatementImportFormat; Rec."Bank Statement Import Format")
                {
                    Caption = 'Bank Statement Import Format';
                }
                field(copyVATSetupToJnlLines; Rec."Copy VAT Setup to Jnl. Lines")
                {
                    Caption = 'Copy VAT Setup to Jnl. Lines';
                }
                field(copyToPostedJnlLines; Rec."Copy to Posted Jnl. Lines")
                {
                    Caption = 'Copy to Posted Jnl. Lines';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(journalTemplateName; Rec."Journal Template Name")
                {
                    Caption = 'Journal Template Name';
                }
                field(lastModifiedDateTime; Rec."Last Modified DateTime")
                {
                    Caption = 'Last Modified DateTime';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(pendingApproval; Rec."Pending Approval")
                {
                    Caption = 'Pending Approval';
                }
                field(postingNoSeries; Rec."Posting No. Series")
                {
                    Caption = 'Posting No. Series';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(recurring; Rec.Recurring)
                {
                    Caption = 'Recurring';
                }
                field(suggestBalancingAmount; Rec."Suggest Balancing Amount")
                {
                    Caption = 'Suggest Balancing Amount';
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
                field(templateType; Rec."Template Type")
                {
                    Caption = 'Template Type';
                }
            }
        }
    }
}
