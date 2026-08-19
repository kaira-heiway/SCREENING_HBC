namespace HEILITE_MTC_.HEILITE_MTC_;

using Microsoft.Finance.GeneralLedger.Setup;

page 90056 "General Ledger Setup API"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    DataAccessIntent = ReadOnly;
    Editable = false;
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'General Ledger Setup API';
    DelayedInsert = true;
    EntityName = 'generalLedgerSetup';
    EntitySetName = 'generalLedgerSetup';
    PageType = API;
    SourceTable = "General Ledger Setup";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(primaryKey; Rec."Primary Key")
                {
                    Caption = 'Primary Key';
                }
                field(allowPostingFrom; Rec."Allow Posting From")
                {
                    Caption = 'Allow Posting From';
                }
                field(allowPostingTo; Rec."Allow Posting To")
                {
                    Caption = 'Allow Posting To';
                }
                field(registerTime; Rec."Register Time")
                {
                    Caption = 'Register Time';
                }
                field(pmtDiscExclVAT; Rec."Pmt. Disc. Excl. VAT")
                {
                    Caption = 'Pmt. Disc. Excl. VAT';
                }
                field(unrealizedVAT; Rec."Unrealized VAT")
                {
                    Caption = 'Unrealized VAT';
                }
                field(adjustForPaymentDisc; Rec."Adjust for Payment Disc.")
                {
                    Caption = 'Adjust for Payment Disc.';
                }
                field(markCrMemosAsCorrections; Rec."Mark Cr. Memos as Corrections")
                {
                    Caption = 'Mark Cr. Memos as Corrections';
                }
                field(localAddressFormat; Rec."Local Address Format")
                {
                    Caption = 'Local Address Format';
                }
                field(invRoundingPrecisionLCY; Rec."Inv. Rounding Precision (LCY)")
                {
                    Caption = 'Inv. Rounding Precision (LCY)';
                }
                field(invRoundingTypeLCY; Rec."Inv. Rounding Type (LCY)")
                {
                    Caption = 'Inv. Rounding Type (LCY)';
                }
                field(localContAddrFormat; Rec."Local Cont. Addr. Format")
                {
                    Caption = 'Local Cont. Addr. Format';
                }
                field(bankAccountNos; Rec."Bank Account Nos.")
                {
                    Caption = 'Bank Account Nos.';
                }
                field(summarizeGLEntries; Rec."Summarize G/L Entries")
                {
                    Caption = 'Summarize G/L Entries';
                }
                field(amountDecimalPlaces; Rec."Amount Decimal Places")
                {
                    Caption = 'Amount Decimal Places';
                }
                field(unitAmountDecimalPlaces; Rec."Unit-Amount Decimal Places")
                {
                    Caption = 'Unit-Amount Decimal Places';
                }
                field(additionalReportingCurrency; Rec."Additional Reporting Currency")
                {
                    Caption = 'Additional Reporting Currency';
                }
                field(vatTolerance; Rec."VAT Tolerance %")
                {
                    Caption = 'VAT Tolerance %';
                }
                field(emuCurrency; Rec."EMU Currency")
                {
                    Caption = 'EMU Currency';
                }
                field(lcyCode; Rec."LCY Code")
                {
                    Caption = 'LCY Code';
                }
                field(vatExchangeRateAdjustment; Rec."VAT Exchange Rate Adjustment")
                {
                    Caption = 'VAT Exchange Rate Adjustment';
                }
                field(amountRoundingPrecision; Rec."Amount Rounding Precision")
                {
                    Caption = 'Amount Rounding Precision';
                }
                field(unitAmountRoundingPrecision; Rec."Unit-Amount Rounding Precision")
                {
                    Caption = 'Unit-Amount Rounding Precision';
                }
                field(applnRoundingPrecision; Rec."Appln. Rounding Precision")
                {
                    Caption = 'Appln. Rounding Precision';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Shortcut Dimension 3 Code';
                }
                field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    Caption = 'Shortcut Dimension 4 Code';
                }
                field(shortcutDimension5Code; Rec."Shortcut Dimension 5 Code")
                {
                    Caption = 'Shortcut Dimension 5 Code';
                }
                field(shortcutDimension6Code; Rec."Shortcut Dimension 6 Code")
                {
                    Caption = 'Shortcut Dimension 6 Code';
                }
                field(shortcutDimension7Code; Rec."Shortcut Dimension 7 Code")
                {
                    Caption = 'Shortcut Dimension 7 Code';
                }
                field(shortcutDimension8Code; Rec."Shortcut Dimension 8 Code")
                {
                    Caption = 'Shortcut Dimension 8 Code';
                }
                field(maxVATDifferenceAllowed; Rec."Max. VAT Difference Allowed")
                {
                    Caption = 'Max. VAT Difference Allowed';
                }
                field(vatRoundingType; Rec."VAT Rounding Type")
                {
                    Caption = 'VAT Rounding Type';
                }
                field(pmtDiscTolerancePosting; Rec."Pmt. Disc. Tolerance Posting")
                {
                    Caption = 'Pmt. Disc. Tolerance Posting';
                }
                field(paymentDiscountGracePeriod; Rec."Payment Discount Grace Period")
                {
                    Caption = 'Payment Discount Grace Period';
                }
                field(paymentTolerance; Rec."Payment Tolerance %")
                {
                    Caption = 'Payment Tolerance %';
                }
                field(maxPaymentToleranceAmount; Rec."Max. Payment Tolerance Amount")
                {
                    Caption = 'Max. Payment Tolerance Amount';
                }
                field(allowGLAccDeletionBefore; Rec."Allow G/L Acc. Deletion Before")
                {
                    Caption = 'Check G/L Acc. Deletion After';
                }
                field(checkGLAccountUsage; Rec."Check G/L Account Usage")
                {
                    Caption = 'Check G/L Account Usage';
                }
                field(paymentTolerancePosting; Rec."Payment Tolerance Posting")
                {
                    Caption = 'Payment Tolerance Posting';
                }
                field(pmtDiscToleranceWarning; Rec."Pmt. Disc. Tolerance Warning")
                {
                    Caption = 'Pmt. Disc. Tolerance Warning';
                }
                field(paymentToleranceWarning; Rec."Payment Tolerance Warning")
                {
                    Caption = 'Payment Tolerance Warning';
                }
                field(lastICTransactionNo; Rec."Last IC Transaction No.")
                {
                    Caption = 'Last IC Transaction No.';
                }
                field(printVATSpecificationInLCY; Rec."Print VAT specification in LCY")
                {
                    Caption = 'Print VAT specification in LCY';
                }
                field(prepaymentUnrealizedVAT; Rec."Prepayment Unrealized VAT")
                {
                    Caption = 'Prepayment Unrealized VAT';
                }
                field(payrollTransImportFormat; Rec."Payroll Trans. Import Format")
                {
                    Caption = 'Payroll Trans. Import Format';
                }
                field(localCurrencySymbol; Rec."Local Currency Symbol")
                {
                    Caption = 'Local Currency Symbol';
                }
                field(capexDimensionCode; Rec."Capex Dimension Code FND")
                {
                    Caption = 'Capex Dimension Code';
                }
                field(capexReferenceBudget; Rec."Capex Reference Budget FND")
                {
                    Caption = 'Capex Reference Budget';
                }
                field(capexAccScheduleName; Rec."Capex Acc. Schedule Name FND")
                {
                    Caption = 'Capex Acc. Schedule Name';
                }
                field(massUploadDimension9; Rec."Mass Upload Dimension 9 FND")
                {
                    Caption = 'Mass Upload Dimension 9';
                }
                field(massUploadDimension10; Rec."Mass Upload Dimension 10 FND")
                {
                    Caption = 'Mass Upload Dimension 10';
                }
                field(massUploadDimension11; Rec."Mass Upload Dimension 11 FND")
                {
                    Caption = 'Mass Upload Dimension 11';
                }
                field(massUploadDimension12; Rec."Mass Upload Dimension 12 FND")
                {
                    Caption = 'Mass Upload Dimension 12';
                }
                field(massUploadDimension13; Rec."Mass Upload Dimension 13 FND")
                {
                    Caption = 'Mass Upload Dimension 13';
                }
                field(massUploadDimension14; Rec."Mass Upload Dimension 14 FND")
                {
                    Caption = 'Mass Upload Dimension 14';
                }
                field(massUploadDimension15; Rec."Mass Upload Dimension 15 FND")
                {
                    Caption = 'Mass Upload Dimension 15';
                }
                field(massUploadDimension16; Rec."Mass Upload Dimension 16 FND")
                {
                    Caption = 'Mass Upload Dimension 16';
                }
                field(massUploadDimension17; Rec."Mass Upload Dimension 17 FND")
                {
                    Caption = 'Mass Upload Dimension 17';
                }
                field(massUploadDimension18; Rec."Mass Upload Dimension 18 FND")
                {
                    Caption = 'Mass Upload Dimension 18';
                }
                field(massUploadDimension19; Rec."Mass Upload Dimension 19 FND")
                {
                    Caption = 'Mass Upload Dimension 19';
                }
                field(massUploadDimension20; Rec."Mass Upload Dimension 20 FND")
                {
                    Caption = 'Mass Upload Dimension 20';
                }
                field(massUploadDimension21; Rec."Mass Upload Dimension 21 FND")
                {
                    Caption = 'Mass Upload Dimension 21';
                }
                field(massUploadDimension22; Rec."Mass Upload Dimension 22 FND")
                {
                    Caption = 'Mass Upload Dimension 22';
                }
                field(massUploadDimension23; Rec."Mass Upload Dimension 23 FND")
                {
                    Caption = 'Mass Upload Dimension 23';
                }
                field(massUploadDimension24; Rec."Mass Upload Dimension 24 FND")
                {
                    Caption = 'Mass Upload Dimension 24';
                }
                field(massUploadDimension25; Rec."Mass Upload Dimension 25 FND")
                {
                    Caption = 'Mass Upload Dimension 25';
                }
                field(massUploadDimension26; Rec."Mass Upload Dimension 26 FND")
                {
                    Caption = 'Mass Upload Dimension 26';
                }
                field(massUploadDimension27; Rec."Mass Upload Dimension 27 FND")
                {
                    Caption = 'Mass Upload Dimension 27';
                }
                field(massUploadDimension28; Rec."Mass Upload Dimension 28 FND")
                {
                    Caption = 'Mass Upload Dimension 28';
                }
                field(massUploadDimension29; Rec."Mass Upload Dimension 29 FND")
                {
                    Caption = 'Mass Upload Dimension 29';
                }
                field(massUploadDimension30; Rec."Mass Upload Dimension 30 FND")
                {
                    Caption = 'Mass Upload Dimension 30';
                }
                field(opcoDimensionCode; Rec."OPCO Dimension Code FND")
                {
                    Caption = 'OPCO Dimension Code';
                }
                field(businessTypeDimensionCode; Rec."Business Type Dim Code FND")
                {
                    Caption = 'Business Type Dimension Code';
                }
                field(brandDimensionCode; Rec."Brand Dimension Code FND")
                {
                    Caption = 'Brand Dimension Code';
                }
                field(whtMinimumInvoiceAmount; Rec."WHT Minimum Invoice Amount FND")
                {
                    Caption = 'WHT Minimum Invoice Amount';
                }
                field(manualSalesWHTCalc; Rec."Manual Sales WHT Calc. FND")
                {
                    Caption = 'Manual Sales WHT Calc.';
                }
                field(enableWHT; Rec."Enable WHT FND")
                {
                    Caption = 'Enable WHT';
                }
                field(roundAmountForWHTCalc; Rec."Round Amount for WHT Calc FND")
                {
                    Caption = 'Round Amount for WHT Calc';
                }
                field(minWHTCalcOnlyOnInvAmt; Rec."Min. WHT CalconlyonInv.Amt FND")
                {
                    Caption = 'Min. WHT Calc only on Inv. Amt';
                }
                field(costCenterDimensionCode; Rec."Cost Center Dimension Code FND")
                {
                    Caption = 'Cost Center Dimension Code';
                }
                field(energyDimCode; Rec."Energy Dim. Code FND")
                {
                    Caption = 'Energy Dim. Code';
                }
                field(waterConsumptionDimCode; Rec."Water Consump Dim. Code FND")
                {
                    Caption = 'Water Consumption Dim. Code';
                }
                field(wasteWaterDimCode; Rec."Waste Water Dim. Code FND")
                {
                    Caption = 'Waste Water Dim. Code';
                }
                field(maintenanceDimCode; Rec."Maintenance Dim. Code FND")
                {
                    Caption = 'Maintenance Dim. Code';
                }
                field(cadencyTemporaryPath; Rec."Cadency Temporary Path FND")
                {
                    Caption = 'Cadency Temporary Path';
                }
                field(skuDimensionCode; Rec."SKU Dimension Code FND")
                {
                    Caption = 'SKU Dimension Code';
                }
                field(wipAccount; Rec."WIP Account FND")
                {
                    Caption = 'WIP Account';
                }
                field(balWipAccount; Rec."Bal. Wip Account FND")
                {
                    Caption = 'Bal. Wip Account';
                }
                field(lineExtDimensionCode; Rec."Line ext Dimension Code FND")
                {
                    Caption = 'Line ext Dimension Code';
                }
                field(customerDimensionCode; Rec."Customer Dimension Code FND")
                {
                    Caption = 'Customer Dimension Code';
                }
                field(glBudgetStandardCost; Rec."Gl Budget Standard Cost FND")
                {
                    Caption = 'Gl Budget Standard Cost';
                }
                field(primaryPackTypeDim; Rec."Primary Pack Type Dim FND")
                {
                    Caption = 'Primary Pack Type Dim';
                }
                field(areaDim; Rec."Area Dim FND")
                {
                    Caption = 'Area Dim';
                }
                field(extendedAddressFormating; Rec."Extended Address Formating FND")
                {
                    Caption = 'Extended Address Formating';
                }
                field(enableTINByLocation; Rec."Enable TIN By Location FND")
                {
                    Caption = 'Enable TIN By Location';
                }
                field(restrtDuplicateExtrnlDoc; Rec."Restrt Dupli Extrnl Doc FND")
                {
                    Caption = 'Restrt Duplicate Extrnl Doc';
                }
                field(finalReportingExtracted; Rec."Final Reporting Extracted FND")
                {
                    Caption = 'Final Reporting Extracted';
                }
                field(applyCompensation; Rec."Apply Compensation FND")
                {
                    Caption = 'Apply Compensation';
                }
                field(licenseDimensionCode; Rec."License Dimension Code FND")
                {
                    Caption = 'License Dimension Code';
                }
                field(wipAccrualMatPerc; Rec."WIP Accrual. Mat. Perc. FND")
                {
                    Caption = 'WIP Accrual. Mat. Perc.';
                }
                field(wipAccrualCapPerc; Rec."WIP Accrual. Cap. Perc. FND")
                {
                    Caption = 'WIP Accrual. Cap. Perc.';
                }
                field(wipOutputZoneFiltering; Rec."WIP Output Zone Filtering FND")
                {
                    Caption = 'WIP Output Zone Filtering';
                }
                field(payrollDimensionCode; Rec."Payroll Dimension Code FND")
                {
                    Caption = 'Payroll Dimension Code';
                }
                field(salariesDimensionCode; Rec."Salaries Dimension Code FND")
                {
                    Caption = 'Salaries Dimension Code';
                }
                field(filePath; Rec."File path FND")
                {
                    Caption = 'File path';
                }
                field(enableCAD; Rec."Enable CAD FND")
                {
                    Caption = 'Enable CAD';
                }
                field(maxCADDifferenceAllowed; Rec."Max CAD Difference Allowed FND")
                {
                    Caption = 'Max CAD Difference Allowed';
                }
                field(cmgDimensionCode; Rec."CMG Dimension Code FND")
                {
                    Caption = 'CMG Dimension Code';
                }
                field(gLApplicationNoSeries; Rec."G/L Application No. Series FND")
                {
                    Caption = 'G/L Application No. Series';
                }
                field(pLByNatureCode; Rec."P&L by Nature code FND")
                {
                    Caption = 'P&L by Nature code';
                }
                field(enableGTFX; Rec."Enable GT FX FND")
                {
                    Caption = 'Enable GT FX';
                }
                field(reversalReevActivateDate; Rec."Reversal Reev. Act Date FND")
                {
                    Caption = 'Reversal Reev. Activate Date';
                }
                field(postedDocumentShippingLimit; Rec."Posted Doc Shipping Limit FND")
                {
                    Caption = 'Posted Document Shipping Limit';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
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
