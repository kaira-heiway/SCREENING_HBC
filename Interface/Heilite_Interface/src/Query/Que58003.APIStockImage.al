query 58003 "API Stock Image"
{
    //BC Upgrade GUNREM01 Old ID-50008
    // version HEI.01

    // HEI.01 FDD-HB899 - CHG2093869 IBM NASTAA02 16.03.2021 # LSR - Transfer and Stock
    //   # New Query created for API Stock Interface

    Caption = 'API Stock Image';
    OrderBy = Ascending(Item_No);

    elements
    {
        dataitem(Warehouse_Entry; "Warehouse Entry")
        {
            column(Location_Code; "Location Code")
            {
            }
            column(Zone_Code; "Zone Code")
            {
            }
            column(Item_No; "Item No.")
            {
            }
            column(Item_Category_Code; "Item Category Code FND")
            {
            }
            column(Unavailable_Stock_Bin; "Unavailable Stock (Bin) FND")
            {
                ColumnFilter = Unavailable_Stock_Bin = CONST(false);
            }
            column(Unavailable_Stock_Quality; "Unavail. Stock (Quality) FND")
            {
                ColumnFilter = Unavailable_Stock_Quality = CONST(false);
            }
            column(Sum_Quantity; Quantity)
            {
                Method = Sum;
            }
        }
    }
}

