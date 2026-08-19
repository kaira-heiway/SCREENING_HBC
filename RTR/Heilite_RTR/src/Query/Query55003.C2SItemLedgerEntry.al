query 55003 "C2S Item Ledger Entry"
{
    // version HEI.03

    // HEI.01 CHG2162842 IBM SAMANR01 04/07/202022 #C2S optimazation
    //   # New query object  created
    // HEI.02 CHG2169207 IBM SISUM01 24/08/2022 #Add column Lot No.
    // HEI.03 CHG2185464 IBM SISUM01 19/12/2022 #Add column Source No. Document Type, Entry Type, Order Line No., Order No.
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50024


    elements
    {
        dataitem(Item_Ledger_Entry; "Item Ledger Entry")
        {
            filter(FilterPostingDate; "Posting Date")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(DocumentLineNo; "Document Line No.")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(ItemCategoryCode; "Item Category Code")
            {
            }
            column(DimensionSetID; "Dimension Set ID")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(LotNo; "Lot No.")
            {
            }
            column(Order_No; "Order No.")
            {
            }
            column(Order_Line_No; "Order Line No.")
            {
            }
            column(Item_No; "Item No.")
            {
            }
            column(Source_No; "Source No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            {
            }
            column(Entry_Type; "Entry Type")
            {
            }
            column(Document_Type; "Document Type")
            {
            }
        }
    }
}

