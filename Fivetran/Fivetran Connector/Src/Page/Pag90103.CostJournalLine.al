page 90103 "Cost Journal Line"
{
    PageType = API;
    DelayedInsert = true;
    SourceTable = "Cost Journal Line";
    ODataKeyFields = SystemId;
    Editable = false;
    DataAccessIntent = ReadOnly;
    APIPublisher = 'fivetran';
    APIVersion = 'v2.0';
    APIGroup = 'standardEndpoints';
    EntityName = 'costJournalLine';
    EntitySetName = 'costJournalLines';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(journalTemplateName; Rec."Journal Template Name")
                {
                    Caption = 'Journal Template Name';
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                    Caption = 'Journal Batch Name';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(costTypeNo; Rec."Cost Type No.")
                {
                    Caption = 'Cost Type No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(balCostTypeNo; Rec."Bal. Cost Type No.")
                {
                    Caption = 'Bal. Cost Type No.';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(balance; Rec.Balance)
                {
                    Caption = 'Balance';
                }
                field(debitAmount; Rec."Debit Amount")
                {
                    Caption = 'Debit Amount';
                }
                field(creditAmount; Rec."Credit Amount")
                {
                    Caption = 'Credit Amount';
                }
                field(costCenterCode; Rec."Cost Center Code")
                {
                    Caption = 'Cost Center Code';
                }
                field(costObjectCode; Rec."Cost Object Code")
                {
                    Caption = 'Cost Object Code';
                }
                field(balCostCenterCode; Rec."Bal. Cost Center Code")
                {
                    Caption = 'Bal. Cost Center Code';
                }
                field(balCostObjectCode; Rec."Bal. Cost Object Code")
                {
                    Caption = 'Bal. Cost Object Code';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(gLEntryNo; Rec."G/L Entry No.")
                {
                    Caption = 'G/L Entry No.';
                }
                field(sourceCode; Rec."Source Code")
                {
                    Caption = 'Source Code';
                }
                field(systemCreatedEntry; Rec."System-Created Entry")
                {
                    Caption = 'System-Created Entry';
                }
                field(costEntryNo; Rec."Cost Entry No.")
                {
                    Caption = 'Cost Entry No.';
                }
                field(allocated; Rec.Allocated)
                {
                    Caption = 'Allocated';
                }
                field(allocationDescription; Rec."Allocation Description")
                {
                    Caption = 'Allocation Description';
                }
                field(allocationID; Rec."Allocation ID")
                {
                    Caption = 'Allocation ID';
                }
                field(additionalCurrencyAmount; Rec."Additional-Currency Amount")
                {
                    Caption = 'Additional-Currency Amount';
                }
                field(addCurrencyDebitAmount; Rec."Add.-Currency Debit Amount")
                {
                    Caption = 'Add.-Currency Debit Amount';
                }
                field(addCurrencyCreditAmount; Rec."Add.-Currency Credit Amount")
                {
                    Caption = 'Add.-Currency Credit Amount';
                }
                field(budgetName; Rec."Budget Name")
                {
                    Caption = 'Budget Name';
                }
                field(brand; Rec."Brand FND")
                {
                    Caption = 'Brand';
                }
                field(line; Rec."Line FND")
                {
                    Caption = 'Line';
                }
                field(dimensionSetID; Rec."Dimension Set ID FND")
                {
                    Caption = 'Dimension Set ID';
                }
                field(startingDate; Rec."Starting Date FND")
                {
                    Caption = 'Starting Date';
                }
                field(endingDate; Rec."Ending Date FND")
                {
                    Caption = 'Ending Date';
                }
                field(shippingCost; Rec."Shipping Cost FND")
                {
                    Caption = 'Shipping Cost';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}