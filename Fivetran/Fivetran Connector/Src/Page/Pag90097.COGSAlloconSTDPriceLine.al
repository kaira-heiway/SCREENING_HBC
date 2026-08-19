namespace J_Interface_QUA.J_Interface_QUA;

page 90097 "COGS Alloc on STD Price Line"
{
    APIGroup = 'customEndpoints';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'COGS Alloc On STD Price Line API';
    DelayedInsert = true;
    EntityName = 'COGSAlloconSTDPriceLine';
    EntitySetName = 'COGSAlloconSTDPriceLine';
    PageType = API;
    SourceTable = "COGS Alloc STD Price Line FND";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;
    APIPublisher = 'fivetran';

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
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(processingDate; Rec."Processing Date")
                {
                    Caption = 'Processing Date';
                }
                field(cogsAllocation; Rec."COGS Allocation")
                {
                    Caption = 'COGS Allocation';
                }
                field(company; Rec.Company)
                {
                    Caption = 'Company';
                }
                field(fiscalYear; Rec."Fiscal Year")
                {
                    Caption = 'Fiscal Year';
                }
                field(periodNumber; Rec."Period Number")
                {
                    Caption = 'Period Number';
                }
                field(location; Rec.Location)
                {
                    Caption = 'Location';
                }
                field(parentItemNo; Rec."Parent Item No.")
                {
                    Caption = 'Parent Item No.';
                }
                field(productionBOMNo; Rec."Production BOM No.")
                {
                    Caption = 'Production BOM No.';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(itemUoM; Rec."Item UoM")
                {
                    Caption = 'Item Unit of Measure Code';
                }
                field(quantityPer; Rec."Quantity per")
                {
                    Caption = 'Quantity per';
                }
                field(scrap; Rec."Scrap %")
                {
                    Caption = 'Scrap %';
                }
                field(routingNo; Rec."Routing No.")
                {
                    Caption = 'Routing No.';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(unitCostRawPack; Rec."Unit Cost Raw&Pack")
                {
                    Caption = 'Unit Cost Raw and Pack.';
                }
                field(unitVolumeHL; Rec."Unit Volume HL")
                {
                    Caption = 'Unit Volume HL';
                }
                field(quantityHL; Rec."Quantity HL")
                {
                    Caption = 'Quantity HL';
                }
                field(totalCost; Rec."Total Cost")
                {
                    Caption = 'Total Cost';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                }
                field(subParentItemNo; Rec."Sub-Parent Item No.")
                {
                    Caption = 'Sub-Parent Item No.';
                }
                field(bomLevel; Rec."BOM Level")
                {
                    Caption = 'BOM Level';
                }
                field(qtyIncludingScrap; Rec."Qty. Including Scrap")
                {
                    Caption = 'Qty. Including Scrap';
                }
                field(workCenterNo; Rec."Work Center No.")
                {
                    Caption = 'Work Center No.';
                }
                field(setupTime; Rec."Setup Time")
                {
                    Caption = 'Setup Time';
                }
                field(runTime; Rec."Run Time")
                {
                    Caption = 'Run Time';
                }
                field(batchSize; Rec."Batch Size")
                {
                    Caption = 'Batch Size';
                }
                field(lotSize; Rec."Lot Size")
                {
                    Caption = 'Lot Size';
                }
                field(costRawOrPackMat; Rec."Cost Raw or Pack Mat.")
                {
                    Caption = 'Cost of Raw or Packaging Materials';
                }
                field(costProdFixExpBuOM; Rec."Cost Prod. Fix. Exp. BuOM")
                {
                    Caption = 'Cost Prod. Fix. Exp. (COGS) per BuOM';
                }
                field(unitCostOfWorkCenter; Rec."Unit Cost of Work Center")
                {
                    Caption = 'Unit Cost of Work Center';
                }
                field(costEnergyWater; Rec."Cost Energy & Water")
                {
                    Caption = 'Cost Energy & Water';
                }
                field(costOtherVariableExp; Rec."Cost Other Variable Exp.")
                {
                    Caption = 'Cost Other Variable Exp.';
                }
                field(prodBOMHeaderUoM; Rec."Prod. BOM Header UoM")
                {
                    Caption = 'Production BOM Header UOM';
                }
                field(prodBOMHeaderInHL; Rec."Prod. BOM Header in HL")
                {
                    Caption = 'Production BOM Header in HL';
                }
                field(prodBOMQtyPerBUoM; Rec."Prod. BOM Qty. per BUoM")
                {
                    Caption = 'Production BOM Header Qty. per BUoM';
                }
                field(qtyPerHLOfFG; Rec."Qty. per HL of FG")
                {
                    Caption = 'Qty. per 1 HL of Finished Good';
                }
                field(costProdFixPerHLOfFG; Rec."Cost. Prod. Fix. per HL of FG")
                {
                    Caption = 'Cost Prod. Fix. Exp. (COGS) for 1 HL of FG';
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
