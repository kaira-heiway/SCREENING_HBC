namespace Heilite_General_MTC.Heilite_General_MTC;

enum 50002 "Free Item Posting Type FND"
{
    // BC Upgrade SHUKLP03 >> Created new enum for free item posting type.

    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; FullAmount)
    {
        Caption = 'Full Amount';
    }
    value(2; Price)
    {
        Caption = 'Price 0';
    }
    value(3; Amount)
    {
        Caption = 'Discount 100%';
    }
}
