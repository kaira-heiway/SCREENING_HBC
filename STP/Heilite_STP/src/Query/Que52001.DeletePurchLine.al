namespace STPLocal.STPLocal;

using Microsoft.Purchases.Document;

query 52001 DeletePurchLine
{
    // HEI.01 CHG2326201 IBM SHARMP16 02.01.2026 Delete the POs that are available in Purchase lines but not in the PO header
    //   # Created new Query

    // BC Upgrade PATELS08 >>
    // Nav Object ID : 50070
    // BC Upgrade PATELS08 <<

    Caption = 'DeletePurchLine';
    QueryType = Normal;
    
    elements
    {
        dataitem(PurchaseLine; "Purchase Line")
        {
            DataItemTableFilter = "Document Type" = Filter(Order);
            
            filter(Doc_No_Filter; "Document No.")
            {
            }

            column(Document_No; "Document No.")
            {
                
            }

            column(Count_)
            {
                Method = Count;
            }

        }
    }
}
