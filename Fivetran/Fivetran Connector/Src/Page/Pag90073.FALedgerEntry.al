namespace fivetran.fivetran;

using Microsoft.FixedAssets.Ledger;

page 90073 "FA Ledger Entry"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'FA Ledger Entry API';
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityName = 'faLedgerEntry';
    EntitySetName = 'faLedgerEntries';
    PageType = API;
    SourceTable = "FA Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(gLEntryNo; Rec."G/L Entry No.")
                {
                    Caption = 'G/L Entry No.';
                }
                field(faNo; Rec."FA No.")
                {
                    Caption = 'FA No.';
                }
                field(faPostingDate; Rec."FA Posting Date")
                {
                    Caption = 'FA Posting Date';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(depreciationBookCode; Rec."Depreciation Book Code")
                {
                    Caption = 'Depreciation Book Code';
                }
                field(faPostingCategory; Rec."FA Posting Category")
                {
                    Caption = 'FA Posting Category';
                }
                field(faPostingType; Rec."FA Posting Type")
                {
                    Caption = 'FA Posting Type';
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
                field(reclassificationEntry; Rec."Reclassification Entry")
                {
                    Caption = 'Reclassification Entry';
                }
                field(partOfBookValue; Rec."Part of Book Value")
                {
                    Caption = 'Part of Book Value';
                }
                field(partOfDepreciableBasis; Rec."Part of Depreciable Basis")
                {
                    Caption = 'Part of Depreciable Basis';
                }
                field(disposalCalculationMethod; Rec."Disposal Calculation Method")
                {
                    Caption = 'Disposal Calculation Method';
                }
                field(disposalEntryNo; Rec."Disposal Entry No.")
                {
                    Caption = 'Disposal Entry No.';
                }
                field(noOfDepreciationDays; Rec."No. of Depreciation Days")
                {
                    Caption = 'No. of Depreciation Days';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(faNoBudgetedFANo; Rec."FA No./Budgeted FA No.")
                {
                    Caption = 'FA No./Budgeted FA No.';
                }
                field(faSubclassCode; Rec."FA Subclass Code")
                {
                    Caption = 'FA Subclass Code';
                }
                field(faLocationCode; Rec."FA Location Code")
                {
                    Caption = 'FA Location Code';
                }
                field(faPostingGroup; Rec."FA Posting Group")
                {
                    Caption = 'FA Posting Group';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(depreciationMethod; Rec."Depreciation Method")
                {
                    Caption = 'Depreciation Method';
                }
                field(depreciationStartingDate; Rec."Depreciation Starting Date")
                {
                    Caption = 'Depreciation Starting Date';
                }
                field(straightLine; Rec."Straight-Line %")
                {
                    Caption = 'Straight-Line %';
                }
                field(noOfDepreciationYears; Rec."No. of Depreciation Years")
                {
                    Caption = 'No. of Depreciation Years';
                }
                field(fixedDeprAmount; Rec."Fixed Depr. Amount")
                {
                    Caption = 'Fixed Depr. Amount';
                }
                field(decliningBalance; Rec."Declining-Balance %")
                {
                    Caption = 'Declining-Balance %';
                }
                field(depreciationTableCode; Rec."Depreciation Table Code")
                {
                    Caption = 'Depreciation Table Code';
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                    Caption = 'Journal Batch Name';
                }
                field(sourceCode; Rec."Source Code")
                {
                    Caption = 'Source Code';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(transactionNo; Rec."Transaction No.")
                {
                    Caption = 'Transaction No.';
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                }
                field(balAccountNo; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
                }
                field(vatAmount; Rec."VAT Amount")
                {
                    Caption = 'VAT Amount';
                }
                field(genPostingType; Rec."Gen. Posting Type")
                {
                    Caption = 'Gen. Posting Type';
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                }
                field(faClassCode; Rec."FA Class Code")
                {
                    Caption = 'FA Class Code';
                }
                field(faExchangeRate; Rec."FA Exchange Rate")
                {
                    Caption = 'FA Exchange Rate';
                }
                field(amountLCY; Rec."Amount (LCY)")
                {
                    Caption = 'Amount (LCY)';
                }
                field(resultOnDisposal; Rec."Result on Disposal")
                {
                    Caption = 'Result on Disposal';
                }
                field(correction; Rec.Correction)
                {
                    Caption = 'Correction';
                }
                field(indexEntry; Rec."Index Entry")
                {
                    Caption = 'Index Entry';
                }
                field(canceledFromFANo; Rec."Canceled from FA No.")
                {
                    Caption = 'Canceled from FA No.';
                }
                field(depreciationEndingDate; Rec."Depreciation Ending Date")
                {
                    Caption = 'Depreciation Ending Date';
                }
                field(useFALedgerCheck; Rec."Use FA Ledger Check")
                {
                    Caption = 'Use FA Ledger Check';
                }
                field(automaticEntry; Rec."Automatic Entry")
                {
                    Caption = 'Automatic Entry';
                }
                field(deprStartingDateCustom1; Rec."Depr. Starting Date (Custom 1)")
                {
                    Caption = 'Depr. Starting Date (Custom 1)';
                }
                field(deprEndingDateCustom1; Rec."Depr. Ending Date (Custom 1)")
                {
                    Caption = 'Depr. Ending Date (Custom 1)';
                }
                field(accumDeprCustom1; Rec."Accum. Depr. % (Custom 1)")
                {
                    Caption = 'Accum. Depr. % (Custom 1)';
                }
                field(deprThisYearCustom1; Rec."Depr. % this year (Custom 1)")
                {
                    Caption = 'Depr. % this year (Custom 1)';
                }
                field(propertyClassCustom1; Rec."Property Class (Custom 1)")
                {
                    Caption = 'Property Class (Custom 1)';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(taxAreaCode; Rec."Tax Area Code")
                {
                    Caption = 'Tax Area Code';
                }
                field(taxLiable; Rec."Tax Liable")
                {
                    Caption = 'Tax Liable';
                }
                field(taxGroupCode; Rec."Tax Group Code")
                {
                    Caption = 'Tax Group Code';
                }
                field(useTax; Rec."Use Tax")
                {
                    Caption = 'Use Tax';
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                }
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                }
                field(reversed; Rec.Reversed)
                {
                    Caption = 'Reversed';
                }
                field(reversedByEntryNo; Rec."Reversed by Entry No.")
                {
                    Caption = 'Reversed by Entry No.';
                }
                field(reversedEntryNo; Rec."Reversed Entry No.")
                {
                    Caption = 'Reversed Entry No.';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(purchaseReceiptLineNoFND; Rec."Purchase Receipt Line No. FND")
                {
                    Caption = 'Purchase Receipt Line No.';
                }
                field(commentFND; Rec."Comment FND")
                {
                    Caption = 'Comment';
                }
                field(vendorIDFND; Rec."Vendor ID FND")
                {
                    Caption = 'Vendor ID';
                }
                field(poNumberFND; Rec."PO Number FND")
                {
                    Caption = 'PO Number';
                }
                field(referenceNumberFND; Rec."Reference Number FND")
                {
                    Caption = 'Reference Number';
                }
                field(capexCodeFND; Rec."CAPEX Code FND")
                {
                    Caption = 'CAPEX Code';
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
