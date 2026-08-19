query 58001 "StockonHand WE"
{
    // version HEI.01

    // HEI.01 CHG2143695 IBM PATHAA02 20.04.22 - S&OP FIT | Bahamas Stock On Hand Interface Performance
    //BC Upgrade GUNREM01 Old ID- 50019

    elements
    {
        dataitem(Warehouse_Entry; "Warehouse Entry")
        {
            column(Item_No; "Item No.")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Sum_Qty_Base; "Qty. (Base)")
            {
                ColumnFilter = Sum_Qty_Base = FILTER(<> 0);
                Method = Sum;
            }
            column(Bin_Code; "Bin Code")
            {
            }
            column(Unavailable_Stock_Bin; "Unavailable Stock (Bin) FND")
            {
            }
            column(Unavailable_Stock_Quality; "Unavail. Stock (Quality) FND")
            {
            }
            filter(Registering_Date; "Registering Date")
            {
            }
            dataitem(Item; Item)
            {
                DataItemLink = "No." = Warehouse_Entry."Item No.";
                SqlJoinType = InnerJoin;
                column(Item_Category_Code; "Item Category Code")
                {
                }
                column(Base_Unit_of_Measure; "Base Unit of Measure")
                {
                }
                dataitem(Bin; Bin)
                {
                    DataItemLink = "Location Code" = Warehouse_Entry."Location Code", Code = Warehouse_Entry."Bin Code";
                    SqlJoinType = InnerJoin;
                    column(Block_Movement; "Block Movement")
                    {
                    }
                    column(Unavailable_Stock; "Unavailable Stock FND")
                    {
                    }
                }
            }
        }
    }
}

