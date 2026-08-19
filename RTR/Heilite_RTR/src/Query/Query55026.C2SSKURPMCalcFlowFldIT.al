query 55026 "C2S SKU RPM CalcFlowFld IT"
{
    // version HEI.01

    // HEI.01 CHG2185464 IBM SISU01  19/12/2022 #New query object created
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50049

    elements
    {
        dataitem(Shipping_Cost_Allocation; "Shipping Cost Allocation FND")
        {
            DataItemTableFilter = "Destination Type" = FILTER(Location), "Only RPM Transportation" = CONST(true);
            filter(FilterPostingDate; "Posting Date")
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
            column(Period_Alloc_Amount_IT; "Primary Allocated Amount")
            {
                Method = Sum;
            }
            column(Period_Gen_Overheads_IT; "General Overheads")
            {
                Method = Sum;
            }
            column(Period_Whse_Overheads_IT; "Warehouse Overheads")
            {
                Method = Sum;
            }
            column(Period_Whse_Handling_IT; "Warehouse Handling")
            {
                Method = Sum;
            }
            column(OVE_Prd_Whse_Handling_IT; "OVE Warehouse Handling")
            {
                Method = Sum;
            }
            column(TRP_Prd_Whse_Handling_IT; "TRP Warehouse Handling")
            {
                Method = Sum;
            }
            column(FIX_Prd_Whse_Handling_IT; "FIX Warehouse Handling")
            {
                Method = Sum;
            }
        }
    }
}

