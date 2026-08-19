query 55002 "C2S Value Entry"
{
    // version HEI.02

    // HEI.01 CHG2162842 IBM SAMANR01 04/07/202022 #C2S optimazation
    //   # New query object  created
    // HEI.02 CHG2185464 IBM SISUM01 19/12/2022 #optimization - add fields Order no.,Oreder Line No., Item Ledger Qty
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50023


    elements
    {
        dataitem(Value_Entry; "Value Entry")
        {
            //DataItemTableFilter = "Document Type"=FILTER("Sales Invoice"|"Sales Credit Memo"),"Invoiced Quantity in HL"=FILTER(<>0);//BC Upgrade KAPOOV01 Drink-IT
            DataItemTableFilter = "Document Type" = FILTER("Sales Invoice" | "Sales Credit Memo");//BC Upgrade KAPOOV01 Drink-IT
            filter(FilterPostingDate; "Posting Date")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(ItemLedgerEntryNo; "Item Ledger Entry No.")
            {
            }
            column(InvoicedQuantityinHL; "Invoiced Quantity HL FND")
            {
            }
            column(DocumentType; "Document Type")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(DocumentLineNo; "Document Line No.")
            {
            }
            column(ItemLedgerEntryQuantity; "Item Ledger Entry Quantity")
            {
            }
            column(OrderNo; "Order No.")
            {
            }
            column(OrderLineNo; "Order Line No.")
            {
            }
        }
    }
}

