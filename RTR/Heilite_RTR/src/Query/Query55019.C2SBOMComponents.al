query 55019 "C2S BOM Components"
{
    // version HEI.02

    // HEI.01 CHG2178734 IBM SISU01 16/11/2022 #New query object created
    // HEI.02 CHG2182707 IBM SISU01 22/11/2022 #Add data item BOM Component
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50042

    elements
    {
        dataitem(Production_BOM_Header; "Production BOM Header")
        {
            filter(FilterLinkedItemNo; "Linked Item No. FND")
            {
            }
            column(No; "No.")
            {
            }
            column(Linked_Item_No; "Linked Item No. FND")
            {
            }
            dataitem(Production_BOM_Line; "Production BOM Line")
            {
                DataItemLink = "Production BOM No." = Production_BOM_Header."No.";
                SqlJoinType = InnerJoin;
                DataItemTableFilter = "Version Code" = FILTER(<> '');
                column(ItemNo; "No.")
                {
                }
                column(Version_Code; "Version Code")
                {
                }
                dataitem(BOM_Component; "BOM Component")
                {
                    DataItemLink = "Parent Item No." = Production_BOM_Line."No.";
                    SqlJoinType = LeftOuterJoin;
                    column(BOMComponentItemNo; "No.")
                    {
                    }
                    column(BOMComponentParentItemNo; "Parent Item No.")
                    {
                    }
                }
            }
        }
    }
}

