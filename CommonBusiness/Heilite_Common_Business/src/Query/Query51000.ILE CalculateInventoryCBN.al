query 51000 "ILE Calculate Inventory CBN"
{
    // version HEI.02

    // HEI.01 CHG2222964 IBM PATHAA02/Mimikos 27.11.2023 Physical inventory journal too slow
    //   # Code Optimisation to Improve performance
    // HEI.02 CHG2222964 IBM PATHAA02/Mimikos 05.12.2023 Physical inventory journal too slow
    //   # Code Optimisation to Improve performance (fixing old bug)


    elements
    {
        dataitem(Item_Ledger_Entry; "Item Ledger Entry")
        {
            column(Item_No; "Item No.")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Lot_No; "Lot No.")
            {
            }
            column(Serial_No; "Serial No.")
            {
            }
            column(Variant_Code; "Variant Code")
            {
            }
            column(Sum_Quantity; Quantity)
            {
                Method = Sum;
            }
            filter(Posting_Date; "Posting Date")
            {
            }
        }
    }
}

