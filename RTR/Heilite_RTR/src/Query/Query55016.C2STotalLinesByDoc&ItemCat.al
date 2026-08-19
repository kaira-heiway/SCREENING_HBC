query 55016 "C2S Total Lines By Doc&ItemCat"
{
    // version HEI.01

    // HEI.01 CHG2178734 IBM SISU01  07/11/2022 #New query object created
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50038

    elements
    {
        dataitem(Shipping_Cost_Allocation; "Shipping Cost Allocation FND")
        {
            filter(FilterPostingDate; "Posting Date")
            {
            }
            filter(FilterNo; "No.")
            {
            }
            filter(FilterItemCategoryCode; "Item Category Code")
            {
            }
            column(No; "No.")
            {
            }
            column(Item_Category_Code; "Item Category Code")
            {
            }
            column(NoOfLines)
            {
                Method = Count;
            }
        }
    }
}

