query 51002 "Warehouse Entry Totals CBN"
{
    // HEI.01  CHG2112762 [INC3414257]  BASAKB01  IBM # New query created


    elements
    {
        dataitem(Warehouse_Entry; "Warehouse Entry")
        {
            column(Location_Code; "Location Code")
            {
            }
            column(Bin_Code; "Bin Code")
            {
            }
            column(Variant_Code; "Variant Code")
            {
            }
            column(Item_No; "Item No.")
            {
            }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            {
            }
            column(Registering_Date; "Registering Date")
            {
            }
            column(Sum_Qty_Base; "Qty. (Base)")
            {
                Method = Sum;
            }
        }
    }
}

