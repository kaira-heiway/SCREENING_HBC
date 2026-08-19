query 55023 "C2S SCA SKU RPM Fld Cust"
{
    // version HEI.01

    // HEI.01 CHG2185464 IBM SISU01  13/12/2022 #New query object created
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50046

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
                DataItemLink = "Period Date" = Shipping_Cost_Allocation."Period Date", "Linked Item No." = Shipping_Cost_Allocation."Item No.", "Customer No." = Shipping_Cost_Allocation."Destination No.", "Own Fleet" = Shipping_Cost_Allocation."Own Fleet";
                SqlJoinType = InnerJoin;
                column(Period_RPM_Gen_Overh_Cust; "Period RPM Gen. Overh. Cust.")
                {
                    Caption = '<Period_RPM_Gen_Overh_Cust>';
                    Method = Max;
                }
                column(Period_RPM_Whse_Overh_Cust; "Period RPM Whse. Overh. Cust.")
                {
                    Method = Max;
                }
                column(Period_RPM_Whse_Handl_Cust; "Period RPM Whse. Handl. Cust.")
                {
                    Method = Max;
                }
                column(OVE_Prd_RPM_Whse_Handl_Cus; "OVE Prd. RPM Whse. Handl. Cust")
                {
                    Method = Max;
                }
                column(TRP_Prd_RPM_Whse_Handl_Cus; "TRP Prd. RPM Whse. Handl. Cust")
                {
                    Method = Max;
                }
                column(FIX_Prd_RPM_Whse_Handl_Cus; "FIX Prd. RPM Whse. Handl. Cust")
                {
                    Method = Max;
                }
            }
        }
    }
}

