page 90101 "Cost Accounting Setup API"
{
    DelayedInsert = true;
    PageType = API;
    APIVersion = 'v2.0';
    APIGroup = 'standardEndpoints';
    ODataKeyFields = SystemId;
    EntityName = 'costAccountingSetup';
    EntitySetName = 'costAccountingSetups';
    SourceTable = "Cost Accounting Setup";
    DataAccessIntent = ReadOnly;
    Editable = false;
    APIPublisher = 'fivetran';

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
                field(primaryKey; Rec."Primary Key")
                {
                    Caption = 'Primary Key';
                }

                field(startingDateForGLTransfer; Rec."Starting Date for G/L Transfer")
                {
                    Caption = 'Starting Date for G/L Transfer';
                }

                field(alignGLAccount; Rec."Align G/L Account")
                {
                    Caption = 'Align G/L Account';
                }

                field(alignCostCenterDimension; Rec."Align Cost Center Dimension")
                {
                    Caption = 'Align Cost Center Dimension';
                }

                field(alignCostObjectDimension; Rec."Align Cost Object Dimension")
                {
                    Caption = 'Align Cost Object Dimension';
                }

                field(lastAllocationID; Rec."Last Allocation ID")
                {
                    Caption = 'Last Allocation ID';
                }

                field(lastAllocationDocumentNo; Rec."Last Allocation Doc. No.")
                {
                    Caption = 'Last Allocation Doc. No.';
                }

                field(autoTransferFromGL; Rec."Auto Transfer from G/L")
                {
                    Caption = 'Auto Transfer from G/L';
                }

                field(checkGLPostings; Rec."Check G/L Postings")
                {
                    Caption = 'Check G/L Postings';
                }

                field(costCenterDimension; Rec."Cost Center Dimension")
                {
                    Caption = 'Cost Center Dimension';
                }

                field(costObjectDimension; Rec."Cost Object Dimension")
                {
                    Caption = 'Cost Object Dimension';
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