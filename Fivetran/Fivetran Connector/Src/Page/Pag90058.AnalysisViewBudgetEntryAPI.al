namespace INTERFACES.INTERFACES;

using Microsoft.Finance.Analysis;

page 90058 "Analysis View Budget Entry API"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    DataAccessIntent = ReadOnly;
    Editable = false;
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Analysis View Budget Entry API';
    DelayedInsert = true;
    EntityName = 'analysisViewBudgetEntry';
    EntitySetName = 'analysisViewBudgetEntry';
    PageType = API;
    ODataKeyFields = SystemId;
    SourceTable = "Analysis View Budget Entry";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(analysisViewCode; Rec."Analysis View Code")
                {
                    Caption = 'Analysis View Code';
                }
                field(budgetName; Rec."Budget Name")
                {
                    Caption = 'Budget Name';
                }
                field(gLAccountNo; Rec."G/L Account No.")
                {
                    Caption = 'G/L Account No.';
                }
                field(dimension1ValueCode; Rec."Dimension 1 Value Code")
                {
                    Caption = 'Dimension 1 Value Code';
                }
                field(dimension2ValueCode; Rec."Dimension 2 Value Code")
                {
                    Caption = 'Dimension 2 Value Code';
                }
                field(dimension3ValueCode; Rec."Dimension 3 Value Code")
                {
                    Caption = 'Dimension 3 Value Code';
                }
                field(dimension4ValueCode; Rec."Dimension 4 Value Code")
                {
                    Caption = 'Dimension 4 Value Code';
                }
                field(businessUnitCode; Rec."Business Unit Code")
                {
                    Caption = 'Business Unit Code';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
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
