query 55017 "C2S RPM Calc Distance&Drops"
{
    // version HEI.01

    // HEI.01 CHG2178734 IBM SISU01  07/11/2022 #New query object created
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50039

    elements
    {
        dataitem(Shipping_Cost_Allocation; "Shipping Cost Allocation FND")
        {
            DataItemTableFilter = "Distribution Type" = FILTER(Total);
            filter(FilterPostingDate; "Posting Date")
            {
            }
            filter(FilterDestinationType; "Destination Type")
            {
            }
            filter(FilterOwnFleet; "Own Fleet")
            {
            }
            column(No; "No.")
            {
            }
            column(Own_Fleet; "Own Fleet")
            {
            }
            column(Destination_Type; "Destination Type")
            {
            }
            column(NoOfDrops; "No. of Drops")
            {
                Method = Max;
            }
            column(Distance; Distance)
            {
                Method = Max;
            }
        }
    }
}

