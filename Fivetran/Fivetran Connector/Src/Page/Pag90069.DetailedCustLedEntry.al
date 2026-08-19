namespace fivetran.fivetran;

using Microsoft.Sales.Receivables;

page 90069 "Detailed Cust. Led. Entry"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Detailed Cust. Led. Entry API';
    DelayedInsert = true;
    DataAccessIntent = ReadOnly;
    ODataKeyFields = SystemId;
    Editable = false;
    EntityName = 'detailedCustLedEntry';
    EntitySetName = 'detailedCustLedEntries';
    PageType = API;
    SourceTable = "Detailed Cust. Ledg. Entry";

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
                field(custLedgerEntryNo; Rec."Cust. Ledger Entry No.")
                {
                    Caption = 'Cust. Ledger Entry No.';
                }
                field(entryType; Rec."Entry Type")
                {
                    Caption = 'Entry Type';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(amountLCY; Rec."Amount (LCY)")
                {
                    Caption = 'Amount (LCY)';
                }
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(sourceCode; Rec."Source Code")
                {
                    Caption = 'Source Code';
                }
                field(transactionNo; Rec."Transaction No.")
                {
                    Caption = 'Transaction No.';
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                    Caption = 'Journal Batch Name';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(debitAmount; Rec."Debit Amount")
                {
                    Caption = 'Debit Amount';
                }
                field(creditAmount; Rec."Credit Amount")
                {
                    Caption = 'Credit Amount';
                }
                field(debitAmountLCY; Rec."Debit Amount (LCY)")
                {
                    Caption = 'Debit Amount (LCY)';
                }
                field(creditAmountLCY; Rec."Credit Amount (LCY)")
                {
                    Caption = 'Credit Amount (LCY)';
                }
                field(initialEntryDueDate; Rec."Initial Entry Due Date")
                {
                    Caption = 'Initial Entry Due Date';
                }
                field(initialEntryGlobalDim1; Rec."Initial Entry Global Dim. 1")
                {
                    Caption = 'Initial Entry Global Dim. 1';
                }
                field(initialEntryGlobalDim2; Rec."Initial Entry Global Dim. 2")
                {
                    Caption = 'Initial Entry Global Dim. 2';
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
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
                field(initialDocumentType; Rec."Initial Document Type")
                {
                    Caption = 'Initial Document Type';
                }
                field(appliedCustLedgerEntryNo; Rec."Applied Cust. Ledger Entry No.")
                {
                    Caption = 'Applied Cust. Ledger Entry No.';
                }
                field(unapplied; Rec.Unapplied)
                {
                    Caption = 'Unapplied';
                }
                field(unappliedByEntryNo; Rec."Unapplied by Entry No.")
                {
                    Caption = 'Unapplied by Entry No.';
                }
                field(remainingPmtDiscPossible; Rec."Remaining Pmt. Disc. Possible")
                {
                    Caption = 'Remaining Pmt. Disc. Possible';
                }
                field(maxPaymentTolerance; Rec."Max. Payment Tolerance")
                {
                    Caption = 'Max. Payment Tolerance';
                }
                field(taxJurisdictionCode; Rec."Tax Jurisdiction Code")
                {
                    Caption = 'Tax Jurisdiction Code';
                }
                field(applicationNo; Rec."Application No.")
                {
                    Caption = 'Application No.';
                }
                field(ledgerEntryAmount; Rec."Ledger Entry Amount")
                {
                    Caption = 'Ledger Entry Amount';
                }
                field(lastAdjustedCurrFactorFND; Rec."Last Adjusted Curr. Factor FND")
                {
                    Caption = 'Last Adjusted Curr. Factor';
                }
                field(reversedFND; Rec."Reversed FND")
                {
                    Caption = 'Reversed';
                }
                field(customer_posting_group; Rec."Customer Posting Group 101FDW")
                {
                    Caption = 'Customer Posting Group';
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
