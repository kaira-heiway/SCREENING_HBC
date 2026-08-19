query 55012 "C2S RPM SKU Linked Item"
{
    // version HEI.03

    // HEI.01 CHG2169207 IBM SISUM01 17/08/2022 # New query object  created
    // HEI.02 CHG2169207 IBM SISUM01 02/09/2022 # add columns and filters: RPM Item No and Own Fleet and take disting the amounts (not sum, but max)
    // HEI.03 CHG2167931 IBM SISUM01 19/11/2022 #add new fields (the ones with OVE, TRP and FIX)
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50034

    elements
    {
        dataitem(RPM_SKU_Relationship; "RPM - SKU Relationship FND")
        {
            column(Period_Start_Date; "Period Start Date")
            {
            }
            column(Linked_Item_No; "Linked Item No.")
            {
            }
            column(RPM_Item_No; "RPM Item No.")
            {
            }
            column(Own_Fleet; "Own Fleet")
            {
            }
            column(RPM_Unit_Cost_Transferred; "RPM Unit Cost Transferred")
            {
                Method = Max;
            }
            column(RPM_Gen_Over_Unit_Cost_T; "RPM Gen. Over. Unit Cost T")
            {
                Method = Max;
            }
            column(RPM_Whse_Over_Unit_Cost_T; "RPM Whse. Over. Unit Cost T")
            {
                Method = Max;
            }
            column(RPM_Whse_Hand_Unit_Cost_T; "RPM Whse. Hand Unit Cost T.")
            {
                Method = Max;
            }
            column(OVE_RPM_Whse_H_Unit_Cost_T; "OVE RPM Whse. H Unit Cost T")
            {
                Method = Max;
            }
            column(TRP_RPM_Whse_H_Unit_Cost_T; "TRP RPM Whse. H Unit Cost T")
            {
                Method = Max;
            }
            column(FIX_RPM_Whse_H_Unit_Cost_T; "FIX RPM Whse. H Unit Cost T")
            {
                Method = Max;
            }
            filter(FilterPeriodStartDate; "Period Start Date")
            {
            }
            filter(FilterLinkedItemNo; "Linked Item No.")
            {
            }
            filter(FilterRPMItemNo; "RPM Item No.")
            {
            }
            filter(FilterOwnFleet; "Own Fleet")
            {
            }
        }
    }
}

