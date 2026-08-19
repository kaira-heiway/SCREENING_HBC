page 90108 "API - Customer Posting Groups"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityName = 'customerPostingGroup';
    EntitySetName = 'customerPostingGroups';
    SourceTable = "Customer Posting Group";
    ODataKeyFields = SystemId;

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
                field(code; Rec.Code)
                {
                    Caption = 'Code';
                }

                field(receivablesAccount; Rec."Receivables Account")
                {
                    Caption = 'Receivables Account';
                }

                field(serviceChargeAccount; Rec."Service Charge Acc.")
                {
                    Caption = 'Service Charge Acc.';
                }

                field(paymentDiscDebitAccount; Rec."Payment Disc. Debit Acc.")
                {
                    Caption = 'Payment Disc. Debit Acc.';
                }

                field(invoiceRoundingAccount; Rec."Invoice Rounding Account")
                {
                    Caption = 'Invoice Rounding Account';
                }

                field(additionalFeeAccount; Rec."Additional Fee Account")
                {
                    Caption = 'Additional Fee Account';
                }

                field(interestAccount; Rec."Interest Account")
                {
                    Caption = 'Interest Account';
                }

                field(debitCurrApplnRndgAccount; Rec."Debit Curr. Appln. Rndg. Acc.")
                {
                    Caption = 'Debit Curr. Appln. Rndg. Acc.';
                }

                field(creditCurrApplnRndgAccount; Rec."Credit Curr. Appln. Rndg. Acc.")
                {
                    Caption = 'Credit Curr. Appln. Rndg. Acc.';
                }

                field(debitRoundingAccount; Rec."Debit Rounding Account")
                {
                    Caption = 'Debit Rounding Account';
                }

                field(creditRoundingAccount; Rec."Credit Rounding Account")
                {
                    Caption = 'Credit Rounding Account';
                }

                field(paymentDiscCreditAccount; Rec."Payment Disc. Credit Acc.")
                {
                    Caption = 'Payment Disc. Credit Acc.';
                }

                field(paymentToleranceDebitAccount; Rec."Payment Tolerance Debit Acc.")
                {
                    Caption = 'Payment Tolerance Debit Acc.';
                }

                field(paymentToleranceCreditAccount; Rec."Payment Tolerance Credit Acc.")
                {
                    Caption = 'Payment Tolerance Credit Acc.';
                }

                field(addFeePerLineAccount; Rec."Add. Fee per Line Account")
                {
                    Caption = 'Add. Fee per Line Account';
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