query 55001 "C2S Document Total Line"
{
    // version HEI.01

    // HEI.01 CHG2162842 IBM SAMANR01 05/07/202022 #C2S optimazation
    //   # New query object  created
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50022

    elements
    {
        dataitem(Shipping_Cost_Allocation; "Shipping Cost Allocation FND")
        {
            filter(FilterPostingDate; "Posting Date")
            {
            }
            column(No; "No.")
            {
            }
            column(NoOfLines)
            {
                Method = Count;
            }
        }
    }
}

