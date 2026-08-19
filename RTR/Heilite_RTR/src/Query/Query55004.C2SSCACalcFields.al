query 55004 "C2S SCA CalcFields"
{
    // version HEI.01

    // HEI.01 CHG2162842 IBM SAMANR01 07/07/202022 #C2S optimazation
    //   # New query object  created
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50025


    elements
    {
        dataitem(Shipping_Cost_Allocation; "Shipping Cost Allocation FND")
        {
            filter(FilterPostingDate; "Posting Date")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(Period_Date; "Period Date")
            {
            }
            column(Item_No; "Item No.")
            {
            }
            column(Own_Fleet; "Own Fleet")
            {
            }
            column(Destination_Type; "Destination Type")
            {
            }
            column(Destination_No; "Destination No.")
            {
            }
            column(Lot_No_Destination_No; "Lot No. & Destination No.")
            {
            }
            column(Source_Document; "Source Document")
            {
            }
            column(Lot_No; "Lot No.")
            {
            }
            dataitem(ShippingCostAllocationChld1; "Shipping Cost Allocation FND")
            {
                DataItemLink = "Period Date" = Shipping_Cost_Allocation."Period Date", "Item No." = Shipping_Cost_Allocation."Item No.", "Lot No." = Shipping_Cost_Allocation."Lot No.", "Destination No." = Shipping_Cost_Allocation."Location Code", "Own Fleet" = Shipping_Cost_Allocation."Own Fleet";
                SqlJoinType = LeftOuterJoin;
                DataItemTableFilter = "Source Document" = FILTER("Outbound Transfer");
                column(STPeriodNetWeightSKU_Lot; "Period Net Weight SKU/Lot")
                {
                    Method = Max;
                }
                column(STPeriodPickFactorSKU_Lot; "Period Picking Factor SKU/Lot")
                {
                    Method = Max;
                }
                column(STTransfersperSKU_Lot; "Period Transfers per SKU/Lot")
                {
                    Method = Max;
                }
                dataitem(ShippingCostAllocationChld2; "Shipping Cost Allocation FND")
                {
                    DataItemLink = "Period Date" = Shipping_Cost_Allocation."Period Date", "Item No." = Shipping_Cost_Allocation."Item No.", "Lot No. & Destination No." = Shipping_Cost_Allocation."Lot No. & Location Code";
                    SqlJoinType = LeftOuterJoin;
                    DataItemTableFilter = "Source Document" = FILTER("Outbound Transfer");
                    column(UnitCost_GeneralOverheadsSO; "Unit Cost-General Overheads ST")
                    {
                        Method = Max;
                    }
                    column(UnitCost_InternalTransferSO; "Unit Cost-Internal Transfer ST")
                    {
                        Method = Max;
                    }
                    column(UnitCost_WhseHandlingSO; "Unit Cost-Whse. Handling ST")
                    {
                        Method = Max;
                    }
                    column(UnitCost_WhseOverheadSO; "Unit Cost-Whse. Overhead ST")
                    {
                        Method = Max;
                    }
                    dataitem(ShippingCostAllocationChld3; "Shipping Cost Allocation FND")
                    {
                        DataItemLink = "Period Date" = Shipping_Cost_Allocation."Period Date", "Item No." = Shipping_Cost_Allocation."Item No.", "Lot No." = Shipping_Cost_Allocation."Lot No.", "Destination No." = Shipping_Cost_Allocation."Location Code", "Destination Type" = Shipping_Cost_Allocation."Destination Type", "Own Fleet" = Shipping_Cost_Allocation."Own Fleet";
                        SqlJoinType = LeftOuterJoin;
                        DataItemTableFilter = "Source Document" = FILTER("Outbound Transfer");
                        column(STGenOverhperSKU_Lot; "General Overheads")
                        {
                            Method = Max;
                        }
                        column(STWhseHandperSKU_Lot; "Warehouse Handling")
                        {
                            Method = Max;
                        }
                    }
                }
            }
        }
    }
}

