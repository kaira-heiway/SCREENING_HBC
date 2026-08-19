query 53000 "Sales Deposit Query"
{
    // HEI.01 FDD-LC-HT736 IBM.GUNERE01 02.10.2019 # Object created


    elements
    {
        dataitem(Item; Item)
        {
            DataItemTableFilter = "Code 104FDW" = filter(<> ''), "Is Empty Good 104FDW" = filter(false);
            column(No_; "No.")
            {
            }
            column(Count_)
            {
                Method = Count;
            }
            dataitem(ItemClassification104FDW; ItemClassification104FDW)
            {
                DataItemLink = "Empty Goods Code" = Item."Code 104FDW";
                column(Qty__Per_Base_UOM; "Qty. Per Base UOM")
                {

                }
                column(Empty_Goods_Code; "Empty Goods Code")
                {

                }
            }
        }
    }
}

