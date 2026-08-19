query 55033 "PPV Allocation Calc Qty"
{
    // version HEI.02

    // HEI.01 CHG2193490 IBM SISUM01 26/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # new object created
    // HEI.02 CHG2193490 IBM SISUM01 12/09/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # add DataItem - Item and column Entry Type

    // BC Upgrade POENAB02: Original (HeiLite) query id 50055

    elements
    {
        dataitem(Item; Item)
        {
            filter(FilterItemNo; "No.")
            {
            }
            filter(FilterItemCategoryCode; "Item Category Code")
            {
            }
            filter(FilterInventoryValueZero; "Inventory Value Zero")
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
                column(Item_No; "Item No.")
                {
                }
                column(Lot_No; "Lot No.")
                {
                }
                column(Entry_Type; "Entry Type")
                {
                }
                column(Sum_Quantity; Quantity)
                {
                    Method = Sum;
                }
            }
        }
    }
}

