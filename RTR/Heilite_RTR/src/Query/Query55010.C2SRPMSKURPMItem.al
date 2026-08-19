query 55010 "C2S RPM SKU RPM Item"
{
    // version HEI.02

    // HEI.01 CHG2169207 IBM SISUM01 12/08/2022 # New query object  created
    // HEI.02 CHG2169207 IBM SISUM01 29/08/2022 # add columns and filters: Linked Item No and Own Fleet and take disting the amounts (not sum)
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50032

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
            column(Linked_Item_No; "Linked Item No.")
            {
            }
            column(Own_Fleet; "Own Fleet")
            {
            }
            column(PeriodNetWeightLinkedItem; "Period Net Weight Linked Item")
            {
                Method = Max;
            }
            column(PeriodPickFactLinkedItem; "Period Pick. Fact. Linked Item")
            {
                Method = Max;
            }
            filter(FilterPeriodStartDate; "Period Start Date")
            {
            }
            filter(FilterRPMItemNo; "RPM Item No.")
            {
            }
            filter(FilterLinkedItemNo; "Linked Item No.")
            {
            }
            filter(FilterOwnFleet; "Own Fleet")
            {
            }
        }
    }
}

