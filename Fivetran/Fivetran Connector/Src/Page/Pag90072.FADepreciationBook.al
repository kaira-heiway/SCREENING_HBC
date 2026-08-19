namespace fivetran.fivetran;

using Microsoft.FixedAssets.Depreciation;

page 90072 "FA Depreciation Book"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'FA Depreciation Book API';
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityName = 'faDepreciationBook';
    EntitySetName = 'faDepreciationBooks';
    PageType = API;
    SourceTable = "FA Depreciation Book";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(faNo; Rec."FA No.")
                {
                    Caption = 'FA No.';
                }
                field(depreciationBookCode; Rec."Depreciation Book Code")
                {
                    Caption = 'Depreciation Book Code';
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
                field(noOfDepreciationMonths; Rec."No. of Depreciation Months")
                {
                    Caption = 'No. of Depreciation Months';
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
                field(finalRoundingAmount; Rec."Final Rounding Amount")
                {
                    Caption = 'Final Rounding Amount';
                }
                field(endingBookValue; Rec."Ending Book Value")
                {
                    Caption = 'Ending Book Value';
                }
                field(faPostingGroup; Rec."FA Posting Group")
                {
                    Caption = 'FA Posting Group';
                }
                field(depreciationEndingDate; Rec."Depreciation Ending Date")
                {
                    Caption = 'Depreciation Ending Date';
                }
                field(acquisitionDate; Rec."Acquisition Date")
                {
                    Caption = 'Acquisition Date';
                }
                field(gLAcquisitionDate; Rec."G/L Acquisition Date")
                {
                    Caption = 'G/L Acquisition Date';
                }
                field(disposalDate; Rec."Disposal Date")
                {
                    Caption = 'Disposal Date';
                }
                field(lastAcquisitionCostDate; Rec."Last Acquisition Cost Date")
                {
                    Caption = 'Last Acquisition Cost Date';
                }
                field(lastDepreciationDate; Rec."Last Depreciation Date")
                {
                    Caption = 'Last Depreciation Date';
                }
                field(lastWriteDownDate; Rec."Last Write-Down Date")
                {
                    Caption = 'Last Write-Down Date';
                }
                field(lastAppreciationDate; Rec."Last Appreciation Date")
                {
                    Caption = 'Last Appreciation Date';
                }
                field(lastCustom1Date; Rec."Last Custom 1 Date")
                {
                    Caption = 'Last Custom 1 Date';
                }
                field(lastCustom2Date; Rec."Last Custom 2 Date")
                {
                    Caption = 'Last Custom 2 Date';
                }
                field(lastSalvageValueDate; Rec."Last Salvage Value Date")
                {
                    Caption = 'Last Salvage Value Date';
                }
                field(faExchangeRate; Rec."FA Exchange Rate")
                {
                    Caption = 'FA Exchange Rate';
                }
                field(fixedDeprAmountBelowZero; Rec."Fixed Depr. Amount below Zero")
                {
                    Caption = 'Fixed Depr. Amount below Zero';
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                }
                field(firstUserDefinedDeprDate; Rec."First User-Defined Depr. Date")
                {
                    Caption = 'First User-Defined Depr. Date';
                }
                field(useFALedgerCheck; Rec."Use FA Ledger Check")
                {
                    Caption = 'Use FA Ledger Check';
                }
                field(lastMaintenanceDate; Rec."Last Maintenance Date")
                {
                    Caption = 'Last Maintenance Date';
                }
                field(deprBelowZero; Rec."Depr. below Zero %")
                {
                    Caption = 'Depr. below Zero %';
                }
                field(projectedDisposalDate; Rec."Projected Disposal Date")
                {
                    Caption = 'Projected Disposal Date';
                }
                field(projectedProceedsOnDisposal; Rec."Projected Proceeds on Disposal")
                {
                    Caption = 'Projected Proceeds on Disposal';
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
                field(deprThisYearCustom1; Rec."Depr. This Year % (Custom 1)")
                {
                    Caption = 'Depr. This Year % (Custom 1)';
                }
                field(propertyClassCustom1; Rec."Property Class (Custom 1)")
                {
                    Caption = 'Property Class (Custom 1)';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(mainAssetComponent; Rec."Main Asset/Component")
                {
                    Caption = 'Main Asset/Component';
                }
                field(componentOfMainAsset; Rec."Component of Main Asset")
                {
                    Caption = 'Component of Main Asset';
                }
                field(faAddCurrencyFactor; Rec."FA Add.-Currency Factor")
                {
                    Caption = 'FA Add.-Currency Factor';
                }
                field(useHalfYearConvention; Rec."Use Half-Year Convention")
                {
                    Caption = 'Use Half-Year Convention';
                }
                field(useDBFirstFiscalYear; Rec."Use DB% First Fiscal Year")
                {
                    Caption = 'Use DB% First Fiscal Year';
                }
                field(tempEndingDate; Rec."Temp. Ending Date")
                {
                    Caption = 'Temp. Ending Date';
                }
                field(tempFixedDeprAmount; Rec."Temp. Fixed Depr. Amount")
                {
                    Caption = 'Temp. Fixed Depr. Amount';
                }
                field(ignoreDefEndingBookValue; Rec."Ignore Def. Ending Book Value")
                {
                    Caption = 'Ignore Def. Ending Book Value';
                }
                field(defaultFADepreciationBook; Rec."Default FA Depreciation Book")
                {
                    Caption = 'Default FA Depreciation Book';
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
