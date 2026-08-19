namespace fivetran.fivetran;

using Microsoft.Warehouse.Structure;

page 90065 "Bin Content API"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Bin Content API';
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    EntityName = 'binContent';
    EntitySetName = 'binContents';
    PageType = API;
    SourceTable = "Bin Content";

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
                field(binCode; Rec."Bin Code")
                {
                    Caption = 'Bin Code';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
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
                field(minQty; Rec."Min. Qty.")
                {
                    Caption = 'Min. Qty.';
                }
                field(maxQty; Rec."Max. Qty.")
                {
                    Caption = 'Max. Qty.';
                }
                field(binRanking; Rec."Bin Ranking")
                {
                    Caption = 'Bin Ranking';
                }
                field("fixed"; Rec."Fixed")
                {
                    Caption = 'Fixed';
                }
                field(crossDockBin; Rec."Cross-Dock Bin")
                {
                    Caption = 'Cross-Dock Bin';
                }
                field(default; Rec.Default)
                {
                    Caption = 'Default';
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure';
                }
                field(dedicated; Rec.Dedicated)
                {
                    Caption = 'Dedicated';
                }
                field(openingStockFND; Rec."Opening Stock FND")
                {
                    Caption = 'Opening Stock';
                }
                field(unitCostOpeningStockFND; Rec."Unit Cost Opening Stock FND")
                {
                    Caption = 'Unit Cost Opening Stock';
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
