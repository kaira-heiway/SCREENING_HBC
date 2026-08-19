query 55031 "PPV Allocation Calc Amts."
{
    // version HEI.02

    // HEI.01 CHG2193490 IBM SISUM01 26/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # new object created
    // HEI.02 CHG2193490 IBM SISUM01 10/09/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # add DataItem - Item Ledger Entry

    // BC Upgrade POENAB02: Original (HeiLite) query id 50056

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
                dataitem(Value_Entry; "Value Entry")
                {
                    DataItemLink = "Item Ledger Entry No." = Item_Ledger_Entry."Entry No.";
                    SqlJoinType = InnerJoin;
                    filter(FilterPostingDateVE; "Posting Date")
                    {
                    }
                    column(Sum_Purchase_Amount_Expected; "Purchase Amount (Expected)")
                    {
                        Method = Sum;
                    }
                    column(Sum_Purchase_Amount_Actual; "Purchase Amount (Actual)")
                    {
                        Method = Sum;
                    }
                    column(Sum_Cost_Amount_Expected; "Cost Amount (Expected)")
                    {
                        Method = Sum;
                    }
                    column(Sum_Cost_Amount_Actual; "Cost Amount (Actual)")
                    {
                        Method = Sum;
                    }
                }
            }
        }
    }
}

