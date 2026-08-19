query 55032 "PPV Item Ledger Entry"
{
    // version HEI.01

    // HEI.01 CHG2193490 IBM SISUM01 27/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # new object created

    // BC Upgrade POENAB02: Original (HeiLite) query id 50053

    elements
    {
        dataitem(Item; Item)
        {
            filter(FilterItemCategoryCode; "Item Category Code")
            {
            }
            filter(FIlterInventoryValueZero; "Inventory Value Zero")
            {
            }
            dataitem(Item_Ledger_Entry; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = Item."No.";
                SqlJoinType = InnerJoin;
                filter(FilterPostingDate; "Posting Date")
                {
                }
                filter(FilterEntryType; "Entry Type")
                {
                }
                column(Lot_No; "Lot No.")
                {
                }
                column(Item_No; "Item No.")
                {
                }
                column(Description; Description)
                {
                }
                column("Count")
                {
                    Method = Count;
                }
            }
        }
    }
}

