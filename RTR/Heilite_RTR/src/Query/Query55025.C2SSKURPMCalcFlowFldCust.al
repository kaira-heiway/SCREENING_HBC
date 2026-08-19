query 55025 "C2S SKU RPM CalcFlowFld Cust"
{
    // version HEI.01

    // HEI.01 CHG2185464 IBM SISU01  19/12/2022 #New query object created
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50048

    elements
    {
        dataitem(Shipping_Cost_Allocation; "Shipping Cost Allocation FND")
        {
            DataItemTableFilter = "Destination Type" = FILTER(Customer), "Source Document" = FILTER("Sales Return Order"), "Only RPM Transportation" = CONST(true);
            filter(FilterPostingDate; "Posting Date")
            {
            }
            column(Period_Date; "Period Date")
            {
            }
            column(Destination_No; "Destination No.")
            {
            }
            column(Item_No; "Item No.")
            {
            }
            column(Own_Fleet; "Own Fleet")
            {
            }
            column(Period_Alloc_Amount_Cust; "Primary Allocated Amount")
            {
                Method = Sum;
            }
            column(Period_Gen_Overheads_Cust; "General Overheads")
            {
                Method = Sum;
            }
            column(Period_Whse_Overheads_Cust; "Warehouse Overheads")
            {
                Method = Sum;
            }
            column(Period_Whse_Handling_Cust; "Warehouse Handling")
            {
                Method = Sum;
            }
            column(OVE_Prd_Whse_Handling_Cust; "OVE Warehouse Handling")
            {
                Method = Sum;
            }
            column(TRP_Prd_Whse_Handling_Cust; "TRP Warehouse Handling")
            {
                Method = Sum;
            }
            column(FIX_Prd_Whse_Handling_Cust; "FIX Warehouse Handling")
            {
                Method = Sum;
            }
        }
    }
}

