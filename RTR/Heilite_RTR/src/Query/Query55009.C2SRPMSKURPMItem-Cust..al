query 55009 "C2S RPM SKU RPM Item - Cust."
{
    // version HEI.03

    // HEI.01 CHG2169207 IBM SISUM01 12/08/2022 # New query object  created
    // HEI.02 CHG2178734 IBM SISU01  07/11/2022 #add Own Fleet as filter and field
    // HEI.03 CHG2178734 IBM SISU01  10/11/2022 #roll back HEI.02
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50031


    elements
    {
        dataitem(RPM_SKU_Relationship; "RPM - SKU Relationship FND")
        {
            column(Period_Start_Date; "Period Start Date")
            {
            }
            column(RPM_Item_No; "RPM Item No.")
            {
            }
            column(Customer_No; "Customer No.")
            {
            }
            column(Sum_Period_Net_Weight_Customer; "Period Net Weight Customer")
            {
                Method = Sum;
            }
            column(Sum_Period_Picking_Factor_Cust; "Period Picking Factor Cust.")
            {
                Method = Sum;
            }
            filter(FilterPeriodStartDate; "Period Start Date")
            {
            }
            filter(FilterRPMItemNo; "RPM Item No.")
            {
            }
            filter(FilterCustomerNo; "Customer No.")
            {
            }
        }
    }
}

