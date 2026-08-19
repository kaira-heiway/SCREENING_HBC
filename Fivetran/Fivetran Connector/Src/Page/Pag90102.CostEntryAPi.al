page 90102 "Cost Entry"
{
    DelayedInsert = true;
    PageType = API;
    ODataKeyFields = SystemId;
    EntityName = 'costEntry';
    EntitySetName = 'costEntries';
    SourceTable = "Cost Entry";
    DataAccessIntent = ReadOnly;
    Editable = false;
    APIPublisher = 'fivetran';
    APIVersion = 'v2.0';
    APIGroup = 'standardEndpoints';

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
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
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
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
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
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(gLAccount; Rec."G/L Account")
                {
                    Caption = 'G/L Account';
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
                field(allocated; Rec.Allocated)
                {
                    Caption = 'Allocated';
                }
                field(allocatedWithJournalNo; Rec."Allocated with Journal No.")
                {
                    Caption = 'Allocated with Journal No.';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(batchName; Rec."Batch Name")
                {
                    Caption = 'Batch Name';
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
                field(brand; Rec."Brand FND")
                {
                    Caption = 'Brand';
                }
                field(line; Rec."Line FND")
                {
                    Caption = 'Line';
                }
                field(shippingCost; Rec."Shipping Cost FND")
                {
                    Caption = 'Shipping Cost';
                }
                field(dimension1Code; Rec."Dimension 1 Code FND")
                {
                    Caption = 'Dimension 1 Code';
                }
                field(dimension2Code; Rec."Dimension 2 Code FND")
                {
                    Caption = 'Dimension 2 Code';
                }
                field(dimension3Code; Rec."Dimension 3 Code FND")
                {
                    Caption = 'Dimension 3 Code';
                }
                field(dimension4Code; Rec."Dimension 4 Code FND")
                {
                    Caption = 'Dimension 4 Code';
                }
                field(dimension5Code; Rec."Dimension 5 Code FND")
                {
                    Caption = 'Dimension 5 Code';
                }
                field(dimension6Code; Rec."Dimension 6 Code FND")
                {
                    Caption = 'Dimension 6 Code';
                }
                field(dimension7Code; Rec."Dimension 7 Code FND")
                {
                    Caption = 'Dimension 7 Code';
                }
                field(dimension8Code; Rec."Dimension 8 Code FND")
                {
                    Caption = 'Dimension 8 Code';
                }
                field(dimension9Code; Rec."Dimension 9 Code FND")
                {
                    Caption = 'Dimension 9 Code';
                }
                field(dimension10Code; Rec."Dimension 10 Code FND")
                {
                    Caption = 'Dimension 10 Code';
                }
                field(dimension11Code; Rec."Dimension 11 Code FND")
                {
                    Caption = 'Dimension 11 Code';
                }
                field(dimension12Code; Rec."Dimension 12 Code FND")
                {
                    Caption = 'Dimension 12 Code';
                }
                field(dimension13Code; Rec."Dimension 13 Code FND")
                {
                    Caption = 'Dimension 13 Code';
                }
                field(dimension14Code; Rec."Dimension 14 Code FND")
                {
                    Caption = 'Dimension 14 Code';
                }
                field(dimension15Code; Rec."Dimension 15 Code FND")
                {
                    Caption = 'Dimension 15 Code';
                }
                field(dimension16Code; Rec."Dimension 16 Code FND")
                {
                    Caption = 'Dimension 16 Code';
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