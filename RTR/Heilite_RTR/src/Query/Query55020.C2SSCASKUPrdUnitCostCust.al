query 55020 "C2S SCA SKU Prd Unit Cost Cust"
{
    // version HEI.01

    // HEI.01 CHG2185464 IBM SISU01  13/12/2022 #New query object created
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50043

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
                DataItemLink = "Period Date" = Shipping_Cost_Allocation."Period Date", "Linked Item No." = Shipping_Cost_Allocation."Item No.", "Customer No." = Shipping_Cost_Allocation."Destination No.";
                SqlJoinType = InnerJoin;
                column(Period_RPM_Unit_Cost_Customer; "RPM Unit Cost Sold Cust.")
                {
                    Method = Sum;
                }
            }
        }
    }
}

