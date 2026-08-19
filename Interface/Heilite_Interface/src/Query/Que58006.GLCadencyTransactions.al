query 58006 "GL Cadency Transactions"
{
    // version HEI.01

    // HEI.01 CHG2228096 IBM KAPOOV01 16.05.2024 Balance Extract Cadency & SL BalanceMergeExtract Cadency execution times
    //   # Created new Query
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50063

    // BC Upgrade POENAB02
    // changed from RtR extension to Interface extension
    // ID changed from 55028 to 58006

    elements
    {
        dataitem(G_L_Entry; "G/L Entry")
        {
            DataItemTableFilter = "Open FND" = CONST(true);
            column(Entry_No; "Entry No.")
            {
            }
            column(G_L_Account_No; "G/L Account No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Remaining_Amount; "Remaining Amount FND")
            {
            }
            column(Document_No; "Document No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Document_Type; "Document Type")
            {
            }
            column(External_Document_No; "External Document No.")
            {
            }
            column(Source_No; "Source No.")
            {
            }
            column(User_ID; "User ID")
            {
            }
            dataitem(G_L_Account; "G/L Account")
            {
                DataItemLink = "No." = G_L_Entry."G/L Account No.";
                SqlJoinType = InnerJoin;
                DataItemTableFilter = "Cadency Transaction Export FND" = const(true), "Income/Balance" = const("Balance Sheet");
            }
        }
    }
}

