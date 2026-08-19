query 55013 "C2S SCA CalcFlowFields"
{
    // version HEI.03

    // HEI.01 CHG2169207 IBM SISUM01 25/08/2022 # New query object created
    // HEI.02 CHG2178734 IBM SISU01  07/11/2022 #add new columns
    // HEI.03 CHG2167931 IBM SISUM01 19/11/2022 #add new fields (the ones with OVE, TRP and FIX)
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50035

    elements
    {
        dataitem(Shipping_Cost_Allocation; "Shipping Cost Allocation FND")
        {
            DataItemTableFilter = "Destination Type" = FILTER(Customer), "Only RPM Transportation" = CONST(false);
            filter(FilterEntryNo; "Entry No.")
            {
            }
            filter(FilterPostingDate; "Posting Date")
            {
            }
            filter(FilterItemCategoryCode; "Item Category Code")
            {
            }
            column(Entry_No; "Entry No.")
            {
            }
            column(ST_Period_Net_Weight_SKU_Lot; "ST Period Net Weight SKU/Lot")
            {
            }
            column(ST_Transfers_per_SKU_Lot; "ST Transfers per SKU/Lot")
            {
            }
            column(ST_Gen_Overh_per_SKU_Lot; "ST Gen. Overh. per SKU/Lot")
            {
            }
            column(ST_Whse_Overh_per_SKU_Lot; "ST Whse. Overh. per SKU/Lot")
            {
            }
            column(ST_Period_Pick_Factor_SKU_Lot; "ST Period Pick. Factor SKU/Lot")
            {
            }
            column(ST_Whse_Hand_per_SKU_Lot; "ST Whse. Hand. per SKU/Lot")
            {
            }
            column(Unit_Cost_General_Overheads_ST; "Unit Cost-General Overheads ST")
            {
            }
            column(Unit_Cost_Whse_Handling_ST; "Unit Cost-Whse. Handling ST")
            {
            }
            column(Unit_Cost_General_Overheads_SO; "Unit Cost-General Overheads SO")
            {
            }
            column(Unit_Cost_Whse_Handling_SO; "Unit Cost-Whse. Handling SO")
            {
            }
            column(Unit_Cost_Whse_Overhead_SO; "Unit Cost-Whse. Overhead SO")
            {
            }
            column(Unit_Cost_Internal_Transfer_SO; "Unit Cost-Internal Transfer SO")
            {
            }
            column(Period_RPM_Unit_Cost_Customer; "Period RPM Unit Cost Customer")
            {
            }
            column(Period_RPM_Unit_Cost_Transfer; "Period RPM Unit Cost Transfer")
            {
            }
            column(Period_RPM_Gen_Overh_Cust; "Period RPM Gen. Overh. Cust.")
            {
            }
            column(Period_RPM_Gen_Overh_IT; "Period RPM Gen. Overh. IT")
            {
            }
            column(Period_RPM_Whse_Overh_Cust; "Period RPM Whse. Overh. Cust.")
            {
            }
            column(Period_RPM_Whse_Overh_IT; "Period RPM Whse. Overh. IT")
            {
            }
            column(Period_RPM_Whse_Handl_Cust; "Period RPM Whse. Handl. Cust.")
            {
            }
            column(Period_RPM_Whse_Handl_IT; "Period RPM Whse. Handl. IT")
            {
            }
            column(OVE_Unit_Cost_Whse_Handl_SO; "OVE Unit Cost-Whse. Handl. SO")
            {
            }
            column(TRP_Unit_Cost_Whse_Handl_SO; "TRP Unit Cost-Whse. Handl. SO")
            {
            }
            column(FIX_Unit_Cost_Whse_Handl_SO; "FIX Unit Cost-Whse. Handl. SO")
            {
            }
            column(OVE_ST_Whse_Hand_SKU_Lot; "OVE ST Whse. Hand. SKU/Lot")
            {
            }
            column(TRP_ST_Whse_Hand_SKU_Lot; "TRP ST Whse. Hand. SKU/Lot")
            {
            }
            column(FIX_ST_Whse_Hand_SKU_Lot; "FIX ST Whse. Hand. SKU/Lot")
            {
            }
            column(OVE_Prd_RPM_Whse_Handl_Cust; "OVE Prd. RPM Whse. Handl. Cust")
            {
            }
            column(TRP_Prd_RPM_Whse_Handl_Cust; "TRP Prd. RPM Whse. Handl. Cust")
            {
            }
            column(FIX_Prd_RPM_Whse_Handl_Cust; "FIX Prd. RPM Whse. Handl. Cust")
            {
            }
            column(OVE_Prd_RPM_Whse_Handl_IT; "OVE Prd. RPM Whse. Handl. IT")
            {
            }
            column(TRP_Prd_RPM_Whse_Handl_IT; "TRP Prd. RPM Whse. Handl. IT")
            {
            }
            column(FIX_Prd_RPM_Whse_Handl_IT; "FIX Prd. RPM Whse. Handl. IT")
            {
            }
            column(Period_Picking_Factor_SKU_Lot; "Period Picking Factor SKU/Lot")
            {
            }
            column(Net_Weight_Kg; "Net Weight (Kg)")
            {
            }
            column(Picking_Factor; "Picking Factor")
            {
            }
            column(Period_Net_Weight_SKU_Lot; "Period Net Weight SKU/Lot")
            {
            }
        }
    }
}

