query 58002 "FM Item Ledger Entry Quantity"
{
    // version HEI.01
    //BC Upgrade GUNREM01 50060
    // HEI.01 CHG2238798 IBM COSTES04 13.02.2024 FM Interfaces Monthly/Weekly Code Optimization
    //  # Fetch Item Ledger Entry data with a query


    elements
    {
        dataitem(Item_Ledger_Entry; "Item Ledger Entry")
        {
            filter(Posting_Date; "Posting Date")
            {
            }
            filter(Entry_Type; "Entry Type")
            {
            }
            filter(Document_Type; "Document Type")
            {
            }
            filter(Document_No; "Document No.")
            {
            }
            filter(Source_Type; "Source Type")
            {
            }
            filter(Source_No; "Source No.")
            {
            }
            filter(Item_No; "Item No.")
            {
            }
            filter(Location_Code; "Location Code")
            {
            }
            filter(Item_Category_Code; "Item Category Code")
            {
            }
            //BC Upgrade GUNREM01 -DIT Field >>
            // column(Sum_Quantity_in_HL; "Quantity in HL")
            // {
            //     Method = Sum;
            // }
            //BC Upgrade GUNREM01 -DIT Field <<
            //BC UPGRADE KUMARR78 FM++
            column(Volume_2_101FDW; "Volume 2 101FDW")
            {

            }
            //BC UPGRADE KUMARR78 FM++

            column(SourceNo; "Source No.")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = Item_Ledger_Entry."Source No.";
                SqlJoinType = InnerJoin;
                filter(Account_Group; "Account Group FND")
                {
                }
                column(No; "No.")
                {
                }
            }
        }
    }
}

