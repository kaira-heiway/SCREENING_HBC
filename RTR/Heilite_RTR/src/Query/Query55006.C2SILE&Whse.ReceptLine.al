query 55006 "C2S ILE & Whse. Recept Line"
{
    // version HEI.03

    // HEI.01 CHG2162842 IBM SAMANR01 07/21/202022 #C2S optimazation
    //   # New query object  created
    // HEI.02 CHG2169207 IBM SISUM01 24/08/2022 #Bug fix - query return nothing
    //   # delete DataItemlinkType property from the 1st DataItem (no needed)
    //   # correct for DataItem "Item Ledger Entry" the filter value for Document Type
    //   # changed to InnerJoin on DataItem "Posted Whse. Receipt Line"
    //   # changed Left outer join on DataItem "Posted Documnet Shipping Cost"
    // HEI.03 CHG2169207 IBM SISUM01 25/08/2022 # add column "Qty. (Base)
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50027


    elements
    {
        dataitem(Item_Ledger_Entry; "Item Ledger Entry")
        {
            SqlJoinType = LeftOuterJoin;
            DataItemTableFilter = "Entry Type" = FILTER(Sale), "Document Type" = FILTER("Sales Return Receipt" | "Sales Credit Memo");
            filter(FilterPostingDate; "Posting Date")
            {
            }
            column(ILE_Entry_No; "Entry No.")
            {
            }
            dataitem(Posted_Whse_Receipt_Line; "Posted Whse. Receipt Line")
            {
                DataItemLink = "Posting Date" = Item_Ledger_Entry."Posting Date", "Posted Source No." = Item_Ledger_Entry."Document No.", "Source Line No." = Item_Ledger_Entry."Document Line No.", "Location Code" = Item_Ledger_Entry."Location Code";
                SqlJoinType = InnerJoin;
                column(No; "No.")
                {
                }
                column(Line_No; "Line No.")
                {
                }
                column(Posting_Date; "Posting Date")
                {
                }
                column(Source_No; "Source No.")
                {
                }
                column(Source_Line_No; "Source Line No.")
                {
                }
                column(Item_No; "Item No.")
                {
                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {
                }
                column(Posted_Source_No; "Posted Source No.")
                {
                }
                column(Location_Code; "Location Code")
                {
                }
                column(Description; Description)
                {
                }
                column(Qty_Base; "Qty. (Base)")
                {
                }
                dataitem(Posted_Document_Shipping_Cost; "Posted Trade Cost Order APS")
                {
                    DataItemLink = "Posted Whse. Receipt No." = Posted_Whse_Receipt_Line."No.";
                    SqlJoinType = LeftOuterJoin;
                    column(PostedDocReceipt_Source_No; "Posted Whse. Receipt No.")
                    {
                    }
                }
            }
        }
    }
}

