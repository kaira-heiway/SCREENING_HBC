namespace fivetran.fivetran;

using Microsoft.FixedAssets.FixedAsset;

page 90070 "FA Posting Group API"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'FA Posting Group API';
    DelayedInsert = true;
    EntityName = 'faPostingGroup';
    ODataKeyFields = SystemId;
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntitySetName = 'faPostingGroups';
    PageType = API;
    SourceTable = "FA Posting Group";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(acquisitionCostAccount; Rec."Acquisition Cost Account")
                {
                    Caption = 'Acquisition Cost Account';
                }
                field(accumDepreciationAccount; Rec."Accum. Depreciation Account")
                {
                    Caption = 'Accum. Depreciation Account';
                }
                field(writeDownAccount; Rec."Write-Down Account")
                {
                    Caption = 'Write-Down Account';
                }
                field(appreciationAccount; Rec."Appreciation Account")
                {
                    Caption = 'Appreciation Account';
                }
                field(custom1Account; Rec."Custom 1 Account")
                {
                    Caption = 'Custom 1 Account';
                }
                field(custom2Account; Rec."Custom 2 Account")
                {
                    Caption = 'Custom 2 Account';
                }
                field(acqCostAccOnDisposal; Rec."Acq. Cost Acc. on Disposal")
                {
                    Caption = 'Acq. Cost Acc. on Disposal';
                }
                field(accumDeprAccOnDisposal; Rec."Accum. Depr. Acc. on Disposal")
                {
                    Caption = 'Accum. Depr. Acc. on Disposal';
                }
                field(writeDownAccOnDisposal; Rec."Write-Down Acc. on Disposal")
                {
                    Caption = 'Write-Down Acc. on Disposal';
                }
                field(appreciationAccOnDisposal; Rec."Appreciation Acc. on Disposal")
                {
                    Caption = 'Appreciation Acc. on Disposal';
                }
                field(custom1AccountOnDisposal; Rec."Custom 1 Account on Disposal")
                {
                    Caption = 'Custom 1 Account on Disposal';
                }
                field(custom2AccountOnDisposal; Rec."Custom 2 Account on Disposal")
                {
                    Caption = 'Custom 2 Account on Disposal';
                }
                field(gainsAccOnDisposal; Rec."Gains Acc. on Disposal")
                {
                    Caption = 'Gains Acc. on Disposal';
                }
                field(lossesAccOnDisposal; Rec."Losses Acc. on Disposal")
                {
                    Caption = 'Losses Acc. on Disposal';
                }
                field(bookValAccOnDispLoss; Rec."Book Val. Acc. on Disp. (Loss)")
                {
                    Caption = 'Book Val. Acc. on Disp. (Loss)';
                }
                field(salesAccOnDispLoss; Rec."Sales Acc. on Disp. (Loss)")
                {
                    Caption = 'Sales Acc. on Disp. (Loss)';
                }
                field(writeDownBalAccOnDisp; Rec."Write-Down Bal. Acc. on Disp.")
                {
                    Caption = 'Write-Down Bal. Acc. on Disp.';
                }
                field(apprecBalAccOnDisp; Rec."Apprec. Bal. Acc. on Disp.")
                {
                    Caption = 'Apprec. Bal. Acc. on Disp.';
                }
                field(custom1BalAccOnDisposal; Rec."Custom 1 Bal. Acc. on Disposal")
                {
                    Caption = 'Custom 1 Bal. Acc. on Disposal';
                }
                field(custom2BalAccOnDisposal; Rec."Custom 2 Bal. Acc. on Disposal")
                {
                    Caption = 'Custom 2 Bal. Acc. on Disposal';
                }
                field(maintenanceExpenseAccount; Rec."Maintenance Expense Account")
                {
                    Caption = 'Maintenance Expense Account';
                }
                field(maintenanceBalAcc; Rec."Maintenance Bal. Acc.")
                {
                    Caption = 'Maintenance Bal. Acc.';
                }
                field(acquisitionCostBalAcc; Rec."Acquisition Cost Bal. Acc.")
                {
                    Caption = 'Acquisition Cost Bal. Acc.';
                }
                field(depreciationExpenseAcc; Rec."Depreciation Expense Acc.")
                {
                    Caption = 'Depreciation Expense Acc.';
                }
                field(writeDownExpenseAcc; Rec."Write-Down Expense Acc.")
                {
                    Caption = 'Write-Down Expense Acc.';
                }
                field(appreciationBalAccount; Rec."Appreciation Bal. Account")
                {
                    Caption = 'Appreciation Bal. Account';
                }
                field(custom1ExpenseAcc; Rec."Custom 1 Expense Acc.")
                {
                    Caption = 'Custom 1 Expense Acc.';
                }
                field(custom2ExpenseAcc; Rec."Custom 2 Expense Acc.")
                {
                    Caption = 'Custom 2 Expense Acc.';
                }
                field(salesBalAcc; Rec."Sales Bal. Acc.")
                {
                    Caption = 'Sales Bal. Acc.';
                }
                field(salesAccOnDispGain; Rec."Sales Acc. on Disp. (Gain)")
                {
                    Caption = 'Sales Acc. on Disp. (Gain)';
                }
                field(bookValAccOnDispGain; Rec."Book Val. Acc. on Disp. (Gain)")
                {
                    Caption = 'Book Val. Acc. on Disp. (Gain)';
                }
                field(accumDepAccountOffsetFND; Rec."Accum. Dep. Account Offset FND")
                {
                    Caption = 'Accum. Depr Acc. Offset';
                }
                field(depExpenseAccOffsetFND; Rec."Dep. Expense Acc Offset FND")
                {
                    Caption = 'Depreciation Exp. Acc. Offset';
                }
                field(acqiCostAccDsposlOffsetFND; Rec."Acqi.CostAcc.Dsposl Offset FND")
                {
                    Caption = 'Acq. Cost On Disposal Offset';
                }
                field(gainAccOnDisposalOffsetFND; Rec."GainAcc.on Disposal Offset FND")
                {
                    Caption = 'Gains Acc. on Disposal Offset';
                }
                field(saleBalAccOnDispOffsetFND; Rec."SaleBal.Acc.on Disp.Offset FND")
                {
                    Caption = 'Sales Bal.Acc. on Disp. Offset';
                }
                field(accumDepOnDispAccOffsetFND; Rec."Accum.Dep.onDisp.AccOffset FND")
                {
                    Caption = 'Accum.Depr.Acc.Disposal Offset';
                }
                field(lossesAccOnDispOffFND; Rec."Losses Acc. on Disp. Off FND")
                {
                    Caption = 'Losses Acc. on Disposal Offset';
                }
                field(descriptionFND; Rec."Description FND")
                {
                    Caption = 'Description';
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
