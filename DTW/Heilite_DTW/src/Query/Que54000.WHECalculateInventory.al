query 54000 "WHE Calculate Inventory"
{
    // version HEI.02

    // HEI.01 CHG2222964 IBM PATHAA02/Mimikos 27.11.2023 Physical inventory journal too slow
    //   # Code Optimisation to Improve performance
    // HEI.02 CHG2234148 IBM PRASAA03/Mimikos 05.01.2024 Calucalte Inventory within Phys. Inventory Journal does not take filters into account
    //   # Code Optimisation to Improve performance (fixing old bug)
    //   # Filter(Sum_Qty_Base=FILTER(<>0)) for column "Qty. (Base)" is changed.
    // BC Upgrade BHARDA11 >>
    // 1. OLD Query ID - 50059.
    // BC Upgrade BHARDA11 <<

    elements
    {
        dataitem(Warehouse_Entry; "Warehouse Entry")
        {
            column(Item_No; "Item No.")
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
            column(Location_Code; "Location Code")
            {
            }
            column(Bin_Code; "Bin Code")
            {
            }
            column(Zone_Code; "Zone Code")
            {
            }
            column(Sum_Qty_Base; "Qty. (Base)")
            {
                Method = Sum;
            }
            filter(Registering_Date; "Registering Date")
            {
            }
        }
    }
}

