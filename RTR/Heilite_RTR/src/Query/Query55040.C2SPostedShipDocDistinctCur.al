query 55040 "C2S PostedShipDoc Distinct Cur"
{
    // version HEI.01

    // HEI.01 CHG2178734 IBM SISU01  07/11/2022 #New query object created


    elements
    {
        dataitem(Posted_Document_Shipping_Cost; "Posted Trade Cost Order APS")
        {
            filter(FilterPostingDate; "Posting Date")
            {
            }
            column(Currency_Code; "Currency Code")
            {
            }
            column(Total)
            {
                Method = Count;
            }
        }
    }
}

