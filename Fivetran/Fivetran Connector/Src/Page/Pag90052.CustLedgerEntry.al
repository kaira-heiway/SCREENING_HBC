page 90052 "Cust. Ledger Entry"
{
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    ApplicationArea = All;
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    EntityName = 'customerLedgerEntries';
    EntitySetName = 'customerLedgerEntry';
    EntityCaption = 'customerLedgerEntry';
    EntitySetCaption = 'customerLedgerEntries';
    PageType = API;
    SourceTable = "Cust. Ledger Entry";

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
                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
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
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(salesLCY; Rec."Sales (LCY)")
                {
                    Caption = 'Sales (LCY)';
                }
                field(profitLCY; Rec."Profit (LCY)")
                {
                    Caption = 'Profit (LCY)';
                }
                field(invDiscountLCY; Rec."Inv. Discount (LCY)")
                {
                    Caption = 'Inv. Discount (LCY)';
                }
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                }
                field(customerPostingGroup; Rec."Customer Posting Group")
                {
                    Caption = 'Customer Posting Group';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(salespersonCode; Rec."Salesperson Code")
                {
                    Caption = 'Salesperson Code';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(sourceCode; Rec."Source Code")
                {
                    Caption = 'Source Code';
                }
                field(onHold; Rec."On Hold")
                {
                    Caption = 'On Hold';
                }
                field(appliesToDocType; Rec."Applies-to Doc. Type")
                {
                    Caption = 'Applies-to Doc. Type';
                }
                field(appliesToDocNo; Rec."Applies-to Doc. No.")
                {
                    Caption = 'Applies-to Doc. No.';
                }
                field(open; Rec.Open)
                {
                    Caption = 'Open';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(pmtDiscountDate; Rec."Pmt. Discount Date")
                {
                    Caption = 'Pmt. Discount Date';
                }
                field(originalPmtDiscPossible; Rec."Original Pmt. Disc. Possible")
                {
                    Caption = 'Original Pmt. Disc. Possible';
                }
                field(pmtDiscGivenLCY; Rec."Pmt. Disc. Given (LCY)")
                {
                    Caption = 'Pmt. Disc. Given (LCY)';
                }
                field(positive; Rec.Positive)
                {
                    Caption = 'Positive';
                }
                field(closedByEntryNo; Rec."Closed by Entry No.")
                {
                    Caption = 'Closed by Entry No.';
                }
                field(closedAtDate; Rec."Closed at Date")
                {
                    Caption = 'Closed at Date';
                }
                field(closedByAmount; Rec."Closed by Amount")
                {
                    Caption = 'Closed by Amount';
                }
                field(appliesToID; Rec."Applies-to ID")
                {
                    Caption = 'Applies-to ID';
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                    Caption = 'Journal Batch Name';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                }
                field(balAccountNo; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
                }
                field(transactionNo; Rec."Transaction No.")
                {
                    Caption = 'Transaction No.';
                }
                field(closedByAmountLCY; Rec."Closed by Amount (LCY)")
                {
                    Caption = 'Closed by Amount (LCY)';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(calculateInterest; Rec."Calculate Interest")
                {
                    Caption = 'Calculate Interest';
                }
                field(closingInterestCalculated; Rec."Closing Interest Calculated")
                {
                    Caption = 'Closing Interest Calculated';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(closedByCurrencyCode; Rec."Closed by Currency Code")
                {
                    Caption = 'Closed by Currency Code';
                }
                field(closedByCurrencyAmount; Rec."Closed by Currency Amount")
                {
                    Caption = 'Closed by Currency Amount';
                }
                field(adjustedCurrencyFactor; Rec."Adjusted Currency Factor")
                {
                    Caption = 'Adjusted Currency Factor';
                }
                field(originalCurrencyFactor; Rec."Original Currency Factor")
                {
                    Caption = 'Original Currency Factor';
                }
                field(remainingPmtDiscPossible; Rec."Remaining Pmt. Disc. Possible")
                {
                    Caption = 'Remaining Pmt. Disc. Possible';
                }
                field(pmtDiscToleranceDate; Rec."Pmt. Disc. Tolerance Date")
                {
                    Caption = 'Pmt. Disc. Tolerance Date';
                }
                field(maxPaymentTolerance; Rec."Max. Payment Tolerance")
                {
                    Caption = 'Max. Payment Tolerance';
                }
                field(lastIssuedReminderLevel; Rec."Last Issued Reminder Level")
                {
                    Caption = 'Last Issued Reminder Level';
                }
                field(acceptedPaymentTolerance; Rec."Accepted Payment Tolerance")
                {
                    Caption = 'Accepted Payment Tolerance';
                }
                field(acceptedPmtDiscTolerance; Rec."Accepted Pmt. Disc. Tolerance")
                {
                    Caption = 'Accepted Pmt. Disc. Tolerance';
                }
                field(pmtToleranceLCY; Rec."Pmt. Tolerance (LCY)")
                {
                    Caption = 'Pmt. Tolerance (LCY)';
                }
                field(amountToApply; Rec."Amount to Apply")
                {
                    Caption = 'Amount to Apply';
                }
                field(icPartnerCode; Rec."IC Partner Code")
                {
                    Caption = 'IC Partner Code';
                }
                field(applyingEntry; Rec."Applying Entry")
                {
                    Caption = 'Applying Entry';
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
                field(prepayment; Rec.Prepayment)
                {
                    Caption = 'Prepayment';
                }
                field(paymentMethodCode; Rec."Payment Method Code")
                {
                    Caption = 'Payment Method Code';
                }
                field(appliesToExtDocNo; Rec."Applies-to Ext. Doc. No.")
                {
                    Caption = 'Applies-to Ext. Doc. No.';
                }
                field(recipientBankAccount; Rec."Recipient Bank Account")
                {
                    Caption = 'Recipient Bank Account';
                }
                field(messageToRecipient; Rec."Message to Recipient")
                {
                    Caption = 'Message to Recipient';
                }
                field(exportedToPaymentFile; Rec."Exported to Payment File")
                {
                    Caption = 'Exported to Payment File';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(directDebitMandateID; Rec."Direct Debit Mandate ID")
                {
                    Caption = 'Direct Debit Mandate ID';
                }
                field(remAmtForWHTFND; Rec."Rem. Amt for WHT FND")
                {
                    Caption = 'Rem. Amt for WHT';
                }
                field(remAmountFND; Rec."Rem. Amt FND")
                {
                    Caption = 'Rem. Amt';
                }
                field(commentFND; Rec."Comment FND")
                {
                    Caption = 'Comment';
                }
                field(whtPaymentFND; Rec."WHT Payment FND")
                {
                    Caption = 'WHT Payment';
                }
                field(emptiesItemNoFND; Rec."Empties Item No. FND")
                {
                    Caption = 'Empties Item No.';
                }
                field(depositQuantityFND; Rec."Deposit Quantity FND")
                {
                    Caption = 'Deposit Quantity';
                }
                field(sourceSystemIdentifierFND; Rec."Source System Identifier FND")
                {
                    Caption = 'Source System Identifier';
                }
                field(relatedSalesOrderNoFND; Rec."Related Sales Order No. FND")
                {
                    Caption = 'Related Sales Order No.';
                }
                field(LocationCodeFND; Rec."Location Code FND")
                {
                    Caption = 'Location Code';
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
