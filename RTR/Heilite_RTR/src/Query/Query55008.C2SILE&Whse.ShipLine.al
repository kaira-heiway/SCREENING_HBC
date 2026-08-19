query 55008 "C2S ILE & Whse. Ship Line"
{
    // version HEI.02

    // HEI.01 CHG2162842 IBM SAMANR01 07/21/202022 #C2S optimazation
    //   # New query object  created
    // HEI.02 CHG2169207 IBM SISUM01 19/08/2022 #Bug fix - query return matching and not matching records with Whse. Shipment.
    //   # delete DataItemlinkType property from the 1st DataItem (no needed)
    //   # changed to InnerJoin on DataItem "Posted Whse. Receipt Line"
    //   # changed Left outer join on DataItem "Posted Documnet Shipping Cost"
    ////BC Upgrade Kamnay01 Original(Heilite) Query id 50029


    elements
    {
        dataitem(Item_Ledger_Entry; "Item Ledger Entry")
        {
            SqlJoinType = LeftOuterJoin;
            DataItemTableFilter = "Entry Type" = FILTER(Sale), "Document Type" = FILTER("Sales Shipment" | "Sales Invoice");
            filter(FilterPostingDate; "Posting Date")
            {
            }
            column(ILE_Entry_No; "Entry No.")
            {
            }
            dataitem(Posted_Whse_Shipment_Line; "Posted Whse. Shipment Line")
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
                column(Destination_Type; "Destination Type")
                {
                }
                column(Destination_No; "Destination No.")
                {
                }
                column(Location_Code; "Location Code")
                {
                }
                column(Description; Description)
                {
                }
                dataitem(Posted_Document_Shipping_Cost; "Posted Trade Cost Order APS")
                {
                    DataItemLink = "Posted Whse. Shipment No." = Posted_Whse_Shipment_Line."No.";
                    SqlJoinType = LeftOuterJoin;
                    column(PostedDocShipment_Source_No; "Posted Whse. Shipment No.")
                    {
                    }
                }
            }
        }
    }
}

