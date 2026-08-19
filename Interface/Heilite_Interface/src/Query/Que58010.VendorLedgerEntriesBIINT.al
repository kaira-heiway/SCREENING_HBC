namespace PowerPlatform.PowerPlatform;

using Microsoft.Purchases.Payables;

query 58010 "Vendor Ledger Entries BI INT"
{
    APIGroup = 'BIReporting';
    APIPublisher = 'IBM';
    APIVersion = 'v2.0';
    EntityName = 'VendorLedgerEntriesAPIBI';
    EntitySetName = 'VendorLedgerEntriesBI';
    QueryType = API;

    elements
    {
        dataitem(vendorLedgerEntry; "Vendor Ledger Entry")
        {
            column(entryNo; "Entry No.")
            {
            }
            column(vendorNo; "Vendor No.")
            {
            }
            column(postingDate; "Posting Date")
            {
            }
            column(documentType; "Document Type")
            {
            }
            column(documentNo; "Document No.")
            {
            }
            column(description; Description)
            {
            }
            column(currencyCode; "Currency Code")
            {
            }
            column(purchaseLCY; "Purchase (LCY)")
            {
            }
            column(invDiscountLCY; "Inv. Discount (LCY)")
            {
            }
            column(buyFromVendorNo; "Buy-from Vendor No.")
            {
            }
            column(vendorPostingGroup; "Vendor Posting Group")
            {
            }
            column(globalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(globalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(purchaserCode; "Purchaser Code")
            {
            }
            column(userID; "User ID")
            {
            }
            column(sourceCode; "Source Code")
            {
            }
            column(onHold; "On Hold")
            {
            }
            column(appliesToDocType; "Applies-to Doc. Type")
            {
            }
            column(appliesToDocNo; "Applies-to Doc. No.")
            {
            }
            column(open; Open)
            {
            }
            column(dueDate; "Due Date")
            {
            }
            column(pmtDiscountDate; "Pmt. Discount Date")
            {
            }
            column(originalPmtDiscPossible; "Original Pmt. Disc. Possible")
            {
            }
            column(pmtDiscRcdLCY; "Pmt. Disc. Rcd.(LCY)")
            {
            }
            column(positive; Positive)
            {
            }
            column(closedByEntryNo; "Closed by Entry No.")
            {
            }
            column(closedAtDate; "Closed at Date")
            {
            }
            column(closedByAmount; "Closed by Amount")
            {
            }
            column(appliesToID; "Applies-to ID")
            {
            }
            column(journalBatchName; "Journal Batch Name")
            {
            }
            column(reasonCode; "Reason Code")
            {
            }
            column(balAccountType; "Bal. Account Type")
            {
            }
            column(balAccountNo; "Bal. Account No.")
            {
            }
            column(transactionNo; "Transaction No.")
            {
            }
            column(closedByAmountLCY; "Closed by Amount (LCY)")
            {
            }
            column(documentDate; "Document Date")
            {
            }
            column(externalDocumentNo; "External Document No.")
            {
            }
            column(noSeries; "No. Series")
            {
            }
            column(closedByCurrencyCode; "Closed by Currency Code")
            {
            }
            column(closedByCurrencyAmount; "Closed by Currency Amount")
            {
            }
            column(adjustedCurrencyFactor; "Adjusted Currency Factor")
            {
            }
            column(originalCurrencyFactor; "Original Currency Factor")
            {
            }
            column(remainingPmtDiscPossible; "Remaining Pmt. Disc. Possible")
            {
            }
            column(pmtDiscToleranceDate; "Pmt. Disc. Tolerance Date")
            {
            }
            column(maxPaymentTolerance; "Max. Payment Tolerance")
            {
            }
            column(acceptedPaymentTolerance; "Accepted Payment Tolerance")
            {
            }
            column(acceptedPmtDiscTolerance; "Accepted Pmt. Disc. Tolerance")
            {
            }
            column(pmtToleranceLCY; "Pmt. Tolerance (LCY)")
            {
            }
            column(amountToApply; "Amount to Apply")
            {
            }
            column(icPartnerCode; "IC Partner Code")
            {
            }
            column(applyingEntry; "Applying Entry")
            {
            }
            column(reversed; Reversed)
            {
            }
            column(reversedEntryNo; "Reversed Entry No.")
            {
            }
            column(reversedByEntryNo; "Reversed by Entry No.")
            {
            }
            column(prepayment; Prepayment)
            {
            }
            column(creditorNo; "Creditor No.")
            {
            }
            column(paymentReference; "Payment Reference")
            {
            }
            column(paymentMethodCode; "Payment Method Code")
            {
            }
            column(appliesToExtDocNo; "Applies-to Ext. Doc. No.")
            {
            }
            column(recipientBankAccount; "Recipient Bank Account")
            {
            }
            column(messageToRecipient; "Message to Recipient")
            {
            }
            column(exportedToPaymentFile; "Exported to Payment File")
            {
            }
            column(dimensionSetID; "Dimension Set ID")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
