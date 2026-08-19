page 90008 "API - Currencies"
{
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'Currency';
    EntitySetCaption = 'Currencies';
    DelayedInsert = true;
    EntityName = 'currency';
    EntitySetName = 'currencies';
    ODataKeyFields = SystemId;
    PageType = API;
    SourceTable = Currency;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(amountDecimalPlaces; Rec."Amount Decimal Places")
                {
                    Caption = 'Amount Decimal Places';
                }
                field(amountRoundingPrecision; Rec."Amount Rounding Precision")
                {
                    Caption = 'Amount Rounding Precision';
                }
                field(applnRoundingPrecision; Rec."Appln. Rounding Precision")
                {
                    Caption = 'Appln. Rounding Precision';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(convLCYRndgCreditAcc; Rec."Conv. LCY Rndg. Credit Acc.")
                {
                    Caption = 'Conv. LCY Rndg. Credit Acc.';
                }
                field(convLCYRndgDebitAcc; Rec."Conv. LCY Rndg. Debit Acc.")
                {
                    Caption = 'Conv. LCY Rndg. Debit Acc.';
                }
                field(coupledToDataverse; Rec."Coupled to Dataverse")
                {
                    Caption = 'Coupled to Dataverse';
                }
                field(currencyFactor; Rec."Currency Factor")
                {
                    Caption = 'Currency Factor';
                }
                field(custLedgEntriesInFilter; Rec."Cust. Ledg. Entries in Filter")
                {
                    Caption = 'Cust. Ledg. Entries in Filter';
                }
                field(customerBalance; Rec."Customer Balance")
                {
                    Caption = 'Customer Balance';
                }
                field(customerBalanceLCY; Rec."Customer Balance (LCY)")
                {
                    Caption = 'Customer Balance (LCY)';
                }
                field(customerBalanceDue; Rec."Customer Balance Due")
                {
                    Caption = 'Customer Balance Due';
                }
                field(customerOutstandingOrders; Rec."Customer Outstanding Orders")
                {
                    Caption = 'Customer Outstanding Orders';
                }
                field(customerShippedNotInvoiced; Rec."Customer Shipped Not Invoiced")
                {
                    Caption = 'Customer Shipped Not Invoiced';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(emuCurrency; Rec."EMU Currency")
                {
                    Caption = 'EMU Currency';
                }
                field(isoCode; Rec."ISO Code")
                {
                    Caption = 'ISO Code';
                }
                field(isoNumericCode; Rec."ISO Numeric Code")
                {
                    Caption = 'ISO Numeric Code';
                }
                field(invoiceRoundingPrecision; Rec."Invoice Rounding Precision")
                {
                    Caption = 'Invoice Rounding Precision';
                }
                field(invoiceRoundingType; Rec."Invoice Rounding Type")
                {
                    Caption = 'Invoice Rounding Type';
                }
                field(lastDateAdjusted; Rec."Last Date Adjusted")
                {
                    Caption = 'Last Date Adjusted';
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    Caption = 'Last Modified Date Time';
                }
                field(maxPaymentToleranceAmount; Rec."Max. Payment Tolerance Amount")
                {
                    Caption = 'Max. Payment Tolerance Amount';
                }
                field(maxVATDifferenceAllowed; Rec."Max. VAT Difference Allowed")
                {
                    Caption = 'Max. VAT Difference Allowed';
                }
                field(paymentTolerance; Rec."Payment Tolerance %")
                {
                    Caption = 'Payment Tolerance %';
                }
                field(realizedGLGainsAccount; Rec."Realized G/L Gains Account")
                {
                    Caption = 'Realized G/L Gains Account';
                }
                field(realizedGLLossesAccount; Rec."Realized G/L Losses Account")
                {
                    Caption = 'Realized G/L Losses Account';
                }
                field(realizedGainsAcc; Rec."Realized Gains Acc.")
                {
                    Caption = 'Realized Gains Acc.';
                }
                field(realizedLossesAcc; Rec."Realized Losses Acc.")
                {
                    Caption = 'Realized Losses Acc.';
                }
                field(residualGainsAccount; Rec."Residual Gains Account")
                {
                    Caption = 'Residual Gains Account';
                }
                field(residualLossesAccount; Rec."Residual Losses Account")
                {
                    Caption = 'Residual Losses Account';
                }
                field(symbol; Rec.Symbol)
                {
                    Caption = 'Symbol';
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
                field(unitAmountDecimalPlaces; Rec."Unit-Amount Decimal Places")
                {
                    Caption = 'Unit-Amount Decimal Places';
                }
                field(unitAmountRoundingPrecision; Rec."Unit-Amount Rounding Precision")
                {
                    Caption = 'Unit-Amount Rounding Precision';
                }
                field(unrealizedGainsAcc; Rec."Unrealized Gains Acc.")
                {
                    Caption = 'Unrealized Gains Acc.';
                }
                field(unrealizedLossesAcc; Rec."Unrealized Losses Acc.")
                {
                    Caption = 'Unrealized Losses Acc.';
                }
                field(vatRoundingType; Rec."VAT Rounding Type")
                {
                    Caption = 'VAT Rounding Type';
                }
                field(vendorAmtRcdNotInvoiced; Rec."Vendor Amt. Rcd. Not Invoiced")
                {
                    Caption = 'Vendor Amt. Rcd. Not Invoiced';
                }
                field(vendorBalance; Rec."Vendor Balance")
                {
                    Caption = 'Vendor Balance';
                }
                field(vendorBalanceLCY; Rec."Vendor Balance (LCY)")
                {
                    Caption = 'Vendor Balance (LCY)';
                }
                field(vendorBalanceDue; Rec."Vendor Balance Due")
                {
                    Caption = 'Vendor Balance Due';
                }
                field(vendorLedgEntriesInFilter; Rec."Vendor Ledg. Entries in Filter")
                {
                    Caption = 'Vendor Ledg. Entries in Filter';
                }
                field(vendorOutstandingOrders; Rec."Vendor Outstanding Orders")
                {
                    Caption = 'Vendor Outstanding Orders';
                }
                //BC UPGRADE KUMARR78 ++06-07-2026
                field(isoCurrencyCode; Rec."ISO Currency Code FND")
                {
                    Caption = 'ISO Currency Code';
                }

                field(bcSendWithoutDecimals; Rec."BC - Send Without Decimals FND")
                {
                    Caption = 'BC - Send Without Decimals';
                }
                field(taxAmountRoundingPrecision; Rec."Tax Amount Rounding Prec.1 FND")
                {
                    Caption = 'Tax Amount Rounding Prec.';
                }

                field(taxUnitAmountRoundingPrecision; Rec."Tax UnitAmt Rounding Prec1 FND")
                {
                    Caption = 'Tax Unit-Amount Rounding Prec.';
                }
                field(unrealizedGainAccPayable; Rec."Unrealized GainAcc.Payable FND")
                {
                    Caption = 'Unrealized Gain Acc. Payable';
                }

                field(unrealizedLossAccPayable; Rec."Unrealized LossAcc.Payable FND")
                {
                    Caption = 'Unrealized Loss Acc. Payable';
                }

                field(realizedLossAccPayable; Rec."Realized Loss Acc. Payable FND")
                {
                    Caption = 'Realized Loss Acc. Payable';
                }

                field(realizedGainAccPayable; Rec."Realized Gain Acc. Payable FND")
                {
                    Caption = 'Realized Gain Acc. Payable';
                }

                field(unrealizedGainAccReceivable; Rec."Unrealized GainAcc.Receiv. FND")
                {
                    Caption = 'Unrealized Gain Acc. Receiv.';
                }

                field(unrealizedLossAccReceivable; Rec."Unrealized LossAcc.Receiv. FND")
                {
                    Caption = 'Unrealized Loss Acc. Receiv.';
                }
                field(realizedLossAccReceivable; Rec."Realized Loss Acc. Receiv. FND")
                {
                    Caption = 'Realized Loss Acc. Receiv.';
                }
                field(realizedGainAccReceivable; Rec."Realized Loss Acc. Receiv. FND")
                {
                    Caption = 'Realized Gain Acc. Receiv.';
                }
                //BC UPGRADE KUMARR78 ++06-07-2026
            }
        }
    }
}
