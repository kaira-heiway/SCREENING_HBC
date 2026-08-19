namespace fivetran.fivetran;

using Microsoft.Inventory.Ledger;

page 90081 "Item Application Entry API"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Item Application Entry API';
    DelayedInsert = true;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;
    EntityName = 'itemApplicationEntry';
    EntitySetName = 'itemApplicationEntries';
    PageType = API;
    SourceTable = "Item Application Entry";

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
                field(itemLedgerEntryNo; Rec."Item Ledger Entry No.")
                {
                    Caption = 'Item Ledger Entry No.';
                }
                field(inboundItemEntryNo; Rec."Inbound Item Entry No.")
                {
                    Caption = 'Inbound Item Entry No.';
                }
                field(outboundItemEntryNo; Rec."Outbound Item Entry No.")
                {
                    Caption = 'Outbound Item Entry No.';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(transferredFromEntryNo; Rec."Transferred-from Entry No.")
                {
                    Caption = 'Transferred-from Entry No.';
                }
                field(creationDate; Rec."Creation Date")
                {
                    Caption = 'Creation Date';
                }
                field(createdByUser; Rec."Created By User")
                {
                    Caption = 'Created By User';
                }
                field(lastModifiedDate; Rec."Last Modified Date")
                {
                    Caption = 'Last Modified Date';
                }
                field(lastModifiedByUser; Rec."Last Modified By User")
                {
                    Caption = 'Last Modified By User';
                }
                field(costApplication; Rec."Cost Application")
                {
                    Caption = 'Cost Application';
                }
                field(outputCompletelyInvdDate; Rec."Output Completely Invd. Date")
                {
                    Caption = 'Output Completely Invd. Date';
                }
                field(outboundEntryIsUpdated; Rec."Outbound Entry is Updated")
                {
                    Caption = 'Outbound Entry is Updated';
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
