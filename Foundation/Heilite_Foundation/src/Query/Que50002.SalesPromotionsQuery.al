query 50002 "Sales Promotions Query"
{
    // HEI.01 FDD-LC-HT736 IBM.GUNERE01 02.10.2019 # Object created
    // BC Upgrade SHUKLP03 >> Restructured code according to new ways of working.


    elements
    {
        dataitem(Sales_Promotion_Item_Charge; RuleSetup105FDW)
        {
            column(Rule_No_; "Rule No.")
            {
            }
            column(Calculation_Type; "Calculation Type")
            {
                ColumnFilter = Calculation_Type = filter("Free (Other Item)");
            }
            column(Sales_Type; "Source Type")
            {
            }
            column(Sales_Code; "Source No.")
            {
            }
            column(Source_Type; "Item Type")
            {
            }
            column(Source_No; "Item No.")
            {
            }
            column(Location_Code; "Based Location Code")
            {
            }
            // BC Upgrade SHUKLP03 >> 0bsolete
            // column(Variant_Code; "Variant Code")
            // {
            // }
            // BC Upgrade SHUKLP03 << 0bsolete
            column(Starting_Date; "Starting Date")
            {
            }
            column(Ending_Date; "Ending Date")
            {
            }
            column(Description; Description)
            {
            }
            column(Shipment_Method_Code; "Based Shipment Method Code")
            {
            }
            column(Calculate_per; "Based Item Type")
            {
            }
            // column(Type; Type)             // BC Upgrade SHUKLP03 << 0bsolete
            // {
            // }
            dataitem(Sales_Promotion_Item_Charge_Lines; RateLines105FDW)
            {
                DataItemLink = ConditionRuleNo = Sales_Promotion_Item_Charge."Rule No.";
                column(Line_No_; "Line No.")
                {
                }
                column(Unit_of_Measure_Code; "Free Unit of Measure Code")
                {
                }
                column(No; "Free Item No.")
                {
                }
                column(Unit_Price; "Rate Value")
                {
                }
                column(Minimum_Quantity; "Minimum Quantity")
                {
                }
                // column(Minimum_Quantity_in_HL; "Minimum Quantity in HL")     // BC Upgrade SHUKLP03 << 0bsolete
                // {
                // }
                column(Minimum_Amount; "Minimum Amount")
                {
                }
                column(Currency_Code; "Currency Code")
                {
                }

                // column(Free_Reason_Code; "Free Reason Code")         // BC Upgrade SHUKLP03 << 0bsolete
                // {
                // }
                column(Free_Quantity; "Free Quantity")
                {
                }

            }
        }

    }
}
