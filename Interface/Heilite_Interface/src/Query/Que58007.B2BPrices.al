query 58007 "B2B Prices"
{
    //BC Upgrade GUNREM01 Old ID- 50009
    // version HEI.02

    // HEI.01 FDD-HB1281 - CHG2056937 IBM NASTAA02 12.04.2021 # B2B Pricing Interface
    //   # New Query created for B2B Pricing Interface
    // HEI.02 CHG2210605 IBM MARTIR52 28.06.2023 B2B-Prices formula change
    //   # Send NetPrice(Order) instead of NetPrice(Item) to cover the scenarios required by StLucia and Bahamas Opcos on the interface

    //BC Upgrade GUNREM01
    //# Commented DIT Fields

    // BC Upgrade SHUKLP03 >> Replaced Old DIT fields and tables.

    Caption = 'B2B Prices';
    OrderBy = Ascending(Customer_No); //BC Upgrade SHUKLP03 -DIT Field

    elements
    {
        dataitem(Customer; Customer)
        {
            DataItemTableFilter = "Bill-to Customer No." = FILTER(<> '');
            column(No; "No.")
            {
            }
            column(Bill_to_Customer_No; "Bill-to Customer No.")
            {
            }
            //BC Upgrade SHUKLP03 -DIT table >>
            dataitem(PriceInfo101FDW; PriceInfo101FDW)
            {
                DataItemTableFilter = "Source Type" = filter('Customer');
                DataItemLink = "Source No." = Customer."Bill-to Customer No.";
                column(Customer_No; "Source No.")
                {
                }
                column(Currency_Code; "Currency Code")
                {
                }
                column(Item_No; "Item No.")
                {
                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {
                }
                column(Minimum_Quantity; "Minimum Quantity")
                {
                }
                column(Starting_Date; "As per Date")
                {
                }
                column(Ending_Date; "As per Date") // BC Upgrade SHUKLP03 << Deprecated as per aptean. Temp added As per date needs to disscused with team.
                {
                }
                column(Unit_Price; "Unit Price Excl. VAT")
                {
                }
                column(Net_Price_Item; "Published Price")
                {
                }
                // column(Disc_Charges_incl_Item_Price; "Disc.-Charges incl. Item Price") // BC Upgrade SHUKLP03 << Obsolete
                // {
                // }
                column(As_Per_date; "As Per date")
                {
                }
                column(Net_Price_Order; "Published Price")
                {
                }
            }
            //BC Upgrade SHUKLP03 -DIT table <<
        }
    }
}

