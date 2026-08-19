namespace fivetran.fivetran;

using Microsoft.Warehouse.Structure;

page 90064 Bin
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Bin API';
    DelayedInsert = true;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;
    EntityName = 'Bin';
    EntitySetName = 'Bins';
    PageType = API;
    SourceTable = Bin;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(zoneCode; Rec."Zone Code")
                {
                    Caption = 'Zone Code';
                }
                field(binTypeCode; Rec."Bin Type Code")
                {
                    Caption = 'Bin Type Code';
                }
                field(warehouseClassCode; Rec."Warehouse Class Code")
                {
                    Caption = 'Warehouse Class Code';
                }
                field(blockMovement; Rec."Block Movement")
                {
                    Caption = 'Block Movement';
                }
                field(specialEquipmentCode; Rec."Special Equipment Code")
                {
                    Caption = 'Special Equipment Code';
                }
                field(binRanking; Rec."Bin Ranking")
                {
                    Caption = 'Bin Ranking';
                }
                field(maximumCubage; Rec."Maximum Cubage")
                {
                    Caption = 'Maximum Cubage';
                }
                field(maximumWeight; Rec."Maximum Weight")
                {
                    Caption = 'Maximum Weight';
                }
                field(empty; Rec.Empty)
                {
                    Caption = 'Empty';
                }
                field(crossDockBin; Rec."Cross-Dock Bin")
                {
                    Caption = 'Cross-Dock Bin';
                }
                field(dedicated; Rec.Dedicated)
                {
                    Caption = 'Dedicated';
                }
                field(batchProductionResourceFND; Rec."Batch Production Resource FND")
                {
                    Caption = 'Batch Production Resource';
                }
                field(batchSequentialNumberFND; Rec."Batch Sequential Number FND")
                {
                    Caption = 'Batch Sequential Number';
                }
                field(grossCapacityFND; Rec."Gross Capacity FND")
                {
                    Caption = 'Gross Capacity';
                }
                field(unavailableStockFND; Rec."Unavailable Stock FND")
                {
                    Caption = 'Unavailable Stock';
                }
                field(cccCodeFND; Rec."Ccc Code FND")
                {
                    Caption = 'Ccc Code';
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
