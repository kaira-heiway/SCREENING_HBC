query 55011 "C2S RPM SKU Linked Item - Cust"
{
    // version HEI.04

    // HEI.01 CHG2169207 IBM SISUM01 17/08/2022 # New query object created
    // HEI.02 CHG2178734 IBM SISU01  07/11/2022 #add Own Fleet as filter and field
    // HEI.03 CHG2178734 IBM SISU01  08/11/2022 #roll back HEI.02
    // HEI.04 CHG2167931 IBM SISUM01 19/11/2022 #add new fields (the ones with OVE, TRP and FIX)
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50033

    elements
    {
        dataitem(RPM_SKU_Relationship; "RPM - SKU Relationship FND")
        {
            column(EntryNo; "Period Start Date")
            {
            }
            column(Linked_Item_No; "Linked Item No.")
            {
            }
            column(Customer_No; "Customer No.")
            {
            }
            column(Sum_RPM_Unit_Cost_Sold_Cust; "RPM Unit Cost Sold Cust.")
            {
                Method = Sum;
            }
            column(Sum_RPM_Gen_Over_Unit_Cost_Cus; "RPM Gen. Over. Unit Cost Cust.")
            {
                Method = Sum;
            }
            column(Sum_RPM_Whse_Over_Unit_Cost_Cu; "RPM Whse. Over. Unit Cost Cust")
            {
                Method = Sum;
            }
            column(Sum_RPM_Whse_Hand_Unit_Cost_Cu; "RPM Whse. Hand Unit Cost Cust.")
            {
                Method = Sum;
            }
            column(Sum_OVE_RPM_Whs_H_Unit_Cost_Cu; "OVE RPM Whs H Unit Cost Cust")
            {
                Method = Sum;
            }
            column(Sum_TRP_RPM_Whs_H_Unit_Cost_Cu; "TRP RPM Whs H Unit Cost Cust")
            {
                Method = Sum;
            }
            column(Sum_FIX_RPM_Whs_H_Unit_Cost_Cu; "FIX RPM Whs H Unit Cost Cust")
            {
                Method = Sum;
            }
            filter(FilterPeriodStartDate; "Period Start Date")
            {
            }
            filter(FilterLinkedItemNo; "Linked Item No.")
            {
            }
            filter(FilterCustomerNo; "Customer No.")
            {
            }
        }
    }
}

