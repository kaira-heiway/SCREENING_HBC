namespace fivetran.fivetran;

using Microsoft.Inventory.Counting.Journal;

page 90124 "Phys. Inventory Ledger Entry"
{
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'Phys. Inventory Ledger Entry';
    DelayedInsert = true;
    EntityCaption = 'Phys. Inventory Ledger Entry';
    EntitySetCaption = 'Phys. Inventory Ledger Entry';
    EntityName = 'PhysInventoryLedgerEntry';
    EntitySetName = 'PhysInventoryLedgerEntry';
    PageType = API;
    SourceTable = "Phys. Inventory Ledger Entry";
    Editable = false;
    DataAccessIntent = ReadOnly;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
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
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                // #BC Upgrade SAIA01 >>
                field(binCode; Rec."Bin Code FND")
                {
                    Caption = 'Bin Code';
                }
                // #BC Upgrade SAIA01 <<
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(entryType; Rec."Entry Type")
                {
                    Caption = 'Entry Type';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(lastItemLedgerEntryNo; Rec."Last Item Ledger Entry No.")
                {
                    Caption = 'Last Item Ledger Entry No.';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(qtyCalculated; Rec."Qty. (Calculated)")
                {
                    Caption = 'Qty. (Calculated)';
                }
                field(qtyPhysInventory; Rec."Qty. (Phys. Inventory)")
                {
                    Caption = 'Qty. (Phys. Inventory)';
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                // #BC Upgrade SAIA01 >>
                field(zoneCode; Rec."Zone Code FND")
                {
                    Caption = 'Zone Code';
                }
                // #BC Upgrade SAIA01 <<
            }
        }
    }
}
