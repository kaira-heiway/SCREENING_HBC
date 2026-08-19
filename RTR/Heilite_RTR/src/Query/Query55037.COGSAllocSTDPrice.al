query 55037 "COGS Alloc. STD. Price"
{
    // HEI.01 CHG2132673 IBM BULIMC01 25/03/2022#new query created to calculate totals value from COGS Allocation STD. Price

    // BC Upgrade POENAB02: Original (HeiLite) query id 50010

    elements
    {
        dataitem(COGS_Allocation_on_STD_Price; "COGS Alloc on STD Price FND")
        {
            filter(Company; Company)
            {
            }
            filter(FiscalYear; "Fiscal Year")
            {
            }
            filter(PeriodNumber; "Period Number")
            {
            }
            column(SumCost_Raw_Pack; "Total Standard Cost")
            {
                Method = Sum;
            }
            column(Sum_TotalCost; "Prod Bought_Resale Avg Cost")
            {
                Method = Sum;
            }
        }
    }
}

