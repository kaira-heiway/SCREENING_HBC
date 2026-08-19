namespace INTERFACES.INTERFACES;

using Microsoft.Inventory.Costing;

page 90062 "Average Cost Calc_ OverviewAPI"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    DataAccessIntent = ReadOnly;
    Editable = false;
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Average Cost Calc_OverviewAPI';
    DelayedInsert = true;
    EntityName = 'averageCostCalcOverview';
    EntitySetName = 'averageCostCalcOverview';
    ODataKeyFields = SystemId;
    PageType = API;
    SourceTable = "Average Cost Calc. Overview";

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
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(valuationDate; Rec."Valuation Date")
                {
                    Caption = 'Valuation Date';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(costIsAdjusted; Rec."Cost is Adjusted")
                {
                    Caption = 'Cost is Adjusted';
                }
                field(attachedToEntryNo; Rec."Attached to Entry No.")
                {
                    Caption = 'Attached to Entry No.';
                }
                field(attachedToValuationDate; Rec."Attached to Valuation Date")
                {
                    Caption = 'Attached to Valuation Date';
                }
                field(level; Rec.Level)
                {
                    Caption = 'Level';
                }
                field(itemLedgerEntryNo; Rec."Item Ledger Entry No.")
                {
                    Caption = 'Item Ledger Entry No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(entryType; Rec."Entry Type")
                {
                    Caption = 'Entry Type';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(documentLineNo; Rec."Document Line No.")
                {
                    Caption = 'Document Line No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(appliedQuantity; Rec."Applied Quantity")
                {
                    Caption = 'Applied Quantity';
                }
                field(costAmountExpected; Rec."Cost Amount (Expected)")
                {
                    Caption = 'Cost Amount (Expected)';
                }
                field(costAmountActual; Rec."Cost Amount (Actual)")
                {
                    Caption = 'Cost Amount (Actual)';
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
