query 55024 "C2S SCA SKU RPM Fld IT"
{
    // version HEI.01

    // HEI.01 CHG2185464 IBM SISU01  13/12/2022 #New query object created

    //BC Upgrade Kamnay01 Original(Heilite) Query id 50047
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
            dataitem(RPM_SKU_Relationship; "RPM - SKU Relationship FND")
            {
                DataItemLink = "Period Date" = Shipping_Cost_Allocation."Period Date", "Linked Item No." = Shipping_Cost_Allocation."Item No.", "Own Fleet" = Shipping_Cost_Allocation."Own Fleet";
                SqlJoinType = InnerJoin;
                column(Period_RPM_Gen_Overh_IT; "Period RPM Gen. Overh. IT")
                {
                    Method = Max;
                }
                column(Period_RPM_Whse_Overh_IT; "Period RPM Whse. Overh. IT")
                {
                    Method = Max;
                }
                column(Period_RPM_Whse_Handl_IT; "Period RPM Whse. Handl. IT")
                {
                    Method = Max;
                }
                column(OVE_Prd_RPM_Whse_Handl_IT; "OVE Prd. RPM Whse. Handl. IT")
                {
                    Method = Max;
                }
                column(TRP_Prd_RPM_Whse_Handl_IT; "TRP Prd. RPM Whse. Handl. IT")
                {
                    Method = Max;
                }
                column(FIX_Prd_RPM_Whse_Handl_IT; "FIX Prd. RPM Whse. Handl. IT")
                {
                    Method = Max;
                }
            }
        }
    }
}

