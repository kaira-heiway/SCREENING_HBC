query 58004 "GL Candency GLE"
{
    // version HEI.01

    // HEI.01 CHG2228096 IBM KAPOOV01 16.05.2024 Balance Extract Cadency & SL BalanceMergeExtract Cadency execution times
    //   # Created new Query
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50062

    // BC Upgrade POENAB02
    // changed from RtR extension to Interface extension
    // ID changed from 55029 to 58004

    elements
    {
        dataitem(G_L_Entry; "G/L Entry")
        {
            column(G_L_Account_No; "G/L Account No.")
            {
            }
            column(Sum_Credit_Amount; "Credit Amount")
            {
                Method = Sum;
            }
            column(Sum_Debit_Amount; "Debit Amount")
            {
                Method = Sum;
            }
            column(Sum_Add_Currency_Credit_Amount; "Add.-Currency Credit Amount")
            {
                Method = Sum;
            }
            column(Sum_Add_Currency_Debit_Amount; "Add.-Currency Debit Amount")
            {
                Method = Sum;
            }
            column(Sum_Amount; Amount)
            {
                Method = Sum;
            }
            column(Currency_Code; "Currency Code FND")
            {
            }
            filter(Posting_Date; "Posting Date")
            {
            }
            column(Max_Entry_No; "Entry No.")
            {
                Method = Max;
            }
            dataitem(G_L_Account; "G/L Account")
            {
                DataItemLink = "No." = G_L_Entry."G/L Account No.";
                SqlJoinType = InnerJoin;
                DataItemTableFilter = "Account Type" = const(Posting), "Income/Balance" = const("Balance Sheet"), Blocked = const(false);
            }
        }
    }
}

