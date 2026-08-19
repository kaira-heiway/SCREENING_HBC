query 58005 "SL Candency VE"
{
    // version HEI.01

    // HEI.01 CHG2228096 IBM KAPOOV01 05.08.2024 Balance Extract Cadency & SL BalanceMergeExtract Cadency execution times
    //   # Created new Query
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50061

    // BC Upgrade POENAB02
    // changed from RtR extension to Interface extension
    // ID changed from 55027 to 58005

    elements
    {
        dataitem(Value_Entry; "Value Entry")
        {
            column(Item_No; "Item No.")
            {
            }
            column(Sum_Cost_Amount_Actual; "Cost Amount (Actual)")
            {
                Method = Sum;
            }
            column(Sum_Cost_Amount_Expected; "Cost Amount (Expected)")
            {
                Method = Sum;
            }
            filter(Posting_Date; "Posting Date")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
        }
    }
}

