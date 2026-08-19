query 55014 "C2S RPM SKU Add Missing Comb"
{
    // version HEI.02

    // HEI.01 CHG2169207 IBM SISUM01 13/09/2022 # New query object created
    // HEI.02 CHG2178734 IBM SISU01  16/11/2022 #Delete sum column and add Item Category code
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50036

    elements
    {
        dataitem(Shipping_Cost_Allocation; "Shipping Cost Allocation FND")
        {
            DataItemTableFilter = "Only RPM Transportation" = CONST(false), "Destination Type" = CONST(Customer), "Distribution Type" = CONST(Total);
            filter(FilterPeriodDate; "Period Date")
            {
            }
            column(PeriodDate; "Period Date")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(DestinationNo; "Destination No.")
            {
            }
            column(OwnFleet; "Own Fleet")
            {
            }
            column(ItemCategoryCode; "Item Category Code")
            {
            }
        }
    }
}

