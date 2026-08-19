namespace J_Interface_QUA.J_Interface_QUA;

page 90098 "COGS Allocation on STD Pr API"
{
    APIGroup = 'customEndpoints';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'COGS Allocation on STD Price API';
    DelayedInsert = true;
    EntityName = 'COGSAllocationonSTDPriceapi';
    EntitySetName = 'COGSAllocationonSTDPriceapi';
    PageType = API;
    SourceTable = "COGS Alloc on STD Price FND";
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

                field(skuOfSoldProducts; Rec."SKU of Sold Products")
                {
                    Caption = 'SKU of Sold Products';
                }

                field(brand; Rec.Brand)
                {
                    Caption = 'Brand';
                }

                field(lineExtension; Rec."Line Extension")
                {
                    Caption = 'Line Extension';
                }

                field(packType; Rec."Pack Type")
                {
                    Caption = 'Pack Type';
                }

                field(volumesSoldHL; Rec."Volumes Sold HL")
                {
                    Caption = 'Volumes Sold_HL';
                }

                field(energyWaterProdHL; Rec."Energy & Water_Prod_HL")
                {
                    Caption = 'Energy & Water_Prod HL';
                }

                field(otherVariableExpensesHL; Rec."Other Variable Expenses_HL")
                {
                    Caption = 'Other Variable Expenses HL';
                }

                field(totalStandardCostHL; Rec."Total Standard Cost/HL")
                {
                    Caption = 'Total Standard Cost HL';
                }

                field(prodBoughtResaleAvgCostHL; Rec."Prod Bought_Resale Avg Cost_HL")
                {
                    Caption = 'Products Bought in for Resale Avg. Cost HL';
                }

                field(rawMaterials; Rec."Raw Materials")
                {
                    Caption = 'Raw Materials';
                }

                field(packagingMaterials; Rec."Packaging Materials")
                {
                    Caption = 'Packaging Materials';
                }

                field(energyWaterProd; Rec."Energy & Water_Prod")
                {
                    Caption = 'Energy & Water_Prod';
                }

                field(otherVariableExpenses; Rec."Other Variable Expenses")
                {
                    Caption = 'Other Variable Expenses';
                }

                field(prodFixExpCOGS; Rec."Prod Fix Exp_COGS")
                {
                    Caption = 'Prod. Fix Exp. COGS';
                }

                field(totalStandardCost; Rec."Total Standard Cost")
                {
                    Caption = 'Total Standard Cost';
                }

                field(prodBoughtResaleAvgCost; Rec."Prod Bought_Resale Avg Cost")
                {
                    Caption = 'Products Bought in for Resale Avg. Cost';
                }

                field(unallocated; Rec.Unallocated)
                {
                    Caption = 'Unallocated';
                }

                field(periodGLCostRawMaterials; Rec."Period G/L Cost Raw Materials")
                {
                    Caption = 'Period G/L Cost Raw Materials';
                }

                field(periodGLCostPackMaterials; Rec."Period G/L Cost Pack Materials")
                {
                    Caption = 'Period G/L Cost Packing Materials';
                }

                field(periodGLCostEnergyWater; Rec."Period G/L Cost Energy & Water")
                {
                    Caption = 'Period G/L Cost Energy & Water';
                }

                field(periodGLCostOtherVarExp; Rec."Period G/L Cost Other Var Exp")
                {
                    Caption = 'Period G/L Cost Other Variable Expenses';
                }

                field(periodGLCostInvMovVarProEx; Rec."Period G/L Cost InvMovVarProEx")
                {
                    Caption = 'Period G/L Cost Inv Mov Var Prod Exp';
                }

                field(periodGLCostProdFixExp; Rec."Period G/L Cost Prod Fix Exp")
                {
                    Caption = 'Period G/L Cost Prod Fix Exp';
                }

                field(periodGLCostProdBghtResale; Rec."Period G/L Cost ProdBghtResale")
                {
                    Caption = 'Period G/L Cost Products Bought in for Resale';
                }

                field(costingMethod; Rec."Costing Method")
                {
                    Caption = 'Costing Method';
                }

                field(volumesSold; Rec."Volumes Sold")
                {
                    Caption = 'Volumes Sold';
                }

                field(costPostedToGL; Rec."Cost Posted to G/L")
                {
                    Caption = 'Cost Posted to G/L';
                }

                field(valuedQuantityHL; Rec."Valued Quantity HL")
                {
                    Caption = 'Valued Quantity HL';
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
