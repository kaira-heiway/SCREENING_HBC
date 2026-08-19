query 55015 "Calc GL Entry Amount by Dim"
{
    // version HEI.01

    // HEI.01 CHG2190464 IBM SISUM01 23/02/23 #new query object created
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50037

    elements
    {
        dataitem(G_L_Account; "G/L Account")
        {
            filter(FinancialStatementVersion; "Financial Stmt version FND")
            {
            }
            dataitem(G_L_Entry; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = G_L_Account."No.";
                SqlJoinType = InnerJoin;
                filter(GLAccountNoFilter; "G/L Account No.")
                {
                }
                filter(PostingDate; "Posting Date")
                {
                }
                column(G_L_Account_No; "G/L Account No.")
                {
                }
                column(Amount; Amount)
                {
                    Method = Sum;
                }
                dataitem(Dimension_Set_Entry; "Dimension Set Entry")
                {
                    DataItemLink = "Dimension Set ID" = G_L_Entry."Dimension Set ID";
                    SqlJoinType = InnerJoin;
                    filter(DimensionCode; "Dimension Code")
                    {
                    }
                    filter(DimensionValueCode; "Dimension Value Code")
                    {
                    }
                }
            }
        }
    }
}

