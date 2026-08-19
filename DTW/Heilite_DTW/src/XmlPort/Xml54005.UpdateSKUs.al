xmlport 54005 "Update SKUs"
{
    //Bc Upgrade YADAVM09 Old id is-50150.
    //Bc Upgrade YADAVM09 Drink it fields blocked.
    Direction = Import;
    FieldSeparator = '|';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'ItemLocalSite';
                UseTemporary = true;
                textelement(itemno_sku)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    XmlName = 'ItemNo';
                }
                textelement(LocationCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(blocked_sku)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    XmlName = 'Blocked';
                }
                textelement(PlantSpecificMaterialStatus)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(StandardCost)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(LotSize)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(FlushingMethod)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ReplenishmentSystem)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(PhysInvtCountingPeriodCode)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(Scrap)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(OverheadRate)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(IndirectCost)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(QualityStandardNo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(QuarantinePostingPolicy)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(RPMSolutionSKU)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(LeadTimeCalculation)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ReorderingPolicy)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ReorderPoint)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(ReorderQuantity)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(MinimumOrderQty)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(MaximumOrderQty)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(OrderMultiple)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SafetyStockQty)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(SafetyLeadTime)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(TimeBucket)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(OverflowLevel)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }
                textelement(BackorderType)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord();
                begin
                    if not StockkeepingUnit.GET(LocationCode, ItemNo_SKU, '') then begin
                        StockkeepingUnit.INIT;
                        StockkeepingUnit.VALIDATE("Item No.", ItemNo_SKU);
                        StockkeepingUnit.VALIDATE("Location Code", LocationCode);
                        StockkeepingUnit.VALIDATE("Variant Code", '');
                        if Blocked_SKU <> '' then begin
                            EVALUATE(varBlocked, Blocked_SKU);
                            StockkeepingUnit.VALIDATE("Blocked FND", varBlocked);//BC Upgrade GUNREM01 Uncommented DIT field code
                        end;
                        if PlantSpecificMaterialStatus <> '' then begin
                            EVALUATE(varPlantSpecificStatus, PlantSpecificMaterialStatus);
                            StockkeepingUnit.VALIDATE("Plant Spec.Material Status FND", varPlantSpecificStatus);
                        end;
                        //StockkeepingUnit.VALIDATE("Quality Standard No.", QualityStandardNo);//Bc Upgrade YADAVM09 Drink it field<<
                        if StandardCost <> '' then begin
                            EVALUATE(StockkeepingUnit."Standard Cost", StandardCost);
                            StockkeepingUnit.VALIDATE("Standard Cost");
                        end;
                        if LotSize <> '' then begin
                            EVALUATE(StockkeepingUnit."Lot Size", LotSize);
                            StockkeepingUnit.VALIDATE("Lot Size");
                        end;
                        if FlushingMethod <> '' then begin
                            EVALUATE(StockkeepingUnit."Flushing Method", FlushingMethod);
                            StockkeepingUnit.VALIDATE("Flushing Method");
                        end;
                        if ReplenishmentSystem <> '' then begin
                            EVALUATE(StockkeepingUnit."Replenishment System", ReplenishmentSystem);
                            StockkeepingUnit.VALIDATE("Replenishment System");
                        end;
                        if PhysInvtCountingPeriodCode <> '' then
                            StockkeepingUnit.VALIDATE("Phys Invt Counting Period Code", PhysInvtCountingPeriodCode);
                        if Scrap <> '' then begin
                            EVALUATE(StockkeepingUnit."Scrap %", Scrap);
                            StockkeepingUnit.VALIDATE("Scrap %");
                        end;
                        //Bc Upgrade YADAVM09 Drink it field>>
                        // if OverheadRate <> '' then begin
                        //     EVALUATE(StockkeepingUnit."Overhead Rate", OverheadRate);
                        //     StockkeepingUnit.VALIDATE("Overhead Rate");
                        //end;
                        // if IndirectCost <> '' then begin
                        //     EVALUATE(StockkeepingUnit."Indirect Cost %", IndirectCost);
                        //     StockkeepingUnit.VALIDATE("Indirect Cost %");
                        // end;
                        // if QuarantinePostingPolicy <> '' then begin
                        //     EVALUATE(StockkeepingUnit."Quarantine Posting Policy", QuarantinePostingPolicy);
                        //     StockkeepingUnit.VALIDATE("Quarantine Posting Policy");
                        // end;
                        //Bc Upgrade YADAVM09 Drink it field<<
                        if RPMSolutionSKU <> '' then begin
                            EVALUATE(StockkeepingUnit."RPM Solution FND", RPMSolutionSKU);
                            StockkeepingUnit.VALIDATE("RPM Solution FND");
                        end;
                        if LeadTimeCalculation <> '' then begin
                            EVALUATE(StockkeepingUnit."Lead Time Calculation", LeadTimeCalculation);
                            StockkeepingUnit.VALIDATE("Lead Time Calculation");
                        end;
                        if ReorderingPolicy <> '' then begin
                            EVALUATE(StockkeepingUnit."Reordering Policy", ReorderingPolicy);
                            StockkeepingUnit.VALIDATE("Reordering Policy");
                        end;
                        if ReorderPoint <> '' then begin
                            EVALUATE(StockkeepingUnit."Reorder Point", ReorderPoint);
                            StockkeepingUnit.VALIDATE("Reorder Point");
                        end;
                        if ReorderQuantity <> '' then begin
                            EVALUATE(StockkeepingUnit."Reorder Quantity", ReorderQuantity);
                            StockkeepingUnit.VALIDATE("Reorder Quantity");
                        end;
                        if MinimumOrderQty <> '' then begin
                            EVALUATE(StockkeepingUnit."Minimum Order Quantity", MinimumOrderQty);
                            StockkeepingUnit.VALIDATE("Minimum Order Quantity");
                        end;
                        if MaximumOrderQty <> '' then begin
                            EVALUATE(StockkeepingUnit."Maximum Order Quantity", MaximumOrderQty);
                            StockkeepingUnit.VALIDATE("Maximum Order Quantity");
                        end;
                        if OrderMultiple <> '' then begin
                            EVALUATE(StockkeepingUnit."Order Multiple", OrderMultiple);
                            StockkeepingUnit.VALIDATE("Order Multiple");
                        end;
                        if SafetyStockQty <> '' then begin
                            EVALUATE(StockkeepingUnit."Safety Stock Quantity", SafetyStockQty);
                            StockkeepingUnit.VALIDATE("Safety Stock Quantity");
                        end;
                        if SafetyLeadTime <> '' then begin
                            EVALUATE(StockkeepingUnit."Safety Lead Time", SafetyLeadTime);
                            StockkeepingUnit.VALIDATE("Safety Lead Time");
                        end;
                        if TimeBucket <> '' then begin
                            EVALUATE(StockkeepingUnit."Time Bucket", TimeBucket);
                            StockkeepingUnit.VALIDATE("Time Bucket");
                        end;
                        if OverflowLevel <> '' then begin
                            EVALUATE(StockkeepingUnit."Overflow Level", OverflowLevel);
                            StockkeepingUnit.VALIDATE("Overflow Level");
                        end;
                        //Bc Upgrade YADAVM09 Drink it field>>
                        // if BackorderType <> '' then begin
                        //     EVALUATE(StockkeepingUnit."Backorder Type", BackorderType);
                        //     StockkeepingUnit.VALIDATE("Backorder Type");
                        // end;
                        //Bc Upgrade YADAVM09 Drink it field<<
                        StockkeepingUnit.INSERT(true);
                    end;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort();
    begin
        MESSAGE('Done');
    end;

    var
        StockkeepingUnit: Record "Stockkeeping Unit";
        varBlocked: Boolean;
        varPlantSpecificStatus: Option "Local Setup","Local Active","Local Inact/ No Procurement","Local Inactive","Local to be Archived";
}

