page 90051 dimensionSetEntry
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'dimensionSetEntry';
    DelayedInsert = true;
    EntityName = 'dimensionSetEntry';
    EntitySetName = 'dimensionSetEntries';
    PageType = API;
    SourceTable = "Dimension Set Entry";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(dimensionCode; Rec."Dimension Code")
                {
                    Caption = 'Dimension Code';
                }
                field(dimensionName; Rec."Dimension Name")
                {
                    Caption = 'Dimension Name';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(dimensionValueCode; Rec."Dimension Value Code")
                {
                    Caption = 'Dimension Value Code';
                }
                field(dimensionValueID; Rec."Dimension Value ID")
                {
                    Caption = 'Dimension Value ID';
                }
                field(dimensionValueName; Rec."Dimension Value Name")
                {
                    Caption = 'Dimension Value Name';
                }
                field(globalDimensionNo; Rec."Global Dimension No.")
                {
                    Caption = 'Shortcut Dimension No.';
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
