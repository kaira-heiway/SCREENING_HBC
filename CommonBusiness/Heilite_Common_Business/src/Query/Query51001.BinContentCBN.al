query 51001 "Bin Content CBN"
{
    // HEI.01  CHG2112762 [INC3414257]  BASAKB01  IBM # New query created


    elements
    {
        dataitem(Bin_Content; "Bin Content")
        {
            column(Location_Code; "Location Code")
            {
            }
            column(Item_No; "Item No.")
            {
            }
            column(Variant_Code; "Variant Code")
            {
            }
            column(Sum_Min_Qty; "Min. Qty.")
            {
                Method = Sum;
            }
        }
    }
}

