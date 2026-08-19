query 55018 "C2S RPM CalcFlowFields"
{
    // version HEI.02

    // HEI.01 CHG2178734 IBM SISU01  07/11/2022 #New query object created
    // HEI.02 CHG2167931 IBM SISUM01 22/11/2022 #add new fields (the ones with OVE, TRP and FIX)
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50040

    elements
    {
        dataitem(RPM_SKU_Relationship; "RPM - SKU Relationship FND")
        {
            filter(Period_Start_Date; "Period Start Date")
            {
            }
            filter(Period_End_Date; "Period End Date")
            {
            }
            filter(FilterRPMItemNo; "RPM Item No.")
            {
            }
            filter(FilterLinkedItemNo; "Linked Item No.")
            {
            }
            filter(FilterCustomerNo; "Customer No.")
            {
            }
            filter(FilterOwnFleet; "Own Fleet")
            {
            }
            column(Period_Alloc_Amount_Customer; "Period Alloc. Amount Customer")
            {
            }
            column(Period_Gen_Overheads_Cust; "Period Gen. Overheads Cust.")
            {
            }
            column(Period_Whse_Overheads_Cust; "Period Whse. Overheads Cust.")
            {
            }
            column(Period_Whse_Handling_Cust; "Period Whse. Handling Cust.")
            {
            }
            column(Period_Alloc_Amount_Transfer; "Period Alloc. Amount Transfer")
            {
            }
            column(Period_Gen_Overheads_IT; "Period Gen. Overheads IT")
            {
            }
            column(Period_Whse_Overheads_IT; "Period Whse. Overheads IT")
            {
            }
            column(Period_Whse_Handling_IT; "Period Whse. Handling IT")
            {
            }
            column(Primary_Alloc_Amount_Customer; "Primary Alloc. Amount Customer")
            {
            }
            column(Second_Alloc_Amount_Customer; "Second. Alloc. Amount Customer")
            {
            }
            column(Period_Net_Weight_Customer; "Period Net Weight Customer")
            {
            }
            column(Period_Picking_Factor_Cust; "Period Picking Factor Cust.")
            {
            }
            column(RPM_Item_No; "RPM Item No.")
            {
            }
            column(Linked_Item_No; "Linked Item No.")
            {
            }
            column(Customer_No; "Customer No.")
            {
            }
            column(Own_Fleet; "Own Fleet")
            {
            }
            column(Primary_Alloc_Amount_Transfer; "Primary Alloc. Amount Transfer")
            {
            }
            column(Second_Alloc_Amount_Transfer; "Second. Alloc. Amount Transfer")
            {
            }
            column(Period_Net_Weight_Linked_Item; "Period Net Weight Linked Item")
            {
            }
            column(OVE_Prd_Whse_Handling_Cust; "OVE Prd Whse. Handling Cust.")
            {
            }
            column(TRP_Prd_Whse_Handling_Cust; "TRP Prd Whse. Handling Cust.")
            {
            }
            column(FIX_Prd_Whse_Handling_Cust; "FIX Prd Whse. Handling Cust.")
            {
            }
            column(OVE_Period_Whse_Handling_IT; "OVE Period Whse. Handling IT")
            {
            }
            column(TRP_Period_Whse_Handling_IT; "TRP Period Whse. Handling IT")
            {
            }
            column(FIX_Period_Whse_Handling_IT; "FIX Period Whse. Handling IT")
            {
            }
        }
    }
}

