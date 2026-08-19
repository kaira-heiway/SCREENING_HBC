page 90014 "Default Dimension"
{
    DelayedInsert = true;
    PageType = API;
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'Default Dimension';
    EntitySetCaption = 'Default Dimensions';
    ODataKeyFields = SystemId;
    EntityName = 'defaultDimension';
    EntitySetName = 'defaultDimensions';
    SourceTable = "Default Dimension";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(allowedValuesFilter; Rec."Allowed Values Filter")
                {
                    Caption = 'Allowed Values Filter';
                }
                field(dimensionCode; Rec."Dimension Code")
                {
                    Caption = 'Dimension Code';
                }
                field(dimensionValueCode; Rec."Dimension Value Code")
                {
                    Caption = 'Dimension Value Code';
                }
                field(dimensionId; Rec.DimensionId)
                {
                    Caption = 'DimensionId';
                }
                field(dimensionValueId; Rec.DimensionValueId)
                {
                    Caption = 'DimensionValueId';
                }
                field(multiSelectionAction; Rec."Multi Selection Action")
                {
                    Caption = 'Multi Selection Action';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(parentType; Rec."Parent Type")
                {
                    Caption = 'Parent Type';
                }
                field(parentId; Rec.ParentId)
                {
                    Caption = 'ParentId';
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
                field(tableCaption; Rec."Table Caption")
                {
                    Caption = 'Table Caption';
                }
                field(tableID; Rec."Table ID")
                {
                    Caption = 'Table ID';
                }
                field(valuePosting; Rec."Value Posting")
                {
                    Caption = 'Value Posting';
                }
                field(budgetedAmount; Rec."Budgeted Amount FND")
                {
                    Caption = 'Budgeted Amount';
                }

            }
        }
    }
}
