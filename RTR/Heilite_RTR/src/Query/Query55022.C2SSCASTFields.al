query 55022 "C2S SCA ST Fields"
{
    // version HEI.01

    // HEI.01 CHG2185464 IBM SISU01  13/12/2022 #New query object created
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50045

    elements
    {
        dataitem(Shipping_Cost_Allocation; "Shipping Cost Allocation FND")
        {
            DataItemTableFilter = "Destination Type" = FILTER(Customer), "Only RPM Transportation" = CONST(false);
            filter(FilterPostingDate; "Posting Date")
            {
            }
            filter(FilterItemCategoryCode; "Item Category Code")
            {
            }
            column(Entry_No; "Entry No.")
            {
            }
            dataitem(Shipping_Cost_Allocation_ST; "Shipping Cost Allocation FND")
            {
                DataItemLink = "Period Date" = Shipping_Cost_Allocation."Period Date", "Item No." = Shipping_Cost_Allocation."Item No.", "Lot No." = Shipping_Cost_Allocation."Lot No.", "Destination No." = Shipping_Cost_Allocation."Location Code";
                SqlJoinType = InnerJoin;
                DataItemTableFilter = "Source Document" = FILTER("Outbound Transfer");
                column(ST_Period_Net_Weight_SKU_Lot; "Net Weight (Kg)")
                {
                    Caption = '<ST Period Net Weight SKULot>';
                    Method = Sum;
                }
                column(ST_Transfers_per_SKU_Lot; "Primary Allocated Amount")
                {
                    Caption = '<ST Transfers per SKU/Lot>';
                    Method = Sum;
                }
                column(ST_Gen_Overh_per_SKU_Lot; "General Overheads")
                {
                    Caption = '<ST Gen. Overh. per SKU/Lot>';
                    Method = Sum;
                }
                column(ST_Whse_Overh_per_SKU_Lot; "Warehouse Overheads")
                {
                    Caption = '<ST Whse. Overh. per SKU/Lot>';
                    Method = Sum;
                }
                column(ST_Whse_Hand_per_SKU_Lot; "Warehouse Handling")
                {
                    Caption = '<ST Whse. Hand. per SKU/Lot>';
                    Method = Sum;
                }
                column(ST_Period_Pick_Factor_SKU_Lot; "Picking Factor")
                {
                    Caption = '<ST Period Pick. Factor SKU/L>';
                    Method = Sum;
                }
                column(OVE_ST_Whse_Hand_SKU_Lot; "OVE Warehouse Handling")
                {
                    Caption = '<OVE ST Whse. Hand. SKU/Lot>';
                    Method = Sum;
                }
                column(TRP_ST_Whse_Hand_SKU_Lot; "TRP Warehouse Handling")
                {
                    Caption = '<TRP ST Whse. Hand. SKU/Lot>';
                    Method = Sum;
                }
                column(FIX_ST_Whse_Hand_SKU_Lot; "FIX Warehouse Handling")
                {
                    Caption = '<FIX ST Whse. Hand. SKU/Lot>';
                    Method = Sum;
                }
            }
        }
    }
}

