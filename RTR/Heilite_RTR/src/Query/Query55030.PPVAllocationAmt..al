query 55030 "PPV Allocation Amt."
{
    // version HEI.01

    // HEI.01 CHG2193490 IBM SISUM01 27/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # new object created

    // BC Upgrade POENAB02: Original (HeiLite) query id 50052

    Caption = 'PPV Allocation Amount';

    elements
    {
        dataitem(PPV_Allocation_Header; "PPV Allocation Header RTR")
        {
            filter(FilterMonth; Month)
            {
            }
            filter(FilterYear; Year)
            {
            }
            column(Inventory_Posting_Group; "Inventory Posting Group")
            {
            }
            column(Gen_Product_Posting_Group; "Gen. Product Posting Group")
            {
            }
            dataitem(PPV_Allocation_Line; "PPV Allocation Line RTR")
            {
                DataItemLink = Month = PPV_Allocation_Header.Month, Year = PPV_Allocation_Header.Year, "Item No." = PPV_Allocation_Header."Item No.";
                SqlJoinType = InnerJoin;
                column(Sum_PPV_Line_Adj_Amount; "PPV Line Adj. Amount")
                {
                    Method = Sum;
                }
            }
        }
    }
}

