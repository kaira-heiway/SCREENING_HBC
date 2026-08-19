query 55036 "Value Entry - Item Cat Code"
{
    // version HEI.04

    // HEI.01 HB2605 - CHG2132673 IBM NASTAA02 15.03.2022 # COGS Allocation
    //   # New Query created
    // HEI.02 HB2605 - CHG2132673 IBM BULIMC01 23.03.2022 # COGS Allocation - new changes
    // 
    // HEI.03 CHG2171815 HB3141 NORRIQ ZOGHLE01 08.12.2022
    //   #Added Filter on "Inventory posting Group"
    // 
    // HEI.04 CHG2190464 IBM SISUM01 14/02/23 #delete Dimension set Id and Location (they are not used in R50550) and sum "Invoiced Quantity in H" and "Invoiced Quantity"

    // BC Upgrade POENAB02: Original (HeiLite) query id 50011

    //PATHAA02 05.04.26 #FDD-COGS-[PID803,FDD-DTW-022,IBM GAP DTW54] 
    //#New field added in Value Entry (Invoiced Quantity HL) is added as column

    Caption = 'Value Entry - Item Category Code';

    elements
    {
        dataitem(Item; Item)
        {
            filter(Item_Category_Code; "Item Category Code")
            {
            }
            filter(Costing_Method; "Costing Method")
            {
            }
            filter(Inventory_Posting_Group; "Inventory Posting Group")
            {
            }
            dataitem(Value_Entry; "Value Entry")
            {
                DataItemLink = "Item No." = Item."No.";
                DataItemTableFilter = "Invoiced Quantity" = FILTER(<> 0), "Item Ledger Entry Type" = CONST(Sale);
                filter(Posting_Date; "Posting Date")
                {
                }
                column(Item_No; "Item No.")
                {
                }
                // BC Upgrade POENAB02 >>
                // Commented, as it is part of Aptean changes
                /* 
                column(Sum_Invoiced_Quantity_in_HL; "Invoiced Quantity in HL")
                {
                    Method = Sum;
                } 
                */
                // BC Upgrade POENAB02 <<

                //PATHAA02>>
                column(Sum_Invoiced_Quantity_in_HL; "Invoiced Quantity HL FND")
                {
                    Method = Sum;
                }
                //PATHAA02<<

                column(Sum_Invoiced_Quantity; "Invoiced Quantity")
                {
                    Method = Sum;
                }
            }
        }
    }
}

