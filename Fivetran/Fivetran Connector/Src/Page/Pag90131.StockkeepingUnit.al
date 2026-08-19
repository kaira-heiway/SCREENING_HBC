page 90131 "Stockkeeping Unit API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'Stockkeeping Unit';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Stockkeeping Unit';
    EntitySetCaption = 'Stockkeeping Unit';
    EntityName = 'stockkeepingUnit';
    EntitySetName = 'stockkeepingUnit';
    SourceTable = "Stockkeeping Unit";
    ODataKeyFields = SystemID;

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
                field(assemblyPolicy; Rec."Assembly Policy")
                {
                    Caption = 'Assembly Policy';
                }
                field(blocked; Rec."Blocked FND")
                {
                    Caption = 'Blocked';
                }
                field(cccDimCode; Rec."CCC Dim. Code FND")
                {
                    Caption = 'CCC Dimension Code';
                }
                field(componentsAtLocation; Rec."Components at Location")
                {
                    Caption = 'Components at Location';
                }
                field(dampenerPeriod; Rec."Dampener Period")
                {
                    Caption = 'Dampener Period';
                }
                field(dampenerQuantity; Rec."Dampener Quantity")
                {
                    Caption = 'Dampener Quantity';
                }
                field(discreteOrderQuantity; Rec."Discrete Order Quantity")
                {
                    Caption = 'Discrete Order Quantity';
                }
                field(flushingMethod; Rec."Flushing Method")
                {
                    Caption = 'Flushing Method';
                }
                field(includeInventory; Rec."Include Inventory")
                {
                    Caption = 'Include Inventory';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(itemType; Rec."Item Type FND")
                {
                    Caption = 'Item Type';
                }
                field(lastCountingPeriodUpdate; Rec."Last Counting Period Update")
                {
                    Caption = 'Last Counting Period Update';
                }
                field(lastDirectCost; Rec."Last Direct Cost")
                {
                    Caption = 'Last Direct Cost';
                }
                field(leadTimeCalculation; Rec."Lead Time Calculation")
                {
                    Caption = 'Lead Time Calculation';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(lotAccumulationPeriod; Rec."Lot Accumulation Period")
                {
                    Caption = 'Lot Accumulation Period';
                }
                field(lotSize; Rec."Lot Size")
                {
                    Caption = 'Lot Size';
                }
                field(manufacturingPolicy; Rec."Manufacturing Policy")
                {
                    Caption = 'Manufacturing Policy';
                }
                field(maximumInventory; Rec."Maximum Inventory")
                {
                    Caption = 'Maximum Inventory';
                }
                field(maximumOrderQuantity; Rec."Maximum Order Quantity")
                {
                    Caption = 'Maximum Order Quantity';
                }
                field(minimumOrderQuantity; Rec."Minimum Order Quantity")
                {
                    Caption = 'Minimum Order Quantity';
                }
                field(nextCountingEndDate; Rec."Next Counting End Date")
                {
                    Caption = 'Next Counting End Date';
                }
                field(nextCountingStartDate; Rec."Next Counting Start Date")
                {
                    Caption = 'Next Counting Start Date';
                }
                field(orderMultiple; Rec."Order Multiple")
                {
                    Caption = 'Order Multiple';
                }
                field(overflowLevel; Rec."Overflow Level")
                {
                    Caption = 'Overflow Level';
                }
                field(physInvtCountingPeriodCode; Rec."Phys Invt Counting Period Code")
                {
                    Caption = 'Phys Invt Counting Period Code';
                }
                field(plantSpecMaterialStatus; Rec."Plant Spec.Material Status FND")
                {
                    Caption = 'Plant-Specific Material Status';
                }
                field(productionBOMNo; Rec."Production BOM No.")
                {
                    Caption = 'Production BOM No.';
                }
                field(putAwayTemplateCode; Rec."Put-away Template Code")
                {
                    Caption = 'Put-away Template Code';
                }
                field(putAwayUnitOfMeasureCode; Rec."Put-away Unit of Measure Code")
                {
                    Caption = 'Put-away Unit of Measure Code';
                }
                field(qualityStandardNo; Rec."Quality Standard No. FND")
                {
                    Caption = 'Quality Standard No.';
                }
                field(quarantinePostingPolicy; Rec."Quarantine Posting Policy FND")
                {
                    Caption = 'Quarantine Posting Policy';
                }
                field(reorderPoint; Rec."Reorder Point")
                {
                    Caption = 'Reorder Point';
                }
                field(reorderQuantity; Rec."Reorder Quantity")
                {
                    Caption = 'Reorder Quantity';
                }
                field(reorderingPolicy; Rec."Reordering Policy")
                {
                    Caption = 'Reordering Policy';
                }
                field(replenishmentSystem; Rec."Replenishment System")
                {
                    Caption = 'Replenishment System';
                }
                field(reschedulingPeriod; Rec."Rescheduling Period")
                {
                    Caption = 'Rescheduling Period';
                }
                field(rolledUpCapOverheadCost; Rec."Rolled-up Cap. Overhead Cost")
                {
                    Caption = 'Rolled-up Cap. Overhead Cost';
                }
                field(rolledUpCapacityCost; Rec."Rolled-up Capacity Cost")
                {
                    Caption = 'Rolled-up Capacity Cost';
                }
                field(rolledUpMaterialCost; Rec."Rolled-up Material Cost")
                {
                    Caption = 'Rolled-up Material Cost';
                }
                field(rolledUpMfgOvhdCost; Rec."Rolled-up Mfg. Ovhd Cost")
                {
                    Caption = 'Rolled-up Mfg. Ovhd Cost';
                }
                field(rolledUpSubcontractedCost; Rec."Rolled-up Subcontracted Cost")
                {
                    Caption = 'Rolled-up Subcontracted Cost';
                }
                field(routingNo; Rec."Routing No.")
                {
                    Caption = 'Routing No.';
                }
                field(rpmSolution; Rec."RPM Solution FND")
                {
                    Caption = 'RPM Solution';
                }
                field(rpmType; Rec."RPM Type FND")
                {
                    Caption = 'RPM Type';
                }
                field(safetyLeadTime; Rec."Safety Lead Time")
                {
                    Caption = 'Safety Lead Time';
                }
                field(safetyStockQuantity; Rec."Safety Stock Quantity")
                {
                    Caption = 'Safety Stock Quantity';
                }
                field(shelfNo; Rec."Shelf No.")
                {
                    Caption = 'Shelf No.';
                }
                field(singleLevelCapOvhdCost; Rec."Single-Level Cap. Ovhd Cost")
                {
                    Caption = 'Single-Level Cap. Ovhd Cost';
                }
                field(singleLevelCapacityCost; Rec."Single-Level Capacity Cost")
                {
                    Caption = 'Single-Level Capacity Cost';
                }
                field(singleLevelMaterialCost; Rec."Single-Level Material Cost")
                {
                    Caption = 'Single-Level Material Cost';
                }
                field(singleLevelMfgOvhdCost; Rec."Single-Level Mfg. Ovhd Cost")
                {
                    Caption = 'Single-Level Mfg. Ovhd Cost';
                }
                field(singleLevelSubcontrdCost; Rec."Single-Level Subcontrd. Cost")
                {
                    Caption = 'Single-Level Subcontrd. Cost';
                }
                field(skuType; Rec."SKU Type FND")
                {
                    Caption = 'Subtype Code';
                }
                field(specialEquipmentCode; Rec."Special Equipment Code")
                {
                    Caption = 'Special Equipment Code';
                }
                field(standardCost; Rec."Standard Cost")
                {
                    Caption = 'Standard Cost';
                }
                field(timeBucket; Rec."Time Bucket")
                {
                    Caption = 'Time Bucket';
                }
                field(transferFromCode; Rec."Transfer-from Code")
                {
                    Caption = 'Transfer-from Code';
                }
                field(transferLevelCode; Rec."Transfer-Level Code")
                {
                    Caption = 'Transfer-Level Code';
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field(useCrossDocking; Rec."Use Cross-Docking")
                {
                    Caption = 'Use Cross-Docking';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(vendorItemNo; Rec."Vendor Item No.")
                {
                    Caption = 'Vendor Item No.';
                }
                field(vendorNo; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                }

            }
        }
    }
}
