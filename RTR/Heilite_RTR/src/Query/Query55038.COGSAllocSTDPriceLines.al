query 55038 "COGS Alloc. STD. Price Lines"
{
    // HEI.01 CHG2132673 IBM BULIMC01 23/03/2022#new query created to calculate totals value from COGS Allocation STD. Price Lines

    // BC Upgrade BHARDA11 >>
    // 1. OLD Query ID - 50012.
    // BC Upgrade BHARDA11 <<
    elements
    {
        dataitem(COGS_Alloc_on_STD_Price_Line; "COGS Alloc STD Price Line FND")
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
            filter(SubParent_ItemNo; "Sub-Parent Item No.")
            {
            }
            filter(Parent_ItemNo; "Parent Item No.")
            {
            }
            column(SumCost_Raw_Pack; "Cost Raw or Pack Mat.")
            {
                Method = Sum;
            }
            column(Sum_TotalCost; "Total Cost")
            {
                Method = Sum;
            }
        }
    }
}

