namespace General.General;

using Microsoft.Sales.Pricing;

tableextension 50149 SalesPriceExtFND extends "Sales Price"
{
    fields
    {
        field(50000; "Last Date Modified FND"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
    }
}
