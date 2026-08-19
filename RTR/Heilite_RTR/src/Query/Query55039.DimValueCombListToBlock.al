query 55039 "Dim. Value Comb. List To Block"
{
    // version HEI.01

    // HEI.01 CHG2131424 IBM SISUM01 09/06/2023 HB2520 Dimension Validation HeiLite
    //   #create new object

    // BC Upgrade KUMARR78 >>
    // Query Name : Dim. Value Comb. Ins Or Del
    // Query ID   : 50583
    // 2. Added UsageCategory property at report level.
    //    Old:
    //         - UsageCategory property was not defined in NAV.
    //    New:
    //         - UsageCategory = ReportsAndAnalysis;
    //         - Makes the report searchable via Tell Me in BC.
    //BC UPGRADE KUMARR <<
    UsageCategory = ReportsAndAnalysis; //BC UPGRADE KUMARR78 Adding UsageCategory

    OrderBy = Ascending(Code_BRAND);

    elements
    {
        dataitem(Dimension_Value1; "Dimension Value")
        {
            DataItemTableFilter = "Dimension Code" = CONST('BRAND');
            filter(Code_Filter; "Code")
            {
            }
            column(Dimension_Code_BRAND; "Dimension Code")
            {
            }
            column(Code_BRAND; "Code")
            {
            }
            dataitem(Dimension_Value2; "Dimension Value")
            {
                SqlJoinType = CrossJoin;
                DataItemTableFilter = "Dimension Code" = CONST('LINE_EXT');
                column(Dimension_Code_LINE_EXT; "Dimension Code")
                {
                }
                column(Code_LINE_EXT; "Code")
                {
                }
            }
        }
    }
}

