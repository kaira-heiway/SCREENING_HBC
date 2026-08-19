query 52000 "Purchase Orders per User"
{
    // version HEI.04

    // HEI.01 CHG2157342 HB2809 IBM NANDIS01 25.07.2022 - Email notifications of Open Po's sent to Requestors
    //   # New query developed to create data
    // HEI.02 CHG2180515 HB3249 IBM NANDIS01 12.12.2022 - Send Email Reminder to Requesters
    //   # field added - <Document_Subtype_Code>
    //   # DrinkIT field <Document_Subtype_Code> and Requester_ID are blocked. 
    // HEI.03 CHG2180515 HB3249 IBM NANDIS01 15.12.2022 - Send Email Reminder to Requesters
    //   # Column changed to filter for <Document_Subtype_Code>
    // HEI.04 CHG2198581 HB2809 IBM NANDIS01 24.04.2023 - to amend the setup on the Overdue date of the report developed
    //   # filter on Status removed
    // DrinkIT fields Requester ID, Document Subtype Code are blocked.


    elements
    {
        dataitem(Purchase_Header; "Purchase Header")
        {
            DataItemTableFilter = "Document Type" = FILTER(Order);

            // BC Upgrade SHUKLP03 >> DrinkIT field is blocked.
            // column(Requester_ID;"Requester ID") 
            // {
            // }
            // BC Upgrade SHUKLP03 << DrinkIT field is blocked.

            column(Status; Status)
            {
            }
            column(Buy_from_Vendor_No; "Buy-from Vendor No.")
            {
            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {
            }
            column(PQ_Approver; "PQ Approver FND")
            {
            }
            column(Maximo_Requisition_No; "Maximo Requisition No. FND")
            {
            }

            // BC Upgrade SHUKLP03 >> field is added.
            filter(Document_Subtype_Code; "Document Subtype Code FND")
            {
            }
            // BC Upgrade SHUKLP03 << field is added.

            dataitem(Purchase_Line; "Purchase Line")
            {
                DataItemLink = "Document Type" = Purchase_Header."Document Type", "Document No." = Purchase_Header."No.";
                SqlJoinType = InnerJoin;
                DataItemTableFilter = "Delivery Finalized FND" = FILTER(false), Type = FILTER(<> " ");
                column(Document_Type; "Document Type")
                {
                }
                column(Document_No; "Document No.")
                {
                }
                column(Line_No; "Line No.")
                {
                }
                column(Type; Type)
                {
                }
                column(No; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Outstanding_Quantity; "Outstanding Quantity")
                {
                }
                column(Expected_Receipt_Date; "Expected Receipt Date")
                {
                }
                dataitem(Purchase_Header_Additional; "Purchase Header Additional FND")
                {
                    DataItemLink = "Document Type" = Purchase_Header."Document Type", "No." = Purchase_Header."No.";
                    SqlJoinType = InnerJoin;
                    column(Shopping_Card_No; "Shopping Card No.")
                    {
                    }
                }
            }
        }
    }
}

