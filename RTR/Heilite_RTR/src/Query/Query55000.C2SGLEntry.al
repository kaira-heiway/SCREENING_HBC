query 55000 "C2S GL Entry"
{
    // version HEI.02

    // HEI.01 CHG2162842 IBM SAMANR01 23/06/202022 #C2S optimazation & archiving
    //   # New query object  created
    // HEI.02 CHG2178734 IBM SISU01  10/11/2022 #Removed column Dimension Set Id for optimization reason
    //BC Upgrade Kamnay01 Original(Heilite) Query id 50021


    elements
    {
        dataitem(G_L_Account; "G/L Account")
        {
            
            column(No; "No.")
            {
            
            }
            filter(FinancialStatementVersion; "Financial Stmt version FND")
            {
            }
            dataitem(G_L_Entry; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = G_L_Account."No.";
                SqlJoinType = InnerJoin;
                column(G_L_Account_No; "G/L Account No.")
                {
                }
                filter(PostingDate; "Posting Date")
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

