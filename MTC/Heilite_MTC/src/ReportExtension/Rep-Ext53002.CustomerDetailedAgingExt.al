reportextension 53002 CustomerDetailedAging extends "Customer Detailed Aging"
{
    dataset
    {
        modify("Cust. Ledger Entry")
        {
            trigger OnBeforePreDataItem()
            begin
                //BC Upgrade Fields changes as per FDD KUMBHS03 OTC071 >>
                Customer.CopyFilter("CM Incl. EG Limit Filter APS", "CM Incl. EG. Lim. Warn APS");

                Customer.COPYFILTER("Customer Posting Group", "Customer Posting Group");
                //BC Upgrade Fields changes as per FDD KUMBHS03 OTC071 <<
            end;
        }
    }

}